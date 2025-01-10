import 'dart:async';

import 'package:bluetooth_classic/bluetooth_classic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_blue_classic/flutter_blue_classic.dart';
import 'package:zwey_walker/widgets/devicetile_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FlutterBlueClassic _blueClassic = FlutterBlueClassic();
  List<BluetoothDevice> _discoveredDevices = [];
  final BluetoothClassic _bluePlug = BluetoothClassic();

  bool isblueScanning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.green,
            height: 50.h,
            width: double.infinity,
          ),
          Container(
            color: const Color.fromARGB(255, 255, 195, 215),
            height: 300.h,
            width: double.infinity,
            child: StreamBuilder<Object>(
                stream: null,
                builder: (context, snapshot) {
                  return isblueScanning
                      ? Placeholder()
                      : ListView.builder(
                          itemCount: _discoveredDevices.length,
                          itemBuilder: (context, index) => BlueDeviceTile(
                              name: _discoveredDevices[index].name ?? "Unknown",
                              address: _discoveredDevices[index].address));
                }),
          ),
          ElevatedButton(
              onPressed: () {
                if (isblueScanning == false) {
                  setState(() {
                    isblueScanning = true;
                  });

                  _blueClassic.startScan();
                  _blueClassic.scanResults.listen(
                    (event) {
                      _discoveredDevices = [..._discoveredDevices, event];
                    },
                    onDone: () {
                      setState(() {
                        debugPrint('object');
                        isblueScanning = false;
                      });
                    },
                  );
                  Future.delayed(
                    Duration(seconds: 5),
                    () {
                      _bluePlug.stopScan();
                      setState(() {
                        debugPrint('object');
                        isblueScanning = false;
                      });
                    },
                  );
                }
              },
              child: StreamBuilder(
                stream: _blueClassic.isScanning,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data == true) {
                    return Text('Scanning');
                  } else {
                    return Text('Scan');
                  }
                },
              ))
        ],
      ),
    );
  }
}



/*

import 'package:bluetooth_classic/bluetooth_classic.dart';
import 'package:bluetooth_classic/models/device.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_blue_classic/flutter_blue_classic.dart';
import 'package:zwey_walker/widgets/devicetile_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FlutterBlueClassic _blueClassic = FlutterBlueClassic();
  late List<Device> _discoveredDevices;
  final BluetoothClassic _bluePlug = BluetoothClassic();

  bool isblueScanning = false;
  bool scannedBefore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.green,
            height: 50.h,
            width: double.infinity,
          ),
          Container(
              color: const Color.fromARGB(255, 255, 195, 215),
              height: 300.h,
              width: double.infinity,
              child: isblueScanning == true
                  ? Placeholder()
                  : scannedBefore
                      ? ListView.builder(
                          itemBuilder: (context, index) => BlueDeviceTile(
                              name: _discoveredDevices[index].name ?? "Unknown",
                              address: _discoveredDevices[index].address),
                        )
                      : Center(
                          child: Text('start scanning'),
                        )),
          ElevatedButton(
              onPressed: () async {
                if (isblueScanning == false) {
                  setState(() {
                    isblueScanning = true;
                  });
                  _bluePlug.startScan();
                  _bluePlug.onDeviceDiscovered().listen(
                    (event) {
                      setState(() {
                        _discoveredDevices = [..._discoveredDevices, event];
                      });
                    },
                  );
                  {
                    _bluePlug.stopScan();
                    setState(() {
                      isblueScanning = false;
                      scannedBefore = true;
                    });
                  }
                }
              },
              child: StreamBuilder(
                stream: _blueClassic.isScanning,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data == true) {
                    return Text('Scanning');
                  } else {
                    return Text('Scan');
                  }
                },
              ))
        ],
      ),
    );
  }
}


*/