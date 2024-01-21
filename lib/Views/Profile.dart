// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Cloud/PostCloudServices.dart';
import 'package:instagram/Cloud/UserCloudServices.dart';
import 'package:instagram/Provider/GuestProvider.dart';
import 'package:instagram/Provider/UserProvider.dart';
import 'package:instagram/Shared/Snackbar.dart';
import 'package:instagram/models/UserPostModel.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  final userid;
  const Profile({super.key, required this.userid});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final UserCloudServices usercloudServices = UserCloudServices();
  final PostCloudServices postCloudServices = PostCloudServices();
  int posts = 0;
  int followers = 0;
  int following = 0;
  bool loading = false;
  bool follow = false;

  loaddata() async {
    setState(() {
      loading = true;
    });

    final guestfollowers =
        await usercloudServices.guestfollowers(userid: widget.userid);

    guestfollowers.contains(FirebaseAuth.instance.currentUser!.uid)
        ? follow = true
        : follow = false;
    final data = await postCloudServices.numberofposts(userid: widget.userid);
    posts = data.docs.length;

    followers =
        await usercloudServices.numberoffollowers(userid: widget.userid);

    following =
        await usercloudServices.numberoffollowings(userid: widget.userid);
    GuestProvider guestProvider = Provider.of(context, listen: false);

    await guestProvider.GuestData(userid: widget.userid);

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    loaddata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.sizeOf(context).width;
    final usermodel = Provider.of<UserProvider>(context).getUsermodel;
    final guestmodel = Provider.of<GuestProvider>(context).getGuestmodel;
    final model = widget.userid == FirebaseAuth.instance.currentUser!.uid
        ? usermodel
        : guestmodel;

    return SafeArea(
        child: model != null && loading == false
            ? Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  title: Text(model.username),
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
                              model.imageurl,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                                width: screenwidth > 600
                                    ? screenwidth * 0.20
                                    : 30),
                            Column(
                              children: [
                                Text('$posts'),
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
                                Text('${followers}'),
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
                                Text('${following}'),
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
                      child: Text(model.title),
                    ),
                    SizedBox(height: 20),
                    Divider(
                      thickness: screenwidth > 600 ? 0.05 : 0.20,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    model == usermodel
                        ? Padding(
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
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                          )
                        : follow == false
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 100, right: 100),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    padding: MaterialStatePropertyAll(
                                      EdgeInsets.symmetric(
                                        vertical: screenwidth > 600 ? 15 : 0,
                                        horizontal: screenwidth > 600 ? 20 : 0,
                                      ),
                                    ),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(
                                      Colors.blue,
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                  onPressed: () async {
                                    await usercloudServices.addfollowers(
                                        context: context,
                                        followerid: model.uid);

                                    setState(() {
                                      followers++;
                                      follow = true;
                                    });
                                  },
                                  child: Center(
                                    child: Text(
                                      'Follow',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                    left: 100, right: 100),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    padding: MaterialStatePropertyAll(
                                      EdgeInsets.symmetric(
                                        vertical: screenwidth > 600 ? 15 : 0,
                                        horizontal: screenwidth > 600 ? 20 : 0,
                                      ),
                                    ),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(
                                      Colors.red,
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                  onPressed: () async {
                                    await usercloudServices.removefollowers(
                                        context: context,
                                        followerid: model.uid);
                                    setState(() {
                                      followers--;
                                      follow = false;
                                    });
                                  },
                                  child: Center(
                                    child: Text(
                                      'unfollow',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                    SizedBox(height: 10),
                    Divider(
                      thickness: screenwidth > 600 ? 0.05 : 0.20,
                      color: Colors.white,
                    ),
                    StreamBuilder<Iterable<UserPostModel>>(
                      stream: postCloudServices.profileData(
                          owneruserid: widget.userid),
                      builder: (BuildContext context,
                          AsyncSnapshot<Iterable<UserPostModel>> snapshot) {
                        if (snapshot.hasError) {
                          return showSnackBar(context, 'Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        }

                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 20,
                                childAspectRatio: 3 / 2,
                              ),
                              itemCount: snapshot.data?.length,
                              itemBuilder: (context, index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.network(
                                    snapshot.data!.elementAt(index).postImg,
                                    fit: BoxFit.fill,
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                )),
              )
            : Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.black,
                ),
                backgroundColor: Colors.black,
                body: Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                ),
              ));
  }
}
