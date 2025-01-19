import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:holding_gesture/holding_gesture.dart';

class ControllerArrows extends StatelessWidget {
  const ControllerArrows({
    super.key,
    required this.name,
    required this.onHold,
    this.imageScale = 9,
    this.highet = 80,
    this.width = 80,
  });
  final String name;
  final void Function() onHold;
  final double highet;
  final double width;
  final double imageScale;

  @override
  Widget build(BuildContext context) {
    return HoldDetector(
      onHold: onHold,
      child: SizedBox(
        height: highet.h,
        width: width.w,
        child: SvgPicture.asset(
          name,
          theme: SvgTheme(
            currentColor: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
    );
  }
}
