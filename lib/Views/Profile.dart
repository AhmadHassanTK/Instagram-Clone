// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:instagram/Cloud/UserCloudServices.dart';
import 'package:instagram/Provider/UserProvider.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final UserCloudServices cloudServices = UserCloudServices();

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.sizeOf(context).width;
    final usermodel = Provider.of<UserProvider>(context).getUsermodel;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(usermodel!.username),
        backgroundColor: Colors.black,
      ),
      body: Center(
          child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 8),
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    usermodel.imageurl,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(width: screenwidth > 600 ? screenwidth * 0.20 : 30),
                  Column(
                    children: [
                      Text('1'),
                      SizedBox(height: 8),
                      Text(
                        'Posts',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: screenwidth > 600 ? screenwidth * 0.20 : 30),
                  Column(
                    children: [
                      Text('${usermodel.followers?.length}'),
                      SizedBox(height: 8),
                      Text(
                        'Followers',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: screenwidth > 600 ? screenwidth * 0.20 : 30),
                  Column(
                    children: [
                      Text('${usermodel.following?.length}'),
                      SizedBox(height: 8),
                      Text(
                        'Following',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 25, left: 10),
            width: double.infinity,
            child: Text(usermodel.title),
          ),
          SizedBox(height: 20),
          Divider(
            thickness: screenwidth > 600 ? 0.05 : 0.20,
            color: Colors.white,
          ),
          SizedBox(height: 10),
          Padding(
            padding: screenwidth > 600
                ? EdgeInsets.only(left: screenwidth * 0.41)
                : EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStatePropertyAll(
                      EdgeInsets.symmetric(
                        vertical: screenwidth > 600 ? 15 : 10,
                        horizontal: screenwidth > 600 ? 15 : 10,
                      ),
                    ),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: Colors.grey,
                        ))),
                    backgroundColor: MaterialStateProperty.all(
                      Colors.black,
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Edit profile',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 30),
                ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStatePropertyAll(
                      EdgeInsets.symmetric(
                        vertical: screenwidth > 600 ? 15 : 10,
                        horizontal: screenwidth > 600 ? 20 : 12,
                      ),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      Colors.red[900],
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Log out',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Divider(
            thickness: screenwidth > 600 ? 0.05 : 0.20,
            color: Colors.white,
          ),
          SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 33,
                  childAspectRatio: 3 / 2,
                ),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    width: 200,
                    height: 200,
                    color: Colors.amber,
                  );
                },
              ),
            ),
          ),
        ],
      )),
    ));
  }
}
