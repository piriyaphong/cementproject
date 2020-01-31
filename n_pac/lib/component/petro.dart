import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Petro extends StatefulWidget {
  @override
  _PetroState createState() => _PetroState();
}

class _PetroState extends State<Petro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text('Petro',style: TextStyle(color: Colors.white),),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
        ), 
      ),
        body: StreamBuilder(
        stream: Firestore.instance.collection('petro').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return new Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return new ListPetro(
            document: snapshot.data.documents,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,color:Colors.white),
        backgroundColor: Colors.green,
        onPressed: (){
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) => AddPetro()));
        },
      ),
      
    );
  }
}




class AddPetro extends StatefulWidget {
  @override
  _AddPetroState createState() => _AddPetroState();
}

class _AddPetroState extends State<AddPetro> {
  String car;
  double petroRate;
  int petroCost;
  int petroMiles;
  void _addPetro(){
    Firestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference = Firestore.instance.collection('petro');
      await reference.add({
        "car" : car,
        "petroRate" : petroRate,
        "petroCost" : petroCost,
        "petroMiles": petroMiles,
        "TimeStamp" : DateTime.now()
      });
    });
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text('Add Petro',style: TextStyle(color: Colors.white),),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
        ), 
      ),
      body: SingleChildScrollView(
       child: Padding(
         padding: EdgeInsets.all(10),
         child: Container(
           child: Column(
             children: <Widget>[
               Container(
                 padding: EdgeInsets.all(10),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                     Container(child: Text('รถ'),),
                     ListTile(
                       title: Text('โม่'),
                       leading: Radio(
                         groupValue: car,
                         value: 'โม่',
                         onChanged: (input){
                           setState(() {
                             car = input;
                           });
                         },
                       ),
                     ),
                     ListTile(
                       title: Text('รถยนต์'),
                       leading: Radio(
                         groupValue: car,
                         value: 'รถยนต์',
                         onChanged: (input){
                           setState(() {
                             car = input;
                           });
                         },
                       ),
                     )
                   ],
                 ),
               ),
               TextField(
                  keyboardType: TextInputType.number,
                 decoration: InputDecoration(
                   labelText: 'ราคาน้ำมัน',
                   alignLabelWithHint: true
                 ),
                 onChanged: (input){
                   setState(() {
                     petroRate = num.tryParse(input);
                   });
                 },
               ),
               TextField(
                keyboardType: TextInputType.number,
                 decoration: InputDecoration(
                   labelText: 'จำนวนเงินที่เติม',
                   alignLabelWithHint: true
                 ),
                 onChanged: (input){
                   setState(() {
                     petroCost = num.tryParse(input);
                   });
                 },
               ),
               TextField(
                  keyboardType: TextInputType.number,
                 decoration: InputDecoration(
                   labelText: 'เลขไมล์ก่อนเติม',
                   alignLabelWithHint: true
                 ),
                 onChanged: (input){
                   setState(() {
                     petroMiles = num.tryParse(input);
                   });
                 },
               )
             ],
           ),
         ),
       ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save,color: Colors.white,),
        backgroundColor: Colors.green,
        onPressed: (){
          _addPetro();
        },
      ),
      
    );
  }
}


class ListPetro extends StatelessWidget {
  List<DocumentSnapshot> document;
  ListPetro ({this.document});
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount:  document.length,
      itemBuilder: (BuildContext context, int i){
        String car = document[i].data['car'];
        double petroRate = document[i].data['petroRate'];
        int petroCost = document[i].data['petroCost'];
        int petroMiles = document[i].data['petroMiles'];

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
                      Row(children: <Widget>[
                        Text(car),Container(width: 20,),Text('จำนวนที่เติม'),Container(width: 20,),Text(petroCost.toString())
                      ],),
                      Row(
                        children: <Widget>[
                          Text('ราคาน้ำมัน'),Container(width: 20,),Text(petroRate.toString()),Container(width: 20,),Text('เลขไมล์ก่อนเติม'),Container(width: 20,),Text(petroMiles.toString())
                        ],
                      )
                    ],
                  ),
                ),
              ),
              new IconButton(
                icon: Icon(Icons.edit),
                onPressed: (){},
              )
            ],
          ),
        );
      },
      
    );
  }
}


