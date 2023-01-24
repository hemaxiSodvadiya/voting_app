import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helper/auth.dart';

class verifyPage extends StatefulWidget {
  const verifyPage({Key? key}) : super(key: key);

  @override
  State<verifyPage> createState() => _verifyPageState();
}

class _verifyPageState extends State<verifyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  Navigator.of(context).pushNamed('/login');
                });
              },
              child: const Text(
                "LOGIN",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w900),
              ),
              style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 130),
                  backgroundColor: const Color(0xffFFCB2B),
                  // fixedSize: const Size(300, 100),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          OutlinedButton(
            onPressed: () {
              setState(() {
                Navigator.of(context).pushNamed('/sign_Up');
              });
            },
            child: const Text(
              "SIGN UP",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w900),
            ),
            style: OutlinedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 130),
                side: const BorderSide(color: Color(0xffF5820D), width: 3),
                // fixedSize: const Size(300, 100),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
          ),
        ],
      ),
    );
  }
}
