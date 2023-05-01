import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hosepchoice/MaradatShammas.dart';
import 'koddas_basily.dart';
import 'koddas_gregory.dart';
import 'koddas_kirollosy.dart';
import 'nayrooz.dart';
import 'yohanna.dart';
import 'EedSaleeb.dart';
import 'Keyahk.dart';
import 'Mylad.dart';
import 'Ghotac.dart';
import 'KanaGaleel.dart';
import 'SoomYonan.dart';
import 'SoomKebeer.dart';
import 'Beshara.dart';
import 'SabtLe3azar.dart';
import 'A7adElSha3aneen.dart';
import 'Albas5a.dart';
import 'KhameesEl3ahd.dart';
import 'Gom3a3azeema.dart';
import 'SabtFara7.dart';
import 'EedAlQeyama.dart';
import 'AlSo3ood.dart';
import 'Al3ansara.dart';
import 'SoomElRosol.dart';
import 'ElTagally.dart';
import 'SoomEl3adra.dart';
import 'BaramonGhotac.dart';
import 'BaramonMylad.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:in_app_update/in_app_update.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  InAppUpdate.checkForUpdate().then((updateInfo) {
    if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
      if (updateInfo.immediateUpdateAllowed) {
        // Perform immediate update
        InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
          if (appUpdateResult == AppUpdateResult.success) {
            //App Update successful
          }
        });
      } else if (updateInfo.flexibleUpdateAllowed) {
        //Perform flexible update
        InAppUpdate.startFlexibleUpdate().then((appUpdateResult) {
          if (appUpdateResult == AppUpdateResult.success) {
            //App Update successful
            InAppUpdate.completeFlexibleUpdate();
          }
        });
      }
    }
  });
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage()
  ));
}

class Keys{
}

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashScreenState();
  }

}

class SplashScreenState extends State<SplashScreen> {




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 6, 3, 97),
                gradient: LinearGradient(begin: Alignment.centerRight, end: Alignment.centerLeft)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Color.fromARGB(200, 255, 255, 255),
                radius: 100.0,
                child: Image.asset('assets/m.png'),
              ),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              Text(
                'Hwc `e`p[oic',
                style: TextStyle(color: Colors.white, fontSize: 32.0,fontFamily: 'Coptic'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }

}

