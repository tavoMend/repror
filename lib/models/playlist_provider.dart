import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:repro/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    //song 1
    Song(
      songName: "Droppin' Seeds",
      artistName: "Tyler, The Creator",
      albumArtImagePath: "assets/images/Flower_boy_image.png",
      audioPath:
          "audio/Tyler, The Creator - Droppin' Seeds (feat Lil' Wayne).mp3",
    ),

    //song 2
    Song(
      songName: "Enjoy Right Now",
      artistName: "Tyler, The Creator",
      albumArtImagePath: "assets/images/Flower_boy_image.png",
      audioPath: "audio/Tyler, The Creator - Enjoy Right Now, Today.mp3",
    ),

    Song(
      songName: "Foreword",
      artistName: "Tyler, The Creator",
      albumArtImagePath: "assets/images/Flower_boy_image.png",
      audioPath:
          "audio/Tyler, The Creator - Foreword (feat Rex Orange County).mp3",
    ),

    //song 3
  ];

  // indice de cancion actual
  int? _currentSongIndex;

  //auidio player

  final AudioPlayer _audioPlayer = AudioPlayer();

  //durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  //contructor
  PlaylistProvider() {
    listenToDuration();
  }

  //initially not playing
  bool _isPlaying = false;

  //play the song

  void play() async {
    final String path = playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  //void pause
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  //resumeplaying

  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  //pause or resume
  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  //seek to a especific posc

  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  //play previus song
  void playPreviusSong() async {
    if (_currentDuration.inSeconds > 2) {
    } else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  //play next

  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        currentSongIndex = currentSongIndex! + 1;
      } else {
        currentSongIndex = 0;
      }
    }
  }

  //listen toduration
  void listenToDuration() {
    //;isten total
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });
    //listen current
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    //listen song complation

    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  //audioplayer

  //getters

  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDureation => _currentDuration;
  Duration get totalDuration => _totalDuration;

  //settlers

  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;

    if (newIndex != null) {
      play();
    }

    notifyListeners();
  }
}
