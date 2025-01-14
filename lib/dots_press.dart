// import 'dart:math';

// import 'package:flutter/material.dart';

// class LightEffectContainer extends StatefulWidget {
//   @override
//   _LightEffectContainerState createState() => _LightEffectContainerState();
// }

// class _LightEffectContainerState extends State<LightEffectContainer> {
//   Offset _touchPosition = Offset(-1, -1); // Default no touch position

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: GestureDetector(
//         onPanUpdate: (details) {
//           setState(() {
//             _touchPosition = details.localPosition; // Get touch position
//           });
//         },
//         onPanEnd: (_) {
//           setState(() {
//             _touchPosition = Offset(-1, -1); // Reset touch position
//           });
//         },
//         child: Container(
//           width: double.maxFinite,
//           height: double.maxFinite,
//           color: Colors.black, // Background color for the container
//           child: CustomPaint(
//             painter: LightEffectPainter(_touchPosition),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class LightEffectPainter extends CustomPainter {
//   final Offset touchPosition;
//   final int dotGridSize = 10; // Grid size for primary dots
//   final double dotRadius = 1.0; // Default radius for primary dots
//   final double maxDistance = 100; // Maximum distance for gravity effect
//   final double gravityStrength = 0.2; // Strength of gravity-like pull
//   final int interpolationSteps = 2; // Number of smaller dots between main dots

//   LightEffectPainter(this.touchPosition);

//   @override
//   void paint(Canvas canvas, Size size) {
//     for (double x = 0; x < size.width; x += dotGridSize) {
//       for (double y = 0; y < size.height; y += dotGridSize) {
//         Offset originalPosition = Offset(x, y);
//         double distance = (originalPosition - touchPosition).distance;

//         if (touchPosition.dx == -1 && touchPosition.dy == -1) {
//           distance = maxDistance;
//         }

//         Color gradientColor = distance < maxDistance
//             ? Color.lerp(
//                 Colors.white, Colors.grey.shade800, distance / maxDistance)!
//             : Colors.grey.shade800;

//         Paint paint = Paint()..color = gradientColor;

//         double dynamicRadius = distance < maxDistance
//             ? dotRadius + (1 - distance / maxDistance) * 4
//             : dotRadius;

//         Offset currentPosition = distance < maxDistance &&
//                 touchPosition.dx != -1 &&
//                 touchPosition.dy != -1
//             ? _moveDotTowards(originalPosition, touchPosition, distance)
//             : originalPosition;

//         canvas.drawCircle(currentPosition, dynamicRadius, paint);

//         if (distance < maxDistance / 2) {
//           Paint glowPaint = Paint()
//             ..color = Colors.white.withOpacity(0.2)
//             ..maskFilter = MaskFilter.blur(
//                 BlurStyle.normal, (maxDistance - distance) * 0.1);
//           canvas.drawCircle(currentPosition, dynamicRadius * 2, glowPaint);
//         }

//         // Smooth interpolation for smaller dots
//         if (x + dotGridSize < size.width) {
//           _drawInterpolatedDots(
//               canvas, originalPosition, Offset(x + dotGridSize, y), distance);
//         }
//         if (y + dotGridSize < size.height) {
//           _drawInterpolatedDots(
//               canvas, originalPosition, Offset(x, y + dotGridSize), distance);
//         }
//       }
//     }
//   }

//   void _drawInterpolatedDots(
//       Canvas canvas, Offset pos1, Offset pos2, double distance) {
//     for (int i = 1; i <= interpolationSteps; i++) {
//       double t = i / (interpolationSteps + 1);
//       Offset interpolatedPosition = Offset.lerp(pos1, pos2, t)!;
//       double interpolatedRadius = dotRadius * 0.5 * (1 - t) + dotRadius * 0.5;
//       Color interpolatedColor = distance < maxDistance
//           ? Color.lerp(
//               Colors.white, Colors.grey.shade600, distance / maxDistance)!
//           : Colors.grey.shade600;

//       Paint smallerDotPaint = Paint()..color = interpolatedColor;

//       canvas.drawCircle(
//           interpolatedPosition, interpolatedRadius, smallerDotPaint);
//     }
//   }

//   Offset _moveDotTowards(Offset from, Offset to, double distance) {
//     double t = 1 - (distance / maxDistance);
//     return Offset.lerp(from, to, t * gravityStrength)!;
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
