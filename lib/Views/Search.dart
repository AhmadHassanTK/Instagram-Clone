// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:instagram/Cloud/UserCloudServices.dart';
import 'package:instagram/Shared/Snackbar.dart';
import 'package:instagram/Views/Profile.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _search = TextEditingController();
  final UserCloudServices userCloudServices = UserCloudServices();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: TextFormField(
            onChanged: (value) {
              setState(() {});
            },
            autofocus: true,
            controller: _search,
            decoration: InputDecoration(labelText: 'Search'),
          ),
        ),
        body: FutureBuilder(
          future: userCloudServices.Searchedusers(username: _search.text),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return showSnackBar(context, 'Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(
                              userid: snapshot.data!.elementAt(index).uid),
                        ));
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      snapshot.data!.elementAt(index).imageurl,
                    ),
                  ),
                  title: Text(
                    snapshot.data!.elementAt(index).username,
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
