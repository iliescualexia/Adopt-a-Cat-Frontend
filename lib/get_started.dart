import 'dart:convert';

import 'package:adopt_a_cat_ui/choose_action.dart';
import 'package:adopt_a_cat_ui/user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'cat_item.dart';
import 'create_cat.dart';

class GetStared extends StatefulWidget {
  UserInfo userInfo;
  GetStared({super.key,required this.userInfo});


  @override
  State<GetStared> createState() => GetStaredState();
}
class GetStaredState extends State<GetStared> {
  @override
  Widget build(BuildContext context) {
    return initWidget();
  }
  Widget initWidget() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff9382C1),
        title: Text("Adopt A Cat"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0.0,70.0,0.0,10.0),
                child: Text(
                  "Welcome!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff9382C1),
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold
                  ),
                )
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0.0,200.0,0.0,0.0),
              child:SizedBox(
                height: 70.0,
                width: 300.0,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith((states) => Color(0xff9382C1))
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>ChooseAction(userInfo: widget.userInfo)
                    ));
                  },
                  child: Text("Get Started",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}