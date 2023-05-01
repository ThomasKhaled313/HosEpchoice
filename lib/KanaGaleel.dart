import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'AudioPlayerScreen.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:share/share.dart';
class KanaGaleel extends StatefulWidget{
  String title;

  KanaGaleel(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return KanaGaleelState(title);
  }
}

class KanaGaleelState extends State<KanaGaleel>{
  String title;
  var url,urlasync;
  KanaGaleelState(this.title);
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
      case 'مرد المزمور' : return 'marad_mazmoor_kanagaleel.mp3'; break;
      case 'مرد الإنجيل' : return 'marad_engeel_kanagaleel.mp3'; break;
      case 'مرد الابركسيس' : return 'marad_eprakcic_kanagaleel.mp3'; break;
      case 'ni ,ora' : return 'ni_khora.mp3'; break;
      case 'اسبسمس ادام' : return 'aspasmoc_adam_kanagaleel.mp3'; break;
      case 'اسبسمس واطس' : return 'aspasmoc_watos_kanagaleel.mp3'; break;

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
            button('مرد المزمور'),

            button('مرد الإنجيل'),

            button('مرد الابركسيس'),

            button('ni ,ora'),

            button('اسبسمس ادام'),

            button('اسبسمس واطس'),

          ],
        ),
      ),
    );
  }


}


