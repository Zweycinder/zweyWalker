import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ControllerArrows extends StatelessWidget {
  const ControllerArrows({super.key, required this.name, required this.onTap});
  final String name;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        name,
        scale: 10.w,
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
    );
  }
}
