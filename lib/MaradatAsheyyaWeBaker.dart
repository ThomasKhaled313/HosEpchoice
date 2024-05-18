import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'AudioPlayerScreen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'main.dart';
import 'dart:convert';



class MaradatAsheyyaWeBaker extends StatefulWidget{
  String title;

  MaradatAsheyyaWeBaker(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MaradatAsheyyaWeBakerState(title);
  }
}

class MaradatAsheyyaWeBakerState extends State<MaradatAsheyyaWeBaker>{
  String title;
  var url,urlasync;
  MaradatAsheyyaWeBakerState(this.title);
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
      case 'Epi `proceu,y' : return 'ehPiPros.mp3'; break;
      case 'Proceuxac;e' : return 'prosEveksaste.mp3'; break;
      case 'Twbh hina الصغيرة' : return 'tobhHinaSmall.mp3'; break;
      case 'اطلبوا لكي يرحمنا الله' : return 'tobhHinaArabic.mp3'; break;
      case 'الراقدين قبطي' : return 'rakedeenCoptic.mp3'; break;
      case 'الراقدين عربي' : return 'rakedeenArabic.mp3'; break;
      case 'المرضي قبطي' : return 'mardaCoptic.mp3'; break;
      case 'المرضي عربي' : return 'mardaArabic.mp3'; break;
      case 'المسافرين قبطي' : return 'mosafereenCoptic.mp3'; break;
      case 'المسافرين عربي' : return 'mosafereenArabic.mp3'; break;
      case 'القرابين قبطي' : return 'qarabeenLarge.mp3'; break;
      case 'القرابين عربي' : return 'qarabeenArabic.mp3'; break;
      case 'Proceuxac;e `upertou' : return 'prosAngelio.mp3'; break;
      case 'صلوا من أجل الانجيل' : return 'salloMnAglElEngeel.mp3'; break;
      case 'Cta;yte metavobou' : return 'estasyte.mp3'; break;
      case 'السلامة قبطي' : return 'salamaBakerCoptic.mp3'; break;
      case 'السلامة عربي' : return 'salamaBakerArabic.mp3'; break;
      case 'الاباء قبطي' : return 'aba2BakerCoptic.mp3'; break;
      case 'الاباء عربي' : return 'aba2BakerArabic.mp3'; break;
      case 'الموضع قبطي' : return 'mawde3BakerCoptic.mp3'; break;
      case 'الموضع عربي' : return 'mawde3BakerArabic.mp3'; break;
      case 'المياه قبطي' : return 'mayyaBakerCoptic.mp3'; break;
      case 'المياه عربي' : return 'mayyaBakerArabic.mp3'; break;
      case 'الزروع و العشب قبطي' : return 'zroo3BakerCoptic.mp3'; break;
      case 'الزروع و العشب عربي' : return 'zroo3BakerArabic.mp3'; break;
      case 'الثمار قبطي' : return 'themarBakerCoptic.mp3'; break;
      case 'الثمار عربي' : return 'themarBakerArabic.mp3'; break;
      case 'الاجتماعات قبطي' : return 'egtema3atBakercoptic.mp3'; break;
      case 'الاجتماعات عربي' : return 'egetema3atBakerArabic.mp3'; break;
      case 'الختام قبطي' : return '5etamBakerCoptic.mp3'; break;




    }
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: ()async{
        Navigator.pop(context);
        return true;

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
            button('Epi `proceu,y'),
            button('Proceuxac;e'),
            button('Twbh hina الصغيرة'),
            button('اطلبوا لكي يرحمنا الله'),
            button('الراقدين قبطي'),
            button('الراقدين عربي'),
            button('المرضي قبطي'),
            button('المرضي عربي'),
            button('المسافرين قبطي'),
            button('المسافرين عربي'),
            button('القرابين قبطي'),
            button('القرابين عربي'),
            button('Proceuxac;e `upertou'),
            button('صلوا من أجل الانجيل'),
            button('Cta;yte metavobou'),
            button('السلامة قبطي'),
            button('السلامة عربي'),
            button('الاباء قبطي'),
            button('الاباء عربي'),
            button('الموضع قبطي'),
            button('الموضع عربي'),
            button('المياه قبطي'),
            button('المياه عربي'),
            button('الزروع و العشب قبطي'),
            button('الزروع و العشب عربي'),
            button('الثمار قبطي'),
            button('الثمار عربي'),
            button('الاجتماعات قبطي'),
            button('الاجتماعات عربي'),
            button('الختام قبطي'),
          ],
        ),
      ),
    );
  }


}


