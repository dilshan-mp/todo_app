import 'package:flutter/material.dart';

Widget buildCategoryRow(
  BuildContext context,
  String categoryName,
  String imagePath,
  String hexcolor,
  VoidCallback onPressed,
) {
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
              // GestureDetector(
              //   onTap: (){},
              //   child: Container(
              //     color: color,
              //     width: 60,
              //     height: 60,
              //     child: Image.asset(
              //       imagePath,
              //       width: 20,
              //       height: 20,

              //     ),
              //   ),
              // ),
              ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(int.parse(hexcolor.replaceFirst('#', '0xFF'))),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    minimumSize: const Size.fromHeight(60),
                    padding: EdgeInsets.zero,
                  ),
                  child: Image.asset(
                    imagePath,
                    width: 30,
                    height: 30,
                  )),
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
