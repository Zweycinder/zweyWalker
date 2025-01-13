import 'package:flutter/material.dart';

class MyBlueDeviceTile extends StatelessWidget {
  const MyBlueDeviceTile(
      {super.key,
      required this.name,
      required this.address,
      required this.onTap});
  final String name;
  final String address;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text(address),
      onTap: onTap,
    );
  }
}
