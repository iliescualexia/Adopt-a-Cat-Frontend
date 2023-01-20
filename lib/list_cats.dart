import 'dart:collection';
import 'dart:convert';

import 'package:adopt_a_cat_ui/choose_action.dart';
import 'package:adopt_a_cat_ui/user_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'breed.dart';
import 'cat_desc.dart';
import 'cat_item.dart';
import 'cat_desc.dart';
import 'food.dart';

class ListCats extends StatefulWidget {
  late List<CatItem> catItems;
  late List<Breed> breeds;
  late List<Food> foods;
  UserInfo userInfo;
  ListCats({super.key,required this.catItems,required this.breeds,required this.foods,required this.userInfo});
  @override
  State<StatefulWidget> createState() => InitState();
}
String shelterName="";
String shelterAddress="";
String email="";
String phoneNumber="";
int userId=0;
class InitState extends State<ListCats>{
  @override
  Widget build(BuildContext context) {
    return initWidget();
  }
}
Widget initWidget() {
  return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff9382C1),
        title: Text("Adopt A Cat"),
        centerTitle: true,
      ),
    body: ListView.builder(
      itemCount: catItems.length,
        itemBuilder:(context,index){
        CatItem catItem=catItems[index];
        String breedname="";
        String foodname="";
        for(var u in breeds){
          if(catItem.breedid==u.breedid){
            breedname=u.breedname;
          }
        }
        for(var u in foods){
          if(catItem.idfood==u.idfood){
            foodname=u.foodname;
          }
        }
        return Card(
          child: ListTile(
            title:Text(catItem.name),
            subtitle: Text("Age: ${catItem.age.toString()}, Breed: $breedname"),
            trailing: Icon(Icons.arrow_forward_rounded),
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>CatDescription(cat: catItem,breed: breedname,food: foodname)));
            },
          ),
        );
        }
    )

  );
}