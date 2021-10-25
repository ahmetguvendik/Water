import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  final Function(User) onSignOut;
  String user;
  double value;
  int count;
  HomePage({@required this.onSignOut,this.user,@required this.count,@required this.value});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> logout() async{
    await FirebaseAuth.instance.signOut();
    widget.onSignOut(null);
  }
  double _value = 0.0;
  int count=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Water"),
        centerTitle: true,
        leading: IconButton(onPressed: (){widget.onSignOut(null);}, icon: Icon(Icons.login_outlined)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance.collection("users").doc(widget.user).collection("water").snapshots(),
                builder: (BuildContext context , AsyncSnapshot async){
                  if(async.hasError){
                    return Center(child: Text("Bir hata Oluştu, Lütfen Daha Sonra Tekrar Deneyiniz"),);
                  }
                  else{
                    if(async.hasData){
                      final  List liste = async.data.docs;
                      return Flexible(
                        child: ListView.builder(
                            itemCount: 1,
                            itemBuilder: (context,index){
                            return Padding(
                              padding: EdgeInsets.only(top: 45),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(icon: FaIcon(FontAwesomeIcons.arrowUp),onPressed: (){
                                    FirebaseFirestore.instance.collection("users").doc(widget.user).collection("water").doc(widget.user).set(
                                        {
                                          "data": liste[index].data()["data"] =liste[index].data()["data"]+200,
                                          "value":liste[index].data()["value"] =liste[index].data()["value"]+0.08
                                        }
                                    );
                                  },),
                                  Text((liste[index].data()["data"]).toString()+" / 2600 mL"),
                                  LinearProgressIndicator(
                                    value: liste[index].data()["value"],
                                    valueColor: AlwaysStoppedAnimation(Colors.green),
                                    minHeight: 31.0,
                                  ),
                                  IconButton(icon: FaIcon(FontAwesomeIcons.arrowDown),onPressed: () async{
                                    FirebaseFirestore.instance.collection("users").doc(widget.user).collection("water").doc(widget.user).update(
                                      {
                                        "data": liste[index].data()["data"]<=0? liste[index].data()["data"]=0 : liste[index].data()["data"] =liste[index].data()["data"]-200,
                                        "value":liste[index].data()["value"]<=0? liste[index].data()["value"]=0.0 : liste[index].data()["value"] =liste[index].data()["value"]-0.08,
                                      }
                                    );
                                  },),
                                ],
                              ),
                            );
                      },
                        ),
                      );
                    }
                    else{
                  return Center(child: CircularProgressIndicator(),);
                  }
                  }
            }
            )
            ],
        ),
      ),
    );
  }
}
