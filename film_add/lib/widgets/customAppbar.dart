import 'package:film_add/screen/edit_user.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class customAppbar extends StatelessWidget {
  final IconData leftIcon;
  final IconData rightIcon;
  final String lpath;
  final String rpath;
  final String? username;
  final String? name;

  const customAppbar(
      {super.key,
      required this.leftIcon,
      required this.rightIcon,
      required this.lpath,
      required this.rpath,
      this.username,
      this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Container(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top, left: 25, right: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  GoRouter.of(context).push(lpath);
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(245, 241, 237, 1)),
                  child: Icon(leftIcon),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return edituser(
                        username: username,
                        name: name,
                      );
                    },
                  ));
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(245, 241, 237, 1)),
                  child: Icon(rightIcon),
                ),
              )
            ],
          )),
    );
  }
}
