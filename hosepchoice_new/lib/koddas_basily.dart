import 'dart:async';


import 'package:flutter/material.dart';
import 'AudioPlayerScreen.dart';
import 'colors.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';

import 'main.dart';
import 'dart:convert';

import 'AudioPlayerScreen.dart';
import 'colors.dart';

import 'package:firebase_storage/firebase_storage.dart';
class Basily extends StatefulWidget{
  String title;

  Basily(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BasilyState(title);
  }
}

class BasilyState extends State<Basily>{
  String title;
  var url,urlasync;
  BasilyState(this.title);
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

      case 'Tenouwst `mviwt' : return 'elbaraka.wav'; break;
      case 'A pinau swpi' : return 'a_pinav_shobi.mp3'; break;
      case 'اللي القربان' : return 'alli_alkorban.mp3'; break;
      case 'Allylouia je `vmeui' : return 'alleloia_jefmevi.wav'; break;
      case 'Allylouia vai pe pi' : return 'alleloia_faipepi.wav'; break;
      case 'Cw;ic' : return 'so.wav'; break;
      case 'Nicabeu tyrou' : return 'nicavev_tero.mp3'; break;
      case 'Tai soury' : return 'taishory.wav'; break;
      case ']soury' : return 'tishory.wav'; break;
      case 'الهيتينيات' : return 'hiten.wav'; break;
      case 'هيتين مارمينا' : return 'hiten_marmina.mp3'; break;
      case 'هيتين الأنبا بيشوي و الأنبا بولا' : return 'hiten_anbabeshoy_anbabola.mp3'; break;
      case 'هيتين الأنبا إبرام' : return 'hiten_anbaabraam.mp3'; break;
      case 'البولس قبطي' : return 'boles_coptic.mp3'; break;
      case 'Tou makariou' : return 'tou_makario.mp3'; break;
      case ']me]cnou]' : return 'tymetyesnoty.mp3'; break;
      case 'A petjyk ebol' : return 'apetjeekevol.mp3'; break;
      case 'الكاثوليكون قبطي' : return 'katholicon_coptic.mp3'; break;
      case 'مرد الإبركسيس الصغير' : return 'praxicsmall.mp3'; break;
      case 'مرد الإبركسيس الكبير' : return 'praxiclong.mp3'; break;
      case 'تكملة مرد الإبركسيس' : return 'takmelet_eprakcic.mp3'; break;
      case 'الإبركسيس قبطي': return 'prakcic_coptic.mp3'; break;
      case 'Va nitenh': return 'fa_ni_tenh.mp3'; break;
      case 'Agioc': return 'agioc_sanawy.mp3'; break;
      case 'A pekran': return 'apekran.mp3'; break;
      case 'المزمور قبطي': return 'mazmoor_koddas_coptic.mp3'; break;
      case 'الإنجيل قبطي': return 'el_engeel_coptic.mp3'; break;
      case 'Wouniatou': return 'ooniato.wav'; break;
      case 'Tenjoust': return 'tengosht.wav'; break;
      case 'Ounof `mmo maria': return 'onofemmo.wav'; break;
      case 'Hiten niprecbia': return 'hitennipresvia.wav'; break;
      case 'P[oic `vnou]': return 'epchoiceefnoty.wav'; break;
      case 'Ni,eroubim': return 'nisherobim.wav'; break;
      case 'Tennah](لغاية أمين أمين)': return 'takdees.wav'; break;
      case 'Tenhwc erok': return 'tenhoc.wav'; break;
      case 'مردات الأواشي': return 'awashy.wav'; break;
      case 'Eu,ec': return 'efchec.mp3'; break;
      case 'Pinis]': return 'pinishty.mp3'; break;
      case 'Pinis] الكبيرة': return 'pinishtyLarge.mp3'; break;
      case 'Ere po`cmou': return 'erepoecmo.wav'; break;
      case 'Wc peryn': return 'wcpereen.wav'; break;
      case 'من بعد كما كان': return 'tenooshtempbekcoma.wav'; break;
      case 'Ic o panagioc': return 'icobanagioc.wav'; break;
      case 'امين قبل الإعتراف' : return 'amene3teraf.mp3'; break;
      case 'المزمور 150' : return 'tawzee3.wav'; break;
      case 'Piwik `nte `pwnq' : return 'piwik.mp3'; break;
      case 'Amyn allylouia' : return 'amin_alleloia.wav'; break;
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


                button('Tenouwst `mviwt'),

                button('A pinau swpi'),

                button('اللي القربان'),

                button('Allylouia je `vmeui'),

                button('Allylouia vai pe pi'),

                button('Cw;ic'),

                button('Nicabeu tyrou'),

                button('Tai soury'),

                button(']soury'),

                button('الهيتينيات'),

                button('هيتين مارمينا'),

                button('هيتين الأنبا بيشوي و الأنبا بولا'),

                button('هيتين الأنبا إبرام'),

                button('البولس قبطي'),

                button('Tou makariou'),

                button(']me]cnou]'),

                button('A petjyk ebol'),

                button('الكاثوليكون قبطي'),

                button('مرد الإبركسيس الصغير'),

                button('مرد الإبركسيس الكبير'),

                button('تكملة مرد الإبركسيس'),

                button('الإبركسيس قبطي'),

                button('Va nitenh'),

                button('Agioc'),

                button('A pekran'),

                button('المزمور قبطي'),

                button('الإنجيل قبطي'),

                button('Wouniatou'),

                button('Tenjoust'),

                button('Ounof `mmo maria'),

                button('Hiten niprecbia'),

                button('P[oic `vnou]'),

                button('Ni,eroubim'),

                button('Tennah](لغاية أمين أمين)'),

                button('Tenhwc erok'),

                button('مردات الأواشي'),

                button('Eu,ec'),

                button('Pinis]'),

                button('Pinis] الكبيرة'),

                button('Ere po`cmou'),

                button('Wc peryn'),

                button('من بعد كما كان'),

                button('Ic o panagioc'),

                button('امين قبل الإعتراف'),

                button('المزمور 150'),

                button('Piwik `nte `pwnq'),

                button('Amyn allylouia')
              ],
            ),
          ),
      ),
    );
  }
}
