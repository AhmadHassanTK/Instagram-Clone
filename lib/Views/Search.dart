// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: TextFormField(
              autofocus: true,
              decoration: InputDecoration(labelText: 'Search'),
            ),
          )),
    );
  }
}
