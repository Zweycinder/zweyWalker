// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:lottie/lottie.dart';
// import 'package:zwey_walker/blue_start.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//         // ignore: use_build_context_synchronously
//         context,
//         MaterialPageRoute(
//             builder: (context) =>
//                 ConnectionScreen()), // Replace with your main screen
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       child: Center(
//         child: SizedBox(
//           child: Lottie.asset('assets/spider_splashscreen.json'),
//           height: 100.h,
//           width: 100.w,
//         ),
//       ),
//     );
//   }
// }
