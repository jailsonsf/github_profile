import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? titleSize;

  const CustomButtonWidget({
    Key? key,
    required this.onPressed,
    required this.title,
    this.titleSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(title),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.deepPurple.shade200;
            }
            if (states.contains(MaterialState.disabled)) {
              return Colors.deepPurple.shade500;
            }
            return Colors.deepPurple;
          },
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        textStyle: MaterialStateProperty.all(TextStyle(
          fontSize: titleSize,
        )),
      ),
    );
  }
}
