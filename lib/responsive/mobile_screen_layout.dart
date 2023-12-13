import 'package:arthub/config/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:arthub/utils/colors.dart';
import 'package:arthub/utils/global_variable.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController; // for tabs animation

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItems,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff050C16),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () => navigationTapped(0),
                icon: Icon(Icons.home),
                iconSize: 24,
                color: _page == 0 ? primaryColor : secondaryColor,
              ),
              label: 'feed'),
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () => navigationTapped(1),
                icon: Icon(Icons.search),
                iconSize: 24,
                color: _page == 1 ? primaryColor : secondaryColor,
              ),
              label: 'search'),
          BottomNavigationBarItem(
              icon: Stack(children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: _page == 2 ? orangeColor : blueColor),
                ),
                Container(
                  child: IconButton(
                    onPressed: () => navigationTapped(2),
                    icon: Icon(Icons.add),
                    iconSize: 24,
                    color: primaryColor,
                  ),
                ),
              ]),
              label: 'add'),
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () => navigationTapped(3),
                icon: Icon(Icons.chat_bubble_outline_rounded),
                iconSize: 24,
                color: _page == 3 ? primaryColor : secondaryColor,
              ),
              label: 'notification'),
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () => navigationTapped(4),
                icon: Icon(Icons.person_sharp),
                iconSize: 24,
                color: _page == 4 ? primaryColor : secondaryColor,
              ),
              label: 'profile'),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }
}
