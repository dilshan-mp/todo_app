import 'package:flutter/material.dart';
import 'package:todo_app/widgets/mainButton.dart';
import 'package:todo_app/widgets/textFields.dart';
import 'package:todo_app/widgets/transparentMainButton.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _LoginPageState();
}

class _LoginPageState extends State<Registerpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        backgroundColor: Colors.black26,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/firstLoginPage');
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 24),
            child: Text(
              'Register',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(
            height: 53,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 24),
            child: Text(
              'UserName',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Textfields(
            hintText: 'eneter name',
            textInputType: TextInputType.emailAddress,
            isPassword: false,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 24, top: 25),
            child: Text(
              'Password',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Textfields(
            hintText: 'eneter password',
            textInputType: TextInputType.visiblePassword,
            isPassword: true,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 24, top: 25),
            child: Text(
              'Password',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Textfields(
            hintText: 'eneter password',
            textInputType: TextInputType.visiblePassword,
            isPassword: true,
          ),
          const SizedBox(
            height: 50,
          ),
          Center(
            child: MainButton(
              buttontext: 'Register',
              onPressed: () {},
            ),
          ),
          const SizedBox(
            height: 31,
          ),
          Center(child: Image.asset('assets/Divider.png')),
          const SizedBox(
            height: 29,
          ),
          Center(
            child: TransparentMainButton(
              imageAsset: 'assets/google.png',
              buttonText: 'Login With Google',
              onPressed: () {},
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: TransparentMainButton(
              imageAsset: 'assets/apple.png',
              buttonText: 'Login With Apple',
              onPressed: () {},
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don’t have an account?",
                  style: TextStyle(color: Colors.white),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
