// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram/Views/AddPost.dart';
import 'package:instagram/Views/Home.dart';
import 'package:instagram/Views/Profile.dart';
import 'package:instagram/Views/Search.dart';

class WebScreen extends StatefulWidget {
  const WebScreen({super.key});

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  PageController controller = PageController(initialPage: 0);
  int currentpage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              controller.jumpToPage(0);
              setState(() {
                currentpage = 0;
              });
            },
            icon: Icon(
              Icons.home_outlined,
              color: currentpage == 0 ? Colors.white : Colors.grey,
            ),
          ),
          IconButton(
            onPressed: () {
              controller.jumpToPage(1);
              setState(() {
                currentpage = 1;
              });
            },
            icon: Icon(
              Icons.search,
              color: currentpage == 1 ? Colors.white : Colors.grey,
            ),
          ),
          IconButton(
            onPressed: () {
              controller.jumpToPage(2);
              setState(() {
                currentpage = 2;
              });
            },
            icon: Icon(
              Icons.add_circle_rounded,
              color: currentpage == 2 ? Colors.white : Colors.grey,
            ),
          ),
          IconButton(
            onPressed: () {
              controller.jumpToPage(3);
              setState(() {
                currentpage = 3;
              });
            },
            icon: Icon(
              Icons.favorite,
              color: currentpage == 3 ? Colors.white : Colors.grey,
            ),
          ),
          IconButton(
            onPressed: () {
              controller.jumpToPage(4);
              setState(() {
                currentpage = 4;
              });
            },
            icon: Icon(
              Icons.person,
              color: currentpage == 4 ? Colors.white : Colors.grey,
            ),
          ),
        ],
        title: SvgPicture.asset(
          'assets/mobile/Instagram.svg',
          height: 52,
        ),
      ),
      body: PageView(
        onPageChanged: (value) {},
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Home(),
          Search(),
          AddPost(),
          Profile(),
        ],
      ),
    );
  }
}
