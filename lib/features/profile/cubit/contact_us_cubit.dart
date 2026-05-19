import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit() : super(ContactUsInitial());

  Future<void> sendEmail({
    required String name,
    required String subject,
    required String email,
    required String message,
  }) async {
    if (name.isEmpty || subject.isEmpty || email.isEmpty || message.isEmpty) {
      emit(const ContactUsFailure("All fields are required"));
      return;
    }

    emit(ContactUsLoading());

    try {
      final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
      const serviceId = "service_ir3vs4i";
      const templateId = "template_iusazdn";
      const userId = "byhX7VWORhRavq-p1";

      final response = await http.post(
        url,
        headers: {
          'origin': 'http:localhost',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "service_id": serviceId,
          "template_id": templateId,
          "user_id": userId,
          "template_params": {
            "name": name,
            "Subject": subject,
            "message": message,
            "user_email": email,
          }
        }),
      );

      if (response.statusCode == 200) {
        emit(ContactUsSuccess());
      } else {
        emit(ContactUsFailure("Failed to send email. Status code: ${response.statusCode}"));
      }
    } catch (e) {
      emit(ContactUsFailure("An error occurred: $e"));
    }
  }
}
