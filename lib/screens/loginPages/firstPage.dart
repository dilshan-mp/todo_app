import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/widgets/mainButton.dart';
import 'package:todo_app/widgets/transparentMainButton.dart';

class FirstLoginPage extends StatelessWidget {
  const FirstLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black26,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 120),
            child: Center(
              child: Text(
                'Welcome to UpTodo',
                style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          SizedBox(
            height: 26,
          ),
          Padding(
            padding: EdgeInsets.only(left: 44, right: 44),
            child: Center(
              child: Text(
                'Please login to your account or create \nnew account to continue',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Spacer(),
          MainButton(
            buttontext: 'LOGIN',
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 40, top: 20),
            child: TransparentMainButton(buttontext: 'CREATE ACCOUNT'),
          )
        ],
      ),
    );
  }
}
