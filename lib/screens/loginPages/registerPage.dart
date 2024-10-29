import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/loginPages/loginPage.dart';
import 'package:todo_app/services/database.dart';
import 'package:todo_app/widgets/mainButton.dart';
import 'package:todo_app/widgets/textFields.dart';
import 'package:todo_app/widgets/transparentMainButton.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _LoginPageState();
}

class _LoginPageState extends State<Registerpage> {
  String email = "", password = "";
  String confirmPassword = "";

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  Future<void> register() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Create user with email and password
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        User? user = userCredential.user;

        if (user != null) {
          // Prepare user info to store in Firestore
          Map<String, dynamic> userInfoMap = {
            "email":
                email, // Save email from the form // Save name from the form
            "imgUrl": "", // Optionally save an image URL, if applicable
            "id": user.uid // Use Firebase user ID
          };

          // Store user info in Firestore
          await DatabaseMethods().addUser(user.uid, userInfoMap);

          // Navigate to the home page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('Register Successful', style: TextStyle(fontSize: 20)),
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        String message;
        if (e.code == 'weak-password') {
          message = "Password provided is too weak.";
        } else if (e.code == 'email-already-in-use') {
          message = "An account already exists with this email.";
        } else {
          message = "An error occurred: ${e.message}";
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(message, style: const TextStyle(fontSize: 18)),
          ),
        );
      } catch (e) {
        print("Error: $e"); // Logs any other errors to the console
      }
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
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an email';
                } else if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              hintText: 'Enter email',
              textInputType: TextInputType.emailAddress,
              isPassword: false,
              textEditingController: emailController,
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
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter a password'
                  : null,
              hintText: 'Enter password',
              textInputType: TextInputType.visiblePassword,
              isPassword: true,
              textEditingController: passwordController,
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
              validator: (value) => value == null || value.isEmpty
                  ? 'Please confirm your password'
                  : null,
              hintText: 'Confirm password',
              textInputType: TextInputType.visiblePassword,
              isPassword: true,
              textEditingController: confirmPasswordController,
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: MainButton(
                buttontext: 'Register',
                onPressed: () {
                  email = emailController.text.trim();
                  password = passwordController.text.trim();
                  confirmPassword = confirmPasswordController.text.trim();

                  if (password == confirmPassword) {
                    register();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Passwords do not match.",
                            style: TextStyle(fontSize: 18)),
                      ),
                    );
                  }
                  register();
                },
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
      ),
    );
  }
}
