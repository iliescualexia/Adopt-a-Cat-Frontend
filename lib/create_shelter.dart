import 'dart:convert';
import 'dart:ffi';

import 'package:adopt_a_cat_ui/choose_action.dart';
import 'package:adopt_a_cat_ui/create_cat.dart';
import 'package:adopt_a_cat_ui/list_cats.dart';
import 'package:adopt_a_cat_ui/shelter.dart';
import 'package:adopt_a_cat_ui/user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'breed.dart';
import 'cat.dart';
import 'cat_item.dart';
import 'food.dart';

class CreateShelter extends StatefulWidget{
  CatItem catItem;
  UserInfo userInfo;
  List<Shelter> shelters;
  CreateShelter({super.key, required this.catItem, required this.shelters,required this.userInfo });
  @override
  State<StatefulWidget> createState() =>InitState();
}
String? selectedValueShelter=shelters[0].name;
String sheltername="";
class InitState extends State<CreateShelter>{
  Future AddCatToShelter()async{
    String url='http://10.0.2.2:8090/api/v1/shelter/addcat';
    int shelterid=0;
    for(var u in shelters){
      if(u.name==sheltername){
        shelterid=u.shelterid;
      }
    }
    var res=await http.post(Uri.parse(url),headers: {'Content-Type':'application/json'},body: jsonEncode(
        {
          "shelterid":shelterid,
          "catId":widget.catItem.catId
        }
    ));
    if(res.statusCode==200){
      String message1="Good job!";
      String message2="Your cat was added to the adoption list";
      showDialog(
          context: context,
          builder: (BuildContext context) => Message(context,message1,message2));
    }
    else{
      String message1="Opps!";
      String message2="Something went wrong";
      showDialog(
          context: context,
          builder: (BuildContext context) => Message(context,message1,message2));
    }
  }
  Future MakeUserOwner()async{
    String url='http://10.0.2.2:8090/api/v1/owner';
    print(widget.userInfo.userId);
    print(widget.catItem.catId);
    var res=await http.post(Uri.parse(url),headers: {'Content-Type':'application/json'},body: jsonEncode(
        {
          "userid":widget.userInfo.userId,
          "catId":widget.catItem.catId
        }
    ));
    print(res.statusCode);
  }
  @override
  Widget build(BuildContext context) {
    return initWidget();
  }
  Widget initWidget(){
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff9382C1),
          title: Text("Adopt A Cat"),
          centerTitle: true,
        ),
        body:SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin:EdgeInsets.only(left:20,right: 20,top: 40),
                padding: EdgeInsets.only(left:20,right:20),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Select Shelter",
                  style: TextStyle(
                      color: Color(0xff9382C1),
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
                child: DropdownButton(
                  iconEnabledColor: Color(0xff9382C1),
                  borderRadius:BorderRadius.circular(20) ,
                  isExpanded: true,
                  hint:Text("Select Shelter"),
                  value: selectedValueShelter,
                  items:shelters.map((shelter){
                    return DropdownMenuItem(
                      value: shelter.name,
                      child: Text(shelter.name),
                    );
                  }).toList(),
                  onChanged: (value){
                    setState(() {
                      sheltername=value!;
                      selectedValueShelter=value;
                    });
                  },
                ),
              ),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith((states) => const Color(0xff9382C1))
                        ),
                        onPressed:(){
                          MakeUserOwner();
                          AddCatToShelter();
                        },
                        child: Text(
                            "Put cat up for adoption"
                        )
                    ),
                )
            ],
          ),
        )
    );
  }
}
Widget Message(BuildContext context,message1,message2) {
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
          Navigator.of(context).pop();
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