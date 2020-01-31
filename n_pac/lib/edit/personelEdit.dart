import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditPersonel extends StatefulWidget {
  EditPersonel(
      {this.personelSalary,
      this.personelIdenNum,
      this.personelAddress,
      this.personelNickName,
      this.personelSirName,
      this.personelName,
      this.index,
      this.personelPhone});
  String personelName;
  String personelSirName;
  String personelNickName;
  String personelAddress;
  int personelIdenNum;
  int personelPhone;
  int personelSalary;
  final index;
  @override
  _EditPersonelState createState() => _EditPersonelState();
}

class _EditPersonelState extends State<EditPersonel> {
  String personelName;
  String personelSirName;
  String personelNickName;
  String personelAddress;
  int personelIdenNum;
  int personelPhone;
  int personelSalary;
  TextEditingController controllerpersonelName;
  TextEditingController controllerpersonelSirName;
  TextEditingController controllerpersonelNickName;
  TextEditingController controllerpersonelAddress;
  TextEditingController controllerpersonelIdenNum;
  TextEditingController controllerpersonelPhone;
  TextEditingController controllerpersonelSalary;

  void _editPersonel() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(widget.index);
      await transaction.update(snapshot.reference, {
        "personelName": personelName,
        "personelSirName": personelSirName,
        "personelNickName": personelNickName,
        "personelAddress": personelAddress,
        "personelIdenNum": personelIdenNum,
        "personelPhone": personelPhone,
        "personelSalary": personelSalary,
        "timestamp": DateTime.now()
      });
    });
    Navigator.pop(context);
  }

  void _deletePersonel() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      //DocumentSnapshot snapshot = await transaction.get(widget.index);
      await transaction.delete(widget.index);
    });
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    personelName = widget.personelName;
    personelSirName = widget.personelSirName;
    personelNickName = widget.personelNickName;
    personelAddress = widget.personelAddress;
    personelIdenNum = widget.personelIdenNum;
    personelPhone = widget.personelPhone;
    personelSalary = widget.personelSalary;
    controllerpersonelName = TextEditingController(text: widget.personelName);
    controllerpersonelSirName =
        TextEditingController(text: widget.personelSirName);
    controllerpersonelNickName =
        TextEditingController(text: widget.personelNickName);
    controllerpersonelAddress =
        TextEditingController(text: widget.personelAddress);
    controllerpersonelIdenNum =
        TextEditingController(text: widget.personelIdenNum.toString());
    controllerpersonelPhone =
        TextEditingController(text: widget.personelPhone.toString());
    controllerpersonelSalary =
        TextEditingController(text: widget.personelSalary.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
        title: Text(
          'Add Personel',
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
              _deletePersonel();
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
                TextField(
                  controller: controllerpersonelName,
                  decoration: InputDecoration(
                    labelText: 'ชื่อ',
                    alignLabelWithHint: true,
                  ),
                  onChanged: (input) {
                    setState(() {
                      personelName = input;
                    });
                  },
                ),
                TextField(
                  controller: controllerpersonelSirName,
                  decoration: InputDecoration(
                    labelText: 'นามสกุล',
                    alignLabelWithHint: true,
                  ),
                  onChanged: (input) {
                    setState(() {
                      personelSirName = input;
                    });
                  },
                ),
                TextField(
                  controller: controllerpersonelNickName,
                  decoration: InputDecoration(
                    labelText: 'ชื่อเล่น',
                    alignLabelWithHint: true,
                  ),
                  onChanged: (input) {
                    setState(() {
                      personelNickName = input;
                    });
                  },
                ),
                TextField(
                  controller: controllerpersonelAddress,
                  decoration: InputDecoration(
                    labelText: 'ที่อยู่',
                    alignLabelWithHint: true,
                  ),
                  onChanged: (input) {
                    setState(() {
                      personelAddress = input;
                    });
                  },
                ),
                TextField(
                  controller: controllerpersonelIdenNum,
                  maxLength: 13,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'เลขบัตรประจำตัวประชาชน',
                    alignLabelWithHint: true,
                  ),
                  onChanged: (input) {
                    setState(() {
                      personelIdenNum = num.tryParse(input);
                    });
                  },
                ),
                TextField(
                  controller: controllerpersonelPhone,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: InputDecoration(
                    labelText: 'เบอร์โทรศัพท์',
                    alignLabelWithHint: true,
                  ),
                  onChanged: (input) {
                    setState(() {
                      personelPhone = num.tryParse(input);
                    });
                  },
                ),
                TextField(
                  controller: controllerpersonelSalary,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'ค่าแรงต่อวัน',
                    alignLabelWithHint: true,
                  ),
                  onChanged: (input) {
                    setState(() {
                      personelSalary = num.tryParse(input);
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save, color: Colors.white),
        backgroundColor: Colors.orangeAccent,
        onPressed: () {
          _editPersonel();
        },
      ),
    );
  }
}
