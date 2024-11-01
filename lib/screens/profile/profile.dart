import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  Uint8List? _webImage;
  String _userName = 'user';
  String editedName = '';

  @override
  void initState() {
    super.initState();
    editedName = _userName;
    _loadImage();
    getUserName();
  }

  Future<void> _loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (kIsWeb) {
      String? imageData = prefs.getString('profile_image');
      if (imageData != null) {
        setState(() {
          _webImage = Uri.parse(imageData)
              .data!
              .contentAsBytes(); // Load image data for web
        });
      }
    } else {
      String? imagePath = prefs.getString('profile_image');
      if (imagePath != null) {
        setState(() {
          _profileImage = File(imagePath); // Load image path for mobile
        });
      }
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (kIsWeb) {
        Uint8List bytes = await pickedFile.readAsBytes();
        setState(() {
          _webImage = bytes; // Update the state with the image bytes
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('profile_image',
            Uri.dataFromBytes(_webImage!).toString()); // Save as data URI
      } else {
        setState(() {
          _profileImage =
              File(pickedFile.path); // Update the state with the selected image
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            'profile_image', pickedFile.path); // Save the file path
      }
    }
  }
  void _showDialogBox() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Task"),
          content: TextField(
            onChanged: (value) {
              editedName = value; // Update the edited task text
            },
            controller: TextEditingController(text: editedName),
            decoration: const InputDecoration(
              hintText: "Enter new task text",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _userName = editedName;
                });
                updateUserNameInFirestore(editedName);
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Future<String> getUserName() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .get();
        if (userDoc.exists && userDoc.data() != null) {
          Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;
          setState(() {
            _userName = userData['name'] ?? 'User';
            editedName = _userName;
          });
        }
      }
    } catch (e) {
      print('Error fetching user name: $e');
    }
    return 'user';
  }

  Future<void> updateUserNameInFirestore(String newName) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .update({
          'name': newName,
        });
        print('User name updated successfully');
      }
    } catch (e) {
      print('Error updating user name: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: _pickImage,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: const CircleBorder(),
                    fixedSize: const Size(60, 60),
                  ),
                  child: CircleAvatar(
                    backgroundImage: kIsWeb
                        ? (_webImage != null ? MemoryImage(_webImage!) : null)
                        : (_profileImage != null
                            ? FileImage(_profileImage!)
                            : null),
                    radius: 40,
                    child: (_webImage == null && _profileImage == null)
                        ? const Icon(
                            Icons.camera_alt,
                            size: 60,
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                _userName,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20, right: 20),
                child: IconButton(
                  onPressed: _showDialogBox,
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Container(
                  color: Color(0XFF363636),
                  width: 154,
                  height: 58,
                  child: const Center(
                      child: Text(
                    '10 Task Left',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  )),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Container(
                  color: const Color(0XFF363636),
                  width: 154,
                  height: 58,
                  child: const Center(
                    child: Text(
                      '5 Task Done',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 24),
                    child: Text(
                      'Setting',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 24,
                        ),
                        child: Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 24,
                        ),
                        child: Text(
                          'App Setings',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 24),
                    child: Text(
                      'Account',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 24,
                        ),
                        child: Icon(
                          Icons.person_outline_outlined,
                          color: Colors.white,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 24,
                        ),
                        child: Text(
                          'Change Account name',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 24,
                        ),
                        child: Icon(
                          Icons.key,
                          color: Colors.white,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 24,
                        ),
                        child: Text(
                          'Change Account password',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 24,
                        ),
                        child: Icon(
                          Icons.image,
                          color: Colors.white,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 24,
                        ),
                        child: Text(
                          'Change Account Image',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 24),
                    child: Text(
                      'Uptodo',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 24,
                        ),
                        child: Icon(
                          Icons.movie_creation_rounded,
                          color: Colors.white,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 24,
                        ),
                        child: Text(
                          'About Us',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 24,
                        ),
                        child: Icon(
                          Icons.do_not_disturb,
                          color: Colors.white,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 24,
                        ),
                        child: Text(
                          'FAQ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 24,
                        ),
                        child: Icon(
                          Icons.help,
                          color: Colors.white,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 24,
                        ),
                        child: Text(
                          'Help & FeedBack',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 24,
                        ),
                        child: Icon(
                          Icons.thumb_up,
                          color: Colors.white,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 24,
                        ),
                        child: Text(
                          'Support Us',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 24,
                        ),
                        child: Icon(
                          Icons.logout,
                          color: Colors.red,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 24,
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, '/firstLoginPage');
                          },
                          child: const Text(
                            'Log Out',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
