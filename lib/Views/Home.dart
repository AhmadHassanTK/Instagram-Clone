// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram/Animation/HeartAnimation.dart';
import 'package:instagram/Auth/Authservices.dart';
import 'package:instagram/Auth/firebaseAuth.dart';
import 'package:instagram/Cloud/CommentCloudServices.dart';
import 'package:instagram/Cloud/PostCloudServices.dart';
import 'package:instagram/Shared/Snackbar.dart';
import 'package:instagram/Views/Comment.dart';
import 'package:instagram/models/UserPostModel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Authservices authservices = Authservices(FirebaseAuthprovider());
  final PostCloudServices postCloudServices = PostCloudServices();
  bool liked = false;

  numberofComments(String postid) async {
    CommentCloudServices commentCloudServices =
        CommentCloudServices(postid: postid);

    final x = await commentCloudServices.numberofComments();

    return x.toString();
  }

  showmodel({required postid}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: [
            SimpleDialogOption(
              onPressed: () async {
                await postCloudServices.deletepost(postid: postid);
              },
              padding: EdgeInsets.all(20),
              child: Text(
                'Delete post',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop();
              },
              padding: EdgeInsets.all(20),
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        );
      },
    );
  }

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
          stream: postCloudServices.homedata(context: context),
          builder: (BuildContext context,
              AsyncSnapshot<Iterable<UserPostModel>> snapshot) {
            if (snapshot.hasError) {
              return showSnackBar(context, 'Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text(""));
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
                                onPressed: () async {
                                  await showmodel(
                                      postid: snapshot.data!
                                          .elementAt(index)
                                          .postID);

                                  if (!mounted) return;

                                  Navigator.of(context).pop();
                                },
                                icon: Icon(Icons.more_vert)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onDoubleTap: () async {
                          setState(() {
                            liked = true;
                          });

                          Timer(Duration(seconds: 3), () {
                            setState(() {
                              liked = false;
                            });
                          });

                          await postCloudServices.addlike(
                              context: context,
                              postid: snapshot.data!.elementAt(index).postID);
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.network(
                              snapshot.data!.elementAt(index).postImg,
                              height: MediaQuery.sizeOf(context).height * 0.35,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            liked
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 111,
                                  )
                                : Text(""),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              LikeAnimation(
                                isAnimating: snapshot.data!
                                    .elementAt(index)
                                    .likes
                                    .contains(
                                        FirebaseAuth.instance.currentUser!.uid),
                                smallLike: true,
                                child: IconButton(
                                  onPressed: () async {
                                    snapshot.data!
                                            .elementAt(index)
                                            .likes
                                            .contains(FirebaseAuth
                                                .instance.currentUser!.uid)
                                        ? await postCloudServices.removelike(
                                            context: context,
                                            postid: snapshot.data!
                                                .elementAt(index)
                                                .postID)
                                        : await postCloudServices.addlike(
                                            context: context,
                                            postid: snapshot.data!
                                                .elementAt(index)
                                                .postID);
                                  },
                                  icon: snapshot.data!
                                          .elementAt(index)
                                          .likes
                                          .contains(FirebaseAuth
                                              .instance.currentUser!.uid)
                                      ? const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        )
                                      : const Icon(
                                          Icons.favorite_border,
                                        ),
                                ),
                              ),
                              SizedBox(width: 10),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Comment(
                                          postid: snapshot.data!
                                              .elementAt(index)
                                              .postID,
                                          visible: true,
                                        ),
                                      ));
                                },
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
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Comment(
                                    postid:
                                        snapshot.data!.elementAt(index).postID,
                                    visible: false,
                                  ),
                                ));
                          },
                          child: Container(
                            width: double.infinity,
                            child: FutureBuilder(
                              future: numberofComments(
                                  snapshot.data!.elementAt(index).postID),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return showSnackBar(
                                      context, 'Something went wrong');
                                }

                                return Text(
                                  'view all ${snapshot.data} comments',
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(214, 157, 157, 165)),
                                  textAlign: TextAlign.start,
                                );
                              },
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
