import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'AudioPlayerScreen.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:share/share.dart';
class Nayrooz extends StatefulWidget{
  String title;

  Nayrooz(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NayroozState(title);
  }
}

class NayroozState extends State<Nayrooz>{
  String title;
  var url,urlasync;
  NayroozState(this.title);
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
      case 'مقدمة أرباع الناقوس الواطس' : return 'mokademet_arba3_nakkos_faray7y_watos.mp3'; break;
      case 'مقدمة أرباع الناقوس الادام' : return 'mokademet_arba3_nakkos_faray7y_adam.mp3'; break;
      case 'أرباع الناقوس' : return 'arba3_nakoos_nayrooz.mp3'; break;
      case 'الذوكصولوجية' : return 'zoksologia_nayrooz.mp3'; break;
      case 'مرد الابركسيس' : return 'marad_epraxic_nayrooz.mp3'; break;
      case 'مرد المزمور' : return 'maradmazmoor_nayrooz.mp3'; break;
      case 'مرد الإنجيل' : return 'maradengeel_nayrooz.mp3'; break;
      case 'الاسبسمس الادام' : return 'aspacmocadam_nayrooz.mp3'; break;
      case 'الاسبسمس الواطس' : return 'aspacmocwatosnayrooz.mp3'; break;
      case 'التوزيع' : return 'tawzee3_nayrooz.mp3'; break;
      case 'ختام الصلوات' : return 'khetam_nayrooz.mp3'; break;

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
            button('مقدمة أرباع الناقوس الواطس'),

            button('مقدمة أرباع الناقوس الادام'),

            button('أرباع الناقوس'),

            button('الذوكصولوجية'),

            button('مرد الابركسيس'),

            button('مرد المزمور'),

            button('مرد الإنجيل'),

            button('الاسبسمس الادام'),

            button('الاسبسمس الواطس'),

            button('التوزيع'),

            button('ختام الصلوات'),
          ],
        ),
      ),
    );
  }


}


