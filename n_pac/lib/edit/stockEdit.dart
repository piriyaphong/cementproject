import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:n_pac/component/stock.dart';

class EditStock extends StatefulWidget {
  EditStock({this.index,this.cement,this.sand,this.stoneType1,this.stoneType2});
  int cement  ;
  int sand;
  int stoneType1  ;
  int stoneType2;
  final index;

  @override
  _EditStockState createState() => _EditStockState();
}

class _EditStockState extends State<EditStock> {
  int cement;
  int sand;
  int stoneType1;
  int stoneType2;
  TextEditingController controllercement;
  TextEditingController controllersand;
  TextEditingController controllerstoneType1;
  TextEditingController controllerstoneType2;

   void _deleteStock() {
    AlertDialog alertDialog = new AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      content: Container(
        height: 160,
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.delete_forever,
                color: Colors.red,
              ),
              iconSize: 50,
            ),
            Container(
              child: Text("ลบสำเร็จ"),
            ),
            Container(
              height: 20,
            ),
            FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                color: Colors.red,
                textColor: Colors.white,
                child: Text('ตกลง'),
                onPressed: () {
                  Firestore.instance
                      .runTransaction((Transaction transaction) async {
                    //DocumentSnapshot snapshot = await transaction.get(widget.index);
                    await transaction.delete(widget.index);
                  });
                  Navigator.of(context)
                      .push(new MaterialPageRoute(builder: (context) => Stock()));
                })
          ],
        ),
      ),
    );
    showDialog(context: context, child: alertDialog);
  }

  void _editStock() {
    
     AlertDialog alertDialog = new AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      content: Container(
        height: 160,
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              iconSize: 50,
            ),
            Container(
              child: Text("อัพเดตสำเร็จ"),
            ),
            Container(
              height: 20,
            ),
            FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                color: Colors.green,
                textColor: Colors.white,
                child: Text('ตกลง'),
                onPressed: () {
                  Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(widget.index);
      await transaction.update(snapshot.reference, {
        "cement" : cement,
        "sand" : sand,
        "stoneType1" : stoneType1,
        "stoneType2" : stoneType2,
        "TimeStamp" : DateTime.now()
      });
    });
                  Navigator.of(context).push(
                      new MaterialPageRoute(builder: (context) => Stock()));
                })
          ],
        ),
      ),
    );
    showDialog(context: context, child: alertDialog);
  }
  @override
  void initState(){
    super.initState();
    cement = widget.cement;
    sand = widget.sand;
    stoneType1 = widget.stoneType1;
    stoneType2 = widget.stoneType2;

    controllercement = new TextEditingController(text: widget.cement.toString());
    controllersand = new TextEditingController(text: widget.sand.toString());
    controllerstoneType1 = new TextEditingController(text: widget.stoneType1.toString());
    controllerstoneType2 = new TextEditingController(text: widget.stoneType2.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text('Update Stock',style: TextStyle(color: Colors.white),),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
        ), 
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete,color: Colors.white),
            onPressed: (){
              _deleteStock();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //Container(child: Text('ปูน'),),
                TextField(
                  controller: controllercement,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'ปูน จำนวน กิโลกรัม',
                    alignLabelWithHint: true
                  ),
                  onChanged: (input){
                    setState(() {
                      cement = num.tryParse(input);
                    });
                  },
                ),
                //Container(child: Text('ปูน'),),
                TextField(
                  controller: controllerstoneType1,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'หินโขง จำนวน กิโลกรัม',
                    alignLabelWithHint: true
                  ),
                  onChanged: (input){
                    setState(() {
                      sand = num.tryParse(input);
                    });
                  },
                ),
                TextField(
                  controller: controllerstoneType2,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'หินภูเขา จำนวน กิโลกรัม',
                    alignLabelWithHint: true
                  ),
                  onChanged: (input){
                    setState(() {
                      stoneType1 = num.tryParse(input);
                    });
                  },
                ),
                TextField(
                  controller: controllersand,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'ทราย จำนวน กิโลกรัม',
                    alignLabelWithHint: true
                  ),
                  onChanged: (input){
                    setState(() {
                      stoneType2 = num.tryParse(input);
                    });
                  },
                ),

              ],
            ),
          ),
        ),
      ),


      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save,color: Colors.white),
        backgroundColor: Colors.blueAccent,
        onPressed: (){
         _editStock();
        },
      ),
    );
  }
}