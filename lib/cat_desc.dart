import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'cat_item.dart';
import 'create_cat.dart';

class CatDescription extends StatefulWidget {
  CatItem cat;
  String breed;
  String food;
  late String shelter;
  late String address;
  late String email;
  late String phoneNumber;
  late int userId;
  CatDescription({super.key, required this.cat,required this.breed,required this.food});
  @override
  State<CatDescription> createState() => CatDescriptionState();
}
class CatDescriptionState extends State<CatDescription> {
  Future getShelter(int catId)async{

    String url='http://10.0.2.2:8090/api/v1/findshelter';
    var res=await http.post(Uri.parse(url),headers: {'Content-Type':'application/json'},body: jsonEncode(
        {
          'catId':catId
        }
    ));
    var jsonData=jsonDecode(res.body);
    widget.shelter=jsonData["name"];
    widget.address=jsonData["address"];
    await getOwner(catId);
    print(widget.address);
    return widget.address;
  }
  Future getOwner(int catId)async{

    String url='http://10.0.2.2:8090/api/v1/findowner';
    var res=await http.post(Uri.parse(url),headers: {'Content-Type':'application/json'},body: jsonEncode(
        {
          'catId':catId
        }
    ));
    var jsonData=jsonDecode(res.body);
    Map user=jsonData['user'];
    widget.email=user['email'];
    widget.phoneNumber=user['phoneNumber'];
    widget.userId=user['userId'];

  }
  Future deleteCat()async{
    String url='http://10.0.2.2:8090/api/v1/cat';
    var res=await http.delete(Uri.parse(url),headers: {'Content-Type':'application/json'},body: jsonEncode(
        {
          'catId':widget.cat.catId,
        }
    ));
    print(res.statusCode);
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getShelter(widget.cat.catId),
        builder:(context,snapshot){
        if(snapshot.hasData){
          return initWidget();
        }else{
          return LinearProgressIndicator(
            backgroundColor: Colors.white,
          );
        }
        },
    );
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
                padding: EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),
                child: Text(
                  "Cat's Description",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff9382C1),
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold
                  ),
                )
            ),
            Container(
              color: Color(0xff9382C1),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(10.0,10.0,0.0,10.0),
              child: Text(
                "Name: ${widget.cat.name}",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(10.0,10.0,0.0,10.0),
              child: Text(
                "Breed: ${widget.breed}",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color(0xff9382C1),
                  fontSize: 25.0,
                ),
              ),
            ),
            Container(
              color: Color(0xff9382C1),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(10.0,10.0,0.0,10.0),
              child: Text(
                "Age: ${widget.cat.age.toString()}",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(10.0,10.0,0.0,10.0),
              child: Text(
                "The Cat's Food: ${widget.food}",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color(0xff9382C1),
                  fontSize: 25.0,
                ),
              ),
            ),
            Container(
              color: Color(0xff9382C1),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(10.0,10.0,0.0,10.0),
              child: Text(
                "The Cat's Shelter: ${widget.shelter}",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(10.0,10.0,0.0,10.0),
              child: Text(
                "The Cat's Address: ${widget.address}",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color(0xff9382C1),
                  fontSize: 25.0,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(10.0, 20.0,20.0, 0.0),
              child: TextButton(
                  onPressed: (){
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => OwnerInfo(context,widget.email,widget.phoneNumber));
                  },
                  child: Text(
                      "Owner's contact info",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xff9382C1),
                        fontSize: 20.0,
                        decoration: TextDecoration.underline,
                        fontStyle: FontStyle.italic
                      )
                  )
              ),
            ),

            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0.0,120.0,0.0,0.0),
              child:SizedBox(
                height: 70.0,
                width: 300.0,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) => Color(0xff9382C1))
                  ),
                  onPressed: (){
                    deleteCat();
                    String message1="Good Job!";
                    String message2="You Adopted A Cat!";
                    showDialog(
                        context: context,
                        builder: (BuildContext context) =>Message(context,message1,message2));
                  },
                  child: Text("Adopt Cat",
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
Widget OwnerInfo(BuildContext context,message1,message2) {
  return new AlertDialog(
    title: Container(
      height: 40,
      alignment: Alignment.center,
      color:Color(0xff9382C1) ,
      child: Text("Owner's contact info",
        textAlign: TextAlign.center,
        style: TextStyle(
        color: Colors.white)
      ),
    ),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Email: $message1",
        style: TextStyle(
        color: Color(0xff9382C1))),
        SizedBox(
          height: 10,
        ),
        Text("Phone Number: $message2",
          style: TextStyle(
              color: Color(0xff9382C1)))
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