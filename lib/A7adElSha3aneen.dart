import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'AudioPlayerScreen.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'main.dart';
import 'dart:convert';




import 'main.dart';
class A7adElSha3aneen extends StatefulWidget{
  String title;

  A7adElSha3aneen(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return A7adElSha3aneenState(title);
  }
}

class A7adElSha3aneenState extends State<A7adElSha3aneen>{
  String title;
  var url,urlasync;
  A7adElSha3aneenState(this.title);
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
      case 'مقدمة الذوكصولوجيات' : return 'intro_zoksolgiat_sha3aneen.mp3'; break;
      case 'الشيرات باللحن الوسط' : return 'sherat_sha3aneen_la7nelmo7ayyer.mp3'; break;
      case 'مرد انجيل عشية الشعانين' : return 'marad_engeel_3asheya_sha3aneen.mp3'; break;
      case 'مرد انجيل باكر الشعانين' : return 'maradengeel_baker_sha3aneen.mp3'; break;
      case 'ارباع ناقوس الشعانين' : return 'arba3nakoos_a7adelsa3aneen.mp3'; break;
      case 'الذوكصولوجية الاولي للشعانين' : return 'first_zoxology_a7adsha3aneen.mp3'; break;
      case 'الذوكصولوجية الثانية للشعانين' : return 'second_zoxology_a7adsha3aneen.mp3'; break;
      case 'الذوكصولوجية الثالثة للشعانين' : return 'third_zoxology_a7adelsa3aneen.mp3'; break;
      case 'Masenak' : return 'tar7_a7adelsha3aneen.mp3'; break;
      case 'Eulogimenoc (الصغير)' : return 'eflogimenos.mp3'; break;
      case 'Eulogimenoc (الكبير)' : return 'evlogimenos_kebeer.mp3'; break;
      case 'Rasi ounof ciwn' : return 'kanoon_elsha3aneen.mp3'; break;
      case 'مرد ابركسيس الشعانين' : return 'marad_eprakcic_sha3aneen.mp3'; break;
      case 'محير الشعانين' : return 'mo7ayyer_sha3aneen.mp3'; break;
      case 'المزمور السنجاري للشعانين' : return 'almazmoor_elsengary_a7adelsha3aneen.m4a'; break;
      case 'المزمور الملخص للشعانين' : return 'mazmoor_sha3aneen_sanawy.mp3'; break;
      case 'مرد مزمور الشعانين' : return 'marad_mazmoor_a7adsha3aneen.mp3'; break;
      case 'مرد اول انجيل الشعانين' : return 'maradengeel_awwel_a7adsha3aneen.mp3'; break;
      case 'مرد ثاني انجيل الشعانين' : return 'maradengeel_tany_a7adsha3aneen.mp3'; break;
      case 'مرد ثالث انجيل الشعانين' : return 'maradengeel_talet_a7adsha3aneen.mp3'; break;
      case 'مرد رابع انجيل الشعانين' : return 'maradengeel_rabe3_a7adsha3aneen.mp3'; break;
      case 'اسبسمس ادام الشعانين' : return 'aspasmocadam_a7adsha3aneen.mp3'; break;
      case 'اسبسمس واطس الشعانين' : return 'aspasmoc_watos_a7adelsha3aneen.mp3'; break;
      case 'Wcanna en tic' : return 'marad_wcanna_sha3aneen.mp3'; break;
      case 'توزيع الشعانين' : return 'tawzee3_a7adsha3aneen.mp3'; break;
      case 'ارباع ناقوس التجنيز' : return 'arba3_nakoos_tagneez.mp3'; break;
      case 'Kata ehoou' : return 'kata_ehoo_tagneez.mp3'; break;
      case 'e;be ]anactacic' : return 'esvety.mp3'; break;




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
            button('الشيرات باللحن الوسط'),

            button('مرد انجيل عشية الشعانين'),

            button('مرد انجيل باكر الشعانين'),

            button('ارباع ناقوس الشعانين'),

            button('مقدمة الذوكصولوجيات'),

            button('الذوكصولوجية الاولي للشعانين'),

            button('الذوكصولوجية الثانية للشعانين'),

            button('الذوكصولوجية الثالثة للشعانين'),

            button('Masenak'),

            button('Eulogimenoc (الصغير)'),

            button('Eulogimenoc (الكبير)'),

            button('Rasi ounof ciwn'),

            button('مرد ابركسيس الشعانين'),

            button('محير الشعانين'),

            button('المزمور السنجاري للشعانين'),

            button('مرد مزمور الشعانين'),

            button('مرد اول انجيل الشعانين'),

            button('مرد ثاني انجيل الشعانين'),

            button('مرد ثالث انجيل الشعانين'),

            button('مرد رابع انجيل الشعانين'),

            button('المزمور الملخص للشعانين'),

            button('اسبسمس ادام الشعانين'),

            button('اسبسمس واطس الشعانين'),

            button('Wcanna en tic'),

            button('توزيع الشعانين'),

            button('e;be ]anactacic'),

            button('ارباع ناقوس التجنيز'),

            button('Kata ehoou')
          ],
        ),
      ),
    );
  }
}


