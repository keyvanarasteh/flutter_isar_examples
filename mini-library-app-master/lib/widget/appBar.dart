import 'package:databaseodev/class/padding.dart';
import 'package:flutter/material.dart';
import 'package:databaseodev/class/colors.dart';
import 'package:go_router/go_router.dart';

class appBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String path;
  appBar({Key? key, required this.path})
      : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 100,
      leadingWidth: 100,
      backgroundColor: appColors.transparent,
      leading: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: MyPadding.together,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                context.pushNamed(path);
              },
              child: Image.asset('images/previous.png'),
            ),
          ),
        ],
      ),
    );
  }
}
