// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:instagram/Responsive/MobileScreen.dart';
import 'package:instagram/Responsive/WebScreen.dart';
import 'package:instagram/Views/Home.dart';
import 'package:instagram/Views/Login.dart';
import 'package:instagram/Views/Register.dart';

class Responsive extends StatefulWidget {
  const Responsive({super.key});

  @override
  State<Responsive> createState() => _ResponsiveState();
}

class _ResponsiveState extends State<Responsive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return Register();
          } else {
            return Login();
          }
        },
      ),
    );
  }
}
