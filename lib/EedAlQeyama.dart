import 'dart:async';
import 'package:flutter/material.dart';
import 'AudioPlayerScreen.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';
class EedAlQeyama extends StatefulWidget{
  String title;

  EedAlQeyama(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EedAlQeyamaState(title);
  }
}

class EedAlQeyamaState extends State<EedAlQeyama>{
  String title;
  var url,urlasync;
  EedAlQeyamaState(this.title);
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
      case 'qen ouswt' : return 'khen_oushot_faray7y.mp3'; break;
      case 'أرباع ناقوس القيامة' : return 'araba3_nakoos_3eebelkeyama.mp3'; break;
      case 'السبع طرائق' : return 'saba3_tarayek.mp3'; break;
      case 'الذوكصولوجية الأولي' : return 'tote_ron_qeyama.mp3'; break;
      case 'vyetafsans' : return 'fyetafshansh_faray7y.mp3'; break;
      case 'ذوكصولوجية الملاك ميخائيل' : return 'ca_etanactacic.mp3'; break;
      case 'مرد انجيل باكر' : return 'maradengeel_baker_elkeyama.mp3'; break;
      case 'ختام باكر' : return '5etam_baker_qeyama.mp4'; break;
      case '`pouro' : return 'eporo_fary7y.mp3'; break;
      case 'الهيتينيات' : return 'hitens_keyama.mp3'; break;
      case 'البولس الفرايحي' : return 'bavloselfary7y.mp3'; break;
      case 'مرد الابركسيس' : return 'epraxicalqeyama.mp3'; break;
      case 'kata ni,oroc(الحجاب)' : return 'katanikhoros7egab.mp3'; break;
      case 'w nim nai cumvwnia' : return 'onemnai.mp3'; break;
      case 'يا كل الصفوف' : return 'iakwlelswfof.mp3'; break;
      case ',rictoc anecty(الطويلة)' : return 'khrectocanectylong.mp3'; break;
      case ',rictoc anecty(القصيرة)' : return 'khrectocanectyshort.mp3'; break;
      case 'ton cuna' : return 'toncena.mp3'; break;
      case 'tou li;oc' : return 'tolithoc.mp3'; break;
      case 'pi,rictoc aftwnf' : return 'pikhrictocaftwnf.mp3'; break;
      case 'المحير' : return 'patchoicalqyema.mp3'; break;
      case 'مرد المزمور' : return 'maradmazmorelqeyama.mp3'; break;
      case 'مرد الانجيل' : return 'libonkeyama.mp3'; break;
      case 'الاسبسمس الادام الاول' : return 'apikhrictoc.mp3'; break;
      case 'الاسبسمس الادام الثاني' : return 'marenhos_aspasmocadam_qeyama.mp3'; break;
      case 'الاسبسمس الادام الثالث' : return 'apasmoc_thirdkeyama.mp3'; break;
      case 'الاسبسمس الواطس' : return 'liponavkaf.mp3'; break;
      case 'التوزيع الكبير' : return 'tawzee3_33edkeyama.mp3'; break;
      case 'kata ni,oroc(التوزيع)' : return 'katani_khoros_small.mp3'; break;

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
            button('qen ouswt'),

            button('أرباع ناقوس القيامة'),

            button('السبع طرائق'),

            button('الذوكصولوجية الأولي'),

            button('vyetafsans'),

            button('ذوكصولوجية الملاك ميخائيل'),

            button('مرد انجيل باكر'),
            button('ختام باكر'),

            button('`pouro'),

            button('الهيتينيات'),

            button('البولس الفرايحي'),

            button('مرد الابركسيس'),

            button('kata ni,oroc(الحجاب)'),

            button('w nim nai cumvwnia'),

            button('يا كل الصفوف'),

            button(',rictoc anecty(الطويلة)'),

            button(',rictoc anecty(القصيرة)'),

            button('ton cuna'),

            button('tou li;oc'),

            button('pi,rictoc aftwnf'),

            button('المحير'),

            button('مرد المزمور'),

            button('مرد الانجيل'),

            button('الاسبسمس الادام الاول'),

            button('الاسبسمس الادام الثاني'),

            button('الاسبسمس الادام الثالث'),

            button('الاسبسمس الواطس'),

            button('التوزيع الكبير'),

            button('kata ni,oroc(التوزيع)')
          ],
        ),
      ),
    );
  }


}


