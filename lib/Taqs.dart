import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_database/firebase_database.dart';

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
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(22, 22, 22, 1),
        title: const Text('طقس'),
      ),
      body: Directionality(
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

            var data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;

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
                String buttonText = data.values.elementAt(index)['name'] as String;
                String url = data.values.elementAt(index)['url'] as String;

                return customElevatedButton(
                  buttonText: buttonText,
                  url: url,
                );
              },
            );
          },
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
              (states) => const Color(0xff323030),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: const BorderSide(color: Colors.red),
          ),
        ),
      ),
      onPressed: () async {
        if (await canLaunch(url)) {
          await launch(
            url,
            forceWebView: true,
            enableJavaScript: true,
          );
        } else {
          throw 'Could not launch $url';
        }
      },
      child: Text(
        buttonText,
        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
      ),
    );
  }
}
