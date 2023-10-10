import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'AudioPlayerScreen.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:share/share.dart';
class Keyahk extends StatefulWidget{
  String title;

  Keyahk(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return KeyahkState(title);
  }
}

class KeyahkState extends State<Keyahk>{
  String title;
  var url,urlasync;
  KeyahkState(this.title);
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
      case 'ارباع الناقوس' : return 'arba3_nakoos_kyahk.mp3'; break;
      case 'الهيتينيات' : return 'hitens_kyahk.mp3'; break;
      case 'مرد الابركسيس الاول' : return 'marad_eprakcicawwel_kyahk.mp3'; break;
      case 'مرد الابركسيس الثاني' : return 'marad_eprakcictany_kyahk.mp3'; break;
      case 'مرد الابركسيس الثالث' : return 'marad_eprakcictalet_kyahk.mp3'; break;
      case 'مرد مزمور الانجيل' : return 'mazmoor_kyahk.mp3'; break;
      case 'مرد الانجيل للاحد الاول و الثاني' : return 'maradenggelawwalwetany_kyahk.mp3'; break;
      case 'مرد الانجيل للاحد الثالث و الرابع' : return 'maradenggeltaletwerabe3_kyahk.mp3'; break;
      case 'اسبسمس ادام اول' : return 'aspasmos_adam_first_sunday.mp3'; break;
      case 'اسبسمس ادام ثاني' : return 'aspasmos_adam_second_sunday.mp3'; break;
      case 'اسبسمس ادام ثالث' : return 'aspasmoc_adam_talet_kyahk.mp3'; break;
      case 'اسبسمس واطس اول' : return 'aspasmos_watosawwel_keyahk.mp3'; break;
      case 'اسبسمس واطس ثاني' : return 'aspasmos_watostany_keyahk.mp3'; break;
      case 'اسبسمس واطس ثالث' : return 'apspasmoc_watos_talet_kyahk.mp3'; break;
      case 'je fcmarwout' : return 'je_efesmarowout.wav'; break;
      case 'التوزيع' : return 'tawzee3_keyahk.mp3'; break;
      case 'fempsa gar' : return 'ef_emebsha_ghar_kyahk.mp3'; break;
      case 'ختام الصلوات' : return 'khetam_kyahk.mp3'; break;

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
            button('ارباع الناقوس'),

            button('الهيتينيات'),

            button('مرد الابركسيس الاول'),

            button('مرد الابركسيس الثاني'),

            button('مرد الابركسيس الثالث'),

            button('مرد مزمور الانجيل'),

            button('مرد الانجيل للاحد الاول و الثاني'),

            button('مرد الانجيل للاحد الثالث و الرابع'),

            button('اسبسمس ادام اول'),

            button('اسبسمس ادام ثاني'),

            button('اسبسمس ادام ثالث'),

            button('اسبسمس واطس اول'),

            button('اسبسمس واطس ثاني'),

            button('اسبسمس واطس ثالث'),

            button('je fcmarwout'),

            button('التوزيع'),

            button('fempsa gar'),

            button('ختام الصلوات'),


          ],
        ),
      ),
    );
  }


}



