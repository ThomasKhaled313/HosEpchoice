import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'AudioPlayerScreen.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:share/share.dart';
class SabtFara7 extends StatefulWidget{
  String title;

  SabtFara7(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SabtFara7State(title);
  }
}

class SabtFara7State extends State<SabtFara7>{
  String title;
  var url,urlasync;
  SabtFara7State(this.title);
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
      case 'مرد انجيل باكر' : return 'marad_engeel_baker_sabtfara7.mp3'; break;
      case 'مرد انجيل القداس' : return 'marad_engeel_koddas_sabtfara7.mp3'; break;
      case 'anok pe pikouji' : return 'anok_ebty.mp3'; break;
      case 'anok pe pikouji(عربي)' : return 'anok_araby.mp3'; break;
      case 'marenouwnh' : return 'marenouonh.mp3'; break;
      case 'الهوس الثالث' : return 'thirdhos.mp3'; break;
      case 'agioc a;anatoc nai nan' : return 'epsali_watos_sabtfara7.mp3'; break;
      case 'vyetafsans' : return 'fyetafshansh_sanawy.mp3'; break;
      case 'المحير' : return 'mo7ayyer_sabtfara7.mp3'; break;
      case 'ختام باكر' : return 'khetambaker_sabtfara7.mp3'; break;
      case 'erepicmou' : return 'erepiesmo.mp3'; break;
      case 'vyete ouon' : return 'fieteouon.wav'; break;
      case 'anok ainau' : return 'anok_ainav.opus'; break;
      case 'الاحجار' : return 'tycenty_a7gar.mp3'; break;
      case 'panou]' : return 'panoty.mp3'; break;
      case 'panou] عربي' : return 'Panoty_arabic.mp3'; break;
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
            button('مرد انجيل باكر'),

            button('مرد انجيل القداس'),

            button('anok pe pikouji'),

            button('anok pe pikouji(عربي)'),

            button('marenouwnh'),

            button('الهوس الثالث'),

            button('agioc a;anatoc nai nan'),

            button('vyetafsans'),

            button('المحير'),

            button('ختام باكر'),

            button('erepicmou'),

            button('vyete ouon'),

            button('anok ainau'),

            button('الاحجار'),

            button('panou]'),
            button('panou] عربي'),
          ],
        ),
      ),
    );
  }


}

