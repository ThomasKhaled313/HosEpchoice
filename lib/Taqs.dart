import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';



class Taqs extends StatefulWidget {
  const Taqs({Key key}) : super(key: key);

  @override
  _TaqsState createState() => _TaqsState();
}

class _TaqsState extends State<Taqs> {
  var _db = fb.app().storage().refFromURL("gs://movieapp-216811.appspot.com").child('Taqs');


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
          child: StreamBuilder(
            stream: _db.onValue,
            builder: (c,snap){
              if(snap.hasData){
                var data = snap.data.snapshot.value;

                return GridView.builder(
                    padding: EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3 / 2,
                    ),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      String buttonText = data[index]['name'];
                      String url = data[index]['url'];

                      return customElevatedButton(
                        buttonText: buttonText,
                        url: url
                      );
                    },
                  );
                }
                else {
                  return Center(child: CircularProgressIndicator(),);
                }
            },
          )
        ));
  }

  Widget customElevatedButton({
     String buttonText,
     String url,
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
        await launch(
          url,
          forceWebView: true,
          enableJavaScript: true,
        );
      },
      child: Text(
        buttonText,
        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
      ),
    );
  }
}
