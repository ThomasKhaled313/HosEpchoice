import 'dart:async';
import 'package:flutter/material.dart';
import 'AudioPlayerScreen.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';
class Ghotac extends StatefulWidget{
  String title;

  Ghotac(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GhotacState(title);
  }
}

class GhotacState extends State<Ghotac>{
  String title;
  var url,urlasync;
  GhotacState(this.title);
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
      case 'ارباع الناقوس' : return 'arba3_nakoos_ghetac.mp3'; break;
      case 'الهيتينيات' : return 'hiten_ghotac.mp3'; break;
      case 'مرد الابركسيس (قداس الغطاس)' : return 'marad_eprakcic_koddas_ghotac.mp3'; break;
      case 'مرد الإنجيل (قداس الغطاس)' : return 'marad_engeel_koddas_ghotac.mp3'; break;
      case 'مرد الإنجيل (لقان الغطاس)' : return 'marad_engeel_lakkan_ghotac.mp3'; break;
      case 'اسبسمس ادام (قداس + لقان الغطاس)' : return 'aspasmoc_adam_ghotac.mp3'; break;
      case 'اسبسمس واطس (قداس الغطاس)' : return 'aspasmoc_watos_ghotac.mp3'; break;
      case 'Ouran nsousou' : return 'oranenshosho_ghotac.mp3'; break;

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

            button('مرد الابركسيس (قداس الغطاس)'),

            button('مرد الإنجيل (لقان الغطاس)'),

            button('مرد الإنجيل (قداس الغطاس)'),

            button('اسبسمس ادام (قداس + لقان الغطاس)'),

            button('اسبسمس واطس (قداس الغطاس)'),

            button('Ouran nsousou'),

          ],
        ),
      ),
    );
  }


}


