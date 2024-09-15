import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'file:///C:/Users/Thomas/StudioProjects/hos_epchoice_web/lib/VideoPage.dart';
import 'package:video_player/video_player.dart';


class Coptic extends StatefulWidget {
  const Coptic({Key key}) : super(key: key);

  @override
  _CopticState createState() => _CopticState();
}

class _CopticState extends State<Coptic> {
  VideoPlayerController controller;
  DatabaseReference _db = FirebaseDatabase(
      databaseURL:
      'https://movieapp-216811.firebaseio.com/')
      .reference()
      .child("coptic");


  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {

    super.dispose();
  }
  String _searchQuery = '';
  
  void openVid(var url) async{
    controller = VideoPlayerController.network(url);
    await controller.initialize();
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => VideoPage(controller: controller,)));
    Navigator.pop(context, "Video");
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        appBar: AppBar(
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
        body: Directionality(
            textDirection: TextDirection.rtl,
            child: StreamBuilder(
              stream: _db.onValue,
              builder: (c,snap){
                if(snap.hasData){
                  var data = snap.data.snapshot.value;
                  var filteredData = _searchQuery.isEmpty
                      ? data
                      : data.where((item) {
                    var name = item['name'] as String;
                    return name?.toLowerCase()?.contains(_searchQuery.toLowerCase()) ?? false;
                  }).toList();


                  return GridView.builder(
                    padding: EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3 / 2,
                    ),
                    itemCount: filteredData.length,
                    itemBuilder: (context, index) {
                      String buttonText = filteredData[index]['name'];
                      String url = filteredData[index]['url'];
                      String vUrl = filteredData[index]['vUrl'];

                      return customElevatedButton(
                          buttonText: buttonText,
                          url: url,
                          vUrl: vUrl
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
    String vUrl
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
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("اختار من الورق او شرح بالفيديو",textDirection: TextDirection.rtl,),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  (buttonText == 'الحروف')?Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(onPressed: (){
                        openVid('https://firebasestorage.googleapis.com/v0/b/movieapp-216811.appspot.com/o/CopticVideos%2Fmoqadema%5B1%5D.mp4?alt=media&token=b8e26bae-bc41-4142-9f9d-1eff92d71270');
                      }, child: Text('مقدمة')),
                      TextButton(onPressed: (){
                        openVid('https://firebasestorage.googleapis.com/v0/b/movieapp-216811.appspot.com/o/CopticVideos%2Fhoroof_mota7areka.mp4?alt=media&token=4bb72db8-f241-45ea-86a0-18681e6dffee');
                      }, child: Text('الحروف المتحركة')),
                      TextButton(onPressed: (){
                        openVid('https://firebasestorage.googleapis.com/v0/b/movieapp-216811.appspot.com/o/CopticVideos%2Fhoroof_1_not2.mp4?alt=media&token=4140a2e2-f151-4c1f-8d18-464be44094b7');
                      }, child: Text('حروف لها نطق واحد')),
                      TextButton(onPressed: (){
                        openVid('https://firebasestorage.googleapis.com/v0/b/movieapp-216811.appspot.com/o/CopticVideos%2Fhoroof_2_not2.mp4?alt=media&token=c82d9367-5309-4839-bb30-13530c6cfc0b');
                      }, child: Text('حروف لها نطقين')),
                      TextButton(onPressed: (){
                          openVid(vUrl);
                      }, child: Text('حروف لها اكثر من نطقين')),
                    ],
                  ):(vUrl != "" && vUrl != null)?IconButton(
                    icon: Icon(Icons.video_collection),
                    onPressed: () async{
                      controller = VideoPlayerController.network(vUrl);
                      await controller.initialize();
                      Navigator.pop(context, "Video");
                      await Navigator.of(context).push(MaterialPageRoute(builder: (context) => VideoPage(controller: controller,)));
                      Navigator.pop(context, "Video");
                    },
                  ):Text('Video is not available yet!',style: TextStyle(fontWeight: FontWeight.bold,),),
                  IconButton(
                    icon: Icon(Icons.picture_as_pdf),
                    onPressed: () async{
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
        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
      ),
    );
  }
}
