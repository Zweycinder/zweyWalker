import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zwey_walker/widgets/drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zwey_walker/screens/control_screen/controller_screen.dart';
import 'package:zwey_walker/widgets/devicetile_widget.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as loc;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ignore: unused_field
  late BluetoothConnection _blueDevice;
  List<BluetoothDiscoveryResult> _discoveredDevices = [];
  final FlutterBluetoothSerial _blueSerial = FlutterBluetoothSerial.instance;
  bool isblueScanning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('S E A R C H'),
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              padding: EdgeInsets.fromLTRB(14, 14, 14, 2),
              margin: EdgeInsets.all(12),
              height: 300.h,
              width: double.infinity,
              child: isblueScanning
                  ? Center(
                      child: SizedBox(
                        height: 150,
                        width: 150,
                        child: Lottie.asset(
                          Theme.of(context).colorScheme.surface ==
                                  Colors.grey.shade300
                              ? 'assets/spiderloading/blackspider_loading.json'
                              : 'assets/spiderloading/whitespider_loading.json',
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _discoveredDevices.length,
                      itemBuilder: (context, index) => MyBlueDeviceTile(
                        name:
                            _discoveredDevices[index].device.name ?? "Unknown",
                        address: _discoveredDevices[index].device.address,
                        onTap: () async {
                          _blueDevice = await BluetoothConnection.toAddress(
                            _discoveredDevices[index].device.address,
                          );

                          Navigator.push(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(
                              builder: (context) => Controllerscreen(),
                            ),
                          );
                        },
                      ),
                    ),
            ),
            SizedBox(
              height: 120.h,
            ),
            TextButton(
              onPressed: _checkPermissionsAndStartScan,
              child: Text(
                'S C A N',
                style: TextStyle(
                  fontSize: 15.w,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Controllerscreen(),
                  ),
                );
              },
              child: Text('control page'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _checkPermissionsAndStartScan() async {
    if (await Permission.bluetooth.isGranted &&
        await Permission.bluetoothScan.isGranted &&
        await Permission.bluetoothConnect.isGranted &&
        await Permission.locationWhenInUse.isGranted) {
      bool? isBluetoothEnabled = await _blueSerial.isEnabled;
      bool? isLocationEnabled = await loc.Location().requestService();
      if (!isBluetoothEnabled! && isLocationEnabled) {
        bool? result = await _blueSerial.requestEnable();
        if (result == true) {
          _startScanning();
        }
      } else {
        _startScanning();
      }
    } else {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.bluetooth,
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
        Permission.locationWhenInUse,
      ].request();
      if (mounted) {
        if (statuses.values.every((status) => status.isGranted)) {
          _checkPermissionsAndStartScan();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Permissions not granted')),
          );
        }
      }
    }
  }

  void _startScanning() {
    setState(() {
      isblueScanning = true;
    });
    _discoveredDevices = [];
    _blueSerial.startDiscovery().listen(
      (event) {
        setState(() {
          _discoveredDevices = [..._discoveredDevices, event];
        });
      },
      onError: (error) {
        setState(() {
          isblueScanning = false;
        });
      },
      onDone: () {
        setState(() {
          isblueScanning = false;
        });
      },
    );
  }
}


/*

import 'package:flutter/material.dart';
import 'package:zwey_walker/screens/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';

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
    super.initState();
    checkPermissionsAndBluetooth();
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
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Enable Bluetooth'),
            ),
          ],
        );
      },
    );
  }

  Future<void> checkPermissionsAndBluetooth() async {
    // Check and request permissions
    var status = await Permission.bluetoothScan.status;

    if (!status.isGranted) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.bluetoothScan,
        Permission.bluetoothAdvertise,
        Permission.bluetoothConnect,
        Permission.location
      ].request();

      if (statuses[Permission.bluetoothScan]!.isGranted &&
          statuses[Permission.bluetoothAdvertise]!.isGranted &&
          statuses[Permission.bluetoothConnect]!.isGranted &&
          statuses[Permission.location]!.isGranted) {
        checkBluetooth();
      } else {}
    } else {
      checkBluetooth();
    }
  }

  Future<void> checkBluetooth() async {
    bool? isEnabled = await _blueSerial.isEnabled;
    setState(() {
      isBluetoothOn = isEnabled!;
    });
  }
}


*/