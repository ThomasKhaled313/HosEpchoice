import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class MyAudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  final _player = AudioPlayer();

  MyAudioHandler() {
    // Broadcast playback state changes to the system
    _player.playbackEventStream.map(_transformEvent).pipe(playbackState);
  }

  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        MediaControl.stop,
        MediaControl.fastForward,
        MediaControl.rewind,



        _player.playing ? MediaControl.pause : MediaControl.play,


      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: _player.playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: _player.currentIndex,
    );
  }
  Future<Duration?> getCurrentDuration() async {
    try {
      return _player.duration; // Assuming you have a `_player` = AudioPlayer();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() => _player.stop();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> setSpeed(double speed) async {
    await _player.setSpeed(speed);
  }

  @override
  Future<void> setUrl(String url, String title) async {
    // ✅ Set the media item (shows in notification)
    final item = MediaItem(
      id: url,
      album: "Hos Epchoice",
      title: title,
      artUri: Uri.parse(
          "https://upload.wikimedia.org/wikipedia/commons/4/4e/Hymn_icon.png"),
      duration: Duration.zero, // will update later
    );
    mediaItem.add(item);

    // ✅ Load and update duration when available
    await _player.setUrl(url);
    final duration = _player.duration;
    if (duration != null) {
      mediaItem.add(item.copyWith(duration: duration));
    }
  }
}
