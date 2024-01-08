// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/route_manager.dart';
import 'package:instagram/Auth/Authservices.dart';
import 'package:instagram/Auth/firebaseAuth.dart';
import 'package:instagram/Shared/MyTextField.dart';
import 'package:instagram/Views/Home.dart';
import 'package:instagram/Views/Register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _key = GlobalKey<FormState>();
  bool buttonpressed = false;
  bool ispassword = true;
  Color iconcolor = Colors.black;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final Authservices authservices = Authservices(FirebaseAuthprovider());

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.sizeOf(context).width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            'Sign in',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenwidth > 600 ? screenwidth * 0.25 : 0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    Text(
                      'Welcome',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Poppins'),
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
                      hintValue: 'Enter your email',
                      textInputType: TextInputType.emailAddress,
                      isObscureText: false,
                      autofocusflag: true,
                      icon: Icon(Icons.email_outlined),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MyTextField(
                      validate: (value) {
                        return value!.length < 8
                            ? 'Enter at least 8 charactars'
                            : null;
                      },
                      controller: _password,
                      hintValue: 'Enter your password',
                      textInputType: TextInputType.text,
                      isObscureText: ispassword,
                      autofocusflag: false,
                      icon: ispassword
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                      onTap: () {
                        setState(() {
                          ispassword = !ispassword;
                        });
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_key.currentState!.validate()) {
                          setState(() {
                            buttonpressed = true;
                          });

                          final user = await authservices.SignIn(
                              email: _email.text, password: _password.text);

                          setState(() {
                            buttonpressed = false;
                          });
                          if (user != null) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (contxt) => Home()),
                                (route) => false);
                          }
                        }
                      },
                      child: buttonpressed
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Poppins',
                              ),
                            ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Get.to(() => ForgetPassword());
                      },
                      child: Text(
                        'Forget your password ?',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Do not have an account?'),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => Register()),
                                (route) => false);
                          },
                          child: const Text('Sign up'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
