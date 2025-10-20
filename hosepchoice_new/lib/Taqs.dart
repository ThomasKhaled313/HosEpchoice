import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_database/firebase_database.dart';

import 'colors.dart';

class Taqs extends StatefulWidget {
  const Taqs({Key? key}) : super(key: key);

  @override
  _TaqsState createState() => _TaqsState();
}

class _TaqsState extends State<Taqs> {
  final DatabaseReference _db = FirebaseDatabase.instance.ref().child('Taqs');

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
    return Scaffold(
        backgroundColor: AppColors.primary,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromRGBO(22, 22, 22, 1),
        title: const Text('طقس',style: TextStyle(color: Colors.white),),
      ),
      body: Container(
        width: double.infinity,
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
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
                return const Center(child: Text('No data available'));
              }

              var data = snapshot.data!.snapshot.value;

              if (data is Map<dynamic, dynamic>) {
                // ✅ Data is a Map
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3 / 2,
                  ),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    var entry = data.values.elementAt(index);
                    String buttonText = entry['name'] ?? 'No Name';
                    String url = entry['url'] ?? '';

                    return customElevatedButton(
                      buttonText: buttonText,
                      url: url,
                    );
                  },
                );
              } else if (data is List) {
                // ✅ Data is a List
                List<Object?> values = data;

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3 / 2,
                  ),
                  itemCount: values.length,
                  itemBuilder: (context, index) {
                    var item = values[index];
                    if (item is Map) {
                      String buttonText = item['name'] ?? 'No Name';
                      String url = item['url'] ?? '';

                      return customElevatedButton(
                        buttonText: buttonText,
                        url: url,
                      );
                    } else {
                      return const SizedBox(); // Skip invalid items
                    }
                  },
                );
              } else {
                return const Center(child: Text('Unknown data format'));
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
  }) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith(
              (states) => AppColors.buttons_bg,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: const BorderSide(color: Colors.black),
          ),
        ),
      ),
      onPressed: () async {
        Uri _url = Uri.parse(url);

        if (await canLaunchUrl(_url)) {
          try {
            await launchUrl(
              _url,
              mode: LaunchMode.inAppWebView,  // Use inAppWebView if the URL needs an embedded view
            );
          } catch (e) {
            // Catching any potential errors
            print('Error launching URL: $e');
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Error'),
                content: Text('Could not open the URL: $url'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          }
        } else {
          print('URL cannot be launched: $url');
          // Provide feedback to user
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Error'),
              content: Text('Could not launch the URL. Check the URL or your app configuration.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      },
      child: Text(
        buttonText,
        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 20,color: AppColors.textLight),
      ),
    );
  }
}
