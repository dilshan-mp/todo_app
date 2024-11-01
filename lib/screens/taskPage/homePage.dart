import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/bottomNavigation.dart';
import 'package:todo_app/screens/taskPage/editPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //final user = FirebaseAuth.instance.currentUser;
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
            print('User data: $userData');
            return userData['name'] ?? 'User';
          }
        }
        return 'user'; // Fallback in case of null data or non-existent document
      } catch (e) {
        print('Error fetching user name: $e');
        return 'user'; // Fallback in case of an error
      }
    }

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
        title: FutureBuilder(
            future: getUserName(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text(
                  "Loading....",
                  style: TextStyle(color: Colors.white),
                );
              }
              if (snapshot.hasError) {
                return const Text(
                  "Error",
                  style: TextStyle(color: Colors.white),
                );
              }
              return Text(
                "Hello ${snapshot.data}",
                style: const TextStyle(color: Colors.white),
              );
            }),
        backgroundColor: Colors.black26,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GestureDetector(
              onTap: () {
                print("User image tapped");
              },
              child: const CircleAvatar(
                backgroundImage: AssetImage(''),
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
                  var taskId = task.id;
                  var taskText = task['task'];
                  var createdAt = (task['createdAt'] as Timestamp).toDate();
                  var category = task['category'];
                  var categoryColor = task['categoryColor'];
                  var icon = task['categoryImage'];
                  var priority = task['priority'];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xff363636),
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      child: ListTile(
                        onTap: () {},
                        onLongPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditPage(
                                taskId: taskId,
                                taskText: taskText,
                                createdAt: createdAt,
                                categoryColor: categoryColor,
                                icon: icon,
                                category: category,
                                priority: priority.toString(),
                              ),
                            ),
                          );
                        },
                        trailing: Container(
                          //color: Colors.amber,
                          width: 120,
                          height: 40,
                          child: Row(
                            children: [
                              Container(
                                width: 80, // Optional padding for some spacing
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color(int.parse(
                                      categoryColor.replaceFirst('#', '0XFF'))),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      //color: Colors.amber,
                                      width: 20,
                                      height: 20,
                                      child: Image.asset(
                                        icon,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Container(
                                      //color: Colors.white,
                                      width: 60,
                                      child: Center(child: Text(category)),
                                    )
                                  ],
                                ),
                              ),
                              Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all()),
                                height: 40,
                                width: 40,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.flag,
                                        size: 10,
                                        color: Colors.white,
                                      ),
                                      Spacer(),
                                      Text(
                                        '${priority}',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 11),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
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
