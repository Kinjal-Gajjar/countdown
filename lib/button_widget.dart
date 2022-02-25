import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {Key? key,
      required this.text,
      required this.onClicked,
      required this.color,
      required this.backgroundcolor})
      : super(key: key);

  final String text;
  final Color color;
  final Color backgroundcolor;
  final VoidCallback onClicked;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: backgroundcolor,
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
        onPressed: onClicked,
        child: Text(
          text,
          style: TextStyle(fontSize: 20, color: color),
        ));
  }
}
