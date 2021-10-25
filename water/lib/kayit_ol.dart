import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class KayitOl extends StatefulWidget {

  @override
  State<KayitOl> createState() => _KayitOlState();
}

class _KayitOlState extends State<KayitOl> {
  TextEditingController epostacontroller = TextEditingController();

  TextEditingController sifrecontroller = TextEditingController();

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
              ElevatedButton(onPressed: () async{
                try{
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(email: epostacontroller.text, password: sifrecontroller.text).then((value) => Fluttertoast.showToast(
                      msg: "KAYIT BAŞARILI",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.blue,
                      textColor: Colors.white,
                      fontSize: 16.0
                  ));
                }
                catch(e){
                  Fluttertoast.showToast(
                      msg: "HATA: " + e.toString(),
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.blue,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                }
              }, child: Text("Kaydet"))
            ],
          ),
        ),
      ),
    );
  }
}