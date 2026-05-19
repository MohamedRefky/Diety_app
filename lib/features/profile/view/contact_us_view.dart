import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../Core/utils/Colors.dart';
import '../../../Core/widget/Custom_Button.dart';
import '../../../Core/widget/Custom_TextFormFealed.dart';
import '../cubit/contact_us_cubit.dart';
import '../cubit/contact_us_state.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactUsCubit(),
      child: const _ContactUsContent(),
    );
  }
}

class _ContactUsContent extends StatefulWidget {
  const _ContactUsContent();

  @override
  State<_ContactUsContent> createState() => _ContactUsContentState();
}

class _ContactUsContentState extends State<_ContactUsContent> {
  final nameController = TextEditingController();
  final subjectController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    subjectController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff030b18),
      appBar: AppBar(
        title: const Text(
          "Contact Us",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff030b18),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.white,
            size: 30,
          ),
        ),
      ),
      body: BlocConsumer<ContactUsCubit, ContactUsState>(
        listener: (context, state) {
          if (state is ContactUsSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Email sent successfully"),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.green,
              ),
            );
            // Clear fields on success
            nameController.clear();
            subjectController.clear();
            emailController.clear();
            messageController.clear();
          } else if (state is ContactUsFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                duration: const Duration(seconds: 2),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "If you need help",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                  const Text(
                    "contact with us!",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                  const Gap(20),
                  CusomTextFormFeald(
                    lable: 'Name',
                    mycontroller: nameController,
                  ),
                  const Gap(20),
                  CusomTextFormFeald(
                    mycontroller: subjectController,
                    lable: 'Subject',
                  ),
                  const Gap(20),
                  CusomTextFormFeald(
                    mycontroller: emailController,
                    lable: 'Email',
                  ),
                  const Gap(20),
                  const Row(
                    children: [
                      Text(
                        'Tell us about your problem',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                  const Gap(4),
                  CusomTextFormFeald(
                    lable: 'Message',
                    mycontroller: messageController,
                    hintText: "Enter your message",
                    maxLines: 5,
                  ),
                  const Gap(25),
                  if (state is ContactUsLoading)
                    const CircularProgressIndicator(color: Colors.white)
                  else
                    Custom_Button(
                      color: const Color(0xff202835),
                      onPressed: () {
                        context.read<ContactUsCubit>().sendEmail(
                              name: nameController.text,
                              subject: subjectController.text,
                              email: emailController.text,
                              message: messageController.text,
                            );
                      },
                      text: 'Send',
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
