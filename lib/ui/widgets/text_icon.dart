import 'package:flutter/material.dart';

class TextIcon extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onPressed;

  const TextIcon(
      {Key? key,
      this.icon = Icons.bluetooth,
      required this.title,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(onPressed: onPressed, icon: Icon(icon)),
        Text(title),
      ],
    );
  }
}
