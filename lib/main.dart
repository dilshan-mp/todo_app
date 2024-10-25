import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/loginPages/firstPage.dart';
import 'package:todo_app/screens/loginPages/loginPage.dart';
import 'package:todo_app/screens/loginPages/registerPage.dart';
import 'package:todo_app/screens/splashPages/firstPage.dart';
import 'package:todo_app/screens/splashPages/fourthPage.dart';
import 'package:todo_app/screens/splashPages/secondPage.dart';
import 'package:todo_app/screens/splashPages/thirdScreen.dart';

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => MyApp(), // Wrap your app
      ),
    );

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
      home: const SecondPage(),
      initialRoute: '/firstPage',
      routes: {
        //splashScreens
        '/firstPage': (context) => const FirstPage(),
        '/secondPage': (context) => const SecondPage(),
        '/thirdPage': (context) => const ThirdScreen(),
        '/fourthPage': (context) => const Fourthpage(),
        //login pages
        '/firstLoginPage': (context) => const FirstLoginPage(),
        '/loginPage': (context) => const LoginPage(),
        '/registerPage': (context) => const Registerpage(),
      },
    );
  }
}
