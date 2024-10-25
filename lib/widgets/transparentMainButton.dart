import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TransparentMainButton extends StatelessWidget {
  final String buttontext;
  const TransparentMainButton({super.key, required this.buttontext});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 327,
      height: 48,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          side: const BorderSide(
            color: Color(0xff8875FF),
            width: 2,
          ),
          elevation: 0,
        ),
        child: Text(
          buttontext,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
