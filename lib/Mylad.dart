import 'dart:async';
import 'package:flutter/material.dart';
import 'AudioPlayerScreen.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';
class Mylad extends StatefulWidget{
  String title;

  Mylad(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyladState(title);
  }
}

class MyladState extends State<Mylad>{
  String title;
  var url,urlasync;
  MyladState(this.title);
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
      case 'السبع طرائق' : return 'saba3_tarayek.mp3'; break;
      case 'ارباع الناقوس' : return 'arba3_nakoos_3eed_mylad.mp3'; break;
      case 'pouro' : return 'eporo_fary7y.mp3'; break;
      case 'مرد انجيل عشية' : return 'maradEngeel3asheyaMilad.mp3'; break;
      case 'مرد انجيل باكر' : return 'maradEngeelBakerMilad.mp3'; break;
      case 'هيتين الميلاد' : return 'hiten_elmylad.mp3'; break;
      case 'مرد الابركسيس' : return 'marad_epracic_elmylad.mp3'; break;
      case 'y par;enoc' : return 'iparthenoc.mp3'; break;
      case 'pijinmici + gene;lion' : return 'be_gen_misi_gensilion.mp3'; break;
      case 'المحير' : return 'mo7yer_milad.mp3'; break;
      case 'مرد المزمور' : return 'marad_mazmoor_elmylad.mp3'; break;
      case 'مرد الانجيل' : return 'marad_engeel_oddas_elmylad.mp3'; break;
      case 'اسبسمس ادام اول' : return 'first_aspasmocadam_elmylad.mp3'; break;
      case 'اسبسمس ادام ثاني' : return 'second_aspasmocadam_elmylad.mp3'; break;
      case 'اسبسمس ادام ثالث' : return 'third_aspasmocadam_elmylad.mp3'; break;
      case 'اسبسمس ادام رابع' : return 'fourth_aspasmocadam_elmylad.mp3'; break;
      case 'اسبسمس واطس اول' : return 'first_aspasmocwatos_elmylad.mp3'; break;
      case 'اسبسمس واطس ثاني' : return 'second_aspasmocwatos_elmylad.mp3'; break;
      case 'التوزيع' : return 'tawzee3_milad.mp3'; break;
      case 'ختام الصلوات' : return 'khetam_elmylad.mp3'; break;
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
            button('السبع طرائق'),

            button('ارباع الناقوس'),

            button('pouro'),

            button('مرد انجيل عشية'),

            button('مرد انجيل باكر'),

            button('هيتين الميلاد'),

            button('مرد الابركسيس'),

            button('y par;enoc'),

            button('pijinmici + gene;lion'),

            button('المحير'),

            button('مرد المزمور'),

            button('مرد الانجيل'),

            button('اسبسمس ادام اول'),

            button('اسبسمس ادام ثاني'),

            button('اسبسمس ادام ثالث'),

            button('اسبسمس ادام رابع'),

            button('اسبسمس واطس اول'),

            button('اسبسمس واطس ثاني'),
            button('التوزيع'),

            button('ختام الصلوات'),
          ],
        ),
      ),
    );
  }


}


