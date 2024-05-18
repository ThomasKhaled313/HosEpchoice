import 'dart:async';
import 'package:flutter/material.dart';
import 'AudioPlayerScreen.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'main.dart';
import 'dart:convert';



class Zoxologyat extends StatefulWidget{
  String title;

  Zoxologyat(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ZoxologyatState(title);
  }
}

class ZoxologyatState extends State<Zoxologyat>{
  String title;
  var url,urlasync;
  ZoxologyatState(this.title);
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
      case 'مقدمة الذوكصولوجيات' : return 'mokaddemet_zoxo.mp3'; break;
      case 'العذراء عشية' : return '3adra_3asheyya.mp3'; break;
      case 'العذراء نصف الليل' : return '3adra_noslel.mp3'; break;
      case 'العذراء باكر' : return '3adra_baker.mp3'; break;
      case 'الملاك ميخائيل' : return 'zoxo_michael.mp3'; break;
      case 'السمائيين' : return 'zoxo_sama2eyeen.mp3'; break;
      case 'يوحنا الأولي' : return 'zoxo_yohanna1.mp3'; break;
      case 'يوحنا الثانية' : return 'zoxo_yohanna2.mp3'; break;
      case 'الرسل' : return 'zoxo_rosol.mp3'; break;
      case 'مارمرقس' : return 'zoxo_markos.mp3'; break;
      case 'استفانوس' : return 'zoxo_stefanos.mp3'; break;
      case 'مارجرجس' : return 'zoxo_margirgis.mp3'; break;
      case 'مارمينا' : return 'zoxo_marmina.mp3'; break;
      case 'الانبا أنطونيوس' : return 'zoxo_anotonios.mp3'; break;
      case 'الانبا بيشوي' : return 'zoxo_anbaBishoy.mp3'; break;
      case 'الانبا ابرآم' : return 'zoxo_anbaAbraam.mp3'; break;
      case 'ختام الذوكصولوجيات' : return 'zoxo_5etam.mp3'; break;
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
            button('مقدمة الذوكصولوجيات'),
            button('العذراء عشية'),
            button('العذراء نصف الليل'),
            button('العذراء باكر'),
            button('الملاك ميخائيل'),
            button('السمائيين'),
            button('يوحنا الأولي'),
            button('يوحنا الثانية'),
            button('الرسل'),
            button('مارمرقس'),
            button('استفانوس'),
            button('مارجرجس'),
            button('مارمينا'),
            button('الانبا أنطونيوس'),
            button('الانبا بيشوي'),
            button('الانبا ابرآم'),
            button('ختام الذوكصولوجيات'),
          ],
        ),
      ),
    );
  }


}


