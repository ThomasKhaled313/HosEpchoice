import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  final VideoPlayerController controller;

  VideoPage({Key key, this.controller}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }
  void _seekForward() {
    final newPosition = widget.controller.value.position + Duration(seconds: 10);
    widget.controller.seekTo(newPosition);
  }

  void _seekBackward() {
    final newPosition = widget.controller.value.position - Duration(seconds: 10);
    widget.controller.seekTo(newPosition);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTapDown: (details) {
          print('hi');
          final screenWidth = MediaQuery.of(context).size.width;
          if (details.globalPosition.dx < screenWidth / 2) {
            _seekBackward();
          } else {
            _seekForward();
          }
        },
        // onTap: () {
        //   setState(() {
        //     if (widget.controller.value.isPlaying) {
        //       widget.controller.pause();
        //     } else {
        //       if (widget.controller.value.position == widget.controller.value.duration) {
        //         widget.controller.seekTo(Duration.zero);
        //       }
        //       widget.controller.play();
        //     }
        //   });
        // },
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                double aspectRatio = constraints.maxWidth / constraints.maxHeight;
                return AspectRatio(
                  aspectRatio: aspectRatio,
                  child: VideoPlayer(widget.controller),
                );
              },
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        widget.controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                      ),
                      onPressed: () {
                        setState(() {
                          if (widget.controller.value.isPlaying) {
                            widget.controller.pause();
                          } else {
                            if (widget.controller.value.position == widget.controller.value.duration) {
                              widget.controller.seekTo(Duration.zero);
                            }
                            widget.controller.play();
                          }
                        });
                      },
                    ),
                    Expanded(
                      child: VideoProgressIndicator(
                        widget.controller,
                        allowScrubbing: true,
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
