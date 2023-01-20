import 'dart:convert';

import 'package:adopt_a_cat_ui/choose_action.dart';
import 'package:adopt_a_cat_ui/user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'breed.dart';
import 'cat_item.dart';
import 'create_cat.dart';
import 'food.dart';
import 'list_cats.dart';

class ChooseAction extends StatefulWidget {
  UserInfo userInfo;
  ChooseAction({super.key,required this.userInfo});


  @override
  State<ChooseAction> createState() => ChooseActionState();
}
List<Breed> breeds=[];
List<Food> foods=[];
List <CatItem> catItems=[];
class ChooseActionState extends State<ChooseAction> {
  @override
  Widget build(BuildContext context) {
    getCats();
    getFoods();
    getBreeds();
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0,180.0,0.0,0.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0.0,0.0,0.0,70.0),
                child: Text(
                  "You want to: ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff9382C1),
                      fontSize: 45.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>ListCats(catItems:catItems,breeds: breeds,foods: foods,userInfo: widget.userInfo)));
                    },///GO TO NEXT PAGE
                    child: Container(
                      alignment: Alignment.center,
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [new Color(0xff9382C1),new Color(0xff5F4C8E),],
                              begin: Alignment.centerLeft,
                              end:Alignment.centerRight),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(
                              offset: Offset(0,10),
                              blurRadius: 50,
                              color:Color(0xffEEEEEE)
                          )]

                      ),
                      child: Text(
                        "Adopt a Cat",
                        style: TextStyle(
                            color:Colors.white
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>CreateCat(breeds: breeds,foods: foods,userInfo: widget.userInfo )));
                    },///GO TO NEXT PAGE
                    child: Container(
                      alignment: Alignment.center,
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [new Color(0xff9382C1),new Color(0xff5F4C8E),],
                              begin: Alignment.centerLeft,
                              end:Alignment.centerRight),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(
                              offset: Offset(0,10),
                              blurRadius: 50,
                              color:Color(0xffEEEEEE)
                          )]

                      ),
                      child: Text(
                        "Put a cat up for adoption",
                        style: TextStyle(
                            color:Colors.white
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
Future getBreeds()async {
  breeds.clear();
  String url = 'http://10.0.2.2:8090/api/v1/breed';
  var response=await http.get(Uri.parse(url));
  var jsonData=jsonDecode(response.body);
  for(var u in jsonData){
    Breed breed=Breed(u["breedid"],u["breedname"]);
    breeds.add(breed);
  }
  Breed otherSelection=Breed(-1,"Other");
  breeds.add(otherSelection);
  return breeds;
}
Future getCats()async {
  catItems.clear();
  String url = 'http://10.0.2.2:8090/api/v1/cat';
  var response=await http.get(Uri.parse(url));
  print(response.statusCode);
  var jsonData;
  if(response.body.isNotEmpty) {
    jsonData=json.decode(response.body);
  }
  for (var u in jsonData) {
    CatItem catItem = CatItem(
        u["catId"], u["name"], u["breedid"], u["age"], u["idfood"]);
    catItems.add(catItem);
  }

  return catItems;
}
Future getFoods()async {
  foods.clear();
  String url = 'http://10.0.2.2:8090/api/v1/food';
  var response=await http.get(Uri.parse(url));
  var jsonData=jsonDecode(response.body);
  for(var u in jsonData){
    Food food=Food(u["idfood"],u["foodname"]);
    foods.add(food);
  }
  Food otherSelection=Food(-1,"Other");
  foods.add(otherSelection);
  return foods;
}
