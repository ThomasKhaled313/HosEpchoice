import 'dart:async';


import 'package:flutter/material.dart';
import 'AudioPlayerScreen.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'main.dart';
import 'dart:convert';

class Gom3a3azeema extends StatefulWidget{
  String title;

  Gom3a3azeema(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Gom3a3azeemaState(title);
  }
}

class Gom3a3azeemaState extends State<Gom3a3azeema>{
  String title;
  var url,urlasync;
  Gom3a3azeemaState(this.title);
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
      case 'taisoury' : return 'taishory_7azayny.mp3'; break;
      case ']epictoly' : return 'tyepistole.mp3'; break;
      case 'agioc' : return 'agioc_7azayny.mp3'; break;
      case 'قطع الساعة السادسة' : return 'keta3_sadsa.mp3'; break;
      case 'o monogenyc' : return 'omonogenic.mp3'; break;
      case 'wouniatk' : return 'ooniatk.mp3'; break;
      case ']soury' : return 'tyshory_7azayny.mp3'; break;
      case 'قطع الساعة التاسعة' : return 'keta3_tas3a.mp3'; break;
      case 'pek;ronoc' : return 'pek_thronos.mp3'; break;
      case 'golgo;a' : return 'golgosa.mp3'; break;
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
            button('taisoury'),

            button(']epictoly'),

            button('agioc'),

            button('قطع الساعة السادسة'),

            button('o monogenyc'),

            button('wouniatk'),

            button(']soury'),

            button('قطع الساعة التاسعة'),

            button('pek;ronoc'),

            button('golgo;a'),

          ],
        ),
      ),
    );
  }


}


