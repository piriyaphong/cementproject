

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:n_pac/component/homeScreen.dart';

import 'component/homeScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  bool isSignIn = false;

  Future<FirebaseUser> _signIn() async{ 
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken);
    FirebaseUser firebaseUser  = await firebaseAuth.signInWithCredential(credential);
    Navigator.of(context).push( MaterialPageRoute(builder: (context)=> HomeScreen(user: firebaseUser, googleSignIn:googleSignIn)));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bggreen.PNG'),
                fit: BoxFit.none)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
            children: <Widget>[
            Container(
                alignment: Alignment.center,
                width: double.maxFinite,
                child: Text(
                  'N-PAC',
                  style: TextStyle(fontSize: 100, color: Colors.white),
                )),
                Container(
              width: 300,
              child: Card(
                child: ListTile( 
                                   
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/googleicon.png'),
                            fit: BoxFit.fill)),
                  ),
                  title: Text('Sign in with Google',style: TextStyle(color: Colors.black54),),
                  onTap: (){
                    _signIn();
                  },
                ),
                
              ),
            )
            
             
          ],
        ),
      ),
    );
  }
}




