import 'dart:async';
import 'package:flutter/material.dart';


import 'AudioPlayerScreen.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'main.dart';
import 'dart:convert';

class Keyahk extends StatefulWidget{
  String title;

  Keyahk(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return KeyahkState(title);
  }
}

class KeyahkState extends State<Keyahk>{
  String title;
  var url,urlasync;
  KeyahkState(this.title);
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
      case 'ارباع ناقوس كيهك' : return 'arba3_nakoos_kyahk.mp3'; break;
      case 'هيتينيات كيهك' : return 'hitens_kyahk.mp3'; break;
      case 'مرد الابركسيس الاول لكيهك' : return 'marad_eprakcicawwel_kyahk.mp3'; break;
      case 'مرد الابركسيس الثاني لكيهك' : return 'marad_eprakcictany_kyahk.mp3'; break;
      case 'مرد الابركسيس الثالث لكيهك' : return 'marad_eprakcictalet_kyahk.mp3'; break;
      case 'مرد مزمور كيهك' : return 'mazmoor_kyahk.mp3'; break;
      case 'مرد الانجيل للاحد الاول و الثاني لكيهك' : return 'maradenggelawwalwetany_kyahk.mp3'; break;
      case 'مرد الانجيل للاحد الثالث و الرابع لكيهك' : return 'maradenggeltaletwerabe3_kyahk.mp3'; break;
      case 'اسبسمس ادام اول كيهك' : return 'aspasmos_adam_first_sunday.mp3'; break;
      case 'اسبسمس ادام ثاني كيهك' : return 'aspasmos_adam_second_sunday.mp3'; break;
      case 'اسبسمس ادام ثالث كيهك' : return 'aspasmoc_adam_talet_kyahk.mp3'; break;
      case 'اسبسمس واطس اول كيهك' : return 'aspasmos_watosawwel_keyahk.mp3'; break;
      case 'اسبسمس واطس ثاني كيهك' : return 'aspasmos_watostany_keyahk.mp3'; break;
      case 'اسبسمس واطس ثالث كيهك' : return 'apspasmoc_watos_talet_kyahk.mp3'; break;
      case 'je fcmarwout كيهك' : return 'je_efesmarowout.wav'; break;
      case 'التوزيع الكيهكي' : return 'tawzee3_keyahk.mp3'; break;
      case 'fempsa gar' : return 'ef_emebsha_ghar_kyahk.mp3'; break;
      case 'ختام صلوات كيهك' : return 'khetam_kyahk.mp3'; break;

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
            button('ارباع ناقوس كيهك'),

            button('هيتينيات كيهك'),

            button('مرد الابركسيس الاول لكيهك'),

            button('مرد الابركسيس الثاني لكيهك'),

            button('مرد الابركسيس الثالث لكيهك'),

            button('مرد مزمور كيهك'),

            button('مرد الانجيل للاحد الاول و الثاني لكيهك'),

            button('مرد الانجيل للاحد الثالث و الرابع لكيهك'),

            button('اسبسمس ادام اول كيهك'),

            button('اسبسمس ادام ثاني كيهك'),

            button('اسبسمس ادام ثالث كيهك'),

            button('اسبسمس واطس اول كيهك'),

            button('اسبسمس واطس ثاني كيهك'),

            button('اسبسمس واطس ثالث كيهك'),

            button('je fcmarwout كيهك'),

            button('التوزيع الكيهكي'),

            button('fempsa gar'),

            button('ختام صلوات كيهك'),


          ],
        ),
      ),
    );
  }


}



