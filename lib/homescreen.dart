import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_blue_classic/flutter_blue_classic.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FlutterBlueClassic _blueClassic = FlutterBlueClassic();
  bool blueScanState = false;

  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: StreamBuilder(
            stream: _blueClassic.scanResults,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Text('No devices found'),
                );
              } else {
                List<BluetoothDevice> devicesFound = [];

                if (snapshot.hasData) {
                  final newDevice = snapshot.data!;

                  // Add the new device if it's not already in the list
                  if (!devicesFound
                      .any((device) => device.name == newDevice.name)) {
                    devicesFound.add(newDevice);
                  }
                }

                return ListView.builder(
                  itemCount: devicesFound.length,
                  itemBuilder: (context, index) {
                    final device = devicesFound[index];
                    return ListTile(
                      title: Text(device.name ?? 'Unknown Device'),
                      subtitle: Text(device.address),
                    );
                  },
                );
              }
            },
          ),
        ),
        ElevatedButton(
            onPressed: () {
              _blueClassic.startScan();
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
    );
  }
}
