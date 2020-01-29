import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:n_pac/edit/personelEdit.dart';

class Personel extends StatefulWidget {
  @override
  _PersonelState createState() => _PersonelState();
}

class _PersonelState extends State<Personel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
        title: Text('Personel',style: TextStyle(color: Colors.white),),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
        ),
        
        
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('personel').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return new Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return new ListPersonel(
            document: snapshot.data.documents,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        child: Icon(Icons.add,color: Colors.white,),
        onPressed: (){
          Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> AddPersonel()));
        },
      ),
      
    );
  }
}



class AddPersonel extends StatefulWidget {
  @override
  _AddPersonelState createState() => _AddPersonelState();
}

class _AddPersonelState extends State<AddPersonel> {
  String personelName;
  String personelSirName;
  String personelNickName;
  String personelAddress;
  int personelIdenNum;
  int personelPhone;
  int personelSalary;

  void _addPersonel(){
    Firestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference = Firestore.instance.collection('personel');
      await reference.add({
        "personelName" : personelName,
        "personelSirName" : personelSirName,
        "personelNickName" : personelNickName,
        "personelAddress" : personelAddress,
        "personelIdenNum" : personelIdenNum,
        "personelPhone" : personelPhone,
        "personelSalary" : personelSalary,
        "timestamp" : DateTime.now() 
       });
    });
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
        title: Text('Add Personel',style: TextStyle(color: Colors.white),),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
        ),
        
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: 'ชื่อ',
                    alignLabelWithHint: true,
                  ),
                  onChanged: (input){
                    setState(() {
                      personelName = input;
                    });
                  },
                ),
                
                TextField(
                  decoration: InputDecoration(
                    labelText: 'นามสกุล',
                    alignLabelWithHint: true,
                  ),
                  onChanged: (input){
                    setState(() {
                      personelSirName = input;
                    });
                  },
                ),
                 TextField(
                  decoration: InputDecoration(
                    labelText: 'ชื่อเล่น',
                    alignLabelWithHint: true,
                  ),
                  onChanged: (input){
                    setState(() {
                      personelNickName = input;
                    });
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'ที่อยู่',
                    alignLabelWithHint: true,
                  ),
                  onChanged: (input){
                    setState(() {
                      personelAddress = input;
                    });
                  },
                ),
                TextField(
                  maxLength: 13,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'เลขบัตรประจำตัวประชาชน',
                    alignLabelWithHint: true,
                  ),
                  onChanged: (input){
                    setState(() {
                      personelIdenNum = num.tryParse(input);
                    });
                  },
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: InputDecoration(
                    labelText: 'เบอร์โทรศัพท์',
                    alignLabelWithHint: true,
                  ),
                  onChanged: (input){
                    setState(() {
                      personelPhone = num.tryParse(input);
                    });
                  },
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'ค่าแรงต่อวัน',
                    alignLabelWithHint: true,
                  ),
                  onChanged: (input){
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
        child: Icon(Icons.save,color:Colors.white),
        backgroundColor: Colors.orangeAccent,
        onPressed: (){
          _addPersonel();
        },
      ),
      
    );
  }
}


class ListPersonel extends StatelessWidget {
  List<DocumentSnapshot> document;
  ListPersonel({this.document});
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: document.length,
      itemBuilder: (BuildContext context, int i){
        String personelName = document[i].data['personelName'];
        String personelSirName = document[i].data['personelSirName'];
        String personelNickName = document[i].data['personelNickName'];
        String personelAddress = document[i].data['personelAddress'];
        int personelIdenNum = document[i].data['personelIdenNum'];
        int personelPhone = document[i].data['personelPhone'];
        int personelSalary = document[i].data['personelSalary'];
        return Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              new Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadiusDirectional.circular(10),
                    boxShadow: [BoxShadow(
                      color: Colors.black45,
                      blurRadius:5,
                      spreadRadius: 1,
                    )]
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.person),Container(width: 10,),Text(personelName,style: TextStyle(fontSize: 20),),Container(width: 10,),Text(personelSirName,style: TextStyle(fontSize: 20)),Container(width: 10,),Text(personelNickName,style: TextStyle(fontSize: 20))
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.phone),Container(width: 10,),Text('0'),Text(personelPhone.toString()),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              new IconButton(
                icon: Icon(Icons.edit),
                onPressed: (){
                  Navigator.of(context).push(new MaterialPageRoute(builder: (context) => EditPersonel(
                    personelName :personelName,
                    personelSirName : personelSirName,
                    personelNickName : personelNickName,
                    personelAddress: personelAddress,
                    personelIdenNum : personelIdenNum,
                    personelPhone : personelPhone,
                    personelSalary : personelSalary,
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


