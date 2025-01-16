import 'package:flutter/material.dart';
import 'package:zwey_walker/screens/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class CheckBluetoothScreen extends StatefulWidget {
  const CheckBluetoothScreen({super.key});

  @override
  State<CheckBluetoothScreen> createState() => _CheckBluetoothScreenState();
}

class _CheckBluetoothScreenState extends State<CheckBluetoothScreen> {
  final FlutterBluetoothSerial _blueSerial = FlutterBluetoothSerial.instance;
  bool isBluetoothOn = false;

  @override
  void initState() {
    checkBluetooth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isBluetoothOn
          ? HomeScreen()
          : Center(
              child: GestureDetector(
                onTap: () => showEnableBluetoothDialog(context),
                child: Icon(
                  Icons.bluetooth_disabled_sharp,
                  size: 150.h,
                  color: Colors.blue,
                ),
              ),
            ),
    );
  }

  Future<void> showEnableBluetoothDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Bluetooth is Off'),
          content: const Text('Please turn on Bluetooth to continue.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _blueSerial.requestEnable();
                checkBluetooth();
                // ignore: use_build_context_synchronously
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Enable Bluetooth'),
            ),
          ],
        );
      },
    );
  }

  Future<void> checkBluetooth() async {
    bool? isEnabled = await _blueSerial.isEnabled;
    setState(() {
      isBluetoothOn = isEnabled!;
    });
  }
}


/*



*/


/*

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:zwey_walker/homescreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_blue_classic/flutter_blue_classic.dart';

class ConnectionScreen extends StatefulWidget {
  const ConnectionScreen({super.key});

  @override
  State<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  final FlutterBlueClassic _blueClassic = FlutterBlueClassic();

  bool blueState = false;

  @override
  Widget build(BuildContext context) {
    return blueState
        ? FutureBuilder(
            future: _blueClassic.isEnabled,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return HomeScreen();
              }
            },
          )
        : Center(
            child: GestureDetector(
              onTap: () => showEnableBluetoothDialog(context),
              child: Icon(
                Icons.bluetooth_disabled_sharp,
                size: 150.h,
                color: Colors.blue,
              ),
            ),
          );
  }

  Future<void> showEnableBluetoothDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Bluetooth is Off'),
          content: const Text('Please turn on Bluetooth to continue.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _blueClassic.turnOn();
                setState(() {
                  blueState = true;
                });
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Enable Bluetooth'),
            ),
          ],
        );
      },
    );
  }
}

/*



*/


*/