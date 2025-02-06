import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zwey_walker/theme/dark_theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:zwey_walker/theme/light_theme.dart';
import 'package:zwey_walker/screens/home_screen.dart';
import 'package:zwey_walker/theme/theme_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    throw Exception('Error loading .env file: $e');
  }

  OpenAI.instance.build(
      token: dotenv.env['Token'],
      baseOption: HttpSetup(
        receiveTimeout: const Duration(seconds: 20),
      ),
      enableLog: true);

  runApp(
    ListenableProvider(
      create: (context) => ThemeProvider(),
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
