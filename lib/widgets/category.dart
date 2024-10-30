import 'package:flutter/material.dart';

Widget buildCategoryRow(BuildContext context, String categoryName,
    IconData icon, Color color, VoidCallback onPressed) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 80,
          height: 80,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  minimumSize: const Size.fromHeight(60),
                  padding: EdgeInsets.zero,
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
              Text(
                categoryName,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
