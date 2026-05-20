import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

void main() {
  test('Test Gemini Connection', () async {
    await dotenv.load(fileName: ".env");
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    print("API Key loaded: $apiKey");
    
    if (apiKey == null || apiKey.isEmpty) {
      print("Error: API Key is null or empty");
      return;
    }
    
    Gemini.init(apiKey: apiKey);
    final gemini = Gemini.instance;
    
    try {
      print("Sending streaming prompt to Gemini...");
      await for (final event in gemini.streamGenerateContent("Hello, how are you? Answer in 1 short sentence.")) {
        final response = event.content?.parts?.fold(
              "", (previous, current) => "$previous${current.text}") ??
          "";
        print("Received chunk: $response");
      }
    } catch (e) {
      print("Gemini streaming error: $e");
    }
  });
}
