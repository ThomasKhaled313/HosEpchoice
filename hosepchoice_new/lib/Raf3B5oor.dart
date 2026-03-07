import 'dart:async';
import 'package:flutter/material.dart';
import 'AudioPlayerScreen.dart';
import 'colors.dart';

import 'package:firebase_storage/firebase_storage.dart';



import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';

import 'main.dart';

class Raf3B5oor extends StatefulWidget{
  String title;

  Raf3B5oor(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Raf3B5oorState(title);
  }
}

class Raf3B5oorState extends State<Raf3B5oor>{
  String title;
  var url,urlasync;
  Raf3B5oorState(this.title);
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
      case 'Qen pi,rictoc iycouc' : return 'khen_pikhrictoc_sanawy.mp3'; break;
      case 'أرباع الناقوس الأدام' : return 'araba3_nakoos_adam.mp3'; break;
      case 'أرباع الناقوس الواطس' : return 'arba3_nakoos_watos.mp3'; break;
      case 'بقية أرباع الناقوس' : return 'rest_arba3_nakoos.mp3'; break;
      case 'مقدمة الذوكصولوجيات' : return 'mokaddemet_zoxo.mp3'; break;
      case 'العذراء عشية' : return '3adra_3asheyya.mp3'; break;
      case 'العذراء نصف الليل' : return '3adra_noslel.mp3'; break;
      case 'العذراء باكر' : return '3adra_baker.mp3'; break;
      case 'الملاك ميخائيل' : return 'zoxo_michael.mp3'; break;
      case 'السمائيين' : return 'zoxo_sama2eyeen.mp3'; break;
      case 'يوحنا الأولي' : return 'zoxo_yohanna1.mp3'; break;
      case 'يوحنا الثانية' : return 'zoxo_yohanna2.mp3'; break;
      case 'الرسل' : return 'zoxo_rosol.mp3'; break;
      case 'مارمرقس' : return 'zoxo_markos.mp3'; break;
      case 'استفانوس' : return 'zoxo_stefanos.mp3'; break;
      case 'مارجرجس' : return 'zoxo_margirgis.mp3'; break;
      case 'مارمينا' : return 'zoxo_marmina.mp3'; break;
      case 'الانبا أنطونيوس' : return 'zoxo_anotonios.mp3'; break;
      case 'الانبا بيشوي' : return 'zoxo_anbaBishoy.mp3'; break;
      case 'الانبا ابرآم' : return 'zoxo_anbaAbraam.mp3'; break;
      case 'ختام الذوكصولوجيات' : return 'zoxo_5etam.mp3'; break;
      case 'Amyn allylouia' : return 'amin_alleloia.wav'; break;
      case 'Epi `proceu,y' : return 'ehPiPros.mp3'; break;
      case 'Proceuxac;e' : return 'prosEveksaste.mp3'; break;
      case 'Twbh hina الصغيرة' : return 'tobhHinaSmall.mp3'; break;
      case 'اطلبوا لكي يرحمنا الله' : return 'tobhHinaArabic.mp3'; break;
      case 'الراقدين قبطي' : return 'rakedeenCoptic.mp3'; break;
      case 'الراقدين عربي' : return 'rakedeenArabic.mp3'; break;
      case 'المرضي قبطي' : return 'mardaCoptic.mp3'; break;
      case 'المرضي عربي' : return 'mardaArabic.mp3'; break;
      case 'المسافرين قبطي' : return 'mosafereenCoptic.mp3'; break;
      case 'المسافرين عربي' : return 'mosafereenArabic.mp3'; break;
      case 'القرابين قبطي' : return 'qarabeenLarge.mp3'; break;
      case 'القرابين عربي' : return 'qarabeenArabic.mp3'; break;
      case 'Proceuxac;e `upertou' : return 'prosAngelio.mp3'; break;
      case 'صلوا من أجل الانجيل' : return 'salloMnAglElEngeel.mp3'; break;
      case 'Cta;yte metavobou' : return 'estasyte.mp3'; break;
      case 'السلامة قبطي' : return 'salamaBakerCoptic.mp3'; break;
      case 'السلامة عربي' : return 'salamaBakerArabic.mp3'; break;
      case 'الاباء قبطي' : return 'aba2BakerCoptic.mp3'; break;
      case 'الاباء عربي' : return 'aba2BakerArabic.mp3'; break;
      case 'الموضع قبطي' : return 'mawde3BakerCoptic.mp3'; break;
      case 'الموضع عربي' : return 'mawde3BakerArabic.mp3'; break;
      case 'المياه قبطي' : return 'mayyaBakerCoptic.mp3'; break;
      case 'المياه عربي' : return 'mayyaBakerArabic.mp3'; break;
      case 'الزروع و العشب قبطي' : return 'zroo3BakerCoptic.mp3'; break;
      case 'الزروع و العشب عربي' : return 'zroo3BakerArabic.mp3'; break;
      case 'الثمار قبطي' : return 'themarBakerCoptic.mp3'; break;
      case 'الثمار عربي' : return 'themarBakerArabic.mp3'; break;
      case 'الاجتماعات قبطي' : return 'egtema3atBakercoptic.mp3'; break;
      case 'الاجتماعات عربي' : return 'egetema3atBakerArabic.mp3'; break;
      case 'الختام قبطي' : return '5etamBakerCoptic.mp3'; break;
      case 'مزمور العشية السنوي' : return 'jehafcaji_3adra.mp3'; break;
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
              button('Qen pi,rictoc iycouc'),

              button('أرباع الناقوس الأدام'),

              button('أرباع الناقوس الواطس'),

              button('بقية أرباع الناقوس'),
              button('مزمور العشية السنوي'),
              button('Epi `proceu,y'),
              button('Proceuxac;e'),
              button('Twbh hina الصغيرة'),
              button('اطلبوا لكي يرحمنا الله'),
              button('الراقدين قبطي'),
              button('الراقدين عربي'),
              button('المرضي قبطي'),
              button('المرضي عربي'),
              button('المسافرين قبطي'),
              button('المسافرين عربي'),
              button('القرابين قبطي'),
              button('القرابين عربي'),
              button('Proceuxac;e `upertou'),
              button('صلوا من أجل الانجيل'),
              button('Cta;yte metavobou'),
              button('السلامة قبطي'),
              button('السلامة عربي'),
              button('الاباء قبطي'),
              button('الاباء عربي'),
              button('الموضع قبطي'),
              button('الموضع عربي'),
              button('المياه قبطي'),
              button('المياه عربي'),
              button('الزروع و العشب قبطي'),
              button('الزروع و العشب عربي'),
              button('الثمار قبطي'),
              button('الثمار عربي'),
              button('الاجتماعات قبطي'),
              button('الاجتماعات عربي'),
              button('الختام قبطي'),


              button('مقدمة الذوكصولوجيات'),
              button('العذراء عشية'),
              button('العذراء نصف الليل'),
              button('العذراء باكر'),
              button('الملاك ميخائيل'),
              button('السمائيين'),
              button('يوحنا الأولي'),
              button('يوحنا الثانية'),
              button('الرسل'),
              button('مارمرقس'),
              button('استفانوس'),
              button('مارجرجس'),
              button('مارمينا'),
              button('الانبا أنطونيوس'),
              button('الانبا بيشوي'),
              button('الانبا ابرآم'),
              button('ختام الذوكصولوجيات'),

              button('Amyn allylouia'),
            ],
          ),
        ),
      ),
    );
  }


}


