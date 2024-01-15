// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram/Auth/Authservices.dart';
import 'package:instagram/Auth/firebaseAuth.dart';
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
  final Authservices authservices = Authservices(FirebaseAuthprovider());

  PageController controller = PageController();
  int currentpage = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: SvgPicture.asset(
            'assets/mobile/Instagram.svg',
            height: 52,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.chat_bubble_outline_outlined),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: IconButton(
                onPressed: () async {
                  await authservices.SignOut();
                },
                icon: Icon(Icons.logout),
              ),
            ),
          ],
        ),
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
