import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "INDEX",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black26,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GestureDetector(
              onTap: () {
                print("User image tapped");
              },
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/user_image.png'),
                radius: 20,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/Frame 162.png'),
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text(
                  'What do you want to do today?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const Text(
                'Tap + to add your tasks',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
