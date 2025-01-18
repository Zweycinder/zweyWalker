import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zwey_walker/control_screen/widgets/controller_arrows.dart';

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
        ControllerArrows(
          name: 'assets/controller_assets/top.png',
          onTap: () {},
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ControllerArrows(
              name: 'assets/controller_assets/left.png',
              onTap: () {},
            ),
            SizedBox(
              width: 100,
              height: 100,
            ),
            ControllerArrows(
              name: 'assets/controller_assets/right.png',
              onTap: () {},
            ),
          ],
        ),
        ControllerArrows(
          name: 'assets/controller_assets/bottom.png',
          onTap: () {},
        ),
      ],
    );
  }
}
