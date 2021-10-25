
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:water/kayit_ol.dart';
import 'package:water/uye_giris.dart';


class LoginPage extends StatelessWidget {
  final Function(User) onSignIn;
  double value;
  int count;

  LoginPage({@required this.onSignIn,@required this.value,@required this.count});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back,color: Colors.blue,)),
        ),
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: Form(
                      child:TextFormField(
                        controller: epostacontroller,
                        decoration: InputDecoration(
                          hintText: "Email Adresi",
                          hintStyle: TextStyle(color: Colors.blue),
                          labelText: "E Mail",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.red)
                          ),
                        ),
                      ),
                    )
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: Form(
                      child:TextFormField(
                        obscureText: true,
                        controller: sifrecontroller,
                        decoration: InputDecoration(
                          hintText: "ŞİFRE",
                          hintStyle: TextStyle(color: Colors.blue),
                          labelText: "Şifre",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.blue)
                          ),
                        ),
                      ),
                    )
                ),
                ElevatedButton(
                    onPressed: () async{
                      try{

                      UserCredential userCredential =  await FirebaseAuth.instance.signInWithEmailAndPassword(email: epostacontroller.text, password: sifrecontroller.text);

                      onSignIn(userCredential.user);

                      FirebaseFirestore.instance.collection("users").doc(epostacontroller.text).collection("water").doc(epostacontroller.text).set(
                          {
                            "data":0,
                            "value": 0.0
                          }
                      );


                      }
                      catch(e){

                          Fluttertoast.showToast(
                              gravity: ToastGravity.CENTER,
                              toastLength: Toast.LENGTH_LONG,
                              msg: "HATA: "+ e.toString());

                      }
                    }
                    , child: Text("GİRİŞ")),
                      SizedBox(height: 20,),
                      ElevatedButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>KayitOl()));
                      }, child: Text("KAYIT OL"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}


