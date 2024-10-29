import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'image': 'assets/Group 182.png',
      'title': 'Manage Your Task',
      'description':
          'You can easily manage all of your daily tasks in DoMe for free',
      'buttonText': 'Next',
    },
    {
      'image': 'assets/Frame 162.png',
      'title': 'Create daily routine',
      'description':
          'In Uptodo you can create your personalized routine to stay productive',
      'buttonText': 'Next',
    },
    {
      'image': 'assets/Frame 161.png',
      'title': 'Organize your tasks',
      'description':
          'You can organize your daily tasks by adding your tasks into separate categories',
      'buttonText': 'Get Started',
    },
  ];

  void _nextPage() {
    setState(() {
      if (_currentPage < _pages.length - 1) {
        _currentPage++;
      } else {
        Navigator.pushReplacementNamed(context, '/firstLoginPage');
      }
    });
  }

  void _previousPage() {
    setState(() {
      if (_currentPage > 0) {
        _currentPage--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 24),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/firstLoginPage');
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                backgroundColor: Colors.transparent,
              ),
              child: const Text(
                'Skip',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Center(
              child: Image.asset(
                _pages[_currentPage]['image']!,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Text(
                _pages[_currentPage]['title']!,
                style: const TextStyle(color: Colors.white, fontSize: 32),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 38, right: 38, top: 42),
            child: Text(
              _pages[_currentPage]['description']!,
              style: const TextStyle(fontSize: 16, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 80),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _previousPage,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  child: const Text(
                    'Back',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    backgroundColor: const Color(0xff8875FF),
                  ),
                  child: Text(
                    _pages[_currentPage]['buttonText']!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
