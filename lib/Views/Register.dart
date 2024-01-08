// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';
import 'package:instagram/Auth/Authservices.dart';
import 'package:instagram/Auth/firebaseAuth.dart';
import 'package:instagram/Views/Login.dart';
import 'package:instagram/Shared/MyTextField.dart';

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

  final TextEditingController _email = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _title = TextEditingController();
  //final CloudServices cloudServices = CloudServices();
  final Authservices authservices = Authservices(FirebaseAuthprovider());

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _title.dispose();
    _username.dispose();

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
                      if (_key.currentState!.validate()) {
                        setState(() {
                          registerpressed = true;
                        });
                        final user = await authservices.Register(
                            email: _email.text, password: _password.text);

                        // await cloudServices.cloudAdduser(
                        //     username: _username.text,
                        //     age: _age.text,
                        //     email: _email.text,
                        //     password: _password.text);

                        // if (!mounted) return;
                        // if (user != null) {
                        //   await authservices.SendEmailVerfication();
                        //   Navigator.of(context).pushAndRemoveUntil(
                        //       MaterialPageRoute(
                        //           builder: (context) => EmailVerfication()),
                        //       (route) => false);
                        // }

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
