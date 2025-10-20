import 'dart:async';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:audio_service/audio_service.dart';
import 'colors.dart';
import 'audio_handler.dart';
import 'main.dart' show audioHandler;
class AudioPlayerScreen extends StatefulWidget {
  final String audioUrl, audioTitle, title, textContent;

  const AudioPlayerScreen(
      this.audioUrl, this.audioTitle, this.title, this.textContent,
      {Key? key})
      : super(key: key);

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  double _sliderValue = 0.0;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isPlaying = false;
  bool _isLoading = true;
  StreamSubscription<PlaybackState>? _playbackSub;
  StreamSubscription<Duration>? _positionSub;
  double _currentSpeed = 1.0;

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  @override
  void dispose() {
    _playbackSub?.cancel();
    _positionSub?.cancel();
    super.dispose();
  }

  void _initAudioPlayer() async {
    // ✅ Initialize and start loading the URL
    await (audioHandler as MyAudioHandler).setUrl(widget.audioUrl, widget.audioTitle);

    // ✅ Listen to playback state (for play/pause/loading)
    _playbackSub = audioHandler.playbackState.listen((state) {
      setState(() {
        _isPlaying = state.playing;
        _isLoading = false;
      });
    });

    // ✅ Listen to position updates
    _positionSub = AudioService.position.listen((pos) {
      setState(() {
        _position = pos;
        _sliderValue = pos.inSeconds.toDouble();
      });
    });

    // ✅ Listen for media item updates (for duration)
    audioHandler.mediaItem.listen((item) {
      if (item?.duration != null && item!.duration!.inSeconds > 0) {
        setState(() => _duration = item.duration!);
      }
    });

    // ✅ Force-refresh duration after 2 seconds (backup check)
    Future.delayed(const Duration(seconds: 2), () async {
      final currentItem = await audioHandler.mediaItem.first;
      if (currentItem?.duration != null && currentItem!.duration!.inSeconds > 0) {
        setState(() => _duration = currentItem.duration!);
      } else {
        // ✅ Try to fetch from player directly if handler exposes it
        final playerDuration = await (audioHandler as MyAudioHandler).getCurrentDuration();
        if (playerDuration != null && playerDuration.inSeconds > 0) {
          setState(() => _duration = playerDuration);
        }
      }
    });
  }




  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  void _playPause() {
    if (_isPlaying) {
      audioHandler.pause();
    } else {
      audioHandler.play();
    }
  }

  void _fastForward() async {
    final newPos = _position + const Duration(seconds: 5);
    await audioHandler.seek(newPos);
  }

  void _fastBackward() async {
    final newPos = _position - const Duration(seconds: 5);
    await audioHandler.seek(newPos >= Duration.zero ? newPos : Duration.zero);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: AppColors.textLight),
        title: Text(
          widget.title,
          style: const TextStyle(color: AppColors.textLight,fontFamily: 'Coptic'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: AppColors.textLight),
            onPressed: () {
              Share.share(widget.audioUrl, subject: widget.audioTitle);
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ===== TEXT CONTAINER =====
              Container(
                width: MediaQuery.of(context).size.width - 20,
                height: MediaQuery.of(context).size.height / 2.5,
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Card(
                    elevation: 100.0,
                    shadowColor: Colors.blueGrey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            widget.textContent,
                            style: const TextStyle(
                              color: AppColors.textBlack,
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
              const SizedBox(height: 30.0),

              // ===== AUDIO TITLE =====
              Text(
                widget.audioTitle,
                style: const TextStyle(
                  color: AppColors.textLight,
                  fontSize: 25,
                  fontFamily: 'Coptic',
                ),
              ),

              // ===== SLIDER =====
              Slider(
                activeColor: AppColors.buttons_bg,
                value: _sliderValue.clamp(0.0, _duration.inSeconds.toDouble()),
                min: 0.0,
                max: _duration.inSeconds.toDouble(),
                onChanged: (value) {
                  setState(() {
                    _sliderValue = value;
                  });
                },
                onChangeEnd: (value) {
                  audioHandler.seek(Duration(seconds: value.toInt()));
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDuration(_position),
                      style: const TextStyle(
                          fontSize: 15.0, color: AppColors.textLight),
                    ),
                    Text(
                      _formatDuration(_duration),
                      style: const TextStyle(
                          fontSize: 15.0, color: AppColors.textLight),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),

              // ===== AUDIO CONTROLS =====
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      color: AppColors.FF_FB_buttonColors,
                      shape: BoxShape.circle,
                    ),
                    width: 50.0,
                    child: IconButton(
                      iconSize: 30,
                      icon: const Icon(Icons.fast_rewind,
                          color: AppColors.textLight),
                      onPressed: _fastBackward,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      color: AppColors.buttons_bg,
                      shape: BoxShape.circle,
                    ),
                    width: 70.0,
                    child: IconButton(
                      iconSize: 50,
                      icon: Icon(
                        _isPlaying ? Icons.pause : Icons.play_arrow,
                        color: AppColors.textLight,
                      ),
                      onPressed: _playPause,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      color: AppColors.FF_FB_buttonColors,
                      shape: BoxShape.circle,
                    ),
                    width: 50.0,
                    child: IconButton(
                      iconSize: 30,
                      icon: const Icon(Icons.fast_forward,
                          color: AppColors.textLight),
                      onPressed: _fastForward,
                    ),
                  ),
                ],
              ),
              // ===== PLAYBACK SPEED CONTROL =====
              TextButton(
                onPressed: () async {
                  double newSpeed;
                  if (_currentSpeed == 1.0) {
                    newSpeed = 1.25;
                  } else if (_currentSpeed == 1.25) {
                    newSpeed = 1.5;
                  } else if (_currentSpeed == 1.5) {
                    newSpeed = 2.0;
                  } else {
                    newSpeed = 1.0;
                  }
                  setState(() => _currentSpeed = newSpeed);
                  await audioHandler.setSpeed(newSpeed);
                },
                child: Text(
                  "${_currentSpeed}x",
                  style: const TextStyle(
                    color: AppColors.textLight,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
