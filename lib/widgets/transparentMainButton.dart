import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TransparentMainButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final String? svgImage; // Add an optional image parameter

  const TransparentMainButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.svgImage,
    // Accept image as an optional parameter
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 327,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (svgImage != null) // Check if the SVG image path is provided
              Padding(
                padding: const EdgeInsets.only(
                    right: 8.0), // Add space between image and text
                child: SvgPicture.asset(
                  svgImage!, // Load the SVG image
                  width: 24,
                  height: 24,
                ),
              ),
            Text(
              buttonText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
