import 'dart:async';
import 'package:flutter/material.dart';
import 'AudioPlayerScreen.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:share/share.dart';
class AlSo3ood extends StatefulWidget{
  String title;

  AlSo3ood(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AlSo3oodState(title);
  }
}

class AlSo3oodState extends State<AlSo3ood>{
  String title;
  var url,urlasync;
  AlSo3oodState(this.title);
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
      case 'أرباع الناقوس' : return 'arba3nakoos_so3ood.mp3'; break;
      case 'ذوكصولوجية الصعود' : return 'zoxology_so3ood.mp3'; break;
      case 'مرد الابركسيس' : return 'marad_eprakcic_so3ood.mp3'; break;
      case 'afrek `tve' : return 'afrek_etfe.mp3'; break;
      case ',rictoc analym(الطويلة)' : return 'khrictoc_analym_long.mp3'; break;
      case ',rictoc analym(القصيرة)' : return 'khrictoc_analym_short.mp3'; break;
      case 'pi,rictoc aftwnf' : return 'apikhrectoctonf_so3ood.mp3'; break;
      case 'مرد المزمور' : return 'marad_mazmoor_so3ood.mp3'; break;
      case 'مرد الانجيل' : return 'marad_engeel_so3ood.mp3'; break;
      case 'اسبسمس ادام' : return 'aspasmoc_adam_so3ood.mp3'; break;
      case 'اسبسمس واطس ثاني' : return 'aspasmoc_watos_tany_so3ood.mp3'; break;
      case 'التوزيع' : return 'tawzee3So3ood.mp3'; break;
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
            button('أرباع الناقوس'),

            button('ذوكصولوجية الصعود'),

            button('مرد الابركسيس'),

            button('afrek `tve'),

            button(',rictoc analym(الطويلة)'),

            button(',rictoc analym(القصيرة)'),

            button('pi,rictoc aftwnf'),

            button('مرد المزمور'),

            button('مرد الانجيل'),

            button('اسبسمس ادام'),

            button('اسبسمس واطس ثاني'),

            button('التوزيع')
          ],
        ),
      ),
    );
  }


}


