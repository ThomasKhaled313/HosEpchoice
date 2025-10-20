import 'dart:async';
import 'package:flutter/material.dart';
import 'AudioPlayerScreen.dart';
import 'colors.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';

import 'main.dart';
import 'dart:convert';



class SoomYonan extends StatefulWidget{
  String title;

  SoomYonan(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SoomYonanState(title);
  }
}

class SoomYonanState extends State<SoomYonan>{
  String title;
  var url,urlasync;
  SoomYonanState(this.title);
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
      case 'ذوكصولوجية صوم يونان' : return 'zoksologiet_yonan.mp3'; break;
      case 'مرد انجيل باكر الإثنين' : return 'maradengeel_bakeretneen_yonan.mp3'; break;
      case 'مرد انجيل قداس الإثنين' : return 'maradengeel_koddasetneen_yonan.mp3'; break;
      case 'مرد انجيل باكر الثلاثاء' : return 'maradengeel_bakertalat_yonan.mp3'; break;
      case 'مرد انجيل قداس الثلاثاء' : return 'maradengeel_koddastalat_yonan.mp3'; break;
      case 'مرد انجيل باكر الاربعاء' : return 'maradengeel_bakerarba3_yonan.mp3'; break;
      case 'مرد انجيل قداس الاربعاء' : return 'maradengeel_koddasarba3_yonan.mp3'; break;
      case 'مرد انجيل باكر الخميس' : return 'maradengeel_baker5amees_yonan.mp3'; break;
      case 'مرد انجيل قداس الخميس' : return 'maradengeel_koddas5amees_yonan.mp3'; break;
      case 'هيتينية صوم يونان' : return 'hiten_yonan.mp3'; break;
      case 'iwna piprovytyc' : return 'tawzee3_yonan.mp3'; break;

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
              button('ذوكصولوجية صوم يونان'),

              button('مرد انجيل باكر الإثنين'),

              button('مرد انجيل قداس الإثنين'),

              button('مرد انجيل باكر الثلاثاء'),

              button('مرد انجيل قداس الثلاثاء'),

              button('مرد انجيل باكر الاربعاء'),

              button('مرد انجيل قداس الاربعاء'),

              button('مرد انجيل باكر الخميس'),

              button('مرد انجيل قداس الخميس'),

              button('هيتينية صوم يونان'),

              button('iwna piprovytyc')
            ],
          ),
        ),
      ),
    );
  }


}


