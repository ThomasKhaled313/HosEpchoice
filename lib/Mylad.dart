import 'dart:async';
import 'package:flutter/material.dart';
import 'AudioPlayerScreen.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'main.dart';


import 'dart:convert';

class Mylad extends StatefulWidget{
  String title;

  Mylad(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyladState(title);
  }
}

class MyladState extends State<Mylad>{
  String title;
  var url,urlasync;
  MyladState(this.title);
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
      case 'السبع طرائق' : return 'saba3_tarayek.mp3'; break;
      case 'ارباع ناقوس الميلاد' : return 'arba3_nakoos_3eed_mylad.mp3'; break;
      case '`pouro فرايحي' : return 'eporo_fary7y.mp3'; break;
      case 'مرد انجيل عشية الميلاد' : return 'maradEngeel3asheyaMilad.mp3'; break;
      case 'مرد انجيل باكر الميلاد' : return 'maradEngeelBakerMilad.mp3'; break;
      case 'هيتين الميلاد' : return 'hiten_elmylad.mp3'; break;
      case 'مرد ابركسيس الميلاد' : return 'marad_epracic_elmylad.mp3'; break;
      case 'y par;enoc' : return 'iparthenoc.mp3'; break;
      case 'pijinmici + gene;lion' : return 'be_gen_misi_gensilion.mp3'; break;
      case 'محير الميلاد' : return 'mo7yer_milad.mp3'; break;
      case 'مرد مزمور الميلاد' : return 'marad_mazmoor_elmylad.mp3'; break;
      case 'مرد انجيل الميلاد' : return 'marad_engeel_oddas_elmylad.mp3'; break;
      case 'اسبسمس ادام اول الميلاد' : return 'first_aspasmocadam_elmylad.mp3'; break;
      case 'اسبسمس ادام ثاني الميلاد' : return 'second_aspasmocadam_elmylad.mp3'; break;
      case 'اسبسمس ادام ثالث الميلاد' : return 'third_aspasmocadam_elmylad.mp3'; break;
      case 'اسبسمس ادام رابع الميلاد' : return 'fourth_aspasmocadam_elmylad.mp3'; break;
      case 'اسبسمس واطس اول الميلاد' : return 'first_aspasmocwatos_elmylad.mp3'; break;
      case 'اسبسمس واطس ثاني الميلاد' : return 'second_aspasmocwatos_elmylad.mp3'; break;
      case 'توزيع الميلاد' : return 'tawzee3_milad.mp3'; break;
      case 'ختام صلوات الميلاد' : return 'khetam_elmylad.mp3'; break;
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
            button('السبع طرائق'),

            button('ارباع ناقوس الميلاد'),

            button('`pouro فرايحي'),

            button('مرد انجيل عشية الميلاد'),

            button('مرد انجيل باكر الميلاد'),

            button('هيتين الميلاد'),

            button('مرد ابركسيس الميلاد'),

            button('y par;enoc'),

            button('pijinmici + gene;lion'),

            button('محير الميلاد'),

            button('مرد مزمور الميلاد'),

            button('مرد انجيل الميلاد'),

            button('اسبسمس ادام اول الميلاد'),

            button('اسبسمس ادام ثاني الميلاد'),

            button('اسبسمس ادام ثالث الميلاد'),

            button('اسبسمس ادام رابع الميلاد'),

            button('اسبسمس واطس اول الميلاد'),

            button('اسبسمس واطس ثاني الميلاد'),
            button('توزيع الميلاد'),

            button('ختام صلوات الميلاد'),
          ],
        ),
      ),
    );
  }


}


