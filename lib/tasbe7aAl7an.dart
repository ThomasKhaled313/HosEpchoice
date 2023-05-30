import 'dart:async';
import 'package:flutter/material.dart';
import 'AudioPlayerScreen.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:share/share.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Tasbe7aAl7an extends StatefulWidget{
  String title;

  Tasbe7aAl7an(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Tasbe7aAl7anState(title);
  }
}

class Tasbe7aAl7anState extends State<Tasbe7aAl7an>{
  String title;
  var url,urlasync;
  Tasbe7aAl7anState(this.title);
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
      case 'Ten;ynou' : return 'tenThinoLong.mp3'; break;
      case 'Qen ouswt' : return 'khenOuShwt.mp3'; break;
      case 'Marenouwnh' : return 'marenOuWnh.mp3'; break;
      case '`Cmou e`P[oic' : return 'esmoEpchoic.mp3'; break;
      case 'Hwc erof' : return 'hocErof.mp3'; break;
      case 'Arihou`o [acf' : return 'ari.mp3'; break;
      case '<ere ne Maria' : return 'shereTasbe7a.mp3'; break;
      case 'Cemou]' : return 'cemoutyLarge.mp3'; break;
      case 'Lipon ansan;wou]' : return 'LiponTasbe7a.mp3'; break;
      case 'لبش الجمعة' : return 'lobshGom3a.mp3'; break;
      case 'الشيرات السنوي' : return 'sheeratSanawy.mp3'; break;





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
            button('Ten;ynou'),
            button('Qen ouswt'),
            button('Marenouwnh'),
            button('`Cmou e`P[oic'),
            button('Hwc erof'),
            button('Arihou`o [acf'),
            button('<ere ne Maria'),
            button('Cemou]'),
            button('Lipon ansan;wou]'),
            button('لبش الجمعة'),
            button('الشيرات السنوي')
          ],
        ),
      ),
    );
  }


}


