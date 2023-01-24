import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_revision_22_1_23/views/home_page.dart';
import 'package:firebase_revision_22_1_23/views/login.dart';
import 'package:firebase_revision_22_1_23/views/record.dart';
import 'package:firebase_revision_22_1_23/views/singup.dart';
import 'package:firebase_revision_22_1_23/views/splash_screen.dart';
import 'package:firebase_revision_22_1_23/views/verifypage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/intro_Screen',
      getPages: <GetPage>[
        GetPage(name: '/intro_Screen', page: () => SplashScreen()),
        GetPage(name: '/v', page: () => verifyPage()),
        GetPage(name: '/login', page: () => Login()),
        GetPage(name: '/sign_Up', page: () => SignUp()),
        GetPage(name: '/home_page', page: () => HomePage()),
        GetPage(name: '/intro_Screen', page: () => SplashScreen()),
        GetPage(name: '/record', page: () => Record()),
      ],
    ),
  );
  // runApp(
  //   MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     initialRoute: 'intro_Screen',
  //     routes: {
  //       'intro_Screen': (context) => const SplashScreen(),
  //       'home_page': (context) => const HomePage(),
  //       'v': (context) => const verifyPage(),
  //       'login': (context) => const Login(),
  //       'sign_Up': (context) => SignUp(),
  //     },
  //   ),
  // );
}
