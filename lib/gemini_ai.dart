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
            'your name is Handel you work as virtul assitent, you can walk, do some moves and talks, you are gonna recive orders and qustions, when the order is about anything of the following, just send the code follows (to center or sit send 1100,to move forward send 1101, to move backward 1102, to move left 1103, to move right 1104, to rotate reverse clock wise 1105, to rotate clock wise 1106) , (for first pose send, 2201, second pose send 2202, third pose send 2203), and if i ask for antyhing else just respond to it normally as your job, answer only with information you have : $requests'),
      ],
    ).then((value) {
      return value?.output;
    }).catchError((e) {
      return 'error';
    });
    return Future.value('error');
  }
}
