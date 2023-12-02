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
        items:[
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () => Navigator.of(context).pushNamed(Routes.feed),
                icon:Icon(Icons.home),
                iconSize: 24,
                color: primaryColor,
              ),
              label: 'feed'),
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () => Navigator.of(context).pushNamed(Routes.search),
                icon:Icon(Icons.search),
                iconSize: 24,
                color: primaryColor,
              ),
              label: 'search'),
          BottomNavigationBarItem(
              icon: Stack(
                children: [ Container(height: 50, width: 50
                ,decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50)), color: Color(0xff514FFF),),),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Icon(
                    Icons.add,
                    size: 24,
                    color: primaryColor,
                  ),
                ),]
              ),
              label: 'add'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications_on_outlined,
                size: 24,
                color: Colors.white,
              ),
              label: 'notification'),
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () => Navigator.of(context).pushNamed(Routes.account),
                icon:Icon(Icons.person_sharp),
                iconSize: 24,
                color: primaryColor,
              ),
              label: 'profile'),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }
}