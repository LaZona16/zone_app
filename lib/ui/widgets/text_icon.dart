import 'package:flutter/material.dart';

class TextIcon extends StatelessWidget {
  final IconData icon;
  final String title;

  const TextIcon({Key? key, required this.icon, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Icon(
          Icons.bluetooth,
          color: Colors.amber,
        ),
        Text(title),
      ],
    );
  }
}
