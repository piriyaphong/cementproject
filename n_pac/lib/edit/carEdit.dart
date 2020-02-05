import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:n_pac/component/car.dart';

class EditCar extends StatefulWidget {
  String carName;
  String carId;
  String carType;
  final index;
  EditCar({this.index, this.carId, this.carName, this.carType});
  @override
  _EditCarState createState() => _EditCarState();
}

class _EditCarState extends State<EditCar> {
  String carName;
  String carId;
  String carType;
  TextEditingController controllercarName;
  TextEditingController controllercarId;
  TextEditingController controllercarType;

  void _deleteCar() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      //DocumentSnapshot snapshot = await transaction.get(widget.index);
      await transaction.delete(widget.index);
    });
    Navigator.pop(context);
  }

  void _editCar() {
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
                      "carName": carName,
                      "carId": carId,
                      "carType": carType,
                      "TimeStamp": DateTime.now()
                    });
                  });
                  Navigator.of(context).push(
                      new MaterialPageRoute(builder: (context) => Car()));
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
    carName = widget.carName;
    carId = widget.carId;
    carType = widget.carId;

    controllercarName = new TextEditingController(text: widget.carName);
    controllercarId = new TextEditingController(text: widget.carId);
    controllercarType = new TextEditingController(text: widget.carType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        centerTitle: true,
        title: Text(
          'Add Car',
          style: TextStyle(color: Colors.white),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete, color: Colors.white),
            onPressed: () {
              _deleteCar();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: controllercarName,
                decoration: InputDecoration(
                    labelText: 'ชื่อรถ', alignLabelWithHint: true),
                onChanged: (input) {
                  setState(() {
                    carName = input;
                  });
                },
              ),
              TextFormField(
                controller: controllercarId,
                decoration: InputDecoration(
                    labelText: 'เลขทะเบียนรถ', alignLabelWithHint: true),
                onChanged: (input) {
                  setState(() {
                    carId = input;
                  });
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 20,
                  ),
                  Container(
                    child: Text('ประเภท'),
                  ),
                  ListTile(
                    title: Text('รถยนต์'),
                    leading: Radio(
                      value: 'รถยนต์',
                      groupValue: carType,
                      onChanged: (input) {
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
                      onChanged: (input) {
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
        child: Icon(
          Icons.save,
          color: Colors.white,
        ),
        onPressed: () {
          _editCar();
        },
      ),
    );
  }
}
