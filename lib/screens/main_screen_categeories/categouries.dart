import 'package:flutter/material.dart';

import '../../constant/constant.dart';

class CategouriesContainer extends StatelessWidget {
  final String img;
  final String sub_header;
  final String? description;
  final VoidCallback? onTap; // Added callback for gestures

  CategouriesContainer({
    Key? key,
    required this.img,
    required this.sub_header,
    this.description,
    this.onTap, // Initialize the callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Handle tap action
      child: Container(
        height: MediaQuery.of(context).size.height * 0.19,
        width: MediaQuery.of(context).size.width * 0.40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // Shadow color with transparency
              spreadRadius: 5, // How wide the shadow will spread
              blurRadius: 10, // How much blur the shadow will have
              offset: Offset(5, 5), // Horizontal and vertical offset of the shadow
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 10,
              child: Image.asset(
                img,
                width: 80, // Set the desired width here
                height: 100, // Set the desired height here
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              top: 120,
              child: Text(
                sub_header,
                style: subheader,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
