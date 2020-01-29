import 'package:flutter/material.dart';
import 'package:n_pac/component/car.dart';
import 'package:n_pac/component/money.dart';
import 'package:n_pac/component/personel.dart';
import 'package:n_pac/component/sale.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('N-PAC',style: TextStyle(color: Colors.white),),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
        ),
        
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
                  child: Text('Welcome',style: TextStyle(
                    fontSize: 50,                   
                    shadows:[
                      Shadow(blurRadius: 20,color: Colors.black38,offset: Offset(5.0, 5.0),)
                    ]
                  ),),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: new BorderRadiusDirectional.circular(10),
                    boxShadow: [BoxShadow(
                      color: Colors.black45,
                      blurRadius: 10,
                      spreadRadius: 1,
                    )]
                  ),
                  child: ListTile(
                    leading: Icon(Icons.shopping_cart,size: 50,color: Colors.white,),
                    title: Text('SALE',style: TextStyle(fontSize: 50,color: Colors.white),),
                    onTap: (){
                      Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>Sale()));
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: new BorderRadiusDirectional.circular(10),
                    boxShadow: [BoxShadow(
                      color: Colors.black45,
                      blurRadius: 10,
                      spreadRadius: 1,
                    )]
                  ),
                  child: ListTile(
                    leading: Icon(Icons.attach_money,size: 50,color: Colors.white,),
                    title: Text('MONEY',style: TextStyle(fontSize: 50,color: Colors.white),),
                    onTap: (){
                      Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> Money()));
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: new BorderRadiusDirectional.circular(10),
                    boxShadow: [BoxShadow(
                      color: Colors.black45,
                      blurRadius: 10,
                      spreadRadius: 1,
                    )]
                  ),
                  child: ListTile(
                    leading: Icon(Icons.person,size: 50,color: Colors.white,),
                    title: Text('PERSONEL',style: TextStyle(fontSize: 50,color: Colors.white),),
                    onTap: (){
                      Navigator.of(context).push(new MaterialPageRoute(builder: (context) => Personel()));
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: new BorderRadiusDirectional.circular(10),
                    boxShadow: [BoxShadow(
                      color: Colors.black45,
                      blurRadius: 10,
                      spreadRadius: 1,
                    )]
                  ),
                  child: ListTile(
                    leading: Icon(Icons.drive_eta,size: 50,color: Colors.white,),
                    title: Text('CAR',style: TextStyle(fontSize: 50,color: Colors.white),),
                    onTap: (){
                      Navigator.of(context).push(new MaterialPageRoute(builder: (context) => Car()));
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: new BorderRadiusDirectional.circular(10),
                    boxShadow: [BoxShadow(
                      color: Colors.black45,
                      blurRadius: 10,
                      spreadRadius: 1,
                    )]
                  ),
                  child: ListTile(
                    leading: Icon(Icons.local_gas_station,size: 50,color: Colors.white,),
                    title: Text('PETRO',style: TextStyle(fontSize: 50,color: Colors.white),),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: new BorderRadiusDirectional.circular(10),
                    boxShadow: [BoxShadow(
                      color: Colors.black45,
                      blurRadius: 10,
                      spreadRadius: 1,
                    )]
                  ),
                  child: ListTile(
                    leading: Icon(Icons.store_mall_directory,size: 50,color: Colors.white,),
                    title: Text('STOCK',style: TextStyle(fontSize: 50,color: Colors.white),),
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