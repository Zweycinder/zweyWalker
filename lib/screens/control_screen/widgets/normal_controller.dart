import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zwey_walker/screens/control_screen/widgets/controller_arrows.dart';

class NormalControl extends StatefulWidget {
  const NormalControl({super.key, required this.blueDevice});
  final BluetoothConnection blueDevice;
  @override
  State<NormalControl> createState() => _NormalControlState();
}

class _NormalControlState extends State<NormalControl> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 80.h, width: 80.w),
            ControllerArrows(
              name: 'assets/controller_assets/top.svg',
              onHold: () {
                widget.blueDevice.output.add(Uint8List.fromList('L'.codeUnits));
              },
            ),
            // ControllerArrows(
            //   name: 'assets/controller_assets/rotate_left.svg',
            //   onHold: () {
            //     widget.blueDevice.output
            //         .add(Uint8List.fromList("1105".codeUnits));
            //   },
            // ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ControllerArrows(
              name: 'assets/controller_assets/left.svg',
              onHold: () {
                widget.blueDevice.output.add(Uint8List.fromList('B'.codeUnits));

                widget.blueDevice.output.add(Uint8List.fromList('B'.codeUnits));
              },
            ),
            ControllerArrows(
              name: 'assets/controller_assets/center.svg',
              onHold: () {
                widget.blueDevice.output.add(Uint8List.fromList(' '.codeUnits));
              },
            ),
            ControllerArrows(
              name: 'assets/controller_assets/right.svg',
              onHold: () {
                widget.blueDevice.output.add(Uint8List.fromList('T'.codeUnits));
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 80.h, width: 80.w),
            ControllerArrows(
              name: 'assets/controller_assets/bottom.svg',
              onHold: () {
                widget.blueDevice.output.add(Uint8List.fromList('R'.codeUnits));
              },
            ),
            // ControllerArrows(
            //   name: 'assets/controller_assets/rotate_right.svg',
            //   onHold: () {
            //     widget.blueDevice.output
            //         .add(Uint8List.fromList("1106".codeUnits));
            //   },
            // ),
          ],
        ),
      ],
    );
  }
}
