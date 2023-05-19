import 'package:flutter/material.dart';

class text extends StatefulWidget {
  final IconData icon;
  final String hint_text;
  final TextEditingController temp;
  final bool hide;
  final Function(String)? onChanged;
  const text({
    super.key,
    required this.icon,
    required this.hint_text,
    required this.hide,
    required this.temp,
    this.onChanged,
  });

  @override
  State<text> createState() => _textState();
}

class _textState extends State<text> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      padding: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey.shade800.withOpacity(0.2),
      ),
      alignment: Alignment.center,
      // ignore: prefer_const_constructors
      child: TextField(
        onChanged: widget.onChanged,
        controller: widget.temp,
        cursorColor: Color.fromRGBO(158, 158, 158, 0.4),
        obscureText: widget.hide,
        // ignore: prefer_const_constructors
        decoration: InputDecoration(
          icon: Icon(
            widget.icon,
            color: Color(0xff058cc0),
          ),
          hintText: widget.hint_text,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}
