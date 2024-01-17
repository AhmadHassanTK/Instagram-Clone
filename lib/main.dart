// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Provider/GuestProvider.dart';
import 'package:instagram/Provider/UserProvider.dart';
import 'package:instagram/Responsive/Responsive.dart';
import 'package:instagram/Shared/Snackbar.dart';
import 'package:instagram/Views/Login.dart';
import 'package:instagram/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyDdfGGL_3p4SkgsHbTNT8n0ICSUZ8bw3UA',
        appId: '1:1067303508029:web:3abb56b64afe2c6e06b254',
        messagingSenderId: '1067303508029',
        projectId: 'my-instagram-clone-2023',
      ),
    );
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return UserProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return GuestProvider();
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            print('Snapshot: $snapshot');
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return showSnackBar(context, 'Something went wrong');
            } else if (snapshot.hasData && snapshot.data != null) {
              return Responsive();
            } else {
              return const Login();
            }
          },
        ),
      ),
    );
  }
}
