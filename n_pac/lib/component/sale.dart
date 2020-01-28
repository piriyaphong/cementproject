import 'package:flutter/material.dart';

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
        title: Text('Sale',style: TextStyle(color: Colors.white),),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
        ),
        
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.add,color: Colors.white,),
        onPressed: (){
          Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>AddSale()));
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: Text('NEW BILL',style: TextStyle(color: Colors.white),),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
        ),   
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'ชื่อลูกค้า',
                  alignLabelWithHint: true              
                ),
                
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'ที่อยู่ลูกค้า',
                  alignLabelWithHint: true
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'จำนวนคิว',
                  alignLabelWithHint: true,
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'ค่าขนส่ง',
                  alignLabelWithHint: true,
                ),
                keyboardType: TextInputType.number,
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
                        onChanged: (input){
                          setState(() {
                            cementType = input;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text('หินภูเขา'),
                      leading: Radio(
                        groupValue: stoneType,
                        value: 'หินภูเขา',
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
              TextField(
                decoration: InputDecoration(
                  labelText: 'รวมเงิน',
                  alignLabelWithHint: true,
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.save,color: Colors.white,),
        onPressed: (){},
      ),

      
    );
  }
}