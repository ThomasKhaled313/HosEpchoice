import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'Coptic.dart';
import 'Taqs.dart';
import 'main.dart';
import 'package:in_app_update/in_app_update.dart';

class ChooseCategory extends StatefulWidget {
  const ChooseCategory({Key key}) : super(key: key);

  @override
  _ChooseCategoryState createState() => _ChooseCategoryState();
}

class _ChooseCategoryState extends State<ChooseCategory> {
  AppUpdateInfo _updateInfo;
  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        _updateInfo = info;
      });
    }).catchError((e) {
      print(e.toString());
    });
  }

  @override
  void initState() {
    checkForUpdate();
    super.initState();
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
                width: MediaQuery.of(context).size.width/1.2,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Text(
                      'الحان',
                      style: TextStyle(fontSize: 22),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width/1.2,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Taqs()));
                    },
                    child: Text('طقس', style: TextStyle(fontSize: 22))),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width/1.2,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Coptic()));
                    },
                    child: Text('قبطي', style: TextStyle(fontSize: 22))),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
