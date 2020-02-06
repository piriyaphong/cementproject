import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:n_pac/edit/moneyEdit.dart';

class Money extends StatefulWidget {
  Money({this.user});
  final FirebaseUser user;
  @override
  _MoneyState createState() => _MoneyState();
}

class _MoneyState extends State<Money> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
        title: Text(
          'Money',
          style: TextStyle(color: Colors.white),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('money').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return new Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return new MoneyList(
            document: snapshot.data.documents,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context)
              .push(new MaterialPageRoute(builder: (context) => AddMoney()));
        },
      ),
    );
  }
}

class AddMoney extends StatefulWidget {
  AddMoney({this.user});
  final FirebaseUser user;
  @override
  _AddMoneyState createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
  String moneyType;
  String moneyName;
  String moneyNote;
  int moneyValue;
  String email;



  

  void _addMoney() {
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
              child: Text("บันทึกสำเร็จ"),
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
                  Firestore.instance
                      .runTransaction((Transaction transaction) async {
                    CollectionReference reference =
                        Firestore.instance.collection('money');
                    DocumentReference docreference = Firestore.instance
                        .collection('Total')
                        .document('totalBalance');
                     await reference.add({
                      "moneyType": moneyType,
                      "moneyName": moneyName,
                      "moneyNote": moneyNote,
                      "moneyValue": moneyValue,
                      "timeStamp": DateTime.now(),
                      
                    });
                     //await docreference.updateData({"temp": totalBalance,"timeStamp":DateTime.now()});
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
        title: Text(
          'Add Money',
          style: TextStyle(color: Colors.white),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'ชื่อรายการ',
                  alignLabelWithHint: true,
                ),
                onChanged: (input) {
                  setState(() {
                    moneyName = input;
                  });
                },
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'จำนวนเงิน',
                  alignLabelWithHint: true,
                ),
                onChanged: (input) {
                  setState(() {
                    moneyValue = num.tryParse(input);
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'หมายเหตุ',
                  alignLabelWithHint: true,
                ),
                onChanged: (input) {
                  setState(() {
                    moneyNote = input;
                  });
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 20,
                  ),
                  Text('ประเภทรายการ'),
                  Container(
                    height: 20,
                  ),
                  ListTile(
                    title: Text('รายรับ'),
                    leading: Radio(
                      value: 'รายรับ',
                      groupValue: moneyType,
                      onChanged: (input) {
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
                      onChanged: (input) {
                        setState(() {
                          moneyType = input;
                        });
                      },
                    ),
                  )
                ],
              ),
              new StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('Total').snapshots(),
                builder: (context, snapshot) {
                  var length = snapshot.data.documents.length;
                  DocumentSnapshot ds = snapshot.data.documents[length - 1];
                  return new TextField(
                    decoration: InputDecoration(
                      labelText: 'ยอดเงินคงเหลือ',
                      alignLabelWithHint: true,
                    ),
                    onChanged: (input) {
                      setState(() {  

                       
                         int totalBalance = moneyValue + num.tryParse(input) + num.tryParse(ds.data['temp']); 
                      });
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.save,
          color: Colors.white,
        ),
        backgroundColor: Colors.pinkAccent,
        onPressed: () {
          
          _addMoney();
        },
      ),
    );
  }
}

class MoneyList extends StatelessWidget {
  List<DocumentSnapshot> document;
  MoneyList({this.document});
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: document.length,
      itemBuilder: (BuildContext context, int i) {
        String moneyType = document[i].data['moneyType'];
        String moneyName = document[i].data['moneyName'];
        String moneyNote = document[i].data['moneyNote'];
        int moneyValue = document[i].data['moneyValue'];
        int totalBalance = document[i].data['totalBalance'];

        return Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              new Container(
                width: 30,
                child: Text((i + 1).toString()),
              ),
              new Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadiusDirectional.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 5,
                          spreadRadius: 1,
                        )
                      ]),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        moneyName,
                        style: TextStyle(fontSize: 30),
                      ),
                      Row(
                        children: <Widget>[
                          Text(moneyType),
                          Container(
                            width: 20,
                          ),
                          Text(moneyValue.toString()),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Note : ',
                            style: TextStyle(color: Colors.black45),
                          ),
                          Container(
                            width: 20,
                          ),
                          Text(moneyNote),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              new IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => EditMoney(
                            moneyName: moneyName,
                            moneyNote: moneyNote,
                            moneyType: moneyType,
                            moneyValue: moneyValue,
                            index: document[i].reference,
                            totalBalance: totalBalance,
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
