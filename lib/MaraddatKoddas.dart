import 'dart:async';
import 'package:flutter/material.dart';
import 'AudioPlayerScreen.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'main.dart';
import 'dart:convert';



class MaraddatKoddas extends StatefulWidget{
  String title;

  MaraddatKoddas(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MaraddatKoddasState(title);
  }
}

class MaraddatKoddasState extends State<MaraddatKoddas>{
  String title;
  var url,urlasync;
  MaraddatKoddasState(this.title);
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
      case 'دورة الحمل' : return 'dawret7amalCoptic.mp3'; break;
      case 'Ic patyr الصغيرة' : return 'smallIspatir.mp3'; break;
      case 'Ic patyr عربي' : return 'smallIspatirArabic.mp3'; break;
      case 'Ic patyr الكبيرة' : return 'bigIspatir.mp3'; break;
      case 'Epi `proceu,y' : return 'ehPiPros.mp3'; break;
      case 'Proceuxac;e' : return 'prosEveksaste.mp3'; break;
      case 'Twbh hina الصغيرة' : return 'smallTwbhHinaCoptic.mp3'; break;
      case 'Twbh hina الكبيرة' : return 'largeTwbhHina.mp3'; break;
      case 'اطلبوا لكي يرحمنا الله' : return 'smallTwbhHinaArabic.mp3'; break;
      case 'En covia' : return 'encofiaCoptic.mp3'; break;
      case 'En covia عربي' : return 'encofiaArabic.mp3'; break;
      case 'مرد صلاة الصلح قبطي' : return 'sol7BasiliyCoptic.mp3'; break;
      case 'مرد صلاة الصلح عربي' : return 'sol7BasiliyArabic.mp3'; break;
      case 'مرد صلاة الصلح الغريغوري' : return 'sol7GregoryArabic.mp3'; break;
      case 'Acpazec;e الصغيرة' : return 'aspazecteSmallCoptic.mp3'; break;
      case 'قبلوا الصغيرة' : return 'aspazecteSmallArabic.mp3'; break;
      case 'Acpazec;e الكبيرة' : return 'aspazecteLargeCoptic.mp3'; break;
      case 'قبلوا الكبيرة' : return 'aspazecteLargeArabic.mp3'; break;
      case 'I ka;ymeni' : return 'ekathymeny.mp3'; break;
      case 'Ic anatolac' : return 'icAnatolac.mp3'; break;
      case 'Proc,wmen' : return 'proc5omen.mp3'; break;
      case 'أيها الجلوس' : return 'ayohaGloos.mp3'; break;
      case 'إلي الشرق' : return 'ilaSharq.mp3'; break;
      case 'ننصت' : return 'nanset.mp3'; break;
      case 'ننصت الغريغوري' : return 'proc5omenGregory.mp3'; break;
      case 'Ouwst `mvnou]' : return 'owshtemfnoty.mp3'; break;
      case 'إسجدوا لله' : return 'esgodohlelah.mp3'; break;
      case 'Procqwmen amyn' : return 'proc5omenAmen.mp3'; break;
      case 'ننصت أمين' : return 'esgodohlelah.mp3'; break;
      case 'السلامة قبطي' : return 'salamaOddasCoptic.mp3'; break;
      case 'السلامة عربي' : return 'salamaOddasArabic.mp3'; break;
      case 'الاباء قبطي' : return 'aba2OddasCoptic.mp3'; break;
      case 'الاباء عربي' : return 'aba2OddasArabic.mp3'; break;
      case 'القمامصة قبطي' : return 'shamamsaOddasCoptic.mp3'; break;
      case 'القمامصة عربي' : return 'shamamsaOddasArabic.mp3'; break;
      case 'الموضع قبطي' : return 'mawde3OddasCoptic.mp3'; break;
      case 'الموضع عربي' : return 'mawde3OddasArabic.mp3'; break;
      case 'المياه قبطي' : return 'mayyaOddasCoptic.mp3'; break;
      case 'المياه عربي' : return 'mayyaOddasArabic.mp3'; break;
      case 'الثمار قبطي' : return 'themarOddasCoptic.mp3'; break;
      case 'الثمار عربي' : return 'themarOddasArabic.mp3'; break;
      case 'الزروع قبطي' : return 'zroo3OddasCoptic.mp3'; break;
      case 'الزروع عربي' : return 'zroo3OddasArabic.mp3'; break;
      case 'القرابين قبطي' : return 'qarabeenOddasCoptic.mp3'; break;
      case 'القرابين عربي' : return 'qarabeenOddasArabic.mp3'; break;
      case 'Nyetws maoutaoy`o' : return 'nyEtwsh.mp3'; break;
      case 'القارئون فليقولوا' : return 'alQare2oon.mp3'; break;
      case 'Amyn amyn proceuxac;e' : return 'amenamenCoptic.mp3'; break;
      case 'أمين أمين صلوا' : return 'amenamenArabic.mp3'; break;
      case 'Tac kevalac' : return 'tacKeFalas.mp3'; break;
      case 'Proc,wmen ;eou' : return 'proc5omenTheo.mp3'; break;
      case 'Cw;ic amyn' : return 'cwticAmen.mp3'; break;
      case 'خلصت حقاً' : return 'cwticAmenArabic.mp3'; break;
      case 'الاعتراف الصغير قبطي' : return 'e3terafSmallCoptic.mp3'; break;
      case 'الاعتراف الصغير عربي' : return 'e3terafSmallArabic.mp3'; break;
      case 'الاعتراف الكبير قبطي' : return 'e3terafLargeCoptic.mp3'; break;
      case 'الاعتراف الكبير عربي' : return 'e3terafLargeArabic.mp3'; break;

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
            button('دورة الحمل'),
            button('Ic patyr الصغيرة'),
            button('Ic patyr عربي'),
            button('Ic patyr الكبيرة'),
            button('Epi `proceu,y'),
            button('Proceuxac;e'),
            button('Twbh hina الصغيرة'),
            button('اطلبوا لكي يرحمنا الله'),
            button('Twbh hina الكبيرة'),
            button('En covia'),
            button('En covia عربي'),
            button('مرد صلاة الصلح قبطي'),
            button('مرد صلاة الصلح عربي'),
            button('مرد صلاة الصلح الغريغوري'),
            button('Acpazec;e الصغيرة'),
            button('قبلوا الصغيرة'),
            button('Acpazec;e الكبيرة'),
            button('قبلوا الكبيرة'),
            button('I ka;ymeni'),
            button('أيها الجلوس'),
            button('Ic anatolac'),
            button('إلي الشرق'),
            button('Proc,wmen'),
            button('ننصت'),
            button('ننصت الغريغوري'),
            button('Ouwst `mvnou]'),
            button('إسجدوا لله'),
            button('Procqwmen amyn'),
            button('ننصت أمين'),
            button('السلامة قبطي'),
            button('السلامة عربي'),
            button('الاباء قبطي'),
            button('الاباء عربي'),
            button('القمامصة قبطي'),
            button('القمامصة عربي'),
            button('الموضع قبطي'),
            button('الموضع عربي'),
            button('المياه قبطي'),
            button('المياه عربي'),
            button('الثمار قبطي'),
            button('الثمار عربي'),
            button('الزروع قبطي'),
            button('الزروع عربي'),
            button('Nyetws maoutaoy`o'),
            button('القارئون فليقولوا'),
            button('Amyn amyn proceuxac;e'),
            button('أمين أمين صلوا'),
            button('Tac kevalac'),
            button('Proc,wmen ;eou'),
            button('Cw;ic amyn'),
            button('خلصت حقاً'),
            button('الاعتراف الصغير قبطي'),
            button('الاعتراف الصغير عربي'),
            button('الاعتراف الكبير قبطي'),
            button('الاعتراف الكبير عربي'),




          ],
        ),
      ),
    );
  }


}


