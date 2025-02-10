import 'package:flutter/cupertino.dart';

class  Song{
   final String songName;
   final String artistName;
  final String albumArtImagePath;
  final String audioPath;
  Song({
   required this.artistName,
  required this.albumArtImagePath,
  required  this.audioPath,
    required this.songName,
   });
}