class HomePageState extends State<HomePage>{
  Widget whichTaks(text){
    switch(text){
      case 'القداس الباسيلي': Navigator.push(context, MaterialPageRoute(builder: (context)=> Basily(text))); break;
      case 'القداس الغريغوري': Navigator.push(context, MaterialPageRoute(builder: (context)=> Gregory(text))); break;
      case 'القداس الكيرلسي' : Navigator.push(context, MaterialPageRoute(builder: (context)=> Kirrolosy(text))); break;
      case 'مردات الشماس': Navigator.push(context, MaterialPageRoute(builder: (context)=> MaradatShammas(text))); break;
      case 'طقس عيد النيروز' :Navigator.push(context, MaterialPageRoute(builder: (context)=> Nayrooz(text))); break;
      case 'طقس أعياد يوحنا المعمدان':  Navigator.push(context, MaterialPageRoute(builder: (context)=> Yohanna(text))); break;
      case 'طقس عيد الصليب':  Navigator.push(context, MaterialPageRoute(builder: (context)=> EedSaleeb(text))); break;
      case 'طقس شهر كيهك':  Navigator.push(context, MaterialPageRoute(builder: (context)=> Keyahk(text))); break;
      case 'طقس برمون عيد الميلاد':  Navigator.push(context, MaterialPageRoute(builder: (context)=> BaramonMylad(text))); break;
      case 'طقس عيد الميلاد':  Navigator.push(context, MaterialPageRoute(builder: (context)=> Mylad(text))); break;
      case 'طقس برمون عيد الغطاس':  Navigator.push(context, MaterialPageRoute(builder: (context)=> BaramonGhotac(text))); break;
      case 'طقس عيد الغطاس':  Navigator.push(context, MaterialPageRoute(builder: (context)=> Ghotac(text))); break;
      case 'طقس عيد عُرس قانا الجليل':  Navigator.push(context, MaterialPageRoute(builder: (context)=> KanaGaleel(text))); break;
      case 'طقس صوم و فصح يونان':  Navigator.push(context, MaterialPageRoute(builder: (context)=> SoomYonan(text))); break;
      case 'طقس الصوم الكبير':  Navigator.push(context, MaterialPageRoute(builder: (context)=> SoomKebeer(text))); break;
      case 'طقس عيد البشارة':  Navigator.push(context, MaterialPageRoute(builder: (context)=> Beshara(text))); break;
      case 'طقس سبت لعازر':  Navigator.push(context, MaterialPageRoute(builder: (context)=> SabtLe3azar(text))); break;
      case 'طقس أحد الشعانين':  Navigator.push(context, MaterialPageRoute(builder: (context)=> A7adElSha3aneen(text))); break;
      case 'طقس البصخة المقدسة':  Navigator.push(context, MaterialPageRoute(builder: (context)=> AlBas5a(text))); break;
      case 'طقس خميس العهد':  Navigator.push(context, MaterialPageRoute(builder: (context)=> KhameesEl3ahd(text))); break;
      case 'طقس الجمعة العظيمة':  Navigator.push(context, MaterialPageRoute(builder: (context)=> Gom3a3azeema(text))); break;
      case 'طقس ليلة أبو غالمسيس':  Navigator.push(context, MaterialPageRoute(builder: (context)=> SabtFara7(text))); break;
      case 'طقس عيد القيامة':  Navigator.push(context, MaterialPageRoute(builder: (context)=> EedAlQeyama(text))); break;
      case 'طقس عيد الصعود':  Navigator.push(context, MaterialPageRoute(builder: (context)=> AlSo3ood(text))); break;
      case 'طقس عيد العنصرة':  Navigator.push(context, MaterialPageRoute(builder: (context)=> Al3ansara(text))); break;
      case 'طقس صوم الرسل و عيدهم':  Navigator.push(context, MaterialPageRoute(builder: (context)=> SoomElRosol(text))); break;
      case 'طقس عيد التجلي':  Navigator.push(context, MaterialPageRoute(builder: (context)=> ElTagally(text))); break;
      case 'طقس صوم العذراء و أعيادها':  Navigator.push(context, MaterialPageRoute(builder: (context)=> SoomEl3adra(text))); break;


    }
  }


