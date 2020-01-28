import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class EditMoney extends StatefulWidget {
  EditMoney({this.index,this.moneyValue,this.moneyType,this.moneyName,this.moneyNote});
  String moneyName;
  String moneyNote;
  String moneyType;
  int moneyValue;
  final index;
  @override
  _EditMoneyState createState() => _EditMoneyState();
}

class _EditMoneyState extends State<EditMoney> {
  String moneyName;
  String moneyNote;
  String moneyType;
  int moneyValue;
  TextEditingController controllermoneyName;
  TextEditingController controllermoneyNote;
  TextEditingController controllermoneyType;
  TextEditingController controllermoneyValue;


  void _deleteMoney() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(widget.index);
      await transaction.delete(widget.index);
    }); 
    Navigator.pop(context);
  }
  
  void _editMoney(){
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(widget.index);
      await transaction.update(snapshot.reference, {
        "moneyType" : moneyType,
        "moneyName" : moneyName,
        "moneyNote" : moneyNote,
        "moneyValue" : moneyValue,
        "timeStamp" : DateTime.now()
      });
    });
    Navigator.pop(context);
  }
  @override
  void initState(){
    super.initState();
    moneyName = widget.moneyName;
    moneyNote = widget.moneyNote;
    moneyType = widget.moneyType;
    moneyValue = widget.moneyValue;
    controllermoneyName = new TextEditingController(text: widget.moneyName);
    controllermoneyNote = new TextEditingController(text: widget.moneyNote);
    controllermoneyType = new TextEditingController(text: widget.moneyType);
    controllermoneyValue = new TextEditingController(text: widget.moneyValue.toString());
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
        title: Text('Edit Money',style: TextStyle(color: Colors.white),),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
        ), 
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete,color: Colors.white,),
            onPressed: (){_deleteMoney();},
          )
        ],       
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              TextField(
                controller: controllermoneyName,
                decoration: InputDecoration(
                  labelText: 'ชื่อรายการ',
                  alignLabelWithHint: true,
                ),
                onChanged: (input){
                  setState(() {
                    moneyName = input;
                  });
                },
              ),
              TextField(
                controller: controllermoneyValue,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'จำนวนเงิน',
                  alignLabelWithHint: true,
                ),
                onChanged: (input){
                  setState(() {
                    moneyValue = num.tryParse(input);
                  });
                },
              ),
              TextField(
                controller: controllermoneyNote,
                decoration: InputDecoration(
                  labelText: 'หมายเหตุ',
                  alignLabelWithHint: true,
                ),
                onChanged: (input){
                  setState(() {
                    moneyNote = input;
                  });
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(height: 20,),
                  Text('ประเภทรายการ'),
                  Container(height: 20,),
                  ListTile(
                    title: Text('รายรับ'),
                    leading: Radio(
                      value: 'รายรับ',
                      groupValue: moneyType,
                      onChanged: (input){
                        setState(() {
                          moneyType = input;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('รายจ่าย'),
                    leading: Radio(
                      value: 'รายจ่าย',
                      groupValue: moneyType,
                      onChanged: (input){
                        setState(() {
                          moneyType = input;
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
        backgroundColor: Colors.pinkAccent,
        onPressed: (){
          _editMoney();
        },
      ),
      
      
    );
  }
}