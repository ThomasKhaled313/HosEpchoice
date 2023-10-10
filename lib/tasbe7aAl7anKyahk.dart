import 'dart:async';
import 'package:flutter/material.dart';
import 'AudioPlayerScreen.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:share/share.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Tasbe7aAl7anKyahk extends StatefulWidget{
  String title;

  Tasbe7aAl7anKyahk(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Tasbe7aAl7anKyahkState(title);
  }
}

class Tasbe7aAl7anKyahkState extends State<Tasbe7aAl7anKyahk>{
  String title;
  var url,urlasync;
  Tasbe7aAl7anKyahkState(this.title);
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
      case 'اللي العصر' : return 'allyEl3asr.mp3'; break;
      case 'Areten;wn]' : return 'aretenthonty.mp3'; break;
      case 'اللي نصف الليل' : return 'allyNosLel.mp3'; break;
      case 'الهوس الكبير' : return 'largeHos.mp3'; break;
      case 'ابصالية علي الهوس الاول' : return 'epsaliHosAwwelKyahk.mp3'; break;
      case 'Tenoueh `ncwk' : return 'tenowehKyahk.mp3'; break;
      case 'Tenen' : return 'Tenen.mp3'; break;
      case 'ابصالية واطس علي المجمع' : return 'epsaleyyaWatosMagma3.mp3'; break;
      case 'ابصالية ادام علي المجمع' : return 'epsaleyyaAdamMagma3.mp3'; break;
      case 'ابصالية ادام علي ثيؤطوكية الاحد' : return 'epsaleyyaAdamTheotokeyyaA7ad.mp3'; break;
      case 'طرح الفعلة' : return 'tar7Fa3laKyahk.mp3'; break;
      case 'الشيرات الكيهكي' : return 'sheratKyahky.ogg'; break;






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
            button('اللي العصر'),
            button('Areten;wn]'),
            button('اللي نصف الليل'),
            button('الهوس الكبير'),
            button('ابصالية علي الهوس الاول'),
            button('Tenoueh `ncwk'),
            button('Tenen'),
            button('ابصالية واطس علي المجمع'),
            button('ابصالية ادام علي المجمع'),
            button('ابصالية ادام علي ثيؤطوكية الاحد'),
            button('طرح الفعلة'),
            button('الشيرات الكيهكي'),




          ],
        ),
      ),
    );
  }


}


