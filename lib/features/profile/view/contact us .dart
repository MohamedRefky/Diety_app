// ignore_for_file: camel_case_types

import 'dart:convert';
import 'dart:developer';

import 'package:diety/Core/widget/Custom_Button.dart';
import 'package:diety/features/profile/view/profile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

import '../../../Core/utils/Colors.dart';
import '../widget/CustomTextFieldContactUs.dart';

class contactus extends StatefulWidget {
  const contactus({super.key});

  @override
  State<contactus> createState() => _contactusState();
}

final nameController = TextEditingController();
final subjectController = TextEditingController();
final emailController = TextEditingController();
final messageController = TextEditingController();

Future sendEmail() async {
  final Url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
  const serviceId = "service_ir3vs4i";
  const templateId = "template_iusazdn";
  const userId = "byhX7VWORhRavq-p1";

  log("enteres response");
  final response = await http.post(Url,
      headers: {'origin': 'http:localhost', 'Content-Type': 'application/json'},
      body: json.encode({
        "service_id": serviceId,
        "template_id": templateId,
        "user_id": userId,
        "template_params": {
          "name": nameController.text,
          "Subject": subjectController.text,
          "message": messageController.text,
          "user_email": emailController.text,
        }
      }));
  log(response.body);
  return response.statusCode;
}

class _contactusState extends State<contactus> {
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
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const Profile(),
            ));
          },
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.white,
            size: 30,
          ),
        ),
      ),
      body: Padding(
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
              CustomTextFieldContactUs(
                label: 'Name',
                mycontroller: nameController,
              ),
              const Gap(20),
              CustomTextFieldContactUs(
                mycontroller: subjectController,
                label: 'Subject',
              ),
              const Gap(20),
              CustomTextFieldContactUs(
                mycontroller: emailController,
                label: 'Email',
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
              CustomTextFieldContactUs(
                mycontroller: messageController,
                hintText: "Enter your message",
                maxLines: 5,
              ),
              const Gap(25),
              Custom_Button(
                color: const Color(0xff202835),
                onPressed: () {
                  sendEmail();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      "email sent",
                    ),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.green,
                  ));
                },
                text: 'Send',
              ),
            ],
          ),
        ),
      ),
    );
  }
}






/*
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../Core/utils/Colors.dart';

class contactus extends StatefulWidget {
  const contactus({super.key});

  @override
  State<contactus> createState() => _contactusState();
}

final nameController = TextEditingController();
final subjectController = TextEditingController();
final emailController = TextEditingController();
final messageController = TextEditingController();

Future<int> sendEmail() async {
  final Url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
  const serviceId = "service_ir3vs4i";
  const templateId = "template_iusazdn";
  const userId = "byhX7VWORhRavq-p1";

  log("enteres response");
  final response = await http.post(Url,
      headers: {
        'origin': 'http:localhost',
        'Content-Type': 'application/json'
      },
      body: json.encode({
        "service_id": serviceId,
        "template_id": templateId,
        "user_id": userId,
        "template_params": {
          "name": nameController.text,
          "Subject": subjectController.text,
          "message": messageController.text,
          "user_email": emailController.text,
        }
      }));
  log(response.body);
  return response.statusCode;
}

class _contactusState extends State<contactus> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Contact Us",
          style: TextStyle(color: Colors.orangeAccent),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            //Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            size: 33,
            color: AppColors.button,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              const Text(
                "If you need help \n please contact us!",
                style: TextStyle(fontSize: 15, color: Colors.blueGrey),
              ),
              const SizedBox(
                height: 7,
              ),
              // TextFields to capture user input
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Your Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: subjectController,
                decoration: const InputDecoration(labelText: 'Subject'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the subject';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Your Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: messageController,
                decoration: const InputDecoration(labelText: 'Message'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a message';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    sendEmail().then((statusCode) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          statusCode == 200 ? "Email sent" : "Email failed",
                        ),
                        duration: Duration(seconds: 2),
                        backgroundColor:
                            statusCode == 200 ? Colors.green : Colors.red,
                      ));
                    });
                  }
                },
                child: const Text("Send"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


 */