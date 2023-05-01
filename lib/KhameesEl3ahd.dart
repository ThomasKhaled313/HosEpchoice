import 'dart:async';
import 'package:flutter/material.dart';
import 'AudioPlayerScreen.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:share/share.dart';
import 'package:fluttertoast/fluttertoast.dart';
class KhameesEl3ahd extends StatefulWidget{
  String title;

  KhameesEl3ahd(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return KhameesEl3ahdState(title);
  }
}

class KhameesEl3ahdState extends State<KhameesEl3ahd>{
  String title;
  var url,urlasync;
  KhameesEl3ahdState(this.title);
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
      case 'Vai etafenf' : return 'fay_etafenf.mp3'; break;
      case 'الابركسيس الحزايني(مقدمة)' : return 'ebraksis_7azayny_intro.mp3'; break;
      case 'الابركسيس الحزايني(جُمَل)' : return 'ebraksis_7azayny_gomal.mp3'; break;
      case 'ioudac' : return 'yodas.mp3'; break;
      case 'اجيوس الحزايني' : return 'agioc_7azayny.mp3'; break;
      case 'مرد انجيل اللقان' : return 'marad_engeel_lakkan.mp3'; break;
      case 'اسبسمس ادام اللقان' : return 'aspasmoc_adam_lakkan.mp3'; break;
      case 'مزمور القداس' : return 'mazmooroddas_5amees3ahd.mp3'; break;
      case 'مرد انجيل القداس' : return 'marad_engeel_khamees3ahd.mp3'; break;
      case 'اسبسمس ادام القداس' : return 'aspasmoc_adam_koddas_5amees3ahd.mp3'; break;


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
            button('Vai etafenf'),

            button('الابركسيس الحزايني(مقدمة)'),

            button('الابركسيس الحزايني(جُمَل)'),

            button('ioudac'),

            button('اجيوس الحزايني'),

            button('مرد انجيل اللقان'),

            button('اسبسمس ادام اللقان'),

            button('مزمور القداس'),

            button('مرد انجيل القداس'),

            button('اسبسمس ادام القداس')
          ],
        ),
      ),
    );
  }


}


