import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share/share.dart';


import 'package:audioplayers/audioplayers.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'main.dart';
import 'dart:convert';


class AudioPlayerScreen extends StatefulWidget {
  final String audioUrl, audioTitle, title,textContent;

  AudioPlayerScreen(this.audioUrl, this.audioTitle, this.title, this.textContent);

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState(audioUrl, audioTitle, title, textContent);
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  double _sliderValue = 0.0;
  String url, audioTitle, title, textContent;
  _AudioPlayerScreenState(this.url, this.audioTitle, this.title, this.textContent);
  AudioPlayer _audioPlayer;
  Duration _duration;
  Duration _position;
  bool _isPlaying = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
    _playPause(url);
  }


  @override
  void dispose() {
    super.dispose();
  }

  void _initAudioPlayer() {
    _audioPlayer = AudioPlayer();
    _audioPlayer.setUrl(widget.audioUrl);

    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
        _isLoading = false;
      });
    });

    _audioPlayer.onAudioPositionChanged.listen((position) {
      setState(() {
        _position = position;
        _sliderValue = position.inSeconds.toDouble();
      });
    });

    _audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        _isPlaying = false;
        _isLoading = false;
        _position = Duration.zero;
      });
    });

    _audioPlayer.onPlayerError.listen((msg) {
      setState(() {
        _isPlaying = false;
      });
      print('audioPlayer error : $msg');
    });


  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  void _playPause(String url) {
    setState(() {
      if (_isPlaying) {
        _audioPlayer.pause();
      } else {
        _audioPlayer.play(url);
      }
      _isPlaying = !_isPlaying;
    });
  }

  void _fastForward() {
    setState(() {
      final Duration newPosition = _position + Duration(seconds: 5);
      _position = newPosition <= _duration ? newPosition : _duration;
      _audioPlayer.seek(_position);
    });
  }

  void _fastBackward() {
    setState(() {
      final Duration newPosition = _position - Duration(seconds: 5);
      _position = newPosition >= Duration.zero ? newPosition : Duration.zero;
      _audioPlayer.seek(_position);
    });
  }
  final List<double> _playbackSpeeds = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];
  var _currentPlaybackSpeed = 1.0;
  void changeAudioSpeed(){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200.0,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Select Playback Speed',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _playbackSpeeds.length,
                  itemBuilder: (BuildContext context, int index) {
                    double speed = _playbackSpeeds[index];
                    return ListTile(
                      title: Text('${speed.toStringAsFixed(1)}x'),
                      onTap: () {
                        setState(() {
                          _currentPlaybackSpeed = speed;
                          _audioPlayer.setPlaybackRate(playbackRate: _currentPlaybackSpeed);
                          _audioPlayer.play(url);
                          _isPlaying = true;
                        });
                        Navigator.pop(context);
                      },
                      selected: _currentPlaybackSpeed == speed,

                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color.fromRGBO(22, 22, 22,1),
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
         backgroundColor: const Color.fromRGBO(22, 22, 22,1),

        actions: [
          IconButton(icon: const Icon(Icons.share), onPressed: (){
            Share.share(url,subject: audioTitle);
          })
        ],
      ),
      body: WillPopScope(
        onWillPop: (){
          if(_isPlaying)
            _playPause(url);
          Navigator.pop(context);
          return;
        },
        child: SingleChildScrollView(
          child: Center(
            child: _isLoading // show CircularProgressIndicator if still loading
                ? const CircularProgressIndicator()
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width-20,
                  height: MediaQuery.of(context).size.height/2.5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Card(
                        elevation: 100.0, // Adjust the elevation as needed
                        shadowColor: Colors.blueGrey, // Specify the shadow color
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Container(
                              width: double.infinity,
                              child: Text(
                                '$textContent',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontFamily: 'Coptic',
                                    height: 1.2
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),



                  ),
                ),
                const SizedBox(height: 30.0),

                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        child: Text(
                          audioTitle,
                          style: TextStyle(color: Colors.white,fontSize: 25, fontFamily: 'Coptic'),
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Container(
                        alignment: Alignment.centerRight,
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        child: IconButton(
                          icon:  Icon(Icons.speed,color: Colors.white),
                          onPressed: (){
                            changeAudioSpeed();
                          },
                        ),
                      ),
                    ),
                    Slider(
                      activeColor: Color.fromRGBO(0, 1, 230,1),
                      value: _sliderValue,
                      min: 0.0,
                      max: _duration?.inSeconds?.toDouble() ?? 0.0,
                      onChanged: (value) {
                        setState(() {
                          _sliderValue = value;
                          _audioPlayer.seek(Duration(seconds: _sliderValue.toInt()));
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0,right: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _position != null
                                ? _formatDuration(_position)
                                : _duration != null
                                ? _formatDuration(Duration.zero)
                                : 'Loading...',
                            style: const TextStyle(fontSize: 15.0, color: Colors.white),
                          ),
                          Text(
                            _position != null
                                ? _formatDuration(_duration)
                                : _duration != null
                                ? _formatDuration(Duration.zero)
                                : 'Loading...',
                            style: const TextStyle(fontSize: 15.0, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(66, 66, 66,1),
                          shape: BoxShape.circle
                      ),
                      width: 50.0,
                      child: IconButton(
                        iconSize: 30,
                        icon: const Icon(Icons.fast_rewind,color: Colors.white),
                        onPressed: _fastBackward,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(0, 1, 230,1),
                          shape: BoxShape.circle
                      ),
                      width: 70.0,
                      child: IconButton(
                        iconSize: 50,
                        icon: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.white
                        ),
                        onPressed: () => _playPause(url),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(66, 66, 66,1),
                          shape: BoxShape.circle
                      ),
                      width: 50.0,
                      child: IconButton(
                        iconSize: 30,
                        icon: const Icon(Icons.fast_forward,color: Colors.white),
                        onPressed: _fastForward,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}