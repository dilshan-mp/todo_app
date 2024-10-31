import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/widgets/category.dart';
import 'package:todo_app/widgets/mainButton.dart';

class EditPage extends StatefulWidget {
  final String taskId;
  final String taskText;
  final DateTime createdAt;
  final String categoryColor;
  final String icon;
  final String category;
  final dynamic priority;

  const EditPage({
    super.key,
    required this.taskText,
    required this.createdAt,
    required this.categoryColor,
    required this.icon,
    required this.category,
    required this.priority,
    required this.taskId,
  });

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late String editedTaskText;
  late String editedCategory;
  late String editedCategoryColor;
  late String editedIcon;
  @override
  void initState() {
    super.initState();
    editedTaskText = widget.taskText;
    editedCategory = widget.category;
    editedCategoryColor = widget.categoryColor;
    editedIcon = widget.icon;
  }

  void _showDialogBox() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Task"),
          content: TextField(
            onChanged: (value) {
              editedTaskText = value; // Update the edited task text
            },
            controller: TextEditingController(text: editedTaskText),
            decoration: const InputDecoration(
              hintText: "Enter new task text",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  // Update the task text in the state
                  editedTaskText =
                      editedTaskText; // This can be replaced with any saving logic
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void categoryShowDialogBox() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xff363636),
          title: const Text(
            'Choose Category',
            style: TextStyle(color: Colors.white),
          ),
          content: Container(
            //constraints: BoxConstraints(maxHeight: 500),
            //color: Colors.amber,
            height: 450,
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Row 1
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildCategoryRow(context, 'Grocery',
                          'assets/category/grocery.png', '#CCFF80', () {
                        _updateCategory('Grocery',
                            'assets/category/grocery.png', '#CCFF80');
                        Navigator.of(context).pop();
                      }),
                      buildCategoryRow(context, 'Work',
                          'assets/category/work.png', '#FF9680', () {
                        _updateCategory(
                            'Work', 'assets/category/work.png', '#FF9680');
                        Navigator.of(context).pop();
                      }),
                      buildCategoryRow(context, 'Sport',
                          'assets/category/sport.png', '#80FFFF', () {
                        _updateCategory(
                            'Sport', 'assets/category/sport.png', '#80FFFF');
                      }),
                    ],
                  ),
                ),

                // Row 2
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildCategoryRow(context, 'Design',
                          'assets/category/design.png', '#80FFD9', () {
                        _updateCategory(
                            'Desing', 'assets/category/design.png', '#80FFD9');
                      }),
                      buildCategoryRow(context, 'School',
                          'assets/category/univercity.png', '#809CFF', () {
                        _updateCategory('School',
                            'assets/category/univercity.png', '#809CFF');
                      }),
                      buildCategoryRow(context, 'Scoial',
                          'assets/category/megaphone.png', '#FF80EB', () {
                        _updateCategory('Scoial',
                            'assets/category/megaphone.png', '#FF80EB');
                      }),
                    ],
                  ),
                ),

                // Row 3
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildCategoryRow(context, 'Music',
                          'assets/category/music.png', '#FC80FF', () {
                        _updateCategory(
                            'Music', 'assets/category/music.png', '#FC80FF');
                      }),
                      buildCategoryRow(context, 'Health',
                          'assets/category/heartbeat.png', '#80FFA3', () {
                        _updateCategory('Health',
                            'assets/category/heartbeat.png', '#80FFA3');
                      }),
                      buildCategoryRow(context, 'Movie',
                          'assets/category/video-camera.png', '#80D1FF', () {
                        _updateCategory('Movie',
                            'assets/category/video-camera.png', '#80D1FF');
                      }),
                    ],
                  ),
                ),

                // Row 4
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildCategoryRow(context, 'Home',
                          'assets/category/home.png', '#FFCC80', () {
                        _updateCategory(
                            'Home', 'assets/category/home.png', '#FFCC80');
                      }),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Column(
                          children: [
                            Icon(Icons.add, color: Colors.white),
                            Text('Create New',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Add Category',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _updateCategory(String category, String color, String icon) {
    setState(() {
      editedCategory = category;
      editedCategoryColor = color;
      editedIcon = icon;
    });
  }

  Future<void> _updateTask() async {
    final CollectionReference tasksCollection =
        FirebaseFirestore.instance.collection('task');
    try {
      await tasksCollection.doc(widget.taskId).update({
        'task': editedTaskText,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task Update successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update task: $e')),
      );
    }
  }

  Future<void> _deleteTask() async {
    final CollectionReference tasksCollection =
        FirebaseFirestore.instance.collection('task');
    try {
      await tasksCollection.doc(widget.taskId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task deleted successfully!')),
      );
      Navigator.of(context).pop(); // Navigate back after deletion
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete task: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        backgroundColor: Colors.black26,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.cancel_outlined,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 80,
            child: ListTile(
              leading: Checkbox(
                value: false,
                onChanged: (value) {},
                shape: const CircleBorder(),
              ),
              title: Text(
                editedTaskText, // Display the edited task text here
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
              subtitle: Text(
                '${widget.createdAt.hour}:${widget.createdAt.minute} ${widget.createdAt.day}/${widget.createdAt.month}/${widget.createdAt.year}',
                style: const TextStyle(color: Colors.grey, fontSize: 11),
              ),
              trailing: IconButton(
                onPressed: _showDialogBox,
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 60,
            child: ListTile(
              leading: Icon(Icons.timer),
              title: const Text(
                'Task Time',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              trailing: Container(
                color: Colors.black,
                width: 70,
                height: 40,
                child: Text(
                  '${widget.createdAt.hour}:${widget.createdAt.minute} ${widget.createdAt.day}/${widget.createdAt.month}/${widget.createdAt.year}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 60,
            child: ListTile(
              leading: Icon(Icons.tag),
              title: const Text(
                "Task Category",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              trailing: GestureDetector(
                onTap: categoryShowDialogBox,
                child: Container(
                  width: 80, // Optional padding for some spacing
                  height: 40,
                  decoration: BoxDecoration(
                    color: widget.categoryColor.isNotEmpty
                        ? Color(
                            int.parse(
                              editedCategoryColor.replaceFirst('#', '0XFF'),
                            ),
                          )
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        child: widget.icon.isNotEmpty
                            ? Image.asset(
                                editedIcon,
                                fit: BoxFit.fill,
                              )
                            : const Icon(Icons.category),
                      ),
                      Container(
                        width: 60,
                        child: Center(child: Text(editedCategory)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 60,
            child: ListTile(
              leading: Icon(Icons.flag_outlined),
              title: const Text(
                'Priority',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              trailing: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(),
                ),
                height: 40,
                width: 40,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        widget.priority
                            .toString(), // Ensure priority is displayed as a string
                        style:
                            const TextStyle(color: Colors.white, fontSize: 11),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 60,
            child: ListTile(
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
              title: GestureDetector(
                onTap: _deleteTask,
                child: Container(
                  width: 20,
                  height: 20,
                  child: const Text(
                    "Delete Task",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: MainButton(
              buttontext: 'Save',
              onPressed: () {
                _updateTask();
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
