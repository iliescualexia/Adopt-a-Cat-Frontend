import 'dart:convert';

import 'package:adopt_a_cat_ui/login_screen.dart';
import 'package:adopt_a_cat_ui/splash_screen.dart';
import 'package:adopt_a_cat_ui/user.dart';
import 'package:adopt_a_cat_ui/user_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'get_started.dart';
class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}
class InitState extends State<SignUpScreen>{

  User user = User("","","","");
  Future save()async{
    String url='http://10.0.2.2:8090/api/v1/register';
    var res=await http.post(Uri.parse(url),headers: {'Content-Type':'application/json'},body: jsonEncode(
        {
          'email':user.email,
          'password':user.password,
          'phoneNumber': user.phoneNumber,
          'name': user.name
        }
    ));
    print(res.statusCode);
    print(res.body);
    if(res.statusCode==200){//Next Page
      var jsonData;
      jsonData=json.decode(res.body);
      UserInfo userInfo = UserInfo(jsonData["userId"],jsonData["email"],jsonData["phoneNumber"]);
      Navigator.push(context, MaterialPageRoute(
          builder: (context)=>GetStared(userInfo: userInfo)
      ));

    }else{
        String message1="Error!";
        String message2="Something went wrong";
        showDialog(
            context: context,
            builder: (BuildContext context) => _buildPopupDialog(context,message1,message2));
    }
  }
@override
  Widget build(BuildContext context) {
    return initWidget();
  }
  Widget initWidget(){
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)),
                    gradient: LinearGradient(
                        colors: [new Color(0xff9382C1),new Color(0xff5F4C8E),],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter
                    )
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top:50),
                        child: Image.asset("assets/logo.png"),
                        height: 90,
                        width: 90,
                      ),
                      Container(
                        margin: EdgeInsets.only(right:20,top:20),
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 20,
                            color:Colors.white
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              Container(
                margin:EdgeInsets.only(left:20,right: 20,top: 70),
                padding: EdgeInsets.only(left:20,right:20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey[200],
                    boxShadow: [BoxShadow(
                        offset: Offset(0,10),
                        blurRadius: 50,
                        color:Color(0xffEEEEEE)
                    )]
                ),
                alignment: Alignment.center,
                child: TextField(
                  controller: TextEditingController(text: user.name),
                  onChanged: (val){
                    user.name=val;
                  },
                  cursorColor: Color(0xff9382C1),
                  decoration: InputDecoration(
                      icon: Icon(
                          Icons.person,
                          color: Color(0xff9382C1)
                      ),
                      hintText: "Full Name",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none
                  ),
                ),
              ),
              Container(
                margin:EdgeInsets.only(left:20,right: 20,top: 20),
                padding: EdgeInsets.only(left:20,right:20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey[200],
                    boxShadow: [BoxShadow(
                        offset: Offset(0,10),
                        blurRadius: 50,
                        color:Color(0xffEEEEEE)
                    )]
                ),
                alignment: Alignment.center,
                child: TextField(
                  controller: TextEditingController(text: user.email),
                  onChanged: (val){
                    user.email=val;
                  },
                  cursorColor: Color(0xff9382C1),
                  decoration: InputDecoration(
                      icon: Icon(
                          Icons.email,
                          color: Color(0xff9382C1)
                      ),
                      hintText: "Email Address",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none
                  ),
                ),
              ),
              Container(
                margin:EdgeInsets.only(left:20,right: 20,top: 20),
                padding: EdgeInsets.only(left:20,right:20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey[200],
                    boxShadow: [BoxShadow(
                        offset: Offset(0,10),
                        blurRadius: 50,
                        color:Color(0xffEEEEEE)
                    )]
                ),
                alignment: Alignment.center,
                child: TextField(
                  controller: TextEditingController(text: user.phoneNumber),
                  onChanged: (val){
                    user.phoneNumber=val;
                  },
                  cursorColor: Color(0xff9382C1),
                  decoration: InputDecoration(
                      icon: Icon(
                          Icons.phone,
                          color: Color(0xff9382C1)
                      ),
                      hintText: "Phone Number",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none
                  ),
                ),
              ),
              Container(
                margin:EdgeInsets.only(left:20,right: 20,top: 20),
                padding: EdgeInsets.only(left:20,right:20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey[200],
                    boxShadow: [BoxShadow(
                        offset: Offset(0,10),
                        blurRadius: 50,
                        color:Color(0xffEEEEEE)
                    )]
                ),
                alignment: Alignment.center,
                child: TextField(
                  controller: TextEditingController(text: user.password),
                  onChanged: (val){
                    user.password=val;
                  },
                  obscureText: true,
                  cursorColor: Color(0xff9382C1),
                  decoration: InputDecoration(
                      icon: Icon(
                          Icons.vpn_key,
                          color: Color(0xff9382C1)
                      ),
                      hintText: "Password",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  save();
                },///GO TO NEXT PAGE
                child: Container(
                  margin: EdgeInsets.only(left:20,right:20,top:70),
                  padding: EdgeInsets.only(left: 20,right: 20),
                  alignment: Alignment.center,
                  height: 54,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [new Color(0xff9382C1),new Color(0xff5F4C8E),],
                          begin: Alignment.centerLeft,
                          end:Alignment.centerRight),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [BoxShadow(
                          offset: Offset(0,10),
                          blurRadius: 50,
                          color:Color(0xffEEEEEE)
                      )]

                  ),
                  child: Text(
                    "REGISTER",
                    style: TextStyle(
                        color:Colors.white
                    ),
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top:10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already Member? "),
                      GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Text("Login Now",
                              style: TextStyle(
                                  color: Color(0xff9382C1)
                              )
                          )
                      )
                    ],
                  )
              )
            ],
          ),
        )
    );
  }
}
Widget _buildPopupDialog(BuildContext context,message1,message2) {
  return new AlertDialog(
    title: Text(message1),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(message2),
      ],
    ),
    actions: <Widget>[
      new TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(
            'Close',
            style: TextStyle(
                color: new Color(0xff9382C1)
            )
        ),
      ),
    ],
  );
}

