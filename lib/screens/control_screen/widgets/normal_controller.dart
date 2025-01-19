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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 80.h, width: 80.w),
            ControllerArrows(
              name: 'assets/controller_assets/top.svg',
              onHold: () {},
            ),
            ControllerArrows(
              name: 'assets/controller_assets/rotate_left.svg',
              onHold: () {},
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ControllerArrows(
              name: 'assets/controller_assets/left.svg',
              onHold: () {},
            ),
            ControllerArrows(
              name: 'assets/controller_assets/center.svg',
              onHold: () {},
            ),
            ControllerArrows(
              name: 'assets/controller_assets/right.svg',
              onHold: () {},
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 80.h, width: 80.w),
            ControllerArrows(
              name: 'assets/controller_assets/bottom.svg',
              onHold: () {},
            ),
            ControllerArrows(
              name: 'assets/controller_assets/rotate_right.svg',
              onHold: () {},
            ),
          ],
        ),
      ],
    );
  }
}
