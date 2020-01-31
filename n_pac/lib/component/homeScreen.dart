import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:n_pac/component/car.dart';
import 'package:n_pac/component/money.dart';
import 'package:n_pac/component/personel.dart';
import 'package:n_pac/component/petro.dart';
import 'package:n_pac/component/sale.dart';
import 'package:n_pac/component/stock.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:n_pac/main.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen({this.googleSignIn,this.user});
  final GoogleSignIn  googleSignIn;
  final FirebaseUser user;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
bool _isLoggedIn = true;
 GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  _logout(){
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
      Navigator.of(context).push(new MaterialPageRoute(builder: (context) => MyHomePage()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'N-PAC',
          style: TextStyle(color: Colors.white),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
        actions: <Widget>[
          IconButton(
            
            icon: Icon(Icons.exit_to_app,color: Colors.white,),
            onPressed: (){
              _logout();
            },
          )
        ],

      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(1),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Welcome',
                    style: TextStyle(fontSize: 50, shadows: [
                      Shadow(
                        blurRadius: 20,
                        color: Colors.black38,
                        offset: Offset(5.0, 5.0),
                      )
                    ]),
                  ),
                ),
              ),
              


              //Sale system
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(

                      color: Colors.redAccent,
                      // image: DecorationImage(
                      //     image: AssetImage('assets/images/bgred.jpg'),
                      //     fit: BoxFit.fill),

                      //color: Colors.redAccent,
                      image: DecorationImage(
                          image: AssetImage('assets/images/bgred.PNG'),
                          fit: BoxFit.fill),

                      borderRadius: new BorderRadiusDirectional.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 10,
                          spreadRadius: 1,
                        )
                      ]),
                  child: ListTile(
                    leading: Icon(
                      Icons.shopping_cart,
                      size: 50,
                      color: Colors.white,
                    ),
                    title: Text(
                      'SALE',
                      style: TextStyle(fontSize: 50, color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                          new MaterialPageRoute(builder: (context) => Sale()));
                    },
                  ),
                ),
              ),
              
              //Money system
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(

                      //color: Colors.pinkAccent,
                      image: DecorationImage(
                          image: AssetImage('assets/images/bgpink.PNG'),
                          fit: BoxFit.fill),

                      borderRadius: new BorderRadiusDirectional.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 10,
                          spreadRadius: 1,
                        )
                      ]),
                  child: ListTile(
                    leading: Icon(
                      Icons.attach_money,
                      size: 50,
                      color: Colors.white,
                    ),
                    title: Text(
                      'MONEY',
                      style: TextStyle(fontSize: 50, color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                          new MaterialPageRoute(builder: (context) => Money()));
                    },
                  ),
                ),
              ),
              
              //Personel system
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      //color: Colors.orangeAccent,
                      image: DecorationImage(
                          image: AssetImage('assets/images/bgorange.PNG'),
                          fit: BoxFit.fill),
                      borderRadius: new BorderRadiusDirectional.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 10,
                          spreadRadius: 1,
                        )
                      ]),
                  child: ListTile(
                    leading: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                    title: Text(
                      'PERSONEL',
                      style: TextStyle(fontSize: 50, color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => Personel()));
                    },
                  ),
                ),
              ),
              
              //Car system
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      //color: Colors.yellow,
                      image: DecorationImage(
                          image: AssetImage('assets/images/bgyellow.PNG'),
                          fit: BoxFit.fill),

                      borderRadius: new BorderRadiusDirectional.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 10,
                          spreadRadius: 1,
                        )
                      ]),
                  child: ListTile(
                    leading: Icon(Icons.drive_eta,size: 50,color: Colors.white,),
                    title: Text('CAR',style: TextStyle(fontSize: 50,color: Colors.white),),
                    onTap: (){
                      Navigator.of(context).push(new MaterialPageRoute(builder:  (context) => Car()));
                    },
                  ),
                ),
              ),
              
              //Petro system
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(

                      //color: Colors.green,
                      image: DecorationImage(
                          image: AssetImage('assets/images/bggreen.PNG'),
                          fit: BoxFit.fill),
                      borderRadius: new BorderRadiusDirectional.circular(10),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 10,
                          spreadRadius: 1,
                        )
                      ]),
                  child: ListTile(
                    leading: Icon(
                      Icons.local_gas_station,
                      size: 50,
                      color: Colors.white,
                    ),
                    title: Text(
                      'PETRO',
                      style: TextStyle(fontSize: 50, color: Colors.white),
                    ),
                    onTap: (){
                      Navigator.of(context).push(new MaterialPageRoute(builder: (context) => Petro()));
                    },
                  ),
                ),
              ),
              
              
              //Stock System
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      //color: Colors.lightBlue,
                      image: DecorationImage(
                          image: AssetImage('assets/images/bgblue.PNG'),
                          fit: BoxFit.fill),
                      borderRadius: new BorderRadiusDirectional.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 10,
                          spreadRadius: 1,
                        )
                      ]),
                  child: ListTile(
                    leading: Icon(
                      Icons.store_mall_directory,
                      size: 50,
                      color: Colors.white,
                    ),
                    title: Text(
                      'STOCK',
                      style: TextStyle(fontSize: 50, color: Colors.white),
                    ),
                    onTap: (){
                      Navigator.of(context).push(new MaterialPageRoute(builder: (context) => Stock()));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      
    );
  }
}