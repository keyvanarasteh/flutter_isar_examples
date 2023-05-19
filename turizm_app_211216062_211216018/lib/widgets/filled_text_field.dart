import 'package:flutter/material.dart';

class FilledTextField extends StatefulWidget {
  final String hint;
  final Icon? icon;
  final bool passwd;
  final bool number;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const FilledTextField({
    Key? key,
    required this.hint,
    this.icon,
    this.passwd = false,
    this.number = false,
    this.onChanged,
    this.validator,
    required this.controller,
  }) : super(key: key);

  @override
  State<FilledTextField> createState() => _FilledTextFieldState();
}

class _FilledTextFieldState extends State<FilledTextField> {
  bool unlocked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.passwd && !unlocked,
        keyboardType: widget.number ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          hintText: widget.hint,
          filled: true,
          // fillColor: const Color.fromARGB(211, 238, 238, 238),
          prefixIcon: widget.icon,
          suffixIcon: widget.passwd
              ? unlocked
                  ? IconButton(
                      icon: const Icon(Icons.lock),
                      onPressed: () {
                        setState(() {
                          unlocked = false;
                        });
                      },
                    )
                  : IconButton(
                      icon: const Icon(Icons.remove_red_eye),
                      onPressed: () {
                        print('unlocking...');
                        setState(() {
                          unlocked = true;
                        });
                      },
                    )
              : null,
          hintStyle: TextStyle(
            fontSize: 14,
            // color: Colors.grey.shade500,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 5,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
                // color: Colors.transparent,
                ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
                // color: Colors.grey.shade200,
                ),
          ),
        ),
        onChanged: widget.onChanged,
        validator: widget.validator,
      ),
    );
  }
}
