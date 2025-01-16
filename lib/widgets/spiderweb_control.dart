import 'dart:math';
import 'package:flutter/material.dart';

class SpiderWebControl extends StatefulWidget {
  const SpiderWebControl({
    super.key,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.topright,
    this.topleft,
    this.bottomright,
    this.bottomleft,
  });
  final Function? top;
  final Function? bottom;
  final Function? left;
  final Function? right;
  final Function? topright;
  final Function? topleft;
  final Function? bottomright;
  final Function? bottomleft;

  @override
  State<SpiderWebControl> createState() => _SpiderWebControlState();
}

class _SpiderWebControlState extends State<SpiderWebControl> {
  Offset _touchPosition = Offset(-1, -1);
  late double _containerWidth;
  late double _containerHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _containerWidth = MediaQuery.of(context).size.width;
            _containerHeight = MediaQuery.of(context).size.height;

            // Check if touch is inside the container's bounds
            if (_isTouchInsideContainer(details.localPosition)) {
              _touchPosition = details.localPosition;
              _printTouchDirection(details.localPosition,
                  context); // Print direction only when inside container
            }
          });
        },
        onPanEnd: (_) {
          setState(() {
            _touchPosition = Offset(-1, -1);
          });
        },
        child: CustomPaint(
          painter: LightEffectPainter(_touchPosition),
        ),
      ),
    );
  }

  // Checks if the touch position is inside the circular container
  bool _isTouchInsideContainer(Offset position) {
    final center = Offset(_containerWidth / 2, _containerHeight / 2);
    final radius = _containerWidth / 2;
    double distance = (position - center).distance;
    return distance <= radius;
  }

  // on diraction trigger
  void _printTouchDirection(Offset position, BuildContext context) {
    final center = Offset(MediaQuery.of(context).size.width / 2,
        MediaQuery.of(context).size.height / 2);
    final angle = atan2(position.dy - center.dy, position.dx - center.dx);
    final direction = _getDirectionFromAngle(angle, context);
    print('Touch Direction: $direction');
  }

  String _getDirectionFromAngle(double angle, BuildContext context) {
    // Set a larger threshold for the disabled center area (e.g., 100px radius)
    double centerThreshold = 80.0;
    double centerDistance = (_touchPosition -
            Offset(MediaQuery.of(context).size.width / 2,
                MediaQuery.of(context).size.height / 2))
        .distance;

    // If the touch is inside the disabled center zone, don't trigger direction
    if (centerDistance < centerThreshold) {
      return 'Disabled Zone';
    }

    // Otherwise, proceed to determine direction
    if (angle >= -pi / 8 && angle < pi / 8) {
      return 'Right';
    } else if (angle >= pi / 8 && angle < 3 * pi / 8) {
      return 'Bottom Right';
    } else if (angle >= 3 * pi / 8 && angle < 5 * pi / 8) {
      return 'Bottom';
    } else if (angle >= 5 * pi / 8 && angle < 7 * pi / 8) {
      return 'Bottom Left';
    } else if (angle >= 7 * pi / 8 || angle < -7 * pi / 8) {
      return 'Left';
    } else if (angle >= -7 * pi / 8 && angle < -5 * pi / 8) {
      return 'Top Left';
    } else if (angle >= -5 * pi / 8 && angle < -3 * pi / 8) {
      return 'Top';
    } else {
      return 'Top Right';
    }
  }
}

class LightEffectPainter extends CustomPainter {
  final Offset touchPosition;
  final int radialDivisions = 36;
  final int circleDivisions = 25;
  final double maxDistance = 400;
  final double dentDepth = 10.0;
  final List<Offset> webPoints = [];
  final Random random;

  LightEffectPainter(this.touchPosition, {int seed = 0})
      : random = Random(seed);

  @override
  void paint(Canvas canvas, Size size) {
    if (webPoints.isEmpty) {
      _initializeWeb(size);
    }

    List<Offset> warpedPoints = [];

    for (var point in webPoints) {
      double distance = (point - touchPosition).distance;

      if (distance < maxDistance) {
        warpedPoints.add(_warpPosition(point, touchPosition, distance));
      } else {
        warpedPoints.add(point);
      }
    }

    _drawWeb(canvas, size, warpedPoints);
  }

  void _initializeWeb(Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double maxRadius = size.shortestSide / 2;

    for (int r = 1; r <= circleDivisions; r++) {
      double radius = maxRadius * (r / circleDivisions);
      for (int i = 0; i < radialDivisions; i++) {
        double angle = (2 * pi / radialDivisions) * i;
        double randomOffset = (random.nextDouble() - 0.5) * radius * 0.05;
        Offset point = Offset(
          centerX + (radius + randomOffset) * cos(angle),
          centerY + (radius + randomOffset) * sin(angle),
        );
        webPoints.add(point);
      }
    }
  }

  void _drawWeb(Canvas canvas, Size size, List<Offset> warpedPoints) {
    for (int r = 0; r < circleDivisions; r++) {
      for (int i = 0; i < radialDivisions; i++) {
        int currentIndex = r * radialDivisions + i;
        int nextIndex = currentIndex + 1 < (r + 1) * radialDivisions
            ? currentIndex + 1
            : r * radialDivisions;
        int radialIndex = currentIndex + radialDivisions < warpedPoints.length
            ? currentIndex + radialDivisions
            : -1;

        if (nextIndex >= 0) {
          Paint mainThreadPaint = Paint()
            ..color = Colors.grey.shade600.withValues(alpha: 0.8)
            ..strokeWidth = 1.5
            ..isAntiAlias = true;
          canvas.drawLine(warpedPoints[currentIndex], warpedPoints[nextIndex],
              mainThreadPaint);
        }

        if (radialIndex >= 0) {
          Paint radialThreadPaint = Paint()
            ..color = Colors.grey.shade600.withValues(alpha: 0.8)
            ..strokeWidth = 1.5
            ..isAntiAlias = true;
          canvas.drawLine(warpedPoints[currentIndex], warpedPoints[radialIndex],
              radialThreadPaint);
        }

        if (nextIndex >= 0 && radialIndex >= 0) {
          Offset midPoint =
              (warpedPoints[currentIndex] + warpedPoints[nextIndex]) / 2;
          Paint minorThreadPaint = Paint()
            ..color = Colors.grey.shade700.withValues(alpha: 0.6)
            ..strokeWidth = 0.5
            ..isAntiAlias = true;
          canvas.drawLine(
              midPoint, warpedPoints[radialIndex], minorThreadPaint);
        }
      }
    }

    Paint dewDropPaint = Paint()..color = Colors.white.withValues(alpha: 0.6);
    for (var point in warpedPoints) {
      if (random.nextDouble() < 0.05) {
        canvas.drawCircle(point, 2.0, dewDropPaint);
      }
    }
  }

  Offset _warpPosition(Offset original, Offset center, double distance) {
    double displacement = dentDepth * exp(-pow(distance / maxDistance, 2));
    Offset direction = (center - original).normalize();
    return original + direction * displacement;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

extension on Offset {
  Offset normalize() {
    double length = distance;
    return length > 0 ? this / length : Offset.zero;
  }
}
