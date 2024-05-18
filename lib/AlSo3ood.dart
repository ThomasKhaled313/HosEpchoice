import 'dart:async';
import 'package:flutter/material.dart';
import 'AudioPlayerScreen.dart';

import 'package:firebase_storage/firebase_storage.dart';


import 'package:audioplayers/audioplayers.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'main.dart';
import 'dart:convert';

class AlSo3ood extends StatefulWidget{
  String title;

  AlSo3ood(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AlSo3oodState(title);
  }
}

class AlSo3oodState extends State<AlSo3ood>{
  String title;
  var url,urlasync;
  AlSo3oodState(this.title);
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
      case 'أرباع ناقوس الصعود' : return 'arba3nakoos_so3ood.mp3'; break;
      case 'ذوكصولوجية الصعود' : return 'zoxology_so3ood.mp3'; break;
      case 'مرد ابركسيس الصعود' : return 'marad_eprakcic_so3ood.mp3'; break;
      case 'afrek `tve' : return 'afrek_etfe.mp3'; break;
      case ',rictoc analym(الطويلة)' : return 'khrictoc_analym_long.mp3'; break;
      case ',rictoc analym(القصيرة)' : return 'khrictoc_analym_short.mp3'; break;
      case 'pi,rictoc aftwnf الصعود' : return 'apikhrectoctonf_so3ood.mp3'; break;
      case 'مرد مزمور الصعود' : return 'marad_mazmoor_so3ood.mp3'; break;
      case 'مرد انجيل الصعود' : return 'marad_engeel_so3ood.mp3'; break;
      case 'اسبسمس ادام الصعود' : return 'aspasmoc_adam_so3ood.mp3'; break;
      case 'اسبسمس واطس ثاني الصعود' : return 'aspasmoc_watos_tany_so3ood.mp3'; break;
      case 'توزيع الصعود' : return 'tawzee3So3ood.mp3'; break;
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
            button('أرباع ناقوس الصعود'),

            button('ذوكصولوجية الصعود'),

            button('مرد ابركسيس الصعود'),

            button('afrek `tve'),

            button(',rictoc analym(الطويلة)'),

            button(',rictoc analym(القصيرة)'),

            button('pi,rictoc aftwnf الصعود'),

            button('مرد مزمور الصعود'),

            button('مرد انجيل الصعود'),

            button('اسبسمس ادام الصعود'),

            button('اسبسمس واطس ثاني الصعود'),

            button('توزيع الصعود')
          ],
        ),
      ),
    );
  }


}


