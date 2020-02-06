import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:n_pac/component/money.dart';
class EditMoney extends StatefulWidget {
  EditMoney({this.index,this.moneyValue,this.moneyType,this.moneyName,this.moneyNote,this.totalBalance});
  String moneyName;
  String moneyNote;
  String moneyType;
  int moneyValue;
  int totalBalance;
 
  final index;
  @override
  _EditMoneyState createState() => _EditMoneyState();
}

class _EditMoneyState extends State<EditMoney> {
  String moneyName;
  String moneyNote;
  String moneyType;
  int moneyValue;
  String email;
  int totalBalance;
  TextEditingController controllermoneyName;
  TextEditingController controllermoneyNote;
  TextEditingController controllermoneyType;
  TextEditingController controllermoneyValue;
  TextEditingController controllertotalBalance;


  void _deleteMoney() {
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
                      .push(new MaterialPageRoute(builder: (context) => Money()));
                })
          ],
        ),
      ),
    );
    showDialog(context: context, child: alertDialog);
  }
  
  void _editMoney(){
    
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
        "moneyType" : moneyType,
        "moneyName" : moneyName,
        "moneyNote" : moneyNote,
        "moneyValue" : moneyValue,
        "timeStamp" : DateTime.now(),
        "totalBalance" : totalBalance
      
      });
    });
                  Navigator.of(context).push(
                      new MaterialPageRoute(builder: (context) => Money()));
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
    moneyName = widget.moneyName;
    moneyNote = widget.moneyNote;
    moneyType = widget.moneyType;
    moneyValue = widget.moneyValue;
    controllermoneyName = new TextEditingController(text: widget.moneyName);
    controllermoneyNote = new TextEditingController(text: widget.moneyNote);
    controllermoneyType = new TextEditingController(text: widget.moneyType);
    controllermoneyValue = new TextEditingController(text: widget.moneyValue.toString());
    controllertotalBalance = new TextEditingController(text: widget.totalBalance.toString());
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
              ),
              TextField(
                controller: controllertotalBalance,
                onChanged: (input){
                  setState(() {
                    totalBalance = total(num.tryParse(input), moneyValue);
                  });
                },
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


int total(int a, int b){
  int total = 0;
  total = a+b;
  return total;
}