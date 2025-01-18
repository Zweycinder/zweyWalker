import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zwey_walker/widgets/drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zwey_walker/control_screen/controller_screen.dart';
import 'package:zwey_walker/widgets/devicetile_widget.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FlutterBluetoothSerial _blueSerial = FlutterBluetoothSerial.instance;
  List<BluetoothDiscoveryResult> _discoveredDevices = [];
  late BluetoothConnection _blueDevice;
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
                        child: Lottie.asset(Theme.of(context)
                                    .colorScheme
                                    .surface ==
                                Colors.grey.shade300
                            ? 'assets/spiderloading/blackspider_loading.json'
                            : 'assets/spiderloading/whitespider_loading.json'),
                      ),
                    )
                  // TODO try to make it stream builder not listview
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
                              builder: (context) => Controllerscreen(
                                  // blueDevice: _blueDevice,
                                  ),
                            ),
                          );
                        },
                      ),
                    ),
            ),
            SizedBox(
              height: 120.h,
            ),
            // start scanning and add list of scanned devices
            TextButton(
              onPressed: () {
                if (isblueScanning == false) {
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
                      setState(
                        () {
                          isblueScanning = false;
                        },
                      );
                    },
                  );
                }
              },
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
                  // ignore: use_build_context_synchronously
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
}
