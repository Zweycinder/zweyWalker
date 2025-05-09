import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
// import 'package:speech_to_text/speech_to_text.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:zwey_walker/screens/control_screen/widgets/spiderweb_controller.dart';

class Controllerscreen extends StatefulWidget {
  const Controllerscreen({
    super.key,
    required this.blueDevice,
  });
  final BluetoothConnection blueDevice;

  @override
  State<Controllerscreen> createState() => _ControllerscreenState();
}

class _ControllerscreenState extends State<Controllerscreen> {
  // SpeechToText _speechToText = SpeechToText();
  // bool _speechEnabled = false;
  // String _lastWords = '';

  //  dotenv.env['Token'],

  @override
  void initState() {
    super.initState();
    // _initSpeech();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('device is connected'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
  }

  @override
  void dispose() {
    // widget.blueDevice.finish();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // geminiTalk('have small conversation with me');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('C O N T R O L'),
      ),
      body: SpiderWebControl(
        blueDevice: widget.blueDevice,
      ),

      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: _speechToText.isNotListening
      //       ? Theme.of(context).colorScheme.inversePrimary
      //       : Theme.of(context).colorScheme.primary,
      //   tooltip: 'Listen',
      //   onPressed:
      //       _speechToText.isNotListening ? _startListening : _stopListening,
      //   child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      // ),
    );
  }

  // void _initSpeech() async {
  //   _speechEnabled = await _speechToText.initialize();
  //   // setState(() {});
  // }

  // void _startListening() async {
  //   await _speechToText.listen(onResult: _onSpeechResult);
  //   setState(() {
  //     _speechEnabled = true;
  //   });
  // }

  // void _stopListening() async {
  //   await _speechToText.stop();
  //   setState(() {
  //     _speechEnabled = false;
  //   });
  // }

  // void _onSpeechResult(SpeechRecognitionResult result) {
  //   setState(() {
  //     _lastWords = result.recognizedWords;
  //   });
  // }
}
