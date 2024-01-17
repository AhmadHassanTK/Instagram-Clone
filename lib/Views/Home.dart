// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram/Auth/Authservices.dart';
import 'package:instagram/Auth/firebaseAuth.dart';
import 'package:instagram/Cloud/PostCloudServices.dart';
import 'package:instagram/Shared/Snackbar.dart';
import 'package:instagram/models/UserPostModel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Authservices authservices = Authservices(FirebaseAuthprovider());
  final PostCloudServices postCloudServices = PostCloudServices();

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
        body: StreamBuilder<Iterable<UserPostModel>>(
          stream: postCloudServices.homedata(),
          builder: (BuildContext context,
              AsyncSnapshot<Iterable<UserPostModel>> snapshot) {
            if (snapshot.hasError) {
              return showSnackBar(context, 'Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Container(
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
                                    snapshot.data!.elementAt(index).profileImg,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(snapshot.data!.elementAt(index).username),
                              ],
                            ),
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.more_vert)),
                          ],
                        ),
                      ),
                      Image.network(
                        snapshot.data!.elementAt(index).postImg,
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
                            '${snapshot.data!.elementAt(index).likes.length} likes',
                            style: TextStyle(
                                color: Color.fromARGB(214, 157, 157, 165)),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          children: [
                            Text(
                              snapshot.data!.elementAt(index).username,
                              style: TextStyle(fontSize: 17),
                            ),
                            SizedBox(width: 10),
                            Text(snapshot.data!.elementAt(index).description,
                                style: TextStyle(fontSize: 15)),
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
                              style: TextStyle(
                                  color: Color.fromARGB(214, 157, 157, 165)),
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
                            snapshot.data!.elementAt(index).postdate,
                            style: TextStyle(
                                color: Color.fromARGB(214, 157, 157, 165)),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
