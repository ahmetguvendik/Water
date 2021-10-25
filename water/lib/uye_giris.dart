import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:water/main.dart';
import 'package:water/water.dart';

TextEditingController epostacontroller = TextEditingController();
TextEditingController sifrecontroller = TextEditingController();
class UyeGiris extends StatefulWidget {

  @override
  State<UyeGiris> createState() => _UyeGirisState();
}
class _UyeGirisState extends State<UyeGiris> {
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
              ElevatedButton(
                  onPressed: ()async{
                    try{
                      await FirebaseAuth.instance.signInWithEmailAndPassword(email: epostacontroller.text, password: sifrecontroller.text).then((value) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Water(bilgi: epostacontroller.text)),(route) => false));}
                    catch(e){
                      setState(() {
                        Fluttertoast.showToast(
                            gravity: ToastGravity.CENTER,
                            toastLength: Toast.LENGTH_LONG,
                            msg: "HATA: "+ e.toString());
                      });
                    }
                  }
                  , child: Text("GİRİŞ"))
            ],
          ),
        ),
      ),
    );
  }
}