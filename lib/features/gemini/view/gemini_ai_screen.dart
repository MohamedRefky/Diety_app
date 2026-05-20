import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:diety/Core/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';

class GeminiAi extends StatefulWidget {
  const GeminiAi({super.key});

  @override
  State<StatefulWidget> createState() => _GeminiAi();
}

class _GeminiAi extends State<GeminiAi> {
  final Gemini gemini = Gemini.instance;

  List<ChatMessage> messages = [];

  ChatUser currentUser = ChatUser(id: "0", firstName: "You");
  ChatUser geminiUser = ChatUser(
    id: "1",
    firstName: "FitCoach AI",
    profileImage: "https://seeklogo.com/images/G/google-gemini-logo-A5787B2669-seeklogo.com.png",
  );

  @override
  void initState() {
    super.initState();
    // Add an initial greeting from the AI coach
    messages.add(
      ChatMessage(
        user: geminiUser,
        createdAt: DateTime.now(),
        text: "Hello! I am your AI Fitness & Diet Coach. 🏋️‍♂️🥗\n\nHow can I help you today? You can ask me about workout routines, nutrition plans, calorie tracking, or even send me a photo of your meal and I'll analyze it for you!",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E2630),
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.button.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.bolt, color: AppColors.button, size: 20),
            ),
            const SizedBox(width: 8),
            Text(
              "AI Fitness Coach",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.white,
            size: 22,
          ),
        ),
      ),
      body: _buildChat(),
    );
  }

  Widget _buildChat() {
    return DashChat(
      currentUser: currentUser,
      onSend: _sendMessage,
      messages: messages,
      messageOptions: MessageOptions(
        showTime: true,
        timeFontSize: 10,
        timeTextColor: Colors.grey.shade500,
        currentUserContainerColor: AppColors.button,
        currentUserTextColor: Colors.white,
        containerColor: const Color(0xFF1E2630),
        textColor: Colors.white,
        userNameBuilder: (user) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              user.firstName ?? "",
              style: TextStyle(
                color: user.id == "0" ? AppColors.text : AppColors.button,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
      inputOptions: InputOptions(
        inputDecoration: InputDecoration(
          hintText: "Ask your AI Coach...",
          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          fillColor: const Color(0xFF1E2630),
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: AppColors.button, width: 1.5),
          ),
        ),
        inputTextStyle: const TextStyle(color: Colors.white, fontSize: 15),
        sendButtonBuilder: (void Function() onSend) {
          return Container(
            margin: const EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
              color: AppColors.button,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
              onPressed: onSend,
            ),
          );
        },
        trailing: [
          IconButton(
            icon: Icon(Icons.image_outlined, color: AppColors.button, size: 26),
            onPressed: _sendMediaMessage,
          ),
        ],
      ),
    );
  }

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });
    try {
      String question = chatMessage.text;
      List<Uint8List>? images;
      if (chatMessage.medias?.isNotEmpty ?? false) {
        final mediaUrl = chatMessage.medias!.first.url;
        try {
          images = [File(mediaUrl).readAsBytesSync()];
        } catch (e) {
          log("Error reading image bytes: $e");
        }
      }
      
      gemini.streamGenerateContent(question, images: images).listen(
        (event) {
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous${current.text}") ??
              "";
          
          if (messages.isNotEmpty && messages.first.user == geminiUser) {
            setState(() {
              ChatMessage lastMessage = messages.removeAt(0);
              lastMessage.text = "${lastMessage.text}$response";
              messages = [lastMessage, ...messages];
            });
          } else {
            ChatMessage message = ChatMessage(
              user: geminiUser,
              createdAt: DateTime.now(),
              text: response,
            );
            setState(() {
              messages = [message, ...messages];
            });
          }
        },
        onError: (error) {
          log("Gemini stream error: $error");
          ChatMessage errorMessage = ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: "I'm sorry, I ran into an error connecting to the intelligence engine. Please check your internet connection or try again shortly.",
          );
          setState(() {
            messages = [errorMessage, ...messages];
          });
        },
      );
    } catch (e) {
      log("Error in sending message: $e");
    }
  }

  void _sendMediaMessage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      ChatMessage chatMessage = ChatMessage(
        user: currentUser,
        createdAt: DateTime.now(),
        text: "Please analyze this picture and give me health/fitness related feedback.",
        medias: [
          ChatMedia(url: file.path, fileName: file.name, type: MediaType.image)
        ],
      );
      _sendMessage(chatMessage);
    }
  }
}
