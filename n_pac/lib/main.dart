import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:n_pac/component/homeScreen.dart';

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
  final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
bool _isLoggedIn = false;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  
  _login() async{
   //FirebaseUserMetadata userMetadata = await _auth.sign 
    try{
      await _googleSignIn.signIn();
      
      setState(() {
        _isLoggedIn = true;
       Navigator.push(context, new MaterialPageRoute(builder: (context) => HomeScreen(
         googleSignIn: googleSignIn,
       )));
      });
    } catch (err){
      print(err);
    }
  }

  _logout(){
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
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
                    _login();
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
