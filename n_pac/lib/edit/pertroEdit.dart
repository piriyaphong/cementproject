import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:n_pac/component/petro.dart';

class EditPetro extends StatefulWidget {
  EditPetro(
      {this.car, this.index, this.petroCost, this.petroMiles, this.petroRate});
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
                  Firestore.instance
                      .runTransaction((Transaction transaction) async {
                    DocumentSnapshot snapshot =
                        await transaction.get(widget.index);
                    await transaction.update(snapshot.reference, {
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

  void _deletePetro() {
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
                      .push(new MaterialPageRoute(builder: (context) => Petro()));
                })
          ],
        ),
      ),
    );
    showDialog(context: context, child: alertDialog);
  }

  @override
  void initState() {
    super.initState();
    car = widget.car;
    petroRate = widget.petroRate;
    petroCost = widget.petroCost;
    petroMiles = widget.petroMiles;

    controllercar = new TextEditingController(text: widget.car);
    controllerpetroCost =
        new TextEditingController(text: widget.petroCost.toString());
    controllerpetroRate =
        new TextEditingController(text: widget.petroRate.toString());
    controllerpetroMiles =
        new TextEditingController(text: widget.petroMiles.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          'Edit Petro',
          style: TextStyle(color: Colors.white),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {
              _deletePetro();
            },
          )
        ],
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
                            padding:
                                EdgeInsets.fromLTRB(12.0, 10.0, 10.0, 10.0),
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
                                                  new BorderRadius.circular(
                                                      5.0)),
                                          padding: EdgeInsets.all(10),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child:
                                                Text(document.data['carName']),
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
                  controller: controllerpetroRate,
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
                  controller: controllerpetroCost,
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
                  controller: controllerpetroMiles,
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
          _editPetro();
        },
      ),
    );
  }
}
