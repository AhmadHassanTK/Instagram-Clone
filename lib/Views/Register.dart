// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, use_build_context_synchronously, depend_on_referenced_packages, unnecessary_import

import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/Auth/Authservices.dart';
import 'package:instagram/Auth/firebaseAuth.dart';
import 'package:instagram/Cloud/UserCloudServices.dart';
import 'package:instagram/Responsive/Responsive.dart';
import 'package:instagram/Views/Login.dart';
import 'package:instagram/Shared/MyTextField.dart';
import 'package:path/path.dart' show basename;

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _key = GlobalKey<FormState>();
  bool ispassword = true;
  bool registerpressed = false;
  bool passwordsuccess = false;
  Uint8List? imgPath;
  String? imgName;
  List followers = [];
  List following = [];
  final TextEditingController _email = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _title = TextEditingController();
  final UserCloudServices cloudServices = UserCloudServices();
  final Authservices authservices = Authservices(FirebaseAuthprovider());

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _title.dispose();
    _username.dispose();

    super.dispose();
  }

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
    final screenwidth = MediaQuery.sizeOf(context).width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            title: Text(
          'Register',
          style: TextStyle(color: Colors.white),
        )),
        body: SingleChildScrollView(
          child: Padding(
            padding: screenwidth < 600
                ? const EdgeInsets.all(16.0)
                : EdgeInsets.symmetric(horizontal: screenwidth * 0.25),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(125, 78, 91, 110),
                    ),
                    child: Stack(
                      children: [
                        imgPath == null
                            ? CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 225, 225, 225),
                                radius: 71,
                                // backgroundImage: AssetImage("assets/img/avatar.png"),
                                backgroundImage:
                                    AssetImage("assets/mobile/avatar.png"),
                              )
                            : CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 225, 225, 225),
                                radius: 71,
                                // backgroundImage: AssetImage("assets/img/avatar.png"),
                                backgroundImage: MemoryImage(imgPath!),
                              ),
                        Positioned(
                          left: 99,
                          bottom: -10,
                          child: IconButton(
                            onPressed: () {
                              // uploadImage2Screen();
                              showmodel();
                            },
                            icon: const Icon(Icons.add_a_photo),
                            color: Color.fromARGB(255, 94, 115, 128),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Create your account",
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    controller: _username,
                    autofocusflag: false,
                    hintValue: 'Enter your username',
                    textInputType: TextInputType.emailAddress,
                    icon: Icon(Icons.person),
                    isObscureText: false,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    controller: _title,
                    autofocusflag: true,
                    hintValue: 'Enter your title',
                    isObscureText: false,
                    textInputType: TextInputType.name,
                    icon: Icon(Icons.person_3_outlined),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    validate: (value) {
                      return value != null && !EmailValidator.validate(value)
                          ? 'Enter a valid email'
                          : null;
                    },
                    controller: _email,
                    autofocusflag: false,
                    hintValue: 'Enter your email',
                    textInputType: TextInputType.emailAddress,
                    icon: Icon(Icons.email_outlined),
                    isObscureText: false,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    validate: (value) {
                      return _password.text.length > 8 ? null : 'Not Valid';
                    },
                    controller: _password,
                    hintValue: 'Enter your password',
                    textInputType: TextInputType.text,
                    isObscureText: ispassword,
                    autofocusflag: false,
                    icon: Icon(
                        ispassword ? Icons.visibility : Icons.visibility_off),
                    onTap: () {
                      setState(() {
                        ispassword = !ispassword;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      if (_key.currentState!.validate() &&
                          imgName != null &&
                          imgPath != null) {
                        setState(() {
                          registerpressed = true;
                        });
                        final user = await authservices.Register(
                          email: _email.text,
                          password: _password.text,
                          context: context,
                        );

                        await cloudServices.adduser(
                          username: _username.text,
                          title: _title.text,
                          email: _email.text,
                          password: _password.text,
                          context: context,
                          imgName: imgName,
                          imgPath: imgPath,
                          followers: followers,
                          following: following,
                        );

                        if (!mounted) return;
                        if (user != null) {
                          //   await authservices.SendEmailVerfication();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => Responsive()),
                              (route) => false);
                        }

                        setState(() {
                          registerpressed = false;
                        });
                      }
                    },
                    child: registerpressed
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Do you already have an account ?'),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => Login()),
                              (route) => false);
                        },
                        child: Text('Sign in'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
