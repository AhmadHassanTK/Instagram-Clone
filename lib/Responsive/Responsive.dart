// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:instagram/Provider/UserProvider.dart';
import 'package:instagram/Responsive/MobileScreen.dart';
import 'package:instagram/Responsive/WebScreen.dart';
import 'package:provider/provider.dart';

class Responsive extends StatefulWidget {
  const Responsive({super.key});

  @override
  State<Responsive> createState() => _ResponsiveState();
}

class _ResponsiveState extends State<Responsive> {
  loadingUserData() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.userData();
  }

  @override
  void initState() {
    loadingUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return WebScreen();
          } else {
            return MobileScreen();
          }
        },
      ),
    );
  }
}
