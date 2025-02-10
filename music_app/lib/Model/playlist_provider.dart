import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app/Model/song_page.dart';

class PlaylistProvider extends ChangeNotifier {
  // Playlist of songs
  final List<Song> _playlist = [
    Song(
      songName: "People",
      artistName: 'Libianca',
      albumArtImagePath: 'assets//people.jpeg',
      audioPath: 'audio/people.mp3',
    ),
    Song(
      songName: "Bir gun ya dal",
      artistName: 'Resool',
      albumArtImagePath: 'assets//resool.jpeg',
      audioPath: 'audio/resool.mp3',
    ),
    Song(
      songName: "Snowman",
      artistName: 'Sia',
      albumArtImagePath: 'assets/snowman.jpeg',
      audioPath: 'audio/snowman.mp3',
    ),
  ];

  int? _currentSongIndex;
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;
  bool _isPlaying = false;

  PlaylistProvider() {
    listenToDuration();
  }

  Future<void> play() async {
    if (_currentSongIndex == null || _currentSongIndex! < 0 || _currentSongIndex! >= _playlist.length) return;

    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  Future<void> resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  Future<void> pauseOrResume() async {
    if (_isPlaying) {
      await pause();
    } else {
      await resume();
    }
  }

  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  void playNextSong() {
    if (_currentSongIndex == null) return;

    if (_currentSongIndex! < _playlist.length - 1) {
      setCurrentSongIndex(_currentSongIndex! + 1);
    } else {
      setCurrentSongIndex(0);
    }
  }

  void playPreviousSong() {
    if (_currentSongIndex == null) return;

    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else if (_currentSongIndex! > 0) {
      setCurrentSongIndex(_currentSongIndex! - 1);
    } else {
      setCurrentSongIndex(_playlist.length - 1);
    }
  }

  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;
  Song? get currentSong => _currentSongIndex != null ? _playlist[_currentSongIndex!] : null;

  void setCurrentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;
    if (newIndex != null) {
      play();
    }
    notifyListeners();
  }
}
