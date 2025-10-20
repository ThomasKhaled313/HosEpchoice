import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'AudioPlayerScreen.dart';
import 'audio_handler.dart';
import 'colors.dart';
import 'ChooseCategory.dart';
import 'HymnSearch.dart';
import 'MaradatShammas.dart';
import 'Tasbe7a.dart';
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


late final MyAudioHandler audioHandler;

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  audioHandler = await AudioService.init(
    builder: () => MyAudioHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.hosepchoice.channel.audio',
      androidNotificationChannelName: 'Hos Epchoice Audio',
      androidNotificationOngoing: true,
    ),
  );
  await Firebase.initializeApp();

  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen(),));
}

class Keys {}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  double _progress = 0.0;
  Timer? _timer;

  void _startLoading() {
    _timer = Timer.periodic(Duration(milliseconds: 30), (Timer timer) {
      setState(() {
        _progress += 0.01;
        if (_progress >= 1.0) {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer to avoid memory leaks
    _controller.dispose();
    super.dispose();
  }
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  void initState() {
    super.initState();
    _startLoading();
// Animation controller for the glowing color
    _controller = AnimationController(
      duration: const Duration(seconds: 2), vsync: this,
    )..repeat(reverse: true);

    // Animate between two cool blue-cyan tones
    _colorAnimation = ColorTween(
      begin: const Color(0xFF26C6DA), // cyan
      end: const Color(0xFF00E5FF), // lighter cyan glow
    ).animate(_controller);
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ChooseCategory()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // 🔹 Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF221E1F),
                  Color(0xFF131112),
                  Color(0xFF010101),
                ],
              ),
            ),
          ),

          // 🔹 Foreground content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // ✅ Full image, centered, not cropped
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Image.asset(
                  'assets/m.png',
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.55,
                ),
              ),

              const SizedBox(height: 30),

              // 🔹 Animated glowing progress bar
              AnimatedBuilder(
                animation: _colorAnimation,
                builder: (context, child) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: _colorAnimation.value!.withOpacity(0.5),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: _progress,
                        minHeight: 6,
                        backgroundColor: const Color(0xFF1E2F40),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _colorAnimation.value!,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );


  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  // Platform messages are asynchronous, so we initialize in an async method.

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget whichTaks(text) {
    switch (text) {
      case 'القداس الباسيلي':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Basily(text)));
        break;
      case 'القداس الغريغوري':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Gregory(text)));
        break;
      case 'القداس الكيرلسي':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Kirrolosy(text)));
        break;
      case 'مردات الشماس':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MaradatShammas(text)));
        break;
      case 'تسبحة نصف الليل':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Tasbe7a(text)));
        break;
      case 'طقس عيد النيروز':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Nayrooz(text)));
        break;
      case 'طقس أعياد يوحنا المعمدان':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Yohanna(text)));
        break;
      case 'طقس عيد الصليب':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => EedSaleeb(text)));
        break;
      case 'طقس شهر كيهك':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Keyahk(text)));
        break;
      case 'طقس برمون عيد الميلاد':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => BaramonMylad(text)));
        break;
      case 'طقس عيد الميلاد':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Mylad(text)));
        break;
      case 'طقس برمون عيد الغطاس':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => BaramonGhotac(text)));
        break;
      case 'طقس عيد الغطاس':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Ghotac(text)));
        break;
      case 'طقس عيد عُرس قانا الجليل':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => KanaGaleel(text)));
        break;
      case 'طقس صوم و فصح يونان':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SoomYonan(text)));
        break;
      case 'طقس الصوم الكبير':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SoomKebeer(text)));
        break;
      case 'طقس عيد البشارة':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Beshara(text)));
        break;
      case 'طقس سبت لعازر':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SabtLe3azar(text)));
        break;
      case 'طقس أحد الشعانين':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => A7adElSha3aneen(text)));
        break;
      case 'طقس البصخة المقدسة':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AlBas5a(text)));
        break;
      case 'طقس خميس العهد':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => KhameesEl3ahd(text)));
        break;
      case 'طقس الجمعة العظيمة':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Gom3a3azeema(text)));
        break;
      case 'طقس ليلة أبو غالمسيس':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SabtFara7(text)));
        break;
      case 'طقس عيد القيامة':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EedAlQeyama(text)));
        break;
      case 'طقس عيد الصعود':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AlSo3ood(text)));
        break;
      case 'طقس عيد العنصرة':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Al3ansara(text)));
        break;
      case 'طقس صوم الرسل و عيدهم':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SoomElRosol(text)));
        break;
      case 'طقس عيد التجلي':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ElTagally(text)));
        break;
      case 'طقس صوم العذراء و أعيادها':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SoomEl3adra(text)));
        break;
    }
    return Center();
  }

  Widget button(String text, {String imagePath = ""}) {
    return InkWell(
      onTap: () => whichTaks(text),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 300, // Adjust as needed for carousel
        height: 150,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          boxShadow: [
            /*BoxShadow(
              color: Colors.black.withOpacity(0.9),
              blurRadius: 1,
              offset: Offset(0, 4),
            ),*/
          ],
        ),
        child: Stack(
          children: [
            // Background image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: imagePath.isNotEmpty
                  ? Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    )
                  : Container(
                      color: Colors.grey[900],
                    ),
            ),

            // Dark overlay for text readability
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
            ),

            // Centered text
            /*Positioned(
              bottom: 10,
              right: 10,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black45,
                      blurRadius: 4,
                      offset: Offset(1, 2),
                    )
                  ],
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  int activeIndex = 0;
  String query = "";
  @override
  Widget build(BuildContext context) {
    final filteredButtons = hymns.where((hymn) {
      final List<String> aliases = List<String>.from(hymn.aliases);
      return aliases.any((alias) =>
          alias.toLowerCase().contains(query.toLowerCase()));
    }).toList();
  print(filteredButtons);
    final pageStateMap = <String, dynamic Function(String)>{
      'طقس أحد الشعانين': (page) => A7adElSha3aneenState(page),
      'طقس عيد العنصرة': (page) => Al3ansaraState(page),
      'طقس البصخة المقدسة': (page) => AlBas5aState(page),
      'القداس الباسيلي': (page) => BasilyState(page),
      'القداس الغريغوري': (page) => GregoryState(page),
      'القداس الكيرلسي': (page) => KirrolosyState(page),
      'طقس عيد النيروز': (page) => NayroozState(page),
      'طقس عيد الميلاد': (page) => MyladState(page),
      'طقس عيد الغطاس': (page) => GhotacState(page),
      'طقس عيد عُرس قانا الجليل': (page) => KanaGaleelState(page),
      'طقس عيد البشارة': (page) => BesharaState(page),
      'طقس عيد القيامة': (page) => EedAlQeyamaState(page),
      'طقس عيد الصعود': (page) => AlSo3oodState(page),
      'طقس عيد التجلي': (page) => ElTagallyState(page),
      'طقس عيد الصليب': (page) => EedSaleebState(page),
      'طقس الجمعة العظيمة': (page) => Gom3a3azeemaState(page),
      'طقس خميس العهد': (page) => KhameesEl3ahdState(page),
      'طقس ليلة أبو غالمسيس': (page) => SabtFara7State(page),
      'طقس أعياد يوحنا المعمدان': (page) => YohannaState(page),
      'طقس شهر كيهك': (page) => KeyahkState(page),
      'طقس برمون عيد الميلاد': (page) => BaramonMyladState(page),
      'طقس برمون عيد الغطاس': (page) => BaramonGhotacState(page),
      'طقس سبت لعازر': (page) => SabtLe3azarState(page),
      'طقس صوم و فصح يونان': (page) => SoomYonanState(page),
      'طقس الصوم الكبير': (page) => SoomKebeerState(page),
      'طقس صوم العذراء و أعيادها': (page) => SoomEl3adraState(page),
      'طقس صوم الرسل و عيدهم': (page) => SoomElRosolState(page),



      // Add all other pages here
    };
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,

          // 👇 This changes the color of the back arrow (and other icons)
          iconTheme: const IconThemeData(
            color: Color(0xFFF0F0F0), // Change this to your desired color
          ),
          backgroundColor: AppColors.appbar,
          title: const Text(
            'Home',
            style: TextStyle(
              color: Color(0xFFF0F0F0),
            ),
          ),
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
          child: Stack(textDirection: TextDirection.rtl, children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'ابحث عن لحن ...',
                        suffixIcon: Icon(Icons.search, color: Colors.grey[700]),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          query = value;
                        });
                      },
                    ),
                  ),
                ),
                if (query.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredButtons.length,
                      itemBuilder: (context, index) {
                        final btn = filteredButtons[index];
                        return Directionality(
                          textDirection: TextDirection.ltr,
                          child: Card(
                            color: AppColors.buttons_bg, // background color of the card
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                            child: ListTile(
                              subtitle: Text(
                                btn.page,
                                style: const TextStyle(
                                  color: AppColors.textGold,
                                  fontSize: 14,
                                ),
                              ),
                              title: Text(
                                btn.title[0].toUpperCase() + btn.title.substring(1),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textLight,
                                  fontFamily: 'Coptic',
                                ),
                              ),
                              onTap: () async {
                                final hymnTitle = btn.title;
                                final page = btn.page;

                                if (page == btn.page) {
                                  // 1. Create an instance of the page state helper
                                  final tempState = pageStateMap[btn.page]!(btn.page);

                                  // 2. Fetch audio URL
                                  final url = await tempState.getAudioUrl(hymnTitle);

                                  // 3. Fetch hymn text
                                  final textContent = await tempState.getTextFileContent(hymnTitle);
                                  print('$url - --- $textContent');

                                  // 4. Navigate directly to AudioPlayerScreen
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => AudioPlayerScreen(
                                        url,
                                        hymnTitle,   // audioTitle
                                        hymnTitle,   // display title
                                        textContent,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          )

                        );
                      },
                    ),
                  )

                else
                  Expanded(
                      child: SingleChildScrollView(
                          child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0, top: 12.0),
                      child: Text(
                        'القداسات',
                        style: TextStyle(
                          fontFamily: 'Cairo', // Or any spiritual-looking font
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                                color: Colors.black45,
                                blurRadius: 4,
                                offset: Offset(1, 2))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        child: Stack(
                          children: [

                            CarouselSlider(
                              items: [
                                button('القداس الباسيلي',
                                    imagePath: 'assets/odas basili.png'),
                                button('القداس الغريغوري',
                                    imagePath: 'assets/odas ghrighory.png'),
                                button('القداس الكيرلسي',
                                    imagePath: 'assets/odas kirolosy.png'),
                                button('مردات الشماس',
                                    imagePath: 'assets/maradat shamas.png'),
                                button('تسبحة نصف الليل',
                                    imagePath: 'assets/tasbe7a.png'),
                              ],
                              options: CarouselOptions(
                                  height: 160,
                                  viewportFraction: 0.7,
                                  enableInfiniteScroll: true,
                                  enlargeCenterPage: true,
                                  initialPage: 0,
                                  padEnds: true),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0, top: 12.0),
                      child: Text(
                        'فرايحي',
                        style: TextStyle(
                          fontFamily: 'Cairo', // Or any spiritual-looking font
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                                color: Colors.black45,
                                blurRadius: 4,
                                offset: Offset(1, 2))
                          ],
                        ),
                      ),
                    ),
                            SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        child: Stack(
                          children: [
                            CarouselSlider(
                              items: [
                                button('طقس عيد النيروز',
                                    imagePath: 'assets/Nayrooz.png'),
                                button('طقس عيد الميلاد',
                                    imagePath: 'assets/milad.png'),
                                button('طقس عيد الغطاس',
                                    imagePath: 'assets/ghetas.png'),
                                button('طقس عيد عُرس قانا الجليل',
                                    imagePath: 'assets/qana el galil.png'),
                                button('طقس عيد البشارة',
                                    imagePath: 'assets/beshara.png'),
                                button('طقس عيد القيامة',
                                    imagePath: 'assets/keyama.png'),
                                button('طقس عيد الصعود',
                                    imagePath: 'assets/so3ood.png'),
                                button('طقس عيد العنصرة',
                                    imagePath: 'assets/3ansara.png'),
                                button('طقس عيد التجلي',
                                    imagePath: 'assets/tagali.png'),
                              ],
                              options: CarouselOptions(
                                  height: 160,
                                  viewportFraction: 0.7,
                                  enableInfiniteScroll: true,
                                  enlargeCenterPage: true,
                                  initialPage: 0,
                                  padEnds: true),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0, top: 12.0),
                      child: Text(
                        'شعانيني',
                        style: TextStyle(
                          fontFamily: 'Cairo', // Or any spiritual-looking font
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                                color: Colors.black45,
                                blurRadius: 4,
                                offset: Offset(1, 2))
                          ],
                        ),
                      ),
                    ),
                            SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        child: Stack(
                          children: [
                            CarouselSlider(
                              items: [
                                button('طقس عيد الصليب',
                                    imagePath: 'assets/salib.png'),
                                button('طقس أحد الشعانين',
                                    imagePath: 'assets/sha3anin.png'),
                              ],
                              options: CarouselOptions(
                                  height: 160,
                                  viewportFraction: 0.7,
                                  enableInfiniteScroll: true,
                                  enlargeCenterPage: true,
                                  initialPage: 0,
                                  padEnds: true),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0, top: 12.0),
                      child: Text(
                        'اسبوع الآلام',
                        style: TextStyle(
                          fontFamily: 'Cairo', // Or any spiritual-looking font
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                                color: Colors.black45,
                                blurRadius: 4,
                                offset: Offset(1, 2))
                          ],
                        ),
                      ),
                    ),
                            SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        child: Stack(
                          children: [
                            CarouselSlider(
                              items: [
                                button('طقس البصخة المقدسة',
                                    imagePath: 'assets/paskha.png'),
                                button('طقس خميس العهد',
                                    imagePath: 'assets/khamis el3ahd.png'),
                                button('طقس الجمعة العظيمة',
                                    imagePath: 'assets/gom3a 3azima.png'),
                                button('طقس ليلة أبو غالمسيس',
                                    imagePath: 'assets/abo ghalamsis.png'),
                              ],
                              options: CarouselOptions(
                                  height: 160,
                                  viewportFraction: 0.7,
                                  enableInfiniteScroll: true,
                                  enlargeCenterPage: true,
                                  initialPage: 0,
                                  padEnds: true),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Text(
                        'برمون + مناسبات',
                        style: TextStyle(
                          fontFamily: 'Cairo', // Or any spiritual-looking font
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                                color: Colors.black45,
                                blurRadius: 4,
                                offset: Offset(1, 2))
                          ],
                        ),
                      ),
                    ),
                            SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        child: Stack(
                          children: [
                            CarouselSlider(
                              items: [
                                button('طقس أعياد يوحنا المعمدان',
                                    imagePath: 'assets/yohanna.png'),
                                button('طقس شهر كيهك',
                                    imagePath: 'assets/kiahk.png'),
                                button('طقس برمون عيد الميلاد',
                                    imagePath: 'assets/baramon milad.png'),
                                button('طقس برمون عيد الغطاس',
                                    imagePath: 'assets/baramon ghetas.png'),
                                button('طقس سبت لعازر',
                                    imagePath: 'assets/lazaros.png'),
                              ],
                              options: CarouselOptions(
                                  height: 160,
                                  viewportFraction: 0.7,
                                  enableInfiniteScroll: true,
                                  enlargeCenterPage: true,
                                  initialPage: 0,
                                  padEnds: true),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0, top: 12.0),
                      child: Text(
                        'صوم',
                        style: TextStyle(
                          fontFamily: 'Cairo', // Or any spiritual-looking font
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                                color: Colors.black45,
                                blurRadius: 4,
                                offset: Offset(1, 2))
                          ],
                        ),
                      ),
                    ),
                            SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, right: 12.0, bottom: 60),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        child: Stack(
                          children: [
                            CarouselSlider(
                              items: [
                                button('طقس صوم و فصح يونان',
                                    imagePath: 'assets/younan.png'),
                                button('طقس الصوم الكبير',
                                    imagePath: 'assets/som kebir.png'),
                                button('طقس صوم العذراء و أعيادها',
                                    imagePath: 'assets/3adra.png'),
                                button('طقس صوم الرسل و عيدهم',
                                    imagePath: 'assets/rosol.png'),
                              ],
                              options: CarouselOptions(
                                  height: 160,
                                  viewportFraction: 0.7,
                                  enableInfiniteScroll: true,
                                  enlargeCenterPage: true,
                                  initialPage: 0,
                                  padEnds: true),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ]))),
              ],
            ),
          ]),
        ));
  }

  // @override
  // void initState() {
  //   super.initState();
  //   initBanner();
  // }
}
