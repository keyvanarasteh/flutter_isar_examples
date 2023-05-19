import 'package:databaseodev/class/colors.dart';
import 'package:databaseodev/class/padding.dart';
import 'package:flutter/material.dart';

class AnimatedBtn extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  const AnimatedBtn({super.key, required this.child, required this.onPressed});

  @override
  State<AnimatedBtn> createState() => _AnimatedBtnState();
}

class _AnimatedBtnState extends State<AnimatedBtn> {
  bool _press = false;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return InkWell(
      onTapDown: (details) => setState(() {
        _press = true;
      }),
      onTapUp: (details) => setState(() {
        _press = false;
      }),
      onTapCancel: () => setState(() {
        _press = false;
      }),
      onTap: widget.onPressed,
      child: Padding(
        padding: MyPadding.vertical,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          width: width * 0.5,
          height: 50,
          child: Center(
            child: widget.child,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: _press ? appColors.loginBtn : appColors.grey_300,
            // boxShadow: _press
            //     ? [
            //         BoxShadow(
            //           offset: Offset(2, 2),
            //           color: appColors.grey_500,
            //           blurRadius: 12,
            //           spreadRadius: 1,
            //         ),
            //         BoxShadow(
            //           offset: Offset(-4, -4),
            //           blurRadius: 12,
            //           color: appColors.white,
            //           spreadRadius: 1,
            //         ),
            //       ]
            //     : [
            //         BoxShadow(
            //           offset: Offset(3, 3),
            //           color: appColors.grey_500,
            //           blurRadius: 5,
            //           spreadRadius: 0,
            //         ),
            //         BoxShadow(
            //           offset: Offset(-3, -3),
            //           blurRadius: 5,
            //           color: appColors.white,
            //           spreadRadius: 0,
            //         ),
            //       ],
          ),
        ),
      ),
    );
  }
}
