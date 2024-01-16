// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, prefer_const_literals_to_create_immutables

import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/Cloud/PostCloudServices.dart';
import 'package:instagram/Cloud/UserCloudServices.dart';
import 'package:instagram/Provider/UserProvider.dart';
import 'package:path/path.dart' show basename;
import 'package:provider/provider.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  Uint8List? imgPath;
  String? imgName;
  final TextEditingController _description = TextEditingController();
  final UserCloudServices cloudServices = UserCloudServices();
  final PostCloudServices postCloudServices = PostCloudServices();
  bool loading = true;
  bool postloading = false;
  uploadImage2Screen(ImageSource source) async {
    final pickedImg = await ImagePicker().pickImage(source: source);
    try {
      if (pickedImg != null) {
        imgPath = await pickedImg.readAsBytes();
        setState(() {
          //  imgPath = File(pickedImg.path);
          imgName = basename(pickedImg.path);
          int random = Random().nextInt(9999999);
          imgName = "$random$imgName";
          print(imgName);
        });
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }

    if (!mounted) return;
    Navigator.pop(context);
  }

  showmodel() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(22),
          height: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await uploadImage2Screen(ImageSource.camera);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.camera,
                      size: 30,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "From Camera",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 22,
              ),
              GestureDetector(
                onTap: () {
                  uploadImage2Screen(ImageSource.gallery);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.photo_outlined,
                      size: 30,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "From Gallery",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final usermodel = Provider.of<UserProvider>(context).getUsermodel;
    return SafeArea(
        child: imgPath != null
            ? Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            postloading = true;
                          });
                          await postCloudServices.addPost(
                            username: usermodel!.username,
                            description: _description.text,
                            context: context,
                            imgPath: imgPath,
                            imgName: imgName,
                            profileImg: usermodel.imageurl,
                          );

                          setState(() {
                            postloading = false;
                          });
                        },
                        child: Text(
                          'Post',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                  leading: IconButton(
                    onPressed: () {
                      setState(() {
                        imgPath = null;
                      });
                    },
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                ),
                body: Column(
                  children: [
                    postloading == false
                        ? Divider(
                            thickness: 0.4,
                          )
                        : LinearProgressIndicator(
                            color: Colors.white,
                          ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 225, 225, 225),
                          radius: 25,
                          backgroundImage: NetworkImage(
                            usermodel!.imageurl,
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          height: 150,
                          child: TextField(
                            controller: _description,
                            maxLines: 8,
                            decoration: InputDecoration(
                              hintText: 'write caption',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          width: 60,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: MemoryImage(imgPath!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            : Scaffold(
                backgroundColor: Colors.black,
                body: Center(
                  child: IconButton(
                    onPressed: () {
                      showmodel();
                    },
                    icon: Icon(
                      Icons.upload,
                      size: 55,
                    ),
                  ),
                ),
              ));
  }
}
