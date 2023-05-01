import 'dart:async';
import 'package:flutter/material.dart';
import 'AudioPlayerScreen.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';

class SoomKebeer extends StatefulWidget{
  String title;

  SoomKebeer(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SoomKebeerState(title);
  }
}

class SoomKebeerState extends State<SoomKebeer>{
  String title;
  var url,urlasync;
  SoomKebeerState(this.title);
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
      case 'كيرياليسون باكر' : return 'kirilison_baker.mp3'; break;
      case 'tenoueh ncwk(1)' : return 'tenouehensok_soomelkebeer_1.mp3'; break;
      case 'tenoueh ncwk(2)' : return 'tenouehensok_soomelkebeer_2.mp3'; break;
      case 'allylouia eiei' : return 'alleloia_eiei.mp3'; break;
      case 'nefcen]' : return 'nefcenti.mp3'; break;
      case 'n;o te ]soury' : return 'ensotetyshory.mp3'; break;
      case 'sare vnou]' : return 'share_efnoty.mp3'; break;
      case 'مرد الابركسيس(احاد)' : return 'marad_eprakcic_soomkebeer.mp3'; break;
      case 'megalou ar,iereuc' : return 'megalo.mp3'; break;
      case ']hiryny' : return 'marad_engeel_soomkebeer.mp3'; break;
      case 'je peniwt' : return 'maradengeel_sobot_a7ad_soomkebeer.mp3'; break;
      case 'اسبسمس ادام' : return 'aspasmoc_adam_soomkebeer.mp3'; break;
      case 'اسبسمس واطس اول' : return 'aspasmocwatos_soomkebeer.mp3'; break;
      case 'اسبسمس واطس ثاني' : return 'aspasmoc_watos2_soomelkebeer.mp3'; break;
      case 'الذوكصولوجية 2' : return 'zoxologiat_tinestia_ayam_soomelkebeer.mp3'; break;
      case 'الذوكصولوجية 3' : return 'zoksologiat_amoinianav_soomelkebeer.mp3'; break;
      case 'الذوكصولوجية 4' : return 'zoksologiat_pimairwmi_soomelkebeer.mp3'; break;
      case 'توزيع الايام' : return 'tawze3ayam_somelkebeer.mp3'; break;
      case 'توزيع الاحاد' : return 'tawzi3a7ad_soumkeber.mp3'; break;
      case 'je fcmarwout' : return 'geefesmaro2ot_soomkebeer.mp3'; break;
      case 'pimairwmi' : return 'pimairomy.mp3'; break;
      case 'ounis]' : return 'oneshti.mp3'; break;
      case 'مزمور جمعة ختام الصوم' : return 'mazmoor_gom3et5etamsoom.mp3'; break;
      case 'مرد انجيل جمعة ختام الصوم' : return 'maradengeel_gom3et5etamsoom.mp3'; break;

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
            button('كيرياليسون باكر'),

            button('tenoueh ncwk(1)'),

            button('tenoueh ncwk(2)'),

            button('allylouia eiei'),

            button('nefcen]'),

            button('n;o te ]soury'),

            button('sare vnou]'),

            button('مرد الابركسيس(احاد)'),

            button('megalou ar,iereuc'),

            button(']hiryny'),

            button('je peniwt'),

            button('اسبسمس ادام'),

            button('اسبسمس واطس اول'),

            button('اسبسمس واطس ثاني'),

            button('الذوكصولوجية 2'),

            button('الذوكصولوجية 3'),

            button('الذوكصولوجية 4'),

            button('توزيع الايام'),

            button('توزيع الاحاد'),

            button('je fcmarwout'),

            button('pimairwmi'),

            button('ounis]'),

            button('مزمور جمعة ختام الصوم'),

            button('مرد انجيل جمعة ختام الصوم'),
          ],
        ),
      ),
    );
  }


}


