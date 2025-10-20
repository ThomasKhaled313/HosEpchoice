import 'dart:async';


import 'package:flutter/material.dart';
import 'AudioPlayerScreen.dart';
import 'colors.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';

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

  String audioTitle = ' ';
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
          color: AppColors.buttons_bg,
          borderRadius: BorderRadius.circular(8.0),
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

    final bytes = await storage.getData();
    if (bytes == null) {
      throw Exception('Failed to load text file: bytes is null');
    }
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
      case 'مرد انجيل عشية وسط' : return 'maradengeel3asheyya3adrawasat.mp3'; break;
      case 'مرد انجيل عشية دمج' : return 'maradengeel3asheyya3adradmg.mp3'; break;
      case 'مرد انجيل باكر وسط' : return 'maradengeelbaker3adrawasat.mp3'; break;
      case 'مرد انجيل باكر دمج' : return 'maradengeelbaker3adradmg.mp3'; break;
      case 'مرد انجيل قداس وسط' : return 'maradengeeloddas3adrawasat.mp3'; break;
      case 'مرد انجيل قداس دمج' : return 'maradengeeloddas3adradmg.mp3'; break;


    }
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        appBar: AppBar(
          centerTitle: true,

          // 👇 This changes the color of the back arrow (and other icons)
          iconTheme: const IconThemeData(
              color: Color(0xFFF0F0F0), // Change this to your desired color
          ),
          backgroundColor: AppColors.appbar,
          title: const Text('Home',style: TextStyle(color: Color(0xFFF0F0F0),),),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            // 👇 Background color or gradient that matches image edges
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF222121),
                Color(0xFF070707),
              ],
            ),
            image: DecorationImage(
              image: AssetImage('assets/bg.png'),
              fit: BoxFit.contain,     // ✅ show full image
              alignment: Alignment.center,
            ),
          ),
          child: GridView.count(
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

              button('a taipar;enoc'),

              button('مرد انجيل عشية وسط'),

              button('مرد انجيل عشية دمج'),

              button('مرد انجيل باكر وسط'),

              button('مرد انجيل باكر دمج'),

              button('مرد انجيل قداس وسط'),

              button('مرد انجيل قداس دمج'),
            ],
          ),
        ),
      ),
    );
  }


}