  Widget button(String text, {String imagePath}) {
    return InkWell(
      onTap: () => whichTaks(text),
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 0, 0, 0),
          border: Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 2.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Stack(
          children: [
            if (imagePath != null)
              Positioned.fill(
                child: Opacity(
                  opacity: 0.4,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
      appBar: AppBar(
         backgroundColor: const Color.fromRGBO(22, 22, 22,1),

        title: const Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('القداسات',style: TextStyle(color: Colors.black,fontSize: 25)),
        Padding(
          padding: const EdgeInsets.only(left: 12.0,right: 12.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Stack(
              children: [
                CarouselSlider(
                  items: [
                    button('القداس الباسيلي',imagePath: 'assets/basyly.jpg'),
                    button('القداس الغريغوري',imagePath: 'assets/gregory.jpg'),
                    button('القداس الكيرلسي',imagePath: 'assets/kirollos.jpg'),
                    button('مردات الشماس',imagePath: 'assets/stefanos.jpg'),
                  ],
                  options: CarouselOptions(
                    height: 300,
                    autoPlay: false,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.7,
                    onPageChanged: (index, reason) => setState(() => activeIndex = index),
                  ),
                ),

              ],
            ),
          ),
        ),
            SizedBox(height: 40),
            Text('فرايحي',style: TextStyle(color: Colors.black,fontSize: 25)),
            Padding(
              padding: const EdgeInsets.only(left: 12.0,right: 12.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Stack(
                  children: [
                    CarouselSlider(
                      items: [
                        button('طقس عيد النيروز',imagePath: 'assets/nayrooz.jpg'),
                        button('طقس عيد الميلاد',imagePath: 'assets/mylad.jpg'),
                        button('طقس عيد الغطاس',imagePath: 'assets/ghotac.jpg'),
                        button('طقس عيد عُرس قانا الجليل',imagePath: 'assets/kana.jpg'),
                        button('طقس عيد البشارة',imagePath: 'assets/beshara.jpg'),
                        button('طقس عيد القيامة',imagePath: 'assets/qyama.jpg'),
                        button('طقس عيد الصعود',imagePath: 'assets/so3od.jpg'),
                        button('طقس عيد العنصرة',imagePath: 'assets/3ansara.jpg'),
                        button('طقس عيد التجلي',imagePath: 'assets/tagally.jpg'),
                      ],
                      options: CarouselOptions(
                        height: 300,
                        autoPlay: false,
                        enlargeCenterPage: true,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.7,
                        onPageChanged: (index, reason) => setState(() => activeIndex = index),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            Text('شعانيني',style: TextStyle(color: Colors.black,fontSize: 25)),
            Padding(
              padding: const EdgeInsets.only(left: 12.0,right: 12.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Stack(
                  children: [
                    CarouselSlider(
                      items: [
                        button('طقس عيد الصليب',imagePath: 'assets/saleeb.jpg'),
                        button('طقس أحد الشعانين',imagePath: 'assets/a7ad_sha3aneen.jpg'),
                      ],
                      options: CarouselOptions(
                        height: 300,
                        autoPlay: false,
                        enlargeCenterPage: true,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.7,
                        onPageChanged: (index, reason) => setState(() => activeIndex = index),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            Text('اسبوع الآلام',style: TextStyle(color: Colors.black,fontSize: 25)),
            Padding(
              padding: const EdgeInsets.only(left: 12.0,right: 12.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Stack(
                  children: [
                    CarouselSlider(
                      items: [
                        button('طقس البصخة المقدسة',imagePath: 'assets/holy_week.jpg'),
                        button('طقس خميس العهد',imagePath: 'assets/khamees_3ahd.jpg'),
                        button('طقس الجمعة العظيمة',imagePath: 'assets/gom3a.jpg'),
                        button('طقس ليلة أبو غالمسيس',imagePath: 'assets/abokalipses.jpg'),
                      ],
                      options: CarouselOptions(
                        height: 300,
                        autoPlay: false,
                        enlargeCenterPage: true,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.7,
                        onPageChanged: (index, reason) => setState(() => activeIndex = index),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            Text('برمون + مناسبات',style: TextStyle(color: Colors.black,fontSize: 25)),
            Padding(
              padding: const EdgeInsets.only(left: 12.0,right: 12.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Stack(
                  children: [
                    CarouselSlider(
                      items: [
                        button('طقس أعياد يوحنا المعمدان',imagePath: 'assets/yohanna.jpg'),
                        button('طقس شهر كيهك',imagePath: 'assets/kyahk.jpg'),
                        button('طقس برمون عيد الميلاد',imagePath: 'assets/baramonMylad.jpg'),
                        button('طقس برمون عيد الغطاس',imagePath: 'assets/baramonGhotac.jpg'),
                        button('طقس سبت لعازر',imagePath: 'assets/sabtle3azar.jpg'),
                      ],
                      options: CarouselOptions(
                        height: 300,
                        autoPlay: false,
                        enlargeCenterPage: true,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.7,
                        onPageChanged: (index, reason) => setState(() => activeIndex = index),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            Text('صوم',style: TextStyle(color: Colors.black,fontSize: 25)),
            Padding(
              padding: const EdgeInsets.only(left: 12.0,right: 12.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Stack(
                  children: [
                    CarouselSlider(
                      items: [
                        button('طقس صوم و فصح يونان',imagePath: 'assets/yonan.jpg'),
                        button('طقس الصوم الكبير',imagePath: 'assets/kbeer.jpg'),
                        button('طقس صوم العذراء و أعيادها',imagePath: 'assets/3adra.jpg'),
                        button('طقس صوم الرسل و عيدهم',imagePath: 'assets/rosol.jpg'),
                      ],
                      options: CarouselOptions(
                        height: 300,
                        autoPlay: false,
                        enlargeCenterPage: true,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.7,
                        onPageChanged: (index, reason) => setState(() => activeIndex = index),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      )
    );
  }
}



