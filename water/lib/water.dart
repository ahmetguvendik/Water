import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Water extends StatefulWidget {
  String bilgi;
  Water({@required this.bilgi});

  @override
  _WaterState createState() => _WaterState();
}

class _WaterState extends State<Water> {
  int count=0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Padding(
                padding: EdgeInsets.only(top: 200),
                child: Column(
                  children: [
                    Text(count.toString()),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: () async{
                        setState(() {
                          count = count+200;
                        });
                        await FirebaseFirestore.instance.collection("users").doc(widget.bilgi).collection("water").doc(count.toString()).set(
                            {"data":count}
                        );
                      },
                      child: CircleAvatar(
                        child: Text("tıkla"),
                      ),
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("users").doc(widget.bilgi).collection("water").snapshots(),
                        builder: (BuildContext context , AsyncSnapshot async ){
                          if(async.hasError){
                            return Center(child: Text("Bir hata Oluştu, Lütfen Daha Sonra Tekrar Deneyiniz"),);
                          }
                          else{
                            if(async.hasData){
                              final  List liste = async.data.docs;
                              return Flexible(
                                  child: ListView.builder(
                                      itemCount: liste.length,
                                      itemBuilder: (context,index){
                                        return Column(
                                          children: [
                                              Card(
                                                child: Text((liste[index].data()["data"].toString()),
                                              ),)
                                          ],
                                        );
                                      }));
                            }
                            else{
                              return Center(child: CircularProgressIndicator(),);
                            }
                          }
                        })
                  ],
                ),
              ),

          ],

        ),
      ),
    );
  }
}
