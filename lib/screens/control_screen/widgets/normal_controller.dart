import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zwey_walker/screens/control_screen/widgets/controller_arrows.dart';

class NormalControl extends StatefulWidget {
  const NormalControl({super.key});

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
          children: [
            SizedBox(
              height: 80.h,
              width: 80.h,
            ),
            ControllerArrows(
              name: 'assets/controller_assets/top.png',
              onHold: () {
                print('cat');
              },
            ),
            ControllerArrows(
              name: 'assets/controller_assets/rotate_left.png',
              onHold: () {},
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ControllerArrows(
              name: 'assets/controller_assets/left.png',
              onHold: () {},
            ),
            ControllerArrows(
              name: 'assets/controller_assets/center.png',
              onHold: () {},
              imageScale: 7,
            ),
            ControllerArrows(
              name: 'assets/controller_assets/right.png',
              onHold: () {},
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 80.h,
              width: 80.h,
            ),
            ControllerArrows(
              name: 'assets/controller_assets/bottom.png',
              onHold: () {
                print('cat');
              },
            ),
            ControllerArrows(
              name: 'assets/controller_assets/rotate_right.png',
              onHold: () {},
            ),
          ],
        ),
      ],
    );
  }
}
