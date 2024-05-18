import 'dart:async';
import 'package:flutter/material.dart';
import 'AudioPlayerScreen.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'main.dart';
import 'dart:convert';



class Tasbe7aAl7an extends StatefulWidget{
  String title;

  Tasbe7aAl7an(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Tasbe7aAl7anState(title);
  }
}

class Tasbe7aAl7anState extends State<Tasbe7aAl7an>{
  String title;
  var url,urlasync;
  Tasbe7aAl7anState(this.title);
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
      case 'اللي العصر' : return 'allyEl3asr.mp3'; break;
      case 'Ten;ynou' : return 'tenThinoLong.mp3'; break;
      case 'Qen ouswt' : return 'khenOuShwt.mp3'; break;
      case 'Marenouwnh' : return 'marenOuWnh.mp3'; break;
      case '`Cmou e`P[oic' : return 'esmoEpchoic.mp3'; break;
      case 'Hwc erof' : return 'hocErof.mp3'; break;
      case 'Arihou`o [acf' : return 'ari.mp3'; break;
      case 'Tenoueh `ncwk' : return 'tenowehEncwk.mp3'; break;
      case ',ere ne Maria' : return 'shereTasbe7a.mp3'; break;
      case 'Cemou]' : return 'cemoutyLarge.mp3'; break;
      case 'Loipon ansan;wou]' : return 'LiponTasbe7a.mp3'; break;
      case 'Teoi `nhikanoc' : return 'Teoi_Large.mp3'; break;
      case ']par;enoc' : return 'typarthenosTasbe7a.mp3'; break;
      case 'Piouai' : return 'piouai.mp3'; break;
      case 'Areten;wn]' : return 'aretenthonty.mp3'; break;
      case 'لبش الجمعة' : return 'lobshGom3a.mp3'; break;
      case 'الشيرات السنوي' : return 'sheeratSanawy.mp3'; break;
      case 'Auen piar,yereuc' : return 'avenpiArshi.mp3'; break;
      case 'Afswlem erof' : return 'afshwlem.mp3'; break;
      case 'Ebol hiten Maria الصغيرة' : return 'evolHitenSmall.mp3'; break;
      case 'Ebol hiten Maria الكبير' : return 'evolHitenLong.mp3'; break;
      case 'Ouon ouhelpic' : return 'ouOnOuHelbis.mp3'; break;





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
            button('اللي العصر'),
            button('Ten;ynou'),
            button('Qen ouswt'),
            button('Marenouwnh'),
            button('`Cmou e`P[oic'),
            button('Hwc erof'),
            button('Arihou`o [acf'),
            button('Tenoueh `ncwk'),
            button(',ere ne Maria'),
            button('Cemou]'),
            button('Loipon ansan;wou]'),
            button('Teoi `nhikanoc'),
            button(']par;enoc'),
            button('Piouai'),
            button('Areten;wn]'),
            button('لبش الجمعة'),
            button('الشيرات السنوي'),
            button('Auen piar,yereuc'),
            button('Afswlem erof'),
            button('Ebol hiten Maria الصغيرة'),
            button('Ebol hiten Maria الكبير'),
            button('Ouon ouhelpic')
          ],
        ),
      ),
    );
  }


}


