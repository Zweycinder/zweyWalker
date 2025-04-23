import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zwey_walker/gemini_ai.dart';
import 'package:zwey_walker/theme/dark_theme.dart';

import 'package:zwey_walker/theme/light_theme.dart';
import 'package:zwey_walker/screens/home_screen.dart';
import 'package:zwey_walker/theme/theme_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  MyAI().geminiInit();

  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  runApp(
    ChangeNotifierProvider<ThemeProvider>(
      create: (context) => themeProvider,
      child: const MyApp(),
    ),
  );
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
          home: HomeScreen(),
        ),
      ),
    );
  }
}
