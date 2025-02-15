import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zwey_walker/theme/theme_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 200.h,
            child: Center(child: Text('LOGO')),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Divider(),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(12),
            child: Row(
              children: [
                const Text(
                  "Dark Mode",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Switch(
                  activeColor: Colors.green,
                  value: Provider.of<ThemeProvider>(context).themeMode ==
                          ThemeMode.dark
                      ? true
                      : false,
                  onChanged: (value) {
                    ThemeProvider themeProvider =
                        Provider.of(context, listen: false);
                    if (themeProvider.themeMode == ThemeMode.light) {
                      themeProvider.setTheme(ThemeMode.dark);
                    } else {
                      themeProvider.setTheme(ThemeMode.light);
                    }
                  },
                )
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Text(
              'Made by Zweycinder',
              style: TextStyle(
                fontFamily: 'OptimusPrinceps',
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ],
      ),
    );
  }
}
