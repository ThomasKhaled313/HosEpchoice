import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class AudioPlayerScreen extends StatefulWidget {
  final String audioUrl, audioTitle, title, textContent;

  AudioPlayerScreen(this.audioUrl, this.audioTitle, this.title, this.textContent);

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayer _audioPlayer;
  PlayerState? _playerState;
  Duration? _duration;
  Duration? _position;
  double _sliderValue = 0.0;

  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;

  bool get _isPlaying => _playerState == PlayerState.playing;
  bool get _isPaused => _playerState == PlayerState.paused;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playerState = _audioPlayer.state;

    // Initialize the audio player.
    _audioPlayer.setSource((UrlSource(widget.audioUrl)));
    _audioPlayer.setReleaseMode(ReleaseMode.stop);

    // Set up the streams for position, duration, and state changes.
    _initStreams();
  }

  @override
  void dispose() {
    // Cancel all the subscriptions when the widget is disposed.
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();
    _audioPlayer.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        backgroundColor: const Color.fromRGBO(22, 22, 22, 1),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              Share.share(widget.audioUrl, subject: widget.audioTitle);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: _duration == null
              ? const CircularProgressIndicator()
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 20,
                height: MediaQuery.of(context).size.height / 2.5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Card(
                      elevation: 10.0,
                      shadowColor: Colors.blueGrey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Container(
                            width: double.infinity,
                            child: Text(
                              widget.textContent,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontFamily: 'Coptic',
                                height: 1.2,
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
              Text(
                widget.audioTitle,
                style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Coptic'),
              ),
              Slider(
                activeColor: const Color.fromRGBO(0, 1, 230, 1),
                value: _sliderValue,
                min: 0.0,
                max: _duration?.inSeconds.toDouble() ?? 0.0,
                onChanged: (value) {
                  setState(() {
                    _sliderValue = value;
                    _audioPlayer.seek(Duration(seconds: _sliderValue.toInt()));
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _position != null ? _positionText : 'Loading...',
                      style: const TextStyle(fontSize: 15.0, color: Colors.white),
                    ),
                    Text(
                      _duration != null ? _durationText : 'Loading...',
                      style: const TextStyle(fontSize: 15.0, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.fast_rewind),
                    color: Colors.white,
                    onPressed: _fastBackward,
                  ),
                  IconButton(
                    icon: Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                    ),
                    onPressed: _togglePlayPause,
                  ),
                  IconButton(
                    icon: const Icon(Icons.fast_forward),
                    color: Colors.white,
                    onPressed: _fastForward,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _initStreams() {
    _durationSubscription = _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });

    _positionSubscription = _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _position = position;
        _sliderValue = position.inSeconds.toDouble();
      });
    });

    _playerCompleteSubscription = _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration.zero;
      });
    });


    _playerStateChangeSubscription = _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        _playerState = state;
      });
    });
  }

  Future<void> _togglePlayPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.resume();
    }

    setState(() {
      _playerState = _audioPlayer.state;
    });
  }

  void _fastForward() {
    if (_position != null && _duration != null) {
      final newPosition = _position! + const Duration(seconds: 5);
      _audioPlayer.seek(newPosition <= _duration! ? newPosition : _duration!);
    }
  }

  void _fastBackward() {
    if (_position != null) {
      final newPosition = _position! - const Duration(seconds: 5);
      _audioPlayer.seek(newPosition >= Duration.zero ? newPosition : Duration.zero);
    }
  }

  String get _durationText => _duration?.toString().split('.').first ?? '';
  String get _positionText => _position?.toString().split('.').first ?? '';
}
