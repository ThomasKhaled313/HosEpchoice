import 'dart:async';
import 'package:flutter/material.dart';
import 'AudioPlayerScreen.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'main.dart';


import 'dart:convert';

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
  AudioPlayer audio = AudioPlayer(); // BannerAd bannerAd = BannerAd(
  //     adUnitId: HomePageState.bannerAdUnitId,
  //     size: AdSize.banner,
  //     request: const AdRequest(),
  //     listener: AdListener(
  //       onAdLoaded: (Ad ad) => print('BannerAd loaded.'),
  //       onAdFailedToLoad: (Ad ad, LoadAdError error) {
  //         ad.dispose();
  //         print('BannerAd failed to load: $error');
  //       },
  //     )
  // );
  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {

    super.dispose();
  }

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

  void urlAndNavigate(text) async {
    String textContent = await getTextFileContent(text);
    print(textContent);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>AudioPlayerScreen(url,audioTitle,title,textContent)));
  }

  Future<String> getTextFileContent(text) async {
    Reference storage = FirebaseStorage.instance.ref().child("text_files").child("$text.txt");

    // Retrieve text file as a byte array
    final bytes = await storage.getData();

    // Decode the byte array to string using UTF-8 encoding
    final content = utf8.decode(bytes);

    print('Content: $content');

    return content;
  }

  getAudioName(title){
    switch(title){
      case 'qen ouswt فرايحي' : return 'khen_oushot_faray7y.mp3'; break;
      case 'أرباع ناقوس القيامة' : return 'araba3_nakoos_3eebelkeyama.mp3'; break;
      case 'السبع طرائق' : return 'saba3_tarayek.mp3'; break;
      case 'الذوكصولوجية الأولي للقيامة' : return 'tote_ron_qeyama.mp3'; break;
      case 'vyetafsans فرايحي' : return 'fyetafshansh_faray7y.mp3'; break;
      case 'ذوكصولوجية الملاك ميخائيل' : return 'ca_etanactacic.mp3'; break;
      case 'مرد انجيل باكر القيامة' : return 'maradengeel_baker_elkeyama.mp3'; break;
      case 'ختام باكر القيامة' : return '5etam_baker_qeyama.mp4'; break;
      case '`pouro فرايحي' : return 'eporo_fary7y.mp3'; break;
      case 'هيتينيات القيامة' : return 'hitens_keyama.mp3'; break;
      case 'البولس الفرايحي' : return 'bavloselfary7y.mp3'; break;
      case 'مرد ابركسيس القيامة' : return 'epraxicalqeyama.mp3'; break;
      case 'kata ni,oroc(الحجاب)' : return 'katanikhoros7egab.mp3'; break;
      case 'w nim nai cumvwnia' : return 'onemnai.mp3'; break;
      case 'يا كل الصفوف' : return 'iakwlelswfof.mp3'; break;
      case ',rictoc anecty(الطويلة) القيامة' : return 'khrectocanectylong.mp3'; break;
      case ',rictoc anecty(القصيرة) القيامة' : return 'khrectocanectyshort.mp3'; break;
      case 'ton cuna' : return 'toncena.mp3'; break;
      case 'tou li;oc' : return 'tolithoc.mp3'; break;
      case 'pi,rictoc aftwnf القيامة' : return 'pikhrictocaftwnf.mp3'; break;
      case 'محير القيامة' : return 'patchoicalqyema.mp3'; break;
      case 'مرد مزمور القيامة' : return 'maradmazmorelqeyama.mp3'; break;
      case 'مرد انجيل القيامة' : return 'libonkeyama.mp3'; break;
      case 'اسبسمس ادام القيامة الاول' : return 'apikhrictoc.mp3'; break;
      case 'اسبسمس ادام القيامة الثاني' : return 'marenhos_aspasmocadam_qeyama.mp3'; break;
      case 'اسبسمس ادام القيامة الثالث' : return 'apasmoc_thirdkeyama.mp3'; break;
      case 'اسبسمس واطس القيامة' : return 'liponavkaf.mp3'; break;
      case 'توزيع القيامة الكبير' : return 'tawzee3_33edkeyama.mp3'; break;
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
            button('qen ouswt فرايحي'),

            button('أرباع ناقوس القيامة'),

            button('السبع طرائق'),

            button('الذوكصولوجية الأولي للقيامة'),

            button('vyetafsans فرايحي'),

            button('ذوكصولوجية الملاك ميخائيل'),

            button('مرد انجيل باكر القيامة'),
            button('ختام باكر القيامة'),

            button('`pouro فرايحي'),

            button('هيتينيات القيامة'),

            button('البولس الفرايحي'),

            button('مرد ابركسيس القيامة'),

            button('kata ni,oroc(الحجاب)'),

            button('w nim nai cumvwnia'),

            button('يا كل الصفوف'),

            button(',rictoc anecty(الطويلة) القيامة'),

            button(',rictoc anecty(القصيرة) القيامة'),

            button('ton cuna'),

            button('tou li;oc'),

            button('pi,rictoc aftwnf القيامة'),

            button('محير القيامة'),

            button('مرد مزمور القيامة'),

            button('مرد انجيل القيامة'),

            button('اسبسمس ادام القيامة الاول'),

            button('اسبسمس ادام القيامة الثاني'),

            button('اسبسمس ادام القيامة الثالث'),

            button('اسبسمس واطس القيامة'),

            button('توزيع القيامة الكبير'),

            button('kata ni,oroc(التوزيع)')
          ],
        ),
      ),
    );
  }


}


