import 'dart:async';
import 'package:flutter/material.dart';
import 'AudioPlayerScreen.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'main.dart';
import 'dart:convert';



class Tasbe7aDamgKyahk extends StatefulWidget{
  String title;

  Tasbe7aDamgKyahk(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Tasbe7aDamgKyahkState(title);
  }
}

class Tasbe7aDamgKyahkState extends State<Tasbe7aDamgKyahk>{
  String title;
  var url,urlasync;
  Tasbe7aDamgKyahkState(this.title);
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
      case 'ابصالية واطس اولي ليوم السبت' : return 'epsaly_watos1_sabt_keyahk.mp3'; break;
      case 'ابصالية واطس ثانية ليوم السبت' : return 'epsaly_watos2_sabt_keyahk.mp3'; break;
      case 'المعقب الرومي 2' : return 'romi2.mp3'; break;

      case 'امدح عذراء وبتول' : return 'amda73adraWeBatool.mp3'; break;
      case 'المعقب الرومي 3' : return 'romi3.mp3'; break;
      case 'المعقب الرومي 4' : return 'romi4.mp3'; break;
      case 'المعقب الرومي 5' : return 'romi5.mp3'; break;
      case 'المعقب الرومي 6' : return 'romi6.mp3'; break;
      case 'المعقب الرومي 7' : return 'romi7.mp3'; break;
      case 'المعقب الرومي 8' : return 'romi8.mp3'; break;
      case 'المعقب الرومي 9' : return 'romi9.mp3'; break;

      case 'تفاسير المعقب 2' : return 'moakkab2.mp3'; break;
      case 'تفاسير المعقب 3' : return 'moakkab3.mp3'; break;
      case 'تفاسير المعقب 4' : return 'moakkab4.mp3'; break;
      case 'تفاسير المعقب 5' : return 'moakkab5.mp3'; break;
      case 'تفاسير المعقب 6' : return 'moakkab6.mp3'; break;
      case 'تفاسير المعقب 7' : return 'moakkab7.mp3'; break;
      case 'تفاسير المعقب 8' : return 'moakkab8.mp3'; break;
      case 'تفاسير المعقب 9' : return 'moakkab9.mp3'; break;

      case 'التفاسير البحيري 2' : return 'behairi2.mp3'; break;
      case 'التفاسير البحيري 3' : return 'behairi3.mp3'; break;
      case 'التفاسير البحيري 4' : return 'behairi4.mp3'; break;
      case 'التفاسير البحيري 5' : return 'behairi5.mp3'; break;
      case 'التفاسير البحيري 6' : return 'behairi6.mp3'; break;
      case 'التفاسير البحيري 7' : return 'behairi7.mp3'; break;
      case 'التفاسير البحيري 8' : return 'behairi8.mp3'; break;
      case 'التفاسير البحيري 9' : return 'behairi9.mp3'; break;

      case 'التفاسير البحيري الاخري 2' : return 'behairib2.mp3'; break;
      case 'التفاسير البحيري الاخري 3' : return 'behairib3.mp3'; break;
      case 'التفاسير البحيري الاخري 4' : return 'behairib4.mp3'; break;
      case 'التفاسير البحيري الاخري 5' : return 'behairib5.mp3'; break;
      case 'التفاسير البحيري الاخري 6' : return 'behairib6.mp3'; break;
      case 'التفاسير البحيري الاخري 7' : return 'behairib7.mp3'; break;
      case 'التفاسير البحيري الاخري 8' : return 'behairib8.mp3'; break;
      case 'التفاسير البحيري الاخري 9' : return 'behairib9.mp3'; break;

      case 'التفاسير المصري 2' : return 'masry2.mp3'; break;
      case 'التفاسير المصري 3' : return 'masry3.mp3'; break;
      case 'التفاسير المصري 4' : return 'masry4.mp3'; break;
      case 'التفاسير المصري 5' : return 'masry5.mp3'; break;
      case 'التفاسير المصري 6' : return 'masry6.mp3'; break;
      case 'التفاسير المصري 7' : return 'masry7.mp3'; break;
      case 'التفاسير المصري 8' : return 'masry8.mp3'; break;
      case 'التفاسير المصري 9' : return 'masry9.mp3'; break;

