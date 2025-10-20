import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hosepchoice/VideoPage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import 'colors.dart';

class Coptic extends StatefulWidget {
  const Coptic({Key? key}) : super(key: key);

  @override
  _CopticState createState() => _CopticState();
}

class _CopticState extends State<Coptic> {
  VideoPlayerController? controller;
  final DatabaseReference _db = FirebaseDatabase.instance
      .refFromURL('https://movieapp-216811.firebaseio.com/')
      .child('coptic');

  String _searchQuery = '';

  void openVid(var url) async {
    controller = VideoPlayerController.network(url);
    await controller?.initialize();
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => VideoPage(controller: controller!)),
    );
    Navigator.pop(context, "Video");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primary,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromRGBO(22, 22, 22, 1),
        title: TextField(
          onChanged: (value) {
            setState(() {
              _searchQuery = value.trim();
            });
          },
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search by name',
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
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
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: StreamBuilder<DatabaseEvent>(
            stream: _db.onValue,
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snap.hasError) {
                return Center(child: Text('Error: ${snap.error}'));
              }

              if (snap.hasData) {
                final dataSnapshot = snap.data!.snapshot;
                final data = dataSnapshot.value;

                if (data == null) {
                  return Center(child: Text('No data available'));
                }

                List<Map<dynamic, dynamic>> entries = [];

                if (data is Map) {
                  entries = data.entries
                      .map((e) => Map<dynamic, dynamic>.from(e.value))
                      .toList();
                } else if (data is List) {
                  entries = data
                      .where((element) => element != null)
                      .map((e) => Map<dynamic, dynamic>.from(e as Map))
                      .toList();
                } else {
                  return Center(child: Text('Unknown data format'));
                }

                // Apply search filter
                final filteredEntries = _searchQuery.isEmpty
                    ? entries
                    : entries.where((item) {
                  final name = item['name'] as String?;
                  return name != null && name.toLowerCase().contains(_searchQuery.toLowerCase());
                }).toList();

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3 / 2,
                  ),
                  itemCount: filteredEntries.length,
                  itemBuilder: (context, index) {
                    final item = filteredEntries[index];
                    final buttonText = item['name'] as String?;
                    final url = item['url'] as String?;
                    final vUrl = item['vUrl'] as String?;

                    return customElevatedButton(
                      buttonText: buttonText ?? 'Unnamed',
                      url: url ?? '',
                      vUrl: vUrl ?? '',
                    );
                  },
                );
              }
              else {
                return Center(child: Text('No data available'));
              }
            },
          ),
        ),
      ),
    );
  }

  Widget customElevatedButton({
    required String buttonText,
    required String url,
    required String vUrl,
  }) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith(
              (states) => AppColors.buttons_bg
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: const BorderSide(color: AppColors.buttons_bg),
          ),
        ),
      ),
      onPressed: () async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "اختار من الورق او شرح بالفيديو",
                textDirection: TextDirection.rtl,
              ),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  (buttonText == 'الحروف')
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () {
                          openVid(
                            'https://firebasestorage.googleapis.com/v0/b/movieapp-216811.appspot.com/o/CopticVideos%2Fmoqadema%5B1%5D.mp4?alt=media&token=b8e26bae-bc41-4142-9f9d-1eff92d71270',
                          );
                        },
                        child: Text('مقدمة'),
                      ),
                      TextButton(
                        onPressed: () {
                          openVid(
                            'https://firebasestorage.googleapis.com/v0/b/movieapp-216811.appspot.com/o/CopticVideos%2Fhoroof_mota7areka.mp4?alt=media&token=4bb72db8-f241-45ea-86a0-18681e6dffee',
                          );
                        },
                        child: Text('الحروف المتحركة'),
                      ),
                      TextButton(
                        onPressed: () {
                          openVid(
                            'https://firebasestorage.googleapis.com/v0/b/movieapp-216811.appspot.com/o/CopticVideos%2Fhoroof_1_not2.mp4?alt=media&token=4140a2e2-f151-4c1f-8d18-464be44094b7',
                          );
                        },
                        child: Text('حروف لها نطق واحد'),
                      ),
                      TextButton(
                        onPressed: () {
                          openVid(
                            'https://firebasestorage.googleapis.com/v0/b/movieapp-216811.appspot.com/o/CopticVideos%2Fhoroof_2_not2.mp4?alt=media&token=c82d9367-5309-4839-bb30-13530c6cfc0b',
                          );
                        },
                        child: Text('حروف لها نطقين'),
                      ),
                      TextButton(
                        onPressed: () {
                          openVid(vUrl);
                        },
                        child: Text('حروف لها اكثر من نطقين'),
                      ),
                    ],
                  )
                      : (vUrl != "" && vUrl != null)
                      ? IconButton(
                    icon: Icon(Icons.video_collection),
                    onPressed: () async {
                      controller = VideoPlayerController.network(vUrl);
                      await controller?.initialize();
                      Navigator.pop(context, "Video");
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => VideoPage(controller: controller!),
                        ),
                      );
                      Navigator.pop(context, "Video");
                    },
                  )
                      : Text(
                    'Video is not available yet!',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.picture_as_pdf),
                    onPressed: () async {
                      await launch(
                        url,
                        forceWebView: true,
                        enableJavaScript: true,
                      );
                      Navigator.pop(context, "PDF");
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Text(
        buttonText,
        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.white),
      ),
    );
  }
}
