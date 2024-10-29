import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/taskPage/homePage.dart';
import 'package:todo_app/services/auth.dart';
import 'package:todo_app/widgets/mainButton.dart';
import 'package:todo_app/widgets/textFields.dart';
import 'package:todo_app/widgets/transparentMainButton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "", password = "";
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login Successful', style: TextStyle(fontSize: 20)),
          ),
        );

        // Navigate to homepage after successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } on FirebaseAuthException catch (e) {
        String message = '';
        if (e.code == 'user-not-found') {
          message = "No user found for that email.";
        } else if (e.code == 'wrong-password') {
          message = "Wrong password provided for that user.";
        } else {
          message = "An error occurred. Please try again.";
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(message, style: const TextStyle(fontSize: 18)),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26, // Body color
      appBar: AppBar(
        backgroundColor: Colors.black26, // Match AppBar color to body color
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/firstLoginPage');
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 24),
              child: Text(
                'Login',
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
            Textfields(
              hintText: 'eneter email',
              textInputType: TextInputType.emailAddress,
              isPassword: false,
              textEditingController: emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter email';
                }
                return null;
              },
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
            Textfields(
              hintText: 'eneter password',
              textInputType: TextInputType.visiblePassword,
              isPassword: true,
              textEditingController: passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter password';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 69,
            ),
            Center(
              child: MainButton(buttontext: 'Login', onPressed: login),
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
                onPressed: () {
                  AuthMethods().signInWithGoogle(context);
                },
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
                      'Register',
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
