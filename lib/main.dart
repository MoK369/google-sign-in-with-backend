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
      debugShowCheckedModeBanner: false,
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
                    try{
                      GoogleSignIn googleSignIn = GoogleSignIn.instance;
                      await googleSignIn.initialize(
                        clientId:
                        "386181200751-76tpftvbo4cie1s83t7upfmv2822oclj.apps.googleusercontent.com"
                        ,
                        serverClientId:
                        "386181200751-qdnpa6bensiqbkke090251q6gv307u1j.apps.googleusercontent.com",
                      );
                      GoogleSignInAccount? userAccount =
                      await googleSignIn.authenticate();
                      GoogleSignInAuthentication auth =
                          userAccount.authentication;
                      if (kDebugMode) {
                        print(userAccount);
                      }
                      if (kDebugMode) {
                        print("idToken:${auth.idToken}");
                      }
                      setState(() {
                        idToken = auth.idToken ?? "null";
                      });
                    }catch(e){
                      idToken = "Something Went Wrong with Retrieving ID Token";
                    }
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
