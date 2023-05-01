import 'dart:async';
import 'package:flutter/material.dart';
import 'AudioPlayerScreen.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:share/share.dart';
import 'package:fluttertoast/fluttertoast.dart';
class A7adElSha3aneen extends StatefulWidget{
  String title;

  A7adElSha3aneen(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return A7adElSha3aneenState(title);
  }
}

class A7adElSha3aneenState extends State<A7adElSha3aneen>{
  String title;
  var url,urlasync;
  A7adElSha3aneenState(this.title);
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
      case 'مقدمة الذوكصولوجيات' : return 'intro_zoksolgiat_sha3aneen.mp3'; break;
      case 'الشيرات باللحن الوسط' : return 'sherat_sha3aneen_la7nelmo7ayyer.mp3'; break;
      case 'مرد انجيل عشية' : return 'marad_engeel_3asheya_sha3aneen.mp3'; break;
      case 'مرد انجيل باكر' : return 'maradengeel_baker_sha3aneen.mp3'; break;
      case 'ارباع الناقوس' : return 'arba3nakoos_a7adelsa3aneen.mp3'; break;
      case 'الذوكصولوجية الاولي' : return 'first_zoxology_a7adsha3aneen.mp3'; break;
      case 'الذوكصولوجية الثانية' : return 'second_zoxology_a7adsha3aneen.mp3'; break;
      case 'الذوكصولوجية الثالثة' : return 'third_zoxology_a7adelsa3aneen.mp3'; break;
      case 'Masenak' : return 'tar7_a7adelsha3aneen.mp3'; break;
      case 'Eulogimenoc (الصغير)' : return 'eflogimenos.mp3'; break;
      case 'Eulogimenoc (الكبير)' : return 'evlogimenos_kebeer.mp3'; break;
      case 'Rasi ounof ciwn' : return 'kanoon_elsha3aneen.mp3'; break;
      case 'مرد الابركسيس' : return 'marad_eprakcic_sha3aneen.mp3'; break;
      case 'المحير' : return 'mo7ayyer_sha3aneen.mp3'; break;
      case 'المزمور السنجاري' : return 'almazmoor_elsengary_a7adelsha3aneen.m4a'; break;
      case 'المزمور الملخص' : return 'mazmoor_sha3aneen_sanawy.mp3'; break;
      case 'مرد المزمور' : return 'marad_mazmoor_a7adsha3aneen.mp3'; break;
      case 'مرد انجيل 1' : return 'maradengeel_awwel_a7adsha3aneen.mp3'; break;
      case 'مرد انجيل 2' : return 'maradengeel_tany_a7adsha3aneen.mp3'; break;
      case 'مرد انجيل 3' : return 'maradengeel_talet_a7adsha3aneen.mp3'; break;
      case 'مرد انجيل 4' : return 'maradengeel_rabe3_a7adsha3aneen.mp3'; break;
      case 'اسبسمس ادام' : return 'aspasmocadam_a7adsha3aneen.mp3'; break;
      case 'اسبسمس واطس' : return 'aspasmoc_watos_a7adelsha3aneen.mp3'; break;
      case 'Wcanna en tic' : return 'marad_wcanna_sha3aneen.mp3'; break;
      case 'التوزيع' : return 'tawzee3_a7adsha3aneen.mp3'; break;
      case 'ارباع ناقوس التجنيز' : return 'arba3_nakoos_tagneez.mp3'; break;
      case 'Kata ehoou' : return 'kata_ehoo_tagneez.mp3'; break;
      case 'e;be ]anactacic' : return 'esvety.mp3'; break;




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
            button('الشيرات باللحن الوسط'),

            button('مرد انجيل عشية'),

            button('مرد انجيل باكر'),

            button('ارباع الناقوس'),

            button('مقدمة الذوكصولوجيات'),

            button('الذوكصولوجية الاولي'),

            button('الذوكصولوجية الثانية'),

            button('الذوكصولوجية الثالثة'),

            button('Masenak'),

            button('Eulogimenoc (الصغير)'),

            button('Eulogimenoc (الكبير)'),

            button('Rasi ounof ciwn'),

            button('مرد الابركسيس'),

            button('المحير'),

            button('المزمور السنجاري'),

            button('مرد المزمور'),

            button('مرد انجيل 1'),

            button('مرد انجيل 2'),

            button('مرد انجيل 3'),

            button('مرد انجيل 4'),

            button('المزمور الملخص'),

            button('اسبسمس ادام'),

            button('اسبسمس واطس'),

            button('Wcanna en tic'),

            button('التوزيع'),

            button('e;be ]anactacic'),

            button('ارباع ناقوس التجنيز'),

            button('Kata ehoou')
          ],
        ),
      ),
    );
  }
}


