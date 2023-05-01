import 'dart:async';
import 'package:flutter/material.dart';
import 'AudioPlayerScreen.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';
class AlBas5a extends StatefulWidget{
  String title;

  AlBas5a(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AlBas5aState(title);
  }
}

class AlBas5aState extends State<AlBas5a>{
  String title;
  var url,urlasync;
  AlBas5aState(this.title);
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
      case 'النبوات قبطي' : return 'nobowat_7azayny.mp3'; break;
      case 'الانجيل قبطي' : return 'engeel_7azayny.mp3'; break;
      case 'مقدمة العظة' : return 'mokademet_eza.mp3'; break;
      case 'ختام العظة' : return 'khetam_eleza.mp3'; break;
      case 'Ke `upertou' : return 'keEbertoDamg.mp3'; break;
      case 'مقدمة + ختام الطرح' : return 'tar7Hazayni.mp3'; break;
      case '`Pouro الختام' : return 'epouro5etamBas5a.mp3'; break;
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
            button('النبوات قبطي'),
            button('الانجيل قبطي'),
            button('مقدمة العظة'),
            button('ختام العظة'),
            button('Ke `upertou'),
            button('مقدمة + ختام الطرح'),
            button('`Pouro الختام'),
          ],
        ),
      ),
    );
  }


}


