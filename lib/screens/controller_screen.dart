import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class Controllerscreen extends StatefulWidget {
  const Controllerscreen({super.key, required this.blueDevice});
  final BluetoothConnection blueDevice;

  @override
  State<Controllerscreen> createState() => _ControllerscreenState();
}

class _ControllerscreenState extends State<Controllerscreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.blueDevice.finish();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('C O N T R O L'),
      ),
      body: Center(
        child: Column(
            children: [SizedBox(height: 1, width: 100, child: Placeholder())]),
      ),
    );
  }

  void _sendMessage(String message) async {
    widget.blueDevice.output
        .add(Uint8List.fromList(utf8.encode(message + "\r\n")));
    await widget.blueDevice.output.allSent;
  }

  void _receiveMessage() async {
    widget.blueDevice.input!.listen((Uint8List data) {
      print('Data received: ${ascii.decode(data)}');
    });
  }

  //////// show dialog to disconnect and leave control page
  // Future<void> _disconnectBlue() {
  //   return showDialog(
  //     context: context,
  //     builder: (dialogContext) => AlertDialog(
  //       title: const Text('Are you sure to disconnect ?'),
  //       actions: <Widget>[
  //         TextButton(
  //           onPressed: () {
  //             Navigator.of(dialogContext).pop();
  //           },
  //           child: const Text('No'),
  //         ),
  //         TextButton(
  //           onPressed: () {
  //             widget.blueDevice.finish();
  //             Navigator.of(dialogContext).pop();
  //           },
  //           child: const Text('Yes'),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
