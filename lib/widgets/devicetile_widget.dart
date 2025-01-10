import 'package:flutter/material.dart';

class BlueDeviceTile extends StatelessWidget {
  const BlueDeviceTile({
    super.key,
    required this.name,
    required this.address,
  });
  final String name;
  final String address;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text(address),
    );
  }
}
