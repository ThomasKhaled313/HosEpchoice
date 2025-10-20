import 'package:flutter/material.dart';

import 'package:hosepchoice/Coptic.dart';
import 'package:hosepchoice/Taqs.dart';
import 'colors.dart';
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
        backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.appbar,
        title: const Text('اختار',style: TextStyle(color: AppColors.textLight),),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.png'),
            fit: BoxFit.cover,     // ✅ show full image
            alignment: Alignment.center,
          ),
        ),
        child: Stack(
          children: [
            Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.buttons_bg,shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16), // 👈 Set your radius here
                            ),), // Corrected here
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HomePage()));
                            },
                            child: const Text(
                              'الحان',
                              style: TextStyle(fontSize: 22,color: AppColors.textLight),
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
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.buttons_bg,shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16), // 👈 Set your radius here
                            ),), // Corrected here
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Taqs()));
                            },
                            child: const Text('طقس', style: TextStyle(fontSize: 22,color: AppColors.textLight)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.buttons_bg,shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16), // 👈 Set your radius here
                            ),), // Corrected here
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Coptic()));
                            },
                            child: const Text('قبطي', style: TextStyle(fontSize: 22,color: AppColors.textLight)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),]
            ),
          ],
        ),
      ),
    );
  }
}
