// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Cloud/CloudServices.dart';
import 'package:instagram/models/UserModel.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final CloudServices cloudServices = CloudServices();
  bool loading = true;
  UserModel? userModel;
  getdata() async {
    setState(() {
      loading = true;
    });
    final user = await cloudServices.getdata(
        userid: FirebaseAuth.instance.currentUser!.uid);

    userModel = user;
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.sizeOf(context).width;

    return SafeArea(
        child: loading
            ? Center(child: CircularProgressIndicator(color: Colors.white))
            : Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  title: Text(userModel!.username),
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
                              userModel!.imageurl,
                            ),
                          ),
                        ),
                        SizedBox(width: 35),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                                width: screenwidth > 600
                                    ? screenwidth * 0.20
                                    : 30),
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
                            SizedBox(
                                width: screenwidth > 600
                                    ? screenwidth * 0.20
                                    : 30),
                            Column(
                              children: [
                                Text('8'),
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
                            SizedBox(
                                width: screenwidth > 600
                                    ? screenwidth * 0.20
                                    : 30),
                            Column(
                              children: [
                                Text('15'),
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
                      child: Text(userModel!.title),
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
                          : EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              padding: MaterialStatePropertyAll(
                                EdgeInsets.symmetric(
                                    vertical: screenwidth > 600 ? 15 : 0,
                                    horizontal: screenwidth > 600 ? 15 : 0),
                              ),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
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
                                    vertical: screenwidth > 600 ? 15 : 0,
                                    horizontal: screenwidth > 600 ? 20 : 0),
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
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
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
