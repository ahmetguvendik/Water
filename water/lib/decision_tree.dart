import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:water/home_page.dart';

import 'login_page.dart';

class DecisionTree extends StatefulWidget {
  const DecisionTree({Key key}) : super(key: key);

  @override
  _DecisionTreeState createState() => _DecisionTreeState();
}

class _DecisionTreeState extends State<DecisionTree> {
  User user;
  void initState(){
    super.initState();
    onReflesh(FirebaseAuth.instance.currentUser);
  }
  onReflesh(userCred){
    setState(() {
      user = userCred;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(user==null){
      return LoginPage(onSignIn: (userCred)=> onReflesh(userCred),);
    }
    return HomePage(onSignOut: (userCred)=>onReflesh(userCred),user: user.email,);
  }
}
