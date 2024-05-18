import 'dart:async';
import 'package:flutter/material.dart';
import 'AudioPlayerScreen.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'main.dart';


import 'dart:convert';


class SoomKebeer extends StatefulWidget{
  String title;

  SoomKebeer(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SoomKebeerState(title);
  }
}

class SoomKebeerState extends State<SoomKebeer>{
  String title;
  var url,urlasync;
  SoomKebeerState(this.title);
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
      case 'كيرياليسون باكر' : return 'kirilison_baker.mp3'; break;
      case 'tenoueh ncwk(1) الصيامي' : return 'tenouehensok_soomelkebeer_1.mp3'; break;
      case 'tenoueh ncwk(2) الصيامي' : return 'tenouehensok_soomelkebeer_2.mp3'; break;
      case 'allylouia eiei' : return 'alleloia_eiei.mp3'; break;
      case 'nefcen]' : return 'nefcenti.mp3'; break;
      case 'n;o te ]soury' : return 'ensotetyshory.mp3'; break;
      case 'sare vnou]' : return 'share_efnoty.mp3'; break;
      case 'مرد الابركسيس(احاد)' : return 'marad_eprakcic_soomkebeer.mp3'; break;
      case 'megalou ar,iereuc' : return 'megalo.mp3'; break;
      case ']hiryny' : return 'marad_engeel_soomkebeer.mp3'; break;
      case 'je peniwt' : return 'maradengeel_sobot_a7ad_soomkebeer.mp3'; break;
      case 'اسبسمس ادام الصوم الكبير' : return 'aspasmoc_adam_soomkebeer.mp3'; break;
      case 'اسبسمس واطس الصوم الكبير الاول' : return 'aspasmocwatos_soomkebeer.mp3'; break;
      case 'اسبسمس واطس الصوم الكبير الثاني' : return 'aspasmoc_watos2_soomelkebeer.mp3'; break;
      case 'الذوكصولوجية الاولي للصوم الكبير' : return 'zoksologiat_neknai_soomelkebeer.mp3'; break;
      case 'الذوكصولوجية الثانية للصوم الكبير' : return 'zoxologiat_tinestia_ayam_soomelkebeer.mp3'; break;
      case 'الذوكصولوجية الثالثة للصوم الكبير' : return 'zoksologiat_amoinianav_soomelkebeer.mp3'; break;
      case 'الذوكصولوجية الرابعة للصوم الكبير' : return 'zoksologiat_pimairwmi_soomelkebeer.mp3'; break;
      case 'الذوكصولوجية الخامسة للصوم الكبير' : return 'zoksologiat_tynestia_kbeera_soomelkebeer.mp3'; break;
      case 'توزيع ايام الصوم الكبير' : return 'tawze3ayam_somelkebeer.mp3'; break;
      case 'توزيع احاد الصوم الكبير' : return 'tawzi3a7ad_soumkeber.mp3'; break;
      case 'je fcmarwout الصيامي' : return 'geefesmaro2ot_soomkebeer.mp3'; break;
      case 'pimairwmi' : return 'pimairomy.mp3'; break;
      case 'ounis]' : return 'oneshti.mp3'; break;
      case 'قانون ختام للصوم الكبير' : return 'khetam_soom_kbeer.mp3'; break;
      case 'مزمور جمعة ختام الصوم' : return 'mazmoor_gom3et5etamsoom.mp3'; break;
      case 'مرد انجيل جمعة ختام الصوم' : return 'maradengeel_gom3et5etamsoom.mp3'; break;

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
            button('كيرياليسون باكر'),

            button('tenoueh ncwk(1) الصيامي'),

            button('tenoueh ncwk(2) الصيامي'),

            button('allylouia eiei'),

            button('nefcen]'),

            button('n;o te ]soury'),

            button('sare vnou]'),

            button('مرد الابركسيس(احاد)'),

            button('megalou ar,iereuc'),

            button(']hiryny'),

            button('je peniwt'),

            button('اسبسمس ادام الصوم الكبير'),

            button('اسبسمس واطس الصوم الكبير الاول'),

            button('اسبسمس واطس الصوم الكبير الثاني'),

            button('الذوكصولوجية الاولي للصوم الكبير'),

            button('الذوكصولوجية الثانية للصوم الكبير'),

            button('الذوكصولوجية الثالثة للصوم الكبير'),

            button('الذوكصولوجية الرابعة للصوم الكبير'),

            button('الذوكصولوجية الخامسة للصوم الكبير'),

            button('توزيع ايام الصوم الكبير'),

            button('توزيع احاد الصوم الكبير'),

            button('je fcmarwout الصيامي'),

            button('pimairwmi'),

            button('ounis]'),

            button('قانون ختام الصوم الكبير'),

            button('مزمور جمعة ختام الصوم'),

            button('مرد انجيل جمعة ختام الصوم'),
          ],
        ),
      ),
    );
  }


}


