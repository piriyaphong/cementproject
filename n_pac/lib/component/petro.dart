import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:n_pac/edit/pertroEdit.dart';

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
        title: Text(
          'Petro',
          style: TextStyle(color: Colors.white),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
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
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.of(context)
              .push(new MaterialPageRoute(builder: (context) => AddPetro()));
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
  void _addPetro() {
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
                        Firestore.instance.collection('petro');
                    await reference.add({
                      "car": car,
                      "petroRate": petroRate,
                      "petroCost": petroCost,
                      "petroMiles": petroMiles,
                      "TimeStamp": DateTime.now()
                    });
                  });
                  Navigator.of(context).push(
                      new MaterialPageRoute(builder: (context) => Petro()));
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
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          'Add Petro',
          style: TextStyle(color: Colors.white),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            child: Column(
              children: <Widget>[
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
                    padding: EdgeInsets.fromLTRB(12.0, 10.0, 10.0, 10.0),
                    child: new Text(
                      "รถที่เติม",
                    ),
                  )),
                  new Expanded(
                    flex: 4,
                    child: new InputDecorator(
                      decoration: const InputDecoration(
                          hintText: 'รถ',
                          hintStyle: TextStyle(
                              fontSize: 20, color: Colors.redAccent)),
                      child: new DropdownButton(
                          hint: Text('เลือกรถที่เติม'),
                          value: car,
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
                              car = value;
                            });
                          }),
                    ),
                  ),
                ],
                  ),
                );
                },
              ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'ราคาน้ำมัน', alignLabelWithHint: true),
                  onChanged: (input) {
                    setState(() {
                      petroRate = num.tryParse(input);
                    });
                  },
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'จำนวนเงินที่เติม', alignLabelWithHint: true),
                  onChanged: (input) {
                    setState(() {
                      petroCost = num.tryParse(input);
                    });
                  },
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'เลขไมล์ก่อนเติม', alignLabelWithHint: true),
                  onChanged: (input) {
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
        child: Icon(
          Icons.save,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
        onPressed: () {
          _addPetro();
        },
      ),
    );
  }
}

class ListPetro extends StatelessWidget {
  List<DocumentSnapshot> document;
  ListPetro({this.document});
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: document.length,
      itemBuilder: (BuildContext context, int i) {
        String _car = document[i].data['car'];
        double petroRate = document[i].data['petroRate'];
        int petroCost = document[i].data['petroCost'];
        int petroMiles = document[i].data['petroMiles'];

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
                  padding: EdgeInsets.all(10),
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
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(_car),
                          Container(
                            width: 20,
                          ),
                          Text('จำนวนที่เติม'),
                          Container(
                            width: 20,
                          ),
                          Text(petroCost.toString())
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('ราคาน้ำมัน'),
                          Container(
                            width: 20,
                          ),
                          Text(petroRate.toString()),
                          Container(
                            width: 20,
                          ),
                          Text('เลขไมล์ก่อนเติม'),
                          Container(
                            width: 20,
                          ),
                          Text(petroMiles.toString())
                        ],
                      )
                    ],
                  ),
                ),
              ),
              new IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => EditPetro(
                            car: _car,
                            petroCost: petroCost,
                            petroMiles: petroMiles,
                            petroRate: petroRate,
                            index: document[i].reference,
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
