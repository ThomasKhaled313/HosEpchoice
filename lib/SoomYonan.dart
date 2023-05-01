import 'dart:async';
import 'package:flutter/material.dart';
import 'AudioPlayerScreen.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:share/share.dart';
class SoomYonan extends StatefulWidget{
  String title;

  SoomYonan(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SoomYonanState(title);
  }
}

class SoomYonanState extends State<SoomYonan>{
  String title;
  var url,urlasync;
  SoomYonanState(this.title);
  AudioPlayer audio = AudioPlayer();


  String audioTitle;
  Future<String> getAudioUrl(text) async{
    var ref = await getAudioName(text);
    audioTitle = text;
    Reference storage = FirebaseStorage.instance.ref().child("${ref}");
    String url = (await storage.getDownloadURL()).toString();
    print('sadasfasfasfsa : ${url}');
    return url;
  }

  Widget button(title){
    return InkWell(
      onTap: (){
        getAudioUrl(title).then((onValue){
          setState(() {
            urlasync = onValue;
          });
        }).whenComplete((){
          setState(() {
            url = urlasync;
          });
          print('abo el urllllllllllllllllllllllllllllllllllllllll: $url');
          urlAndNavigate(title);
        });

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

  Widget urlAndNavigate(text){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>AudioPlayerScreen(url,audioTitle,title)));
  }

  getAudioName(title){
    switch(title){
      case 'الذوكصولوجية' : return 'zoksologiet_yonan.mp3'; break;
      case 'مرد انجيل باكر الإثنين' : return 'maradengeel_bakeretneen_yonan.mp3'; break;
      case 'مرد انجيل قداس الإثنين' : return 'maradengeel_koddasetneen_yonan.mp3'; break;
      case 'مرد انجيل باكر الثلاثاء' : return 'maradengeel_bakertalat_yonan.mp3'; break;
      case 'مرد انجيل قداس الثلاثاء' : return 'maradengeel_koddastalat_yonan.mp3'; break;
      case 'مرد انجيل باكر الاربعاء' : return 'maradengeel_bakerarba3_yonan.mp3'; break;
      case 'مرد انجيل قداس الاربعاء' : return 'maradengeel_koddasarba3_yonan.mp3'; break;
      case 'مرد انجيل باكر الخميس' : return 'maradengeel_baker5amees_yonan.mp3'; break;
      case 'مرد انجيل قداس الخميس' : return 'maradengeel_koddas5amees_yonan.mp3'; break;
      case 'الهيتينية' : return 'hiten_yonan.mp3'; break;
      case 'iwna piprovytyc' : return 'tawzee3_yonan.mp3'; break;

    }
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
            button('الذوكصولوجية'),

            button('مرد انجيل باكر الإثنين'),

            button('مرد انجيل قداس الإثنين'),

            button('مرد انجيل باكر الثلاثاء'),

            button('مرد انجيل قداس الثلاثاء'),

            button('مرد انجيل باكر الاربعاء'),

            button('مرد انجيل قداس الاربعاء'),

            button('مرد انجيل باكر الخميس'),

            button('مرد انجيل قداس الخميس'),

            button('الهيتينية'),

            button('iwna piprovytyc')
          ],
        ),
      ),
    );
  }


}


