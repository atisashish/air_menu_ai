import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class NoDataFound extends StatelessWidget {
  final String message;

  const NoDataFound({super.key, this.message = "No Data Found!"});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInDown(
            child: Icon(
              Icons.search_off_rounded,
              size: 80,
              color: Colors.grey.shade400,
            ),
          ),
          SizedBox(height: 10),
          FadeInUp(
            // Use FadeInUp instead of BounceIn
            child: Text(
              message,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
