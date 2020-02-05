import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:n_pac/edit/saleEdit.dart';

class Sale extends StatefulWidget {
  @override
  _SaleState createState() => _SaleState();
}

class _SaleState extends State<Sale> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: Text(
          'Sale',
          style: TextStyle(color: Colors.white),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('salebill').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return new Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return new BillList(
            document: snapshot.data.documents,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context)
              .push(new MaterialPageRoute(builder: (context) => AddSale()));
        },
      ),
    );
  }
}

class AddSale extends StatefulWidget {
  @override
  _AddSaleState createState() => _AddSaleState();
}

class _AddSaleState extends State<AddSale> {
  String cementType = '';
  String stoneType = '';
  String cusName = '';
  String cusAds = '';
  int deliPrice;
  int valueCement;
  int totalPrice;
  String _car;
  String _personelDeli;

  void addNewBill() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference = Firestore.instance.collection('salebill');
      await reference.add({
        "cusName": cusName,
        "cusAds": cusAds,
        "cementType": cementType,
        "stoneType": stoneType,
        "deliPrice": deliPrice,
        "valueCement": valueCement,
        "totalPrice": totalPrice,
        "carDeli" : _car,
        "personelDeli" : _personelDeli,
        "timeStamp": DateTime.now(),
      });
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: Text(
          'NEW BILL',
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
                    labelText: 'ชื่อลูกค้า', alignLabelWithHint: true),
                onChanged: (input) {
                  setState(() {
                    cusName = input;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'ที่อยู่ลูกค้า', alignLabelWithHint: true),
                onChanged: (input) {
                  setState(() {
                    cusAds = input;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'จำนวนคิว',
                  alignLabelWithHint: true,
                ),
                keyboardType: TextInputType.number,
                onChanged: (input) {
                  setState(() {
                    valueCement = num.tryParse(input);
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'ค่าขนส่ง',
                  alignLabelWithHint: true,
                ),
                keyboardType: TextInputType.number,
                onChanged: (input) {
                  setState(() {
                    deliPrice = num.tryParse(input);
                  });
                },
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 20,
                    ),
                    Container(
                      child: Text('ประเภทปูน'),
                    ),
                    ListTile(
                      title: Text('#180'),
                      leading: Radio(
                        groupValue: cementType,
                        value: '#180',
                        onChanged: (input) {
                          setState(() {
                            cementType = input;
                            totalPrice =
                                calculate(valueCement, deliPrice, 1800);
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text('#200'),
                      leading: Radio(
                        groupValue: cementType,
                        value: '#200',
                        onChanged: (input) {
                          setState(() {
                            cementType = input;
                            totalPrice =
                                calculate(valueCement, deliPrice, 1900);
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text('#240'),
                      leading: Radio(
                        groupValue: cementType,
                        value: '#240',
                        onChanged: (input) {
                          setState(() {
                            cementType = input;
                            totalPrice =
                                calculate(valueCement, deliPrice, 2200);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 20,
                    ),
                    Container(
                      child: Text('ประเภทหิน'),
                    ),
                    ListTile(
                      title: Text('หินโขง'),
                      leading: Radio(
                        groupValue: stoneType,
                        value: 'หินโขง',
                        onChanged: (inputstone) {
                          setState(() {
                            stoneType = inputstone;
                          });
                        },
                      ),
                    ),
                    ListTile(
                        title: Text('หินภูเขา'),
                        leading: Radio(
                          groupValue: stoneType,
                          value: 'หินภูเขา',
                          onChanged: (inputstone) {
                            setState(() {
                              stoneType = inputstone;
                            });
                          },
                        ))
                  ],
                ),
              ),
              new StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('car').snapshots(),
                builder: (context, snapshot) {
                  var length = snapshot.data.documents.length;
                  DocumentSnapshot ds = snapshot.data.documents[length - 1];
                  return new Container(
                    //padding: EdgeInsets.all(20),
                    width: double.infinity,
                    
                    child: Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                            child: new Container(
                              padding:
                                  EdgeInsets.fromLTRB(12.0, 10.0, 10.0, 10.0),
                              child: new Text(
                                "รถขนส่ง",
                              ),
                            )),
                        new Expanded(
                          
                          flex: 4,
                          child: new InputDecorator(
                            decoration: const InputDecoration(
                              hintText: 'รถ',
                              hintStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.redAccent
                              )
                            ),
                            child: new DropdownButton(
                              
                              hint: Text('เลือกรถขนส่ง'),
                              value: _car,
                              isDense: true,
                              items: snapshot.data.documents
                                    .map((DocumentSnapshot document) {
                                  return new DropdownMenuItem<String>(
                                    
                                      value: document.data['carName'],
                                      child: new Container(
                                        width: 200,
                                        decoration: new BoxDecoration(
                                            //color: Colors.white,
                                            borderRadius:
                                                new BorderRadius.circular(5.0)),
                                        
                                        padding: EdgeInsets.all(10),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(document.data['carName']),
                                        ),
                                      ));
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _car = value;
                                  });
                                }),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              new StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('personel').snapshots(),
                builder: (context, snapshot) {
                  var length = snapshot.data.documents.length;
                  DocumentSnapshot ds = snapshot.data.documents[length - 1];
                  return new Container(
                    //padding: EdgeInsets.all(20),
                    width: double.infinity,
                    
                    child: Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                            child: new Container(
                              padding:
                                  EdgeInsets.fromLTRB(12.0, 10.0, 10.0, 10.0),
                              child: new Text(
                                "รถขนส่ง",
                              ),
                            )),
                        new Expanded(
                          
                          flex: 4,
                          child: new InputDecorator(
                            decoration: const InputDecoration(
                              hintText: 'พนักงานขนส่ง',
                              hintStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.redAccent
                              )
                            ),
                            child: new DropdownButton(
                              
                              hint: Text('พนักงานส่ง'),
                              value: _personelDeli,
                              isDense: true,
                              items: snapshot.data.documents
                                    .map((DocumentSnapshot document) {
                                  return new DropdownMenuItem<String>(
                                    
                                      value: document.data['personelNickName'],
                                      child: new Container(
                                        width: 200,
                                        decoration: new BoxDecoration(
                                            //color: Colors.white,
                                            borderRadius:
                                                new BorderRadius.circular(5.0)),
                                        
                                        padding: EdgeInsets.all(10),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(document.data['personelNickName']),
                                        ),
                                      ));
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _personelDeli = value;
                                  });
                                }),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        child: Icon(
          Icons.save,
          color: Colors.white,
        ),
        onPressed: () {
          addNewBill();
        },
      ),
    );
  }
}

int calculate(int a, int b, int c) {
  int total = 0;
  total = (a * c) + b;
  return total;
}

class BillList extends StatelessWidget {
  List<DocumentSnapshot> document;
  BillList({this.document});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: document.length,
      itemBuilder: (BuildContext context, int i) {
        String cusName = document[i].data['cusName'];
        String cusAds = document[i].data['cusAds'];
        int deliPrice = document[i].data['deliPrice'];
        int valueCement = document[i].data['valueCement'];
        int totalPrice = document[i].data['totalPrice'];
        String cementType = document[i].data['cementType'];
        String stoneType = document[i].data['stoneType'];
        String _car = document[i].data['carDeli'];
        String _personelDeli = document[i].data['personelDeli'];
        return Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
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
                      Text(cusName),
                      Container(
                        height: 10,
                      ),
                      Text(cusAds),
                      Row(
                        children: <Widget>[
                          Text(valueCement.toString()),
                          Text('  คิว  ค่าขนส่ง    '),
                          Text(deliPrice.toString()),
                          Text('  บาท     รวม    '),
                          Text(totalPrice.toString()),
                          Text('  บาท     '),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(cementType),
                          Container(
                            width: 20,
                          ),
                          Text(stoneType),
                          Container(
                            width: 20,
                          ),
                          Text('พนักงานส่ง :     '),
                          Text(_personelDeli),
                          Text('รถขนส่ง :     '),
                          Text(_car),
                      
                          
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
                      builder: (context) => EditSale(
                          cusName: cusName,
                          cusAds: cusAds,
                          deliPrice: deliPrice,
                          valueCement: valueCement,
                          totalPrice: totalPrice,
                          cementType: cementType,
                          stoneType: stoneType,
                          index: document[i].reference)));
                },
              )
            ],
          ),
        );
      },
    );
  }
}
