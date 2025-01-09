import 'package:flutter/material.dart';
import 'package:zwey_walker/blue_start.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zwey_walker/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      child: MaterialApp(
        home: Scaffold(
          body: const ConnectionScreen(),
        ),
      ),
    );
  }
}
