import 'package:flutter/material.dart';
import 'package:todo_app/screens/taskPage/homePage.dart';
import 'package:todo_app/widgets/textFields.dart';

class BottomNavigationBarExample extends StatefulWidget {
  @override
  _BottomNavigationBarExampleState createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    CalendarPage(),
    FocusPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _ShowDialogBox() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0XFF363636),
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
                width: 327, // Fixed width
                height: 43, // Fixed height
                padding: const EdgeInsets.symmetric(
                    vertical: 8, horizontal: 16), // Padding // Positioning
                child: TextField(
                  style: const TextStyle(
                    color: Colors.white, // Text color
                  ),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4), // Border radius
                        bottomLeft: Radius.circular(4),
                        bottomRight: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                      borderSide: BorderSide(
                        color: Colors.white, // Border color
                        width: 5,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white
                        .withOpacity(0), // Background color with opacity
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16), // Inner padding
                  ),
                ),
              )
            ],
          ),
          actions: [
            TextButton(
              child: const Text(
                "Cancel",
                style: TextStyle(
                    color: Colors.white), // Optional: style the button text
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text(
                "OK",
                style: TextStyle(
                    color: Colors.white), // Optional: style the button text
              ),
              onPressed: () {
                // Add any action you want on OK press
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
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
class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text('Calendar Page', style: TextStyle(fontSize: 24)));
  }
}

class FocusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text('Focus Page', style: TextStyle(fontSize: 24)));
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text('Profile Page', style: TextStyle(fontSize: 24)));
  }
}

ThemeData buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: shrineColorScheme,
    textTheme: buildShrineTextTheme(base.textTheme),
  );
}

TextTheme buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
        bodyLarge: base.bodyLarge?.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          letterSpacing: defaultLetterSpacing,
        ),
        labelLarge: base.labelLarge?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          letterSpacing: defaultLetterSpacing,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: shrineBrown900,
        bodyColor: shrineBrown900,
      );
}

const ColorScheme shrineColorScheme = ColorScheme(
  primary: shrinePink100,
  secondary: shrinePink50,
  surface: shrineSurfaceWhite,
  background: shrineBackgroundWhite,
  error: shrineErrorRed,
  onPrimary: shrineBrown900,
  onSecondary: shrineBrown900,
  onSurface: shrineBrown900,
  onBackground: shrineBrown900,
  onError: shrineSurfaceWhite,
  brightness: Brightness.light,
);

const Color shrinePink50 = Color(0xFFFEEAE6);
const Color shrinePink100 = Color(0xFFFEDBD0);
const Color shrinePink300 = Color(0xFFFBB8AC);
const Color shrinePink400 = Color(0xFFEAA4A4);

const Color shrineBrown900 = Color(0xFF442B2D);
const Color shrineBrown600 = Color(0xFF7D4F52);

const Color shrineErrorRed = Color(0xFFC5032B);

const Color shrineSurfaceWhite = Color(0xFFFFFBFA);
const Color shrineBackgroundWhite = Colors.white;

const double defaultLetterSpacing = 0.03;
