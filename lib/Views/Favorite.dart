// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'favorite',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ));
  }
}
