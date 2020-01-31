import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditPetro extends StatefulWidget {
  EditPetro({this.car,this.index,this.petroCost,this.petroMiles,this.petroRate});
   String car;
  double petroRate;
  int petroCost;
  int petroMiles;
  final index;
  @override
  _EditPetroState createState() => _EditPetroState();
}

class _EditPetroState extends State<EditPetro> {
  String car;
  double petroRate;
  int petroCost;
  int petroMiles;
  TextEditingController controllercar;
  TextEditingController controllerpetroRate;
  TextEditingController controllerpetroCost;
  TextEditingController controllerpetroMiles;

  void _editPetro() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(widget.index);
      await transaction.update(snapshot.reference, {
         "car" : car,
        "petroRate" : petroRate,
        "petroCost" : petroCost,
        "petroMiles": petroMiles,
        "TimeStamp" : DateTime.now()
      });
    });
    Navigator.pop(context);
  }

  void _deletePetro() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      //DocumentSnapshot snapshot = await transaction.get(widget.index);
      await transaction.delete(widget.index);
    });
    Navigator.pop(context);
  }
  @override
  void initState(){
    super.initState();
    car = widget.car;
    petroRate = widget.petroRate;
    petroCost = widget.petroCost;
    petroMiles = widget.petroMiles;

    controllercar = new TextEditingController(text: widget.car);
    controllerpetroCost = new TextEditingController(text: widget.petroCost.toString());
    controllerpetroRate = new TextEditingController(text: widget.petroRate.toString());
    controllerpetroMiles = new TextEditingController(text: widget.petroMiles.toString());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text('Edit Petro',style: TextStyle(color: Colors.white),),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete,color: Colors.white,),
            onPressed: (){_deletePetro();},
          )
        ], 
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
                 controller: controllerpetroRate,
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
                 controller: controllerpetroCost,
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
                 controller: controllerpetroMiles,
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
          _editPetro();
        },
      ),
    );
  }
}