// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram/Auth/Authservices.dart';
import 'package:instagram/Auth/firebaseAuth.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Authservices authservices = Authservices(FirebaseAuthprovider());

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.sizeOf(context).width;
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
        backgroundColor:
            screenwidth > 600 ? Color.fromRGBO(32, 33, 36, 1) : Colors.black,
        body: Container(
          margin: EdgeInsets.symmetric(
            horizontal: screenwidth > 600 ? screenwidth / 4 : 0,
            vertical: 11,
          ),
          decoration: BoxDecoration(
            color: screenwidth > 600 ? Colors.black : null,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1547721064-da6cfb341d50',
                          ),
                        ),
                        SizedBox(width: 10),
                        Text('Ahmad Taha'),
                      ],
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
                  ],
                ),
              ),
              Image.network(
                'https://images.unsplash.com/photo-1547721064-da6cfb341d50',
                height: MediaQuery.sizeOf(context).height * 0.35,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.favorite_border),
                      ),
                      SizedBox(width: 10),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.chat),
                      ),
                      SizedBox(width: 10),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.send_sharp),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.bookmark_border_outlined),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Container(
                  width: double.infinity,
                  child: Text(
                    '10 likes',
                    style: TextStyle(color: Color.fromARGB(214, 157, 157, 165)),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  children: [
                    Text(
                      'USERNAME',
                      style: TextStyle(fontSize: 17),
                    ),
                    SizedBox(width: 10),
                    Text('love giraffe', style: TextStyle(fontSize: 15)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      'view all 100 comments',
                      style:
                          TextStyle(color: Color.fromARGB(214, 157, 157, 165)),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Container(
                  width: double.infinity,
                  child: Text(
                    '10June 2022',
                    style: TextStyle(color: Color.fromARGB(214, 157, 157, 165)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
