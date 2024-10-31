import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/screens/bottomNavigation.dart';
import 'package:todo_app/screens/loginPages/firstPage.dart';
import 'package:todo_app/screens/loginPages/loginPage.dart';
import 'package:todo_app/screens/loginPages/registerPage.dart';
import 'package:todo_app/screens/splashPages/firstPage.dart';
import 'package:todo_app/screens/splashPages/secondPage.dart';
import 'package:todo_app/screens/taskPage/editPage.dart';
import 'package:todo_app/screens/taskPage/homePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: FirstPage(),
      initialRoute: '/firstPage',
      routes: {
        //splashScreens
        '/firstPage': (context) => const FirstPage(),
        'onBoardPage': (context) => const OnboardingPage(),

        //login pages
        '/firstLoginPage': (context) => const FirstLoginPage(),
        '/loginPage': (context) => const LoginPage(),
        '/registerPage': (context) => const Registerpage(),

        //taskPage
        "/homePage": (context) => const HomePage(),

        //bottomnavigation
        "bottomNavigation": (context) => BottomNavigationBarExample()
      },
    );
  }
}
