import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class MyAI {
  void geminiInit() {
    Gemini.init(
      apiKey: '${dotenv.env['Token_gemini']}',
    );
  }

  Future<String> geminiTalk(String requests) {
    Gemini.instance.prompt(
      parts: [
        Part.text(
            'from now on you name is (spidzy) and you will answer the next request $requests'),
      ],
    ).then((value) {
      return value?.output;
    }).catchError((e) {
      return 'error';
    });
    return Future.value('error');
  }
}
