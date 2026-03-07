import 'package:flutter/material.dart';

import 'Tasbe7et3asheyya.dart';
import 'colors.dart';
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

  String audioTitle = ' ';

  Widget button(title){
    return InkWell(
      onTap: (){
        if(title == 'سنوي دمج'){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Tasbe7aDamg(title)));
        }
        else if (title == 'الذوكصولوجيات'){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Zoxologyat(title)));
        }
        else if (title == 'تسبحة عشية'){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Tasbe7et3asheyya(title)));
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
          centerTitle: true,

          // 👇 This changes the color of the back arrow (and other icons)
          iconTheme: const IconThemeData(
            color: Color(0xFFF0F0F0), // Change this to your desired color
          ),
          backgroundColor: AppColors.appbar,
          title:  Text(title,style: TextStyle(color: Color(0xFFF0F0F0),),),
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
              button('تسبحة عشية'),

              button('سنوي دمج'),

              button('سنوي الحان'),

              button('الذوكصولوجيات'),

              button('كيهكي دمج'),

              button('كيهكي الحان'),

              button('ذوكصولوجيات كيهك'),

            ],
          ),
        ),
      ),
    );
  }


}


