import 'dart:convert';
import 'dart:ffi';

import 'package:adopt_a_cat_ui/choose_action.dart';
import 'package:adopt_a_cat_ui/list_cats.dart';
import 'package:adopt_a_cat_ui/shelter.dart';
import 'package:adopt_a_cat_ui/user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'breed.dart';
import 'cat.dart';
import 'cat_item.dart';
import 'create_shelter.dart';
import 'food.dart';

class CreateCat extends StatefulWidget{
  late List<Breed> breeds;
  late List<Food> foods;
  UserInfo userInfo;
  CreateCat({super.key,required this.breeds,required this.foods,required this.userInfo});
  @override
  State<StatefulWidget> createState() =>InitState();
}
List <Shelter> shelters=[];
Cat cat=Cat("","","","");
String? selectedValueBreed=breeds[0].breedname;
String? selectedValueFood=foods[0].foodname;
class InitState extends State<CreateCat>{
  late int breedid;
  late int foodid;
  Future getBreeds(breedname)async {
    String url = 'http://10.0.2.2:8090/api/v1/breed';
    var response=await http.get(Uri.parse(url));
    var jsonData=jsonDecode(response.body);
    for(var u in jsonData){
      Breed breed=Breed(u["breedid"],u["breedname"]);
      if(breed.breedname==breedname){
        breedid=breed.breedid;
      }
    }
  }
  Future getFoods(foodname)async {
    String url = 'http://10.0.2.2:8090/api/v1/food';
    var response=await http.get(Uri.parse(url));
    var jsonData=jsonDecode(response.body);
    for(var u in jsonData){
      Food food=Food(u["idfood"],u["foodname"]);
      if(food.foodname==foodname){
        foodid=food.idfood;
      }
    }
  }
  Future saveCat()async{
    await getBreeds(cat.breedname);
    await getFoods(cat.foodname);
    await getShelter();
    String url='http://10.0.2.2:8090/api/v1/cat';
    var res=await http.post(Uri.parse(url),headers: {'Content-Type':'application/json'},body: jsonEncode(
        {
          'name':cat.name,
          'breedid':breedid,
          'age':cat.age,
          'idfood':foodid
        }
    ));
    var u;
    if(res.statusCode==200){
      u=json.decode(res.body);
      CatItem catItem = CatItem(
          u["catId"], u["name"], u["breedid"], u["age"], u["idfood"]);
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context)=>CreateShelter(catItem: catItem,shelters: shelters,userInfo:widget.userInfo)));

    }else{
      String message1="Opps!";
      String message2="Something went wrong";
      showDialog(
          context: context,
          builder: (BuildContext context) => Message(context,message1,message2));
    }
  }
  @override
  Widget build(BuildContext context) {
    for(var u in foods){
      print(u.foodname);
    }
    for(var u in breeds){
      print(u.breedname);
    }
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
            Padding(
              padding: const EdgeInsets.only(top:5.0),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Describe Your Cat",
                  style: TextStyle(
                      color: Color(0xff9382C1),
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              margin:EdgeInsets.only(left:20,right: 20,top: 40),
              padding: EdgeInsets.only(left:20,right:20),
              alignment: Alignment.centerLeft,
              child: Text(
                "Name",
                style: TextStyle(
                    color: Color(0xff9382C1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              margin:EdgeInsets.only(left:20,right: 20,top: 10),
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
                controller: TextEditingController(text:cat.name),
                onChanged: (val){
                  cat.name=val;
                },
                cursorColor: Color(0xff9382C1),
                decoration: InputDecoration(
                  hintText: "Enter The Cat's Name",
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            Container(
              margin:EdgeInsets.only(left:20,right: 20,top: 40),
              padding: EdgeInsets.only(left:20,right:20),
              alignment: Alignment.centerLeft,
              child: Text(
                "Age",
                style: TextStyle(
                    color: Color(0xff9382C1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              margin:EdgeInsets.only(left:20,right: 20,top: 10),
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
                controller: TextEditingController(text:cat.age),
                onChanged: (val){
                  cat.age=val;
                },
                cursorColor: Color(0xff9382C1),
                decoration: InputDecoration(
                  hintText: "Enter The Cat's Age",
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            Container(
              margin:EdgeInsets.only(left:20,right: 20,top: 40),
              padding: EdgeInsets.only(left:20,right:20),
              alignment: Alignment.centerLeft,
              child: Text(
                "Breed",
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
                hint:Text("Select Breed"),
                value: selectedValueBreed,
                items:breeds.map((breed){
                  return DropdownMenuItem(
                    value: breed.breedname,
                    child: Text(breed.breedname),
                  );
                }).toList(),
                onChanged: (value){
                  setState(() {
                    if(value=="Other")
                      {
                        String breedname="";
                        String message1="Enter the Cat's Breed";
                        String message2="Enter Breed";
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => _buildPopupDialog(context,message1,message2,breedname,"breed"));
                      }
                    cat.breedname=value!;
                    selectedValueBreed=value;
                  });
                },
              ),
            ),
            Container(
              margin:EdgeInsets.only(left:20,right: 20,top: 40),
              padding: EdgeInsets.only(left:20,right:20),
              alignment: Alignment.centerLeft,
              child: Text(
                "Select The Food you Cat Eats",
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
                hint:Text("Select Food"),
                value: selectedValueFood,
                items:foods.map((food){
                  return DropdownMenuItem(
                    value: food.foodname,
                    child: Text(food.foodname),
                  );
                }).toList(),
                onChanged: (value){
                  setState(() {
                    if(value=="Other")
                    {
                      String foodname="";
                      String message1="Enter Your Cat's Food";
                      String message2="Enter Food";
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => _buildPopupDialog(context,message1,message2,foodname,"food"));
                    }
                    cat.foodname=value!;
                    selectedValueFood=value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
            child:ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith((states) => const Color(0xff9382C1))
              ),
                onPressed:(){
                saveCat();
                },
                child: Text(
                  "Next"
                )
            )
            )
          ],
        ),
      )
    );
  }
}
Future saveBreed(String breedname)async{
  String url='http://10.0.2.2:8090/api/v1/breed';
  var res=await http.post(Uri.parse(url),headers: {'Content-Type':'application/json'},body: jsonEncode(
      {
        'breedname':breedname
      }
  ));
}
Future saveFood(String foodname)async{
  String url='http://10.0.2.2:8090/api/v1/food';
  var res=await http.post(Uri.parse(url),headers: {'Content-Type':'application/json'},body: jsonEncode(
      {
        'foodname':foodname
      }
  ));
}
Widget _buildPopupDialog(BuildContext context,message1,message2,addition,type) {
  return AlertDialog(
    title: Text(message1),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          controller: TextEditingController(text: addition),
          onChanged: (val){
            addition=val;
          },
          cursorColor: Color(0xff9382C1),
          decoration: InputDecoration(
            hintText: message2,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text(
                    'Close',
                    style: TextStyle(
                        color: new Color(0xff9382C1)
                    )
                )),
            SizedBox(
              width: 90,
            ),
            TextButton(
                onPressed: (){
                  bool found=false;
                  if(type=="food"){
                    for(var u in foods){
                      if(addition==u.foodname){
                        found=true;
                      }
                    }

                    if(found==false){
                      cat.foodname=addition;
                      saveFood(addition);
                      Navigator.of(context).pop();
                    }
                    else{
                      Navigator.of(context).pop();
                      message1="Oops!";
                      message2="Food already exists";
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => Error(context,message1,message2));
                    }
                  }
                  else{
                    for(var u in breeds){
                      if(addition==u.breedname){
                        found=true;
                      }
                    }
                    if(found==false){
                      cat.breedname=addition;
                      saveBreed(addition);
                      Navigator.of(context).pop();
                    }else{
                      Navigator.of(context).pop();
                      message1="Oops!";
                      message2="Breed already exists";
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => Error(context,message1,message2));
                    }
                  }
                },
                child: Text(
                    'Ok',
                    style: TextStyle(
                        color: new Color(0xff9382C1)
                    )
                )),
          ],
        )
      ],
    ),
  );
}
Widget Error(BuildContext context,message1,message2) {
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
Future getShelter()async {
  shelters.clear();
  String url = 'http://10.0.2.2:8090/api/v1/shelter';
  var response=await http.get(Uri.parse(url));
  print(response.statusCode);
  var jsonData;
  if(response.body.isNotEmpty) {
    jsonData=json.decode(response.body);
  }
  for (var u in jsonData) {
    Shelter shelter=Shelter(u["shelterid"], u["name"], u["address"]);
    shelters.add(shelter);
  }
  return shelters;
}


