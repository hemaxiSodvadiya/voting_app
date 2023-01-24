import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    // TODO: implement initState
    super.initState();

    Duration duration = Duration(seconds: 4);

    Timer(duration, () {
      Navigator.of(context).pushReplacementNamed('/v');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text(
            "Voting App",
            style: TextStyle(
                fontSize: 60, color: Colors.black, fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }
}
