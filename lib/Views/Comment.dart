// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:instagram/Cloud/CommentCloudServices.dart';
import 'package:instagram/Provider/UserProvider.dart';
import 'package:instagram/Shared/MyTextField.dart';
import 'package:instagram/models/UserCommentModel.dart';
import 'package:provider/provider.dart';

class Comment extends StatefulWidget {
  final String postid;
  final bool visible;
  const Comment({super.key, required this.postid, required this.visible});

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  bool loading = false;
  final TextEditingController _comment = TextEditingController();
  late CommentCloudServices commentCloudServices =
      CommentCloudServices(postid: widget.postid);

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final usermodel = Provider.of<UserProvider>(context).getUsermodel;
    return SafeArea(
      child: usermodel != null
          ? Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text(
                  'Comments',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StreamBuilder<Iterable<UserCommentModel>>(
                    stream: commentCloudServices.homedata(),
                    builder: (BuildContext context,
                        AsyncSnapshot<Iterable<UserCommentModel>> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }

                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundImage: NetworkImage(snapshot
                                            .data!
                                            .elementAt(index)
                                            .imgpath),
                                      ),
                                      SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(snapshot.data!
                                                  .elementAt(index)
                                                  .username),
                                              SizedBox(width: 10),
                                              Text(snapshot.data!
                                                  .elementAt(index)
                                                  .caption),
                                            ],
                                          ),
                                          Text(snapshot.data!
                                              .elementAt(index)
                                              .commentdate),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(Icons.favorite),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    },
                  ),
                  Visibility(
                    visible: widget.visible,
                    child: Container(
                      margin: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 27,
                            backgroundImage: NetworkImage(usermodel.imageurl),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: MyTextField(
                                controller: _comment,
                                autofocusflag: false,
                                hintValue: 'comment as ${usermodel.username}',
                                textInputType: TextInputType.text,
                                isObscureText: false,
                                icon: Icon(Icons.send),
                                onTap: () async {
                                  await commentCloudServices.addComment(
                                    username: usermodel.username,
                                    caption: _comment.text,
                                    context: context,
                                    profileImg: usermodel.imageurl,
                                  );

                                  _comment.clear();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          : Scaffold(
              body: Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              )),
            ),
    );
  }
}
