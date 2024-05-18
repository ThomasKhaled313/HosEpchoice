import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'main.dart';
import 'tasbe7aAl7an.dart';
import 'tasbe7aAl7anKyahk.dart';
import 'tasbe7aDamg.dart';
import 'tasbe7aDamgKyahk.dart';
import 'Zoxologyat.dart';
import 'ZoxologyatKyahk.dart';


class Tasbe7a extends StatefulWidget{
  String title;

  Tasbe7a(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Tasbe7aState(title);
  }
}

class Tasbe7aState extends State<Tasbe7a>{
  String title;
  var url,urlasync;
  Tasbe7aState(this.title);

  String audioTitle;

  Widget button(title){
    return InkWell(
      onTap: (){
        if(title == 'سنوي دمج'){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Tasbe7aDamg(title)));
        }
        else if (title == 'الذوكصولوجيات'){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Zoxologyat(title)));
        }
        else if(title == 'سنوي الحان'){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Tasbe7aAl7an(title)));
        }
        if(title == 'كيهكي دمج'){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Tasbe7aDamgKyahk(title)));
        }
        else if (title == 'ذوكصولوجيات كيهك'){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ZoxologyatKyahk(title)));
        }
        else if(title == 'كيهكي الحان'){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Tasbe7aAl7anKyahk(title)));
        }
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
            button('سنوي دمج'),

            button('سنوي الحان'),

            button('الذوكصولوجيات'),

            button('كيهكي دمج'),

            button('كيهكي الحان'),

            button('ذوكصولوجيات كيهك'),

          ],
        ),
      ),
    );
  }


}


