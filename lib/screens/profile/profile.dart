import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero, // Removes padding around the image
                  shape: CircleBorder(),
                  fixedSize: Size(60, 60)),
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/profile_picture.jpg',
                ), // or NetworkImage for a URL
                radius: 20, // Adjust the size of the profile picture
              ),
            ),
          )
        ],
      ),
    );
  }
}
