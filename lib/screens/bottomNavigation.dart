import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/taskPage/homePage.dart';
import 'package:todo_app/widgets/category.dart';
import 'package:todo_app/widgets/textFields.dart';

class BottomNavigationBarExample extends StatefulWidget {
  @override
  _BottomNavigationBarExampleState createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  TextEditingController _taskcontroller = TextEditingController();
  int _selectedIndex = 0;
  int _selectedPriority = 0;

  final List<Widget> _pages = [
    HomePage(),
    //CalendarPage(),
    //FocusPage(),
    //ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }

  void _addTaskToFirestore() async {
    String task = _taskcontroller.text;
    if (task.isNotEmpty && _selectedPriority != 0) {
      await FirebaseFirestore.instance.collection('task').add(
        {
          'task': task,
          'priority': _selectedPriority,
          'category': _selectedCategory,
          //'categoryIcon':_selectedCategoryIcon,
          'createdAt': Timestamp.now(),
        },
      );
      _taskcontroller.clear();
      _selectedPriority = 0;
      _selectedCategory = '';
      Navigator.pop(context);
    }
  }

  // ignore: non_constant_identifier_names
  void _ShowDialogBox() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0XFF363636),
          title: const Text(
            "Add Task",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 335, // Fixed width
                height: 55, // Fixed height
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ), // Padding // Positioning
                child: TextField(
                  controller: _taskcontroller,
                  style: const TextStyle(
                    color: Colors.white, // Text color
                  ),
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        bottomLeft: Radius.circular(4),
                        bottomRight: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                      borderSide: BorderSide(
                        color: Colors.white, // Border color when not focused
                        width: 2, // Border width
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        bottomLeft: Radius.circular(4),
                        bottomRight: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                      borderSide: BorderSide(
                        color: Colors.white, // Border color when focused
                        width: 2, // Border width
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white
                        .withOpacity(0), // Background color with opacity
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, // Inner padding
                    ),
                  ),
                ),
              )
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.timer,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: _categoryShowDialogBox,
              icon: const Icon(
                Icons.category_outlined,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: _priorityDialogBox,
              icon: const Icon(
                Icons.flag,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: _addTaskToFirestore,
              icon: const Icon(
                Icons.send,
                color: Colors.blueAccent,
              ),
            )
          ],
        );
      },
    );
  }

  void _priorityDialogBox() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Task Priority'),
          content: Container(
            height: 200,
            width: 300,
            //color: Colors.amber,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 6,
              ),
              itemCount: 10,
              itemBuilder: (context, Index) {
                int Priority = Index + 1;
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedPriority == Priority
                        ? Colors.blue // Highlight selected button
                        : Colors.grey, // Default color for unselected
                    shape:
                        const RoundedRectangleBorder(), // Circular shape for buttons
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedPriority = Priority;
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.flag),
                      Text(
                        '$Priority',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
              child: const Text(
                'cancel',
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
            const SizedBox(
              width: 70,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _ShowDialogBox();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  final Map<String, IconData> _categoryIcons = {
    'Grocery': Icons.shopping_cart,
    'Design': Icons.design_services,
    'Music': Icons.music_note,
    'Home': Icons.home,
  };

  String _selectedCategory = '';
  IconData? _selectedCategoryIcon;

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
      //_selectedCategoryIcon = _categoryIcons[category];
    });
  }

  void _categoryShowDialogBox() {
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
                      buildCategoryRow(
                          context, 'Grocery', Icons.shopping_cart, Colors.green,
                          () {
                        _selectCategory('Grocery');
                      }),
                      buildCategoryRow(
                          context, 'Work', Icons.work, Colors.orange, () {
                        _selectCategory('Work');
                      }),
                      buildCategoryRow(
                          context, 'Sport', Icons.sports, Colors.cyan, () {
                        _selectCategory('Sport');
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
                      buildCategoryRow(
                          context, 'Design', Icons.design_services, Colors.pink,
                          () {
                        _selectCategory('Desing');
                      }),
                      buildCategoryRow(context, 'School', Icons.design_services,
                          Colors.purple, () {
                        _selectCategory('School');
                      }),
                      buildCategoryRow(context, 'Scoial', Icons.social_distance,
                          Colors.purple, () {
                        _selectCategory('Scoial');
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
                      buildCategoryRow(
                          context, 'Music', Icons.music_note, Colors.purple,
                          () {
                        _selectCategory('Music');
                      }),
                      buildCategoryRow(
                          context, 'Health', Icons.favorite, Colors.green, () {
                        _selectCategory('Health');
                      }),
                      buildCategoryRow(
                          context, 'Movie', Icons.movie, Colors.cyan, () {
                        _selectCategory('Movie');
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
                      buildCategoryRow(
                          context, 'Home', Icons.home, Colors.orange, () {
                        _selectCategory('Home');
                      }),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _addTaskToFirestore();
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
                    _ShowDialogBox();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF363636),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildBottomNavItem(
              icon: Icons.home,
              label: 'Home',
              index: 0,
            ),
            _buildBottomNavItem(
              icon: Icons.calendar_month,
              label: 'Calendar',
              index: 1,
            ),
            _buildBottomNavItem(
              icon: Icons.timer,
              label: 'Focus',
              index: 2,
            ),
            _buildBottomNavItem(
              icon: Icons.person,
              label: 'Profile',
              index: 3,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: _ShowDialogBox),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBottomNavItem(
      {required IconData icon, required String label, required int index}) {
    Color iconColor = _selectedIndex == index ? Colors.blue : Colors.white;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            icon,
            color: iconColor,
          ),
          onPressed: () =>
              _onItemTapped(index), // Navigate to the selected page
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 10),
        ),
      ],
    );
  }
}

// Example Pages
