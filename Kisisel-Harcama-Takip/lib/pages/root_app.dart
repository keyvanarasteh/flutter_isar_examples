import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:kisisel_takip/theme/renkler.dart';
import 'package:kisisel_takip/pages/harcamalar.dart';
import 'package:kisisel_takip/pages/sayfa.dart';
import 'package:kisisel_takip/pages/profil.dart';
import 'package:kisisel_takip/pages/yeni_girdi.dart';
import 'package:kisisel_takip/scoped_model/sema.dart';
import 'package:animations/animations.dart';
import 'package:kisisel_takip/pages/gelirler.dart';

class RootApp extends StatefulWidget {
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;
  PageController controller = PageController(initialPage: 0);

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModelDescendant<ExpenseModel>(
        builder: (context, child, model) => PageView(
          controller: controller,
          children: [
            DailyPage(model: model, callback: callback),
            StatsPage(model: model, callback: callback),
            StatsPageG(model: model, callback: callback),
            ProfilePage(model: model),
          ],
          onPageChanged: (val) {
            setState(() {
              pageIndex = val;
            });
          },
          physics: ClampingScrollPhysics(),
        ),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        activeColor: myColors[pageIndex][0],
        splashColor: myColors[pageIndex][1],
        inactiveColor: Colors.black.withOpacity(0.5),
        icons: <IconData>[
          Ionicons.md_calendar,
          Ionicons.md_stats,
          Ionicons.md_stats,
          Ionicons.md_settings,
        ],
        activeIndex: pageIndex,
        notchSmoothness: NotchSmoothness.softEdge,
        iconSize: 30,
        onTap: (index) {
          setState(() {
            pageIndex = index;
            controller.animateToPage(
              pageIndex,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          });
        },
      ),
      floatingActionButton: OpenContainer(
        transitionType: ContainerTransitionType.fadeThrough,
        openBuilder: (BuildContext context, _) =>
            NewEntryLog(callback: callback, context: context),
        closedElevation: 5.0,
        openElevation: 0,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
        ),
        closedColor: Color(0xff2f2f2f),
        closedBuilder: (_, __) => SizedBox(
          height: 50,
          width: 50,
          child: Center(
            child: Icon(Icons.add, color: Color(0xfffe6f27)),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  callback(int index) {
    setState(() {
      index ??= 3;
      pageIndex = index;
      controller.animateToPage(
        pageIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }
}
