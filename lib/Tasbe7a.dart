import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:hosepchoice/MaradatAsheyyaWeBaker.dart';
import 'package:hosepchoice/tasbe7aAl7an.dart';
import 'package:hosepchoice/tasbe7aDamg.dart';
import 'AudioPlayerScreen.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:share/share.dart';

import 'MaraddatKoddas.dart';
class Tasbe7a extends StatefulWidget{
  String title;

  Tasbe7a(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Tasbe7aState(title);
  }
}

class Tasbe7aState extends State<Tasbe7a>{
  String title;
  var url,urlasync;
  Tasbe7aState(this.title);

  String audioTitle;

  Widget button(title){
    return InkWell(
      onTap: (){
        if(title == 'دمج'){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Tasbe7aDamg(title)));
        }
        else {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Tasbe7aAl7an(title)));
        }
      },
      child: new Container(
        width: MediaQuery.of(context).size.width,
        height: 50.0,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 0, 0, 0),
          border: Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 2.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: new Center(child: new Text(title, textAlign: TextAlign.center,style: new TextStyle(fontSize: 18.0, fontFamily: 'Coptic' ,color: Colors.white),),),
      ),
    );
  }





  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: (){
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(22, 22, 22,1),


          title: Text(title),
        ),
        body: GridView.count(
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 4/2,
          padding: const EdgeInsets.all(12),
          crossAxisCount: 2,
          children: [
            button('دمج'),

            button('الحان'),

          ],
        ),
      ),
    );
  }


}


