import 'dart:async';


import 'package:flutter/material.dart';
import 'AudioPlayerScreen.dart';
import 'colors.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';

import 'MaradatAsheyyaWeBaker.dart';
import 'main.dart';
import 'dart:convert';


import 'MaraddatKoddas.dart';
class MaradatShammas extends StatefulWidget{
  String title;

  MaradatShammas(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MaradatShammasState(title);
  }
}

class MaradatShammasState extends State<MaradatShammas>{
  String title;
  var url,urlasync;
  MaradatShammasState(this.title);

  String audioTitle = ' ';

  Widget button(title){
    return InkWell(
      onTap: (){
        if(title == 'عشية و باكر'){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MaradatAsheyyaWeBaker(title)));
        }
        else {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MaraddatKoddas(title)));
        }
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
          iconTheme: const IconThemeData(
            color: Color(0xFFF0F0F0), // Change this to your desired color
          ),
          backgroundColor: AppColors.appbar,


          title: Text(title,style: TextStyle(color: Colors.white),),
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
              button('عشية و باكر'),

              button('القداس'),

            ],
          ),
        ),
      ),
    );
  }


}


