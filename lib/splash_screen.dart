import 'dart:async';

import 'package:adopt_a_cat_ui/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => InitState();
}
class InitState extends State<SplashScreen>{
  @override
  void initState() {
    super.initState();
    startTimer();
  }
  startTimer() async{
    var duration=Duration(seconds: 3);
    return Timer(duration,loginRoute);
  }
  loginRoute(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
  }
  @override
  Widget build(BuildContext context) => initWidget();
}

Widget initWidget(){
  return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: new Color(0xff9382C1),
                gradient: LinearGradient(
                    colors: [new Color(0xff9382C1),new Color(0xff5F4C8E),],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter

                )
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  child: Image.asset("assets/logo.png",
                    height: 200,width: 200,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0,60.0,0.0,0.0),
                child: Container(
                    child: SpinKitRing(
                      color: Colors.white,
                      size: 50.0,
                    )
                ),
              )
            ],
          )
        ],
      )
  );
}