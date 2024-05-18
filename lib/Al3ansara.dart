import 'dart:async';
import 'package:flutter/material.dart';
import 'AudioPlayerScreen.dart';

import 'package:firebase_storage/firebase_storage.dart';



import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'main.dart';
class Al3ansara extends StatefulWidget{
  String title;

  Al3ansara(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Al3ansaraState(title);
  }
}

class Al3ansaraState extends State<Al3ansara>{
  String title;
  var url,urlasync;
  Al3ansaraState(this.title);
  AudioPlayer audio = AudioPlayer();
   // BannerAd bannerAd = BannerAd(
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
      case 'أرباع ناقوس العنصرة' : return 'arba3_nakoos_3ansara.mp3'; break;
      case 'مرد ابركسيس العنصرة' : return 'marad_eprakcic_3ansara.mp3'; break;
      case 'العنصرة Pi,rictoc aftwnf' : return 'pikhrictoc_aftonf_3ansara.mp3'; break;
      case 'قطع الساعة الثالثة العنصرة' : return 'keta3_eltalta_3ansara.mp3'; break;
      case 'محير العنصرة' : return 'mo7ayyer_3ansara.mp3'; break;
      case 'Pipneuma' : return 'piebnevma_3ansara.mp3'; break;
      case 'مرد مزمور العنصرة' : return 'marad_mazmoor_3ansara.mp3'; break;
      case 'مرد انجيل العنصرة' : return 'marad_engeel_3ansara.mp3'; break;


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
            button('أرباع ناقوس العنصرة'),

            button('العنصرة Pi,rictoc aftwnf'),

            button('مرد ابركسيس العنصرة'),

            button('قطع الساعة الثالثة العنصرة'),

            button('محير العنصرة'),

            button('Pipneuma'),

            button('مرد مزمور العنصرة'),

            button('مرد انجيل العنصرة')
          ],
        ),
      ),
    );
  }


}


