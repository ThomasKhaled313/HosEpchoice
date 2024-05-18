import 'dart:async';
import 'package:flutter/material.dart';
import 'AudioPlayerScreen.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'main.dart';


import 'dart:convert';

class Ghotac extends StatefulWidget{
  String title;

  Ghotac(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GhotacState(title);
  }
}

class GhotacState extends State<Ghotac>{
  String title;
  var url,urlasync;
  GhotacState(this.title);
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
      case 'ارباع ناقوس الغطاس' : return 'arba3_nakoos_ghetac.mp3'; break;
      case 'هيتينيات الغطاس' : return 'hiten_ghotac.mp3'; break;
      case 'مرد الابركسيس (قداس الغطاس)' : return 'marad_eprakcic_koddas_ghotac.mp3'; break;
      case 'مرد الإنجيل (قداس الغطاس)' : return 'marad_engeel_koddas_ghotac.mp3'; break;
      case 'مرد الإنجيل (لقان الغطاس)' : return 'marad_engeel_lakkan_ghotac.mp3'; break;
      case 'اسبسمس ادام (قداس + لقان الغطاس)' : return 'aspasmoc_adam_ghotac.mp3'; break;
      case 'اسبسمس واطس (قداس الغطاس)' : return 'aspasmoc_watos_ghotac.mp3'; break;
      case 'Ouran nsousou' : return 'oranenshosho_ghotac.mp3'; break;
      case 'توزيع الغطاس' : return 'tawzee3_ghotac.mp3'; break;
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
            button('ارباع ناقوس الغطاس'),

            button('هيتينيات الغطاس'),

            button('مرد الابركسيس (قداس الغطاس)'),

            button('مرد الإنجيل (لقان الغطاس)'),

            button('مرد الإنجيل (قداس الغطاس)'),

            button('اسبسمس ادام (قداس + لقان الغطاس)'),

            button('اسبسمس واطس (قداس الغطاس)'),

            button('Ouran nsousou'),
            button('توزيع الغطاس'),

          ],
        ),
      ),
    );
  }


}


