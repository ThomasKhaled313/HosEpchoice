import 'dart:async';
import 'package:flutter/material.dart';
import 'AudioPlayerScreen.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'main.dart';
import 'dart:convert';



class Tasbe7aDamg extends StatefulWidget{
  String title;

  Tasbe7aDamg(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Tasbe7aDamgState(title);
  }
}

class Tasbe7aDamgState extends State<Tasbe7aDamg>{
  String title;
  var url,urlasync;
  Tasbe7aDamgState(this.title);
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
      case 'Ten;ynou' : return 'tenThinoDamg.mp3'; break;
      case 'Tennau' : return 'tennav.mp3'; break;
      case 'الهوس الأول' : return 'FirstHos.mp3'; break;
      case 'الهوس الثاني' : return 'SecondHos.mp3'; break;
      case 'الهوس الثالث' : return 'ThirdHos.mp3'; break;
      case 'Ari\'alin' : return 'Aripsalin.mp3'; break;
      case 'المجمع' : return 'Magma3.mp3'; break;
      case 'الهوس الرابع' : return 'FourthHos.mp3'; break;
      case 'ابصالية الجمعة' : return 'epsaliGom3a.mp3'; break;
      case 'ابصالية السبت' : return 'epsaliSabt.mp3'; break;
      case 'Ainah] ابصالية' : return 'ainahty.mp3'; break;
      case 'Aikw] ابصالية' : return 'aikwty.mp3'; break;
      case 'ثيؤطوكية الجمعة' : return 'theoktokyaGom3a.mp3'; break;
      case 'ثيؤطوكية الاحد ق1' : return 'part1.mp3'; break;
      case 'ثيؤطوكية الاحد ق2' : return 'part2.mp3'; break;
      case 'ثيؤطوكية الاحد ق3' : return 'part3.mp3'; break;
      case 'ثيؤطوكية الاحد ق4' : return 'part4.mp3'; break;
      case 'ثيؤطوكية الاحد ق5' : return 'part5.mp3'; break;
      case 'ثيؤطوكية الاحد ق6' : return 'part6.mp3'; break;
      case 'ثيؤطوكية الاحد ق7' : return 'part7.mp3'; break;
      case 'ثيؤطوكية الاحد ق8' : return 'part8.mp3'; break;
      case 'ثيؤطوكية الاحد ق9' : return 'part9.mp3'; break;
      case 'ثيؤطوكية الاحد ق10' : return 'part10.mp3'; break;
      case 'ثيؤطوكية الاحد ق11' : return 'part11.mp3'; break;
      case 'ثيؤطوكية الاحد ق12' : return 'part12.mp3'; break;
      case 'ثيؤطوكية الاحد ق13' : return 'part13.mp3'; break;
      case 'ثيؤطوكية الاحد ق14' : return 'part14.mp3'; break;
      case 'ثيؤطوكية الاحد ق15' : return 'part15.mp3'; break;
      case 'Nim gar' : return 'nimghar.mp3'; break;
      case 'W Pen[oic' : return 'wPenchoic.mp3'; break;
      case 'Neknai w Panou]' : return 'nekNaiWPanoty.mp3'; break;





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
            button('Ten;ynou'),
            button('Tennau'),
            button('الهوس الأول'),
            button('الهوس الثاني'),
            button('الهوس الثالث'),
            button('Ari\'alin'),
            button('المجمع'),
            button('الهوس الرابع'),
            button('ابصالية الجمعة'),
            button('ثيؤطوكية الجمعة'),
            button('ابصالية السبت'),
            button('Ainah] ابصالية'),
            button('Aikw] ابصالية'),
            button('ثيؤطوكية الاحد ق1'),
            button('ثيؤطوكية الاحد ق2'),
            button('ثيؤطوكية الاحد ق3'),
            button('ثيؤطوكية الاحد ق4'),
            button('ثيؤطوكية الاحد ق5'),
            button('ثيؤطوكية الاحد ق6'),
            button('ثيؤطوكية الاحد ق7'),
            button('ثيؤطوكية الاحد ق8'),
            button('ثيؤطوكية الاحد ق9'),
            button('ثيؤطوكية الاحد ق10'),
            button('ثيؤطوكية الاحد ق11'),
            button('ثيؤطوكية الاحد ق12'),
            button('ثيؤطوكية الاحد ق13'),
            button('ثيؤطوكية الاحد ق14'),
            button('ثيؤطوكية الاحد ق15'),
            button('Nim gar'),
            button('W Pen[oic'),
            button('Neknai w Panou]'),
          ],
        ),
      ),
    );
  }


}


