import 'package:flutter/material.dart';
import 'package:zwey_walker/screens/control_screen/widgets/normal_controller.dart';
import 'package:zwey_walker/screens/control_screen/widgets/spiderweb_controller.dart';

class Controllerscreen extends StatefulWidget {
  const Controllerscreen({
    super.key,
    // required this.blueDevice,
  });
  // final BluetoothConnection blueDevice;

  @override
  State<Controllerscreen> createState() => _ControllerscreenState();
}

class _ControllerscreenState extends State<Controllerscreen> {
  bool controller = true;

  @override
  void initState() {
    super.initState();
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('C O N T R O L'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                controller = !controller;
              });
            },
            icon: Icon(
              Icons.control_camera_sharp,
            ),
          )
        ],
      ),
      body: controller ? SpiderWebControl() : NormalControl(),
    );
  }
}
