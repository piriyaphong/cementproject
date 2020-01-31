import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:n_pac/edit/stockEdit.dart';

class Stock extends StatefulWidget {
  @override
  _StockState createState() => _StockState();
}

class _StockState extends State<Stock> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text('Stock',style: TextStyle(color: Colors.white),),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
        ), 
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('stock').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return new Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return new ListStock(
            document: snapshot.data.documents,
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,color: Colors.white),
        backgroundColor: Colors.blueAccent,
        onPressed: (){
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) => AddStock()));
        },
      ),
      
    );
  }
}


class AddStock extends StatefulWidget {
  @override
  _AddStockState createState() => _AddStockState();
}

class _AddStockState extends State<AddStock> {
  int cement = 0 ;
  int sand= 0;
  int stoneType1 = 0;
  int stoneType2 = 0;

  void _addStock(){
    Firestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference = Firestore.instance.collection('stock');
      await reference.add({
        "cement" : cement,
        "sand" : sand,
        "stoneType1" : stoneType1,
        "stoneType2" : stoneType2,
        "TimeStamp" : DateTime.now()
      });
    });
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text('Update Stock',style: TextStyle(color: Colors.white),),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
        ), 
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //Container(child: Text('ปูน'),),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'ปูน จำนวน กิโลกรัม',
                    alignLabelWithHint: true
                  ),
                  onChanged: (input){
                    setState(() {
                      cement = num.tryParse(input);
                    });
                  },
                ),
                //Container(child: Text('ปูน'),),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'หินโขง จำนวน กิโลกรัม',
                    alignLabelWithHint: true
                  ),
                  onChanged: (input){
                    setState(() {
                      sand = num.tryParse(input);
                    });
                  },
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'หินภูเขา จำนวน กิโลกรัม',
                    alignLabelWithHint: true
                  ),
                  onChanged: (input){
                    setState(() {
                      stoneType1 = num.tryParse(input);
                    });
                  },
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'ทราย จำนวน กิโลกรัม',
                    alignLabelWithHint: true
                  ),
                  onChanged: (input){
                    setState(() {
                      stoneType2 = num.tryParse(input);
                    });
                  },
                ),

              ],
            ),
          ),
        ),
      ),


      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save,color: Colors.white),
        backgroundColor: Colors.blueAccent,
        onPressed: (){
          _addStock();
        },
      ),
      
    );
  }
}


class ListStock extends StatelessWidget {
  List<DocumentSnapshot> document;
  ListStock({this.document});
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: document.length,
      itemBuilder: (BuildContext context, int i){
        int cement = document[i].data['cement'];
        int sand = document[i].data['sand'];
        int stoneType1 = document[i].data['stoneType1'];
        int stoneType2 = document[i].data['stoneType2'];

        return Padding(
          padding:  EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadiusDirectional.circular(10),
                    boxShadow: [BoxShadow(
                      color: Colors.black45,
                      blurRadius:5,
                      spreadRadius: 1,
                    )]
                  ),
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                new Expanded(
                  child: Container(                  
                    padding: EdgeInsets.all(10),
                    child: Text((i+1).toString()),
                  ),
                ),
                new Expanded(                
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('ปูน'),
                      Text("ทราย")
                    ],
                  ),
                ),
                 new Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(cement.toString()),
                      Text(sand.toString())
                    ],
                  ),
                ),
                 new Expanded(
                  child: Column(
                    children: <Widget>[
                      Text('หินโขง'),
                      Text("หินภูเขา")
                    ],
                  ),
                ),
                 new Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(stoneType1.toString()),
                      Text(stoneType2.toString())
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: (){
                    Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>EditStock(
                      cement : cement,
                      sand : sand,
                      stoneType1 : stoneType1,
                      stoneType2 : stoneType2,
                      index : document[i].reference
                    )));
                  },
                )
              ],
            ),
          ),
        );
      },
      
    );
  }
}