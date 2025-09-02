import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gmail Sign In',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Gmail Sign In'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String idToken = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () async {
                    GoogleSignIn googleSignIn = GoogleSignIn.instance;
                    await googleSignIn.initialize(
                      clientId:
                          kReleaseMode
                              ? "386181200751-6q6b030ft9gvd1g3i99f5c5qf5u2ud41.apps.googleusercontent.com"
                              : "386181200751-859jk6otmeg909tp658hliatrgc5uihj.apps.googleusercontent.com",
                      serverClientId:
                          "386181200751-qdnpa6bensiqbkke090251q6gv307u1j.apps.googleusercontent.com",
                    );
                    GoogleSignInAccount? userAccount =
                        await googleSignIn.authenticate();
                    GoogleSignInAuthentication auth =
                        userAccount.authentication;
                    print(userAccount);
                    print("idToken:${auth.idToken}");
                    setState(() {
                      idToken = auth.idToken ?? "null";
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/icons/google_logo.png", width: 30),
                      SizedBox(width: 15),
                      Text("sign in", style: TextStyle(fontSize: 25)),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SelectableText(idToken, style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
