import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zwey_walker/screens/checkblue_screen.dart';
import 'package:zwey_walker/theme/dark_theme.dart';
import 'package:zwey_walker/theme/light_theme.dart';
import 'package:zwey_walker/theme/theme_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(ListenableProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) => ScreenUtilInit(
        designSize: const Size(360, 690),
        child: MaterialApp(
          theme: myLightMode,
          darkTheme: myDarkMode,
          themeMode: themeProvider.themeMode,
          debugShowCheckedModeBanner: false,
          home: CheckBluetoothScreen(),
        ),
      ),
    );
  }
}
