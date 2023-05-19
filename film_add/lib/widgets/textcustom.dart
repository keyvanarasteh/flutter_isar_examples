import 'package:flutter/material.dart';

class customtext extends StatefulWidget {
  final String label;
  final Function(String)? onChanged;
  final IconData Icon;
  final Color color;
  final bool hide;
  const customtext(
      {super.key,
      required this.label,
      required this.Icon,
      this.onChanged,
      required this.color,
      required this.hide});

  @override
  State<customtext> createState() => _customtextState();
}

class _customtextState extends State<customtext> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        obscureText: widget.hide,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
            labelText: widget.label,
            suffixIcon: Align(
              widthFactor: 2,
              heightFactor: 2,
              child: Icon(widget.Icon, color: widget.color),
            ),
            border: OutlineInputBorder()),
      ),
    );
  }
}
