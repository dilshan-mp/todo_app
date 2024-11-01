import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/loginPages/loginPage.dart';
import 'package:todo_app/widgets/mainButton.dart';
import 'package:todo_app/widgets/textFields.dart';
import 'package:todo_app/widgets/transparentMainButton.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _Registerpagestate();
}

class _Registerpagestate extends State<Registerpage> {
  String email = "", password = "", userName = "";

  final TextEditingController usernamecontroller = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> registration() async {
    // Update email, username, and password before registration
    setState(() {
      email = emailcontroller.text.trim();
      userName = usernamecontroller.text.trim();
      password = passwordController.text;
    });

    if (password.isNotEmpty && userName.isNotEmpty && email.isNotEmpty) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        addUsersToFireStore(userCredential.user!);

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Registered Successfully",
            style: TextStyle(fontSize: 20.0),
          ),
        ));

        // Navigate to login page after successful registratio
        Navigator.pushReplacementNamed(context, '/firstLoginPage');
      } on FirebaseAuthException catch (e) {
        // Display error messages based on FirebaseAuthException codes
        String errorMessage;
        if (e.code == 'weak-password') {
          errorMessage = "Password provided is too weak.";
        } else if (e.code == 'email-already-in-use') {
          errorMessage = "An account already exists with this email.";
        } else {
          errorMessage = "Error: ${e.message}";
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            errorMessage,
            style: const TextStyle(fontSize: 18.0),
          ),
        ));
      }
    }
  }

  void addUsersToFireStore(User firebaseUser) async {
    String name = usernamecontroller.text;
    String email = emailcontroller.text;
    if (name.isNotEmpty && email.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(firebaseUser.uid)
          .set({'name': name, 'email': email});
    }
  }

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
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
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
                'Register',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 53),
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
            const SizedBox(height: 5),
            Textfields(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a username';
                }
                return null;
              },
              hintText: 'Enter UserName',
              textInputType: TextInputType.text,
              isPassword: false,
              textEditingController: usernamecontroller,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 24, top: 25),
              child: Text(
                'Email',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Textfields(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an email';
                }
                return null;
              },
              hintText: 'Enter Email',
              textInputType: TextInputType.emailAddress,
              isPassword: false,
              textEditingController: emailcontroller,
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
            const SizedBox(height: 5),
            Textfields(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                return null;
              },
              hintText: 'Enter Password',
              textInputType: TextInputType.visiblePassword,
              isPassword: true,
              textEditingController: passwordController,
            ),
            const SizedBox(height: 50),
            Center(
              child: MainButton(
                buttontext: 'Register',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await registration();
                  }
                },
              ),
            ),
            const SizedBox(height: 31),
            Center(child: Image.asset('assets/Divider.png')),
            const SizedBox(height: 29),
            Center(
              child: TransparentMainButton(
                imageAsset: 'assets/google.png',
                buttonText: 'Login With Google',
                onPressed: () {},
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: TransparentMainButton(
                imageAsset: 'assets/apple.png',
                buttonText: 'Login With Apple',
                onPressed: () {},
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