      case 'التفاسير الصعيدي 1' : return 'saidi1.mp3'; break;
      case 'التفاسير الصعيدي 2' : return 'saidi2.mp3'; break;
      case 'التفاسير الصعيدي 3' : return 'saidi3.mp3'; break;
      case 'التفاسير الصعيدي 4' : return 'saidi4.mp3'; break;
      case 'التفاسير الصعيدي 5' : return 'saidi5.mp3'; break;
      case 'التفاسير الصعيدي 6' : return 'saidi6.mp3'; break;
      case 'التفاسير الصعيدي 7' : return 'saidi7.mp3'; break;
      case 'التفاسير الصعيدي 8' : return 'saidi8.mp3'; break;
      case 'التفاسير الصعيدي 9' : return 'saidi9.mp3'; break;

      case 'التفسير الاول ثيؤطوكية الاحد' : return 'firstTafseerA7ad.mp3'; break;
      case 'التفسير الثاني ثيؤطوكية الاحد' : return 'secondTafseerA7ad.mp3'; break;
      case 'التفسير الثالث ثيؤطوكية الاحد' : return 'thirdTafseerA7ad.mp3'; break;
      case 'التفسير الرابع ثيؤطوكية الاحد' : return 'fourthTafseerA7ad.mp3'; break;
      case 'التفسير الخامس ثيؤطوكية الاحد' : return 'fifthTafseerA7ad.mp3'; break;
      case 'التفسير السادس ثيؤطوكية الاحد' : return 'sixthTafseerA7ad.mp3'; break;
      case 'التفسير السابع ثيؤطوكية الاحد' : return 'seventhTafseerA7ad.mp3'; break;
      case 'التفسير الثامن ثيؤطوكية الاحد' : return 'eighthsTafseerA7ad.mp3'; break;


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
            button('ابصالية واطس اولي ليوم السبت'),

            button('ابصالية واطس ثانية ليوم السبت'),

            button('امدح عذراء وبتول'),

            button('المعقب الرومي 2'),

            button('المعقب الرومي 3'),

            button('المعقب الرومي 4'),

            button('المعقب الرومي 5'),

            button('المعقب الرومي 6'),

            button('المعقب الرومي 7'),

            button('المعقب الرومي 8'),

            button('المعقب الرومي 9'),


            button('تفاسير المعقب 2'),

            button('تفاسير المعقب 3'),

            button('تفاسير المعقب 4'),

            button('تفاسير المعقب 5'),

            button('تفاسير المعقب 6'),

            button('تفاسير المعقب 7'),

            button('تفاسير المعقب 8'),

            button('تفاسير المعقب 9'),


            button('التفاسير البحيري 2'),

            button('التفاسير البحيري 3'),

            button('التفاسير البحيري 4'),

            button('التفاسير البحيري 5'),

            button('التفاسير البحيري 6'),

            button('التفاسير البحيري 7'),

            button('التفاسير البحيري 8'),

            button('التفاسير البحيري 9'),


            button('التفاسير البحيري الاخري 2'),

            button('التفاسير البحيري الاخري 3'),

            button('التفاسير البحيري الاخري 4'),

            button('التفاسير البحيري الاخري 5'),

            button('التفاسير البحيري الاخري 6'),

            button('التفاسير البحيري الاخري 7'),

            button('التفاسير البحيري الاخري 8'),

            button('التفاسير البحيري الاخري 9'),


            button('التفاسير المصري 2'),

            button('التفاسير المصري 3'),

            button('التفاسير المصري 4'),

            button('التفاسير المصري 5'),

            button('التفاسير المصري 6'),

            button('التفاسير المصري 7'),

            button('التفاسير المصري 8'),

            button('التفاسير المصري 9'),


            button('التفاسير الصعيدي 2'),

            button('التفاسير الصعيدي 3'),

            button('التفاسير الصعيدي 4'),

            button('التفاسير الصعيدي 5'),

            button('التفاسير الصعيدي 6'),

            button('التفاسير الصعيدي 7'),

            button('التفاسير الصعيدي 8'),

            button('التفاسير الصعيدي 9'),


            button('التفسير الاول ثيؤطوكية الاحد'),
            button('التفسير الثاني ثيؤطوكية الاحد'),
            button('التفسير الثالث ثيؤطوكية الاحد'),
            button('التفسير الرابع ثيؤطوكية الاحد'),
            button('التفسير الخامس ثيؤطوكية الاحد'),
            button('التفسير السادس ثيؤطوكية الاحد'),
            button('التفسير السابع ثيؤطوكية الاحد'),
            button('التفسير الثامن ثيؤطوكية الاحد'),


          ],
        ),
      ),
    );
  }


}


