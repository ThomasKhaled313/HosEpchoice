import 'dart:async';


import 'package:flutter/material.dart';
import 'AudioPlayerScreen.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'main.dart';
import 'dart:convert';

class SoomEl3adra extends StatefulWidget{
  String title;

  SoomEl3adra(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SoomEl3adraState(title);
  }
}

class SoomEl3adraState extends State<SoomEl3adra>{
  String title;
  var url,urlasync;
  SoomEl3adraState(this.title);
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
    //
  }

  @override
  void dispose() {
    // bannerAd.dispose();
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
      case 'je aucaji' : return 'jehafcaji_3adra.mp3'; break;
      case ',ere ;eotoke' : return 'shere_theotoke.mp3'; break;
      case 'agioc ictin' : return 'agioc_ictin_3adra.mp3'; break;
      case 'ari`precbeuin' : return 'ariebresvevin.mp3'; break;
      case 'sasf `ncop' : return 'shashf_ensob.mp3'; break;
      case 'deute' : return 'zefte_bandees.mp3'; break;
      case 'rasi ne' : return 'rashine_3adra.mp3'; break;
      case 'cena`tso' : return 'cenaetsho.mp3'; break;
      case 'vai pe plumen' : return 'faibeblimen_3adra.mp3'; break;
      case '`n;o `;mau' : return 'enso_ethmaf_3adra.mp3'; break;
      case 'a taipar;enoc' : return 'a_tai_parthenoc_3adra.mp3'; break;


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
            button('je aucaji'),

            button(',ere ;eotoke'),

            button('agioc ictin'),

            button('ari`precbeuin'),

            button('sasf `ncop'),

            button('deute'),

            button('rasi ne'),

            button('cena`tso'),

            button('vai pe plumen'),

            button('`n;o `;mau'),

            button('a taipar;enoc')
          ],
        ),
      ),
    );
  }


}


