import 'dart:async';

import 'package:adir_web_app/api/session.dart';
import 'package:adir_web_app/common/slide_route.dart';
import 'package:adir_web_app/models/user.dart';
import 'package:adir_web_app/pages/home_page.dart';
import 'package:adir_web_app/pages/motor_insurance_page.dart';
import 'package:adir_web_app/pages/questions_page/questions_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

import 'common/splash_screen.dart';
import 'kernel.dart';

const storage = FlutterSecureStorage();

Logger logger = Logger(
  printer: PrettyPrinter(
      methodCount: 1,
      errorMethodCount: 8,
      lineLength: 200,
      colors: true,
      printEmojis: true,
      printTime: false),
);

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        // statusBarColor: Colors.white,
        // statusBarIconBrightness: Brightness.dark,
        // statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    WidgetsFlutterBinding.ensureInitialized();
    runApp(const Launcher());
  }, (e, s) => logger.e('Global', error: e, stackTrace: s));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adir Web App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }

  Future<void> init() async {
//TODO fix this
    String? token = await storage.read(key: 'accessToken');
    String? mobileNumber = await storage.read(key: 'mobileNumber');
    String? password = await storage.read(key: 'password');

    if (token == null) {
      //TODO Change page
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          SlideRoute(
            page: const MotorInsurancePage(),
          ),
          (route) => false,
        );
      }
    } else {
      Session().accessToken = token;
      User? user;
      try {
        user = await Session().getLoggedInUser();
        if (mounted) {
          Session().init(context, user!);
          Navigator.of(context).pushReplacement(
            SlideRoute(
              page: const HomePage(),
            ),
          );
        }
      } catch (e) {
        //TODO Change page

        logger.e(e);
        Session().accessToken = null;
        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            SlideRoute(
              page: const QuestionsPage(),
            ),
            (route) => false,
          );
        }
      }
    }
  }
}
