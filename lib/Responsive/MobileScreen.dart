// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Views/AddPost.dart';
import 'package:instagram/Views/Favorite.dart';
import 'package:instagram/Views/Home.dart';
import 'package:instagram/Views/Profile.dart';
import 'package:instagram/Views/Search.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  PageController controller = PageController(initialPage: 2);
  int currentpage = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CupertinoTabBar(
          backgroundColor: Colors.black,
          onTap: (value) {
            controller.jumpToPage(value);
            setState(() {
              currentpage = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: currentpage == 0 ? Colors.white : Colors.grey,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: currentpage == 1 ? Colors.white : Colors.grey,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle_rounded,
                color: currentpage == 2 ? Colors.white : Colors.grey,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: currentpage == 3 ? Colors.white : Colors.grey,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: currentpage == 4 ? Colors.white : Colors.grey,
              ),
              label: '',
            ),
          ],
        ),
        body: PageView(
          onPageChanged: (value) {},
          controller: controller,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Home(),
            Search(),
            AddPost(),
            Favorite(),
            Profile(),
          ],
        ),
      ),
    );
  }
}
