import 'package:flutter/material.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';

class CustomCounter extends StatefulWidget {
  const CustomCounter({super.key});
 
  @override
  CustomCounterState createState() => CustomCounterState();
}

class CustomCounterState extends State<CustomCounter> {
  
  int count = 1;

  void increment() {
    setState(() {
      count++;
    });
  }

  void decrement() {
    if (count > 1) {
      setState(() {
        count--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildButton(Icons.add, increment),
        SizedBox(width: 12),
        Text(
          count.toString().padLeft(2, '0'),
          style: AppTextStyles.w400_18.copyWith(color: Colors.black),
        ),
        SizedBox(width: 12),
        _buildButton(Icons.remove, decrement),
      ],
    );
  }

  Widget _buildButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(icon: Icon(icon), onPressed: onPressed),
    );
  }
}