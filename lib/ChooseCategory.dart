import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hosepchoice/Coptic.dart';
import 'package:hosepchoice/Taqs.dart';
import 'main.dart';
import 'package:in_app_update/in_app_update.dart';

class ChooseCategory extends StatefulWidget {
  const ChooseCategory({Key? key}) : super(key: key);

  @override
  _ChooseCategoryState createState() => _ChooseCategoryState();
}

class _ChooseCategoryState extends State<ChooseCategory> {
  AppUpdateInfo? _updateInfo;  // Make sure it's nullable

  Future<void> checkForUpdate() async {
    try {
      final info = await InAppUpdate.checkForUpdate();
      setState(() {
        _updateInfo = info;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    checkForUpdate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(22, 22, 22, 1),
        title: const Text('اختار'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width / 1.2,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black), // Corrected here
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: const Text(
                    'الحان',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width / 1.2,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black), // Corrected here
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Taqs()));
                  },
                  child: const Text('طقس', style: TextStyle(fontSize: 22)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width / 1.2,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black), // Corrected here
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Coptic()));
                  },
                  child: const Text('قبطي', style: TextStyle(fontSize: 22)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
