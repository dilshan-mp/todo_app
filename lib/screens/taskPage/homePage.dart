import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/bottomNavigation.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavigationBarExample(),
              ),
            );
          },
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
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('task')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Column(
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
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, Index) {
                  var task = snapshot.data!.docs[Index];
                  var taskText = task['task'];
                  var createdAt = (task['createdAt'] as Timestamp).toDate();

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xff363636),
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      child: ListTile(
                        leading: Checkbox(
                          value: false,
                          onChanged: (value) {},
                          shape: const CircleBorder(),
                          checkColor: Colors.white,
                          activeColor: Colors.white,
                        ),
                        title: Text(
                          taskText,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        ),
                        subtitle: Text(
                          '${createdAt.hour}:${createdAt.minute} ${createdAt.day}/${createdAt.month}/${createdAt.year}',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 11),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
