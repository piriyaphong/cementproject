import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:n_pac/edit/carEdit.dart';

class Car extends StatefulWidget {
  @override
  _CarState createState() => _CarState();
}

class _CarState extends State<Car> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        centerTitle: true,
        title: Text('Car',style: TextStyle(color: Colors.white),),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
        ), 
      ),
        body: StreamBuilder(
        stream: Firestore.instance.collection('car').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return new Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return new ListCar(
            document: snapshot.data.documents,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,color: Colors.white,),
        onPressed: (){
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) => AddCar()));
        },
        
      ),
    );
  }
}

class AddCar extends StatefulWidget {
  @override
  _AddCarState createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  String carName;
  String carId;
  String carType;

  void _addCar(){
    Firestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference = Firestore.instance.collection('car');
      await reference.add(
        {
          "carName" : carName,
          "carId" : carId,
          "carType" : carType,
          "TimeStamp" : DateTime.now()
        }
      );
    });
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        centerTitle: true,
        title: Text('Add Car',style: TextStyle(color: Colors.white),),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
        ), 
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'ชื่อรถ',
                  alignLabelWithHint: true
                ),
                onChanged: (input){
                  setState(() {
                    carName = input;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'เลขทะเบียนรถ',
                  alignLabelWithHint: true
                ),
                onChanged: (input){
                  setState(() {
                    carId = input;
                  });
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(height: 20,),
                  Container(
                    child: Text('ประเภท'),
                  ),
                  ListTile(
                    title: Text('รถยนต์'),
                    leading: Radio(
                      value: 'รถยนต์',
                      groupValue: carType,
                      onChanged: (input){
                        setState(() {
                          carType = input;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('รถบรรทุก'),
                    leading: Radio(
                      value: 'รถบรรทุก',
                      groupValue: carType,
                      onChanged: (input){
                        setState(() {
                          carType = input;
                        });
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save,color: Colors.white,),
        onPressed: (){
          _addCar();
        },
        
      ),
    );
  }
}

class ListCar extends StatelessWidget {
  List<DocumentSnapshot> document;
  ListCar({this.document});
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: document.length,
      itemBuilder: (BuildContext context, int i){
        String carName = document[i].data['carName'];
        String carId = document[i].data['carId'];
        String carType = document[i].data['carType'];
        return Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              new Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadiusDirectional.circular(10),
                    boxShadow: [BoxShadow(
                      color: Colors.black45,
                      blurRadius:5,
                      spreadRadius: 1,
                    )]
                  ),
                  child: Column( 
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(carName),Container(width: 20,),Text(carId)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              new IconButton(
                icon: Icon(Icons.edit),
                onPressed: (){
                  Navigator.of(context).push(new MaterialPageRoute(builder: (context) => EditCar(
                    carName : carName,
                    carId : carId,
                    carType : carType,
                    index : document[i].reference
                  )));
                },
              )
            ],
          ),
        );
      },
      
    );
  }
}