import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zwey_walker/theme/theme_provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 300,
          ),
          Switch(
            activeColor: Colors.green,
            value:
                Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
                    ? true
                    : false,
            onChanged: (value) {
              ThemeProvider themeProvider = Provider.of(context, listen: false);
              if (themeProvider.themeMode == ThemeMode.light) {
                themeProvider.setTheme(ThemeMode.dark);
              } else {
                themeProvider.setTheme(ThemeMode.light);
              }
            },
          )
        ],
      ),
    );
  }
}
