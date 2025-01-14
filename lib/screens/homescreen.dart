import 'dart:async';
import 'package:bluetooth_classic/bluetooth_classic.dart';
import 'package:bluetooth_classic/models/device.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:zwey_walker/screens/controllerscreen.dart';
import 'package:zwey_walker/widgets/devicetile_widget.dart';
import 'package:zwey_walker/widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BluetoothClassic _blueClassic = BluetoothClassic();
  List<Device> _discoveredDevices = [];
  late Device _connectedDevice;

  bool isblueScanning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('S E A R C H'),
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(24),
            ),
            margin: EdgeInsets.all(12),
            height: 300.h,
            width: double.infinity,
            child: isblueScanning
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  )
                : ListView.builder(
                    itemCount: _discoveredDevices.length,
                    itemBuilder: (context, index) => MyBlueDeviceTile(
                      name: _discoveredDevices[index].name ?? "Unknown",
                      address: _discoveredDevices[index].address,
                      onTap: () {
                        _blueClassic.connect(_discoveredDevices[index].address,
                            "00001101-0000-1000-8000-00805F9B34FB");
                        if (Device.connected == 1) {
                          print(Device.connected);
                        }
                      },
                    ),
                  ),
          ),
          SizedBox(
            height: 100.h,
          ),
          // start scanning and add list of scanned devices
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 1,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: TextButton(
              onPressed: () {
                _scan();
              },
              child: Text(
                'S C A N',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _scan() async {
    await _blueClassic.startScan();
    _blueClassic.onDeviceDiscovered().listen(
      (event) {
        setState(() {
          _discoveredDevices = [..._discoveredDevices, event];
        });
      },
    );
    setState(() {
      isblueScanning = false;
    });
  }
}
 
 

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_blue_classic/flutter_blue_classic.dart';
// import 'package:zwey_walker/screens/controllerscreen.dart';
// import 'package:zwey_walker/widgets/devicetile_widget.dart';
// import 'package:zwey_walker/widgets/drawer.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final FlutterBlueClassic _blueClassic = FlutterBlueClassic();
//   List<BluetoothDevice> _discoveredDevices = [];
//   BluetoothConnection? _connectedDevice;

//   bool isblueScanning = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('S E A R C H'),
//       ),
//       drawer: MyDrawer(),
//       body: Column(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               border: Border.all(width: 1),
//               borderRadius: BorderRadius.circular(24),
//             ),
//             margin: EdgeInsets.all(12),
//             height: 300.h,
//             width: double.infinity,
//             child: isblueScanning
//                 ? Center(
//                     child: CircularProgressIndicator(
//                       color: Colors.black,
//                     ),
//                   )
//                 // TODO try to make it stream builder not listview
//                 : ListView.builder(
//                     itemCount: _discoveredDevices.length,
//                     itemBuilder: (context, index) => MyBlueDeviceTile(
//                       name: _discoveredDevices[index].name ?? "Unknown",
//                       address: _discoveredDevices[index].address,
//                       onTap: () {
//                         _blueClassic.connect(_discoveredDevices[index].address);
//                         if (BluetoothConnection.fromConnectionId(
//                                 index, _discoveredDevices[index].address)
//                             .isConnected) {
//                           //////
//                           _connectedDevice =
//                               BluetoothConnection.fromConnectionId(
//                                   1, _discoveredDevices[index].address);
//                           //////////
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => Controllerscreen(
//                                 connectedDevice: _connectedDevice,
//                               ),
//                             ),
//                           );
//                         }
//                       },
//                     ),
//                   ),
//           ),
//           SizedBox(
//             height: 100.h,
//           ),
//           // start scanning and add list of scanned devices
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(
//                 width: 1,
//               ),
//             ),
//             padding: EdgeInsets.symmetric(horizontal: 6.w),
//             child: TextButton(
//               onPressed: () {
//                 if (isblueScanning == false) {
//                   setState(() {
//                     isblueScanning = true;
//                   });
//                   _blueClassic.startScan();
//                   // after 10 seconds stop scanning and show
//                   Timer(Duration(seconds: 10), () {
//                     if (mounted) {
//                       _blueClassic.stopScan();
//                       setState(() {
//                         isblueScanning = false;
//                       });
//                     }
//                   });
//                   _discoveredDevices = [];
//                   _blueClassic.scanResults.listen(
//                     (event) {
//                       setState(() {
//                         _discoveredDevices = [..._discoveredDevices, event];
//                       });
//                     },
//                     onError: (error) {
//                       setState(() {
//                         isblueScanning = false;
//                       });
//                     },
//                   );
//                 }
//               },
//               child: Text(
//                 'S C A N',
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
 
 

 ///////////////////////////////////////


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