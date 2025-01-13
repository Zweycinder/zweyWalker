import 'package:flutter/material.dart';

class MySnackBar extends StatelessWidget {
  const MySnackBar({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
    );
  }
}
