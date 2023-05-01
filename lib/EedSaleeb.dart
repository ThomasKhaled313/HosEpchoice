import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:share/share.dart';
import 'AudioPlayerScreen.dart';
class EedSaleeb extends StatefulWidget{
  String title;

  EedSaleeb(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EedSaleebState(title);
  }
}

class EedSaleebState extends State<EedSaleeb>{
  String title;
  var url,urlasync;
  EedSaleebState(this.title);
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
      case 'ارباع الناقوس' : return 'arba3_nakoos_saleeb.mp3'; break;
      case 'مقدمة الذوكصولوجيات' : return 'intro_zoksolgiat_sha3aneen.mp3'; break;
      case 'مردات اناجيل الدورة' : return 'maradat_anageel_dawra_baker.mp3'; break;
      case 'هيتينيات' : return 'hitens_3eedsaleeb.mp3'; break;
      case 'مرد الابركسيس' : return 'marad_eprakcic_3eedsaleeb.mp3'; break;
      case 'etau``en ni`cqai' : return 'etafEniEskhai.mp3'; break;
      case 'مرد الانجيل' : return 'maradengeel_3eedsaleeb.mp3'; break;
      case 'الاسبسمس الادام' : return 'aspasmoc_adam_3eedsaleeb.mp3'; break;
      case 'الاسبسمس الواطس' : return 'aspasmoc_watos_3eedsaleeb.mp3'; break;
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
            button('مقدمة الذوكصولوجيات'),

            button('مردات اناجيل الدورة'),

            button('هيتينيات'),

            button('مرد الابركسيس'),

            button('etau``en ni`cqai'),

            button('مرد الانجيل'),

            button('الاسبسمس الادام'),

            button('الاسبسمس الواطس'),
          ],
        ),
      ),
    );
  }


}




