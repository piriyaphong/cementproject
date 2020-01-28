import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditSale extends StatefulWidget {
  EditSale({this.cusName,this.cusAds,this.valueCement,this.totalPrice,this.deliPrice,this.stoneType,this.cementType,this.index});
  String cementType ;
  String stoneType;
  String cusName ;
  String cusAds ;
  int deliPrice ;
  int valueCement ; 
  int totalPrice ;
  final index;
  @override
  _EditSaleState createState() => _EditSaleState();
}

class _EditSaleState extends State<EditSale> {
  TextEditingController controllercusName;
  TextEditingController controllercusAds;
  TextEditingController controllercementType;
  TextEditingController controllerstoneType;
  TextEditingController controllerdeliPrice;
  TextEditingController controllervalueCement;
  TextEditingController controllertotalPrice;
  String cementType ;
  String stoneType;
  String cusName ;
  String cusAds ;
  int deliPrice ;
  int valueCement ; 
  int totalPrice ;

  void _editBill(){
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(widget.index);
      await transaction.update(snapshot.reference, {
         "cusName" : cusName,
        "cusAds" : cusAds,
        "cementType" : cementType,
        "stoneType" : stoneType,
        "deliPrice" : deliPrice,
        "valueCement" : valueCement,
        "totalPrice" : totalPrice,
        "timeStamp" : DateTime.now(),
      });
    });
    Navigator.pop(context);
  }

  void _deleteBill() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(widget.index);
      await transaction.delete(widget.index);
    }); 
    Navigator.pop(context);
  }

  @override
  void initState(){
    super.initState();
    cementType = widget.cementType;
    stoneType = widget.stoneType;
    cusName = widget.cusName;
    cusAds = widget.cusAds;
    deliPrice = widget.deliPrice;
    valueCement = widget.valueCement;
    totalPrice = widget.totalPrice;
    controllercusName = new TextEditingController(text: widget.cusName);
    controllercusAds = new TextEditingController(text: widget.cusAds);
    controllercementType = new TextEditingController(text: widget.cementType);
    controllerdeliPrice = new TextEditingController(text: widget.deliPrice.toString());
    controllertotalPrice = new TextEditingController(text: widget.totalPrice.toString());
    controllerstoneType = new TextEditingController(text: widget.stoneType);
    controllervalueCement = new TextEditingController(text: widget.valueCement.toString());

    


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: Text('EDIT BILL',style: TextStyle(color: Colors.white),),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
        ),   
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete,color:Colors.white),
            onPressed: (){
              _deleteBill();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              TextField(
                controller: controllercusName,
                decoration: InputDecoration(
                  labelText: 'ชื่อลูกค้า',
                  alignLabelWithHint: true              
                ),
                onChanged: (input){
                  setState(() {
                    cusName = input;
                  });
                },
              ),
              TextField(
                controller: controllercusAds,
                decoration: InputDecoration(
                  labelText: 'ที่อยู่ลูกค้า',
                  alignLabelWithHint: true
                ),
                onChanged: (input){
                  setState(() {
                    cusAds = input;
                  });
                },
              ),
              TextField(
                controller: controllervalueCement,
                decoration: InputDecoration(
                  labelText: 'จำนวนคิว',
                  alignLabelWithHint: true,
                ),
                keyboardType: TextInputType.number,
                onChanged: (input){
                  setState(() {
                    valueCement = num.tryParse(input);
                  });
                },
              ),
              TextField(
                controller: controllerdeliPrice,
                decoration: InputDecoration(
                  labelText: 'ค่าขนส่ง',
                  alignLabelWithHint: true,
                ),
                keyboardType: TextInputType.number,
                onChanged: (input){
                  setState(() {
                    deliPrice = num.tryParse(input);
                  });
                },
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(height: 20,),
                    Container(
                      child: Text('ประเภทปูน'),
                    ),
                    ListTile(
                      title: Text('#180'),
                      leading: Radio(
                        groupValue: cementType,
                        value: '#180',
                        onChanged: (input){
                          setState(() {
                            cementType = input;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text('#200'),
                      leading: Radio(
                        groupValue: cementType,
                        value: '#200',
                        onChanged: (input){
                          setState(() {
                            cementType = input;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text('#240'),
                      leading: Radio(
                        groupValue: cementType,
                        value: '#240',
                        onChanged: (input){
                          setState(() {
                            cementType = input;
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
                    Container(height: 20,),
                    Container(
                      child: Text('ประเภทหิน'),
                    ),
                    ListTile(
                      title: Text('หินโขง'),
                      leading: Radio(
                        groupValue: stoneType,
                        value: 'หินโขง',
                        onChanged: (inputstone){
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
                        onChanged: (inputstone){
                          setState(() {
                            stoneType = inputstone;
                          });
                        },
                      )
                    )
                  ],
                ),
              ),
              TextField(
                controller: controllertotalPrice,
                decoration: InputDecoration(
                  labelText: 'รวมเงิน',
                  alignLabelWithHint: true,
                ),
                keyboardType: TextInputType.number,
                onChanged: (input){
                  setState(() {
                    totalPrice = num.tryParse(input);
                  });
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.save,color: Colors.white),
        onPressed: (){
         _editBill();
        },
      ),    
   
      
    );
  }
}