import 'package:flutter/material.dart';
import 'package:music_app/Model/playlist_provider.dart';
import 'package:music_app/components/neu_box.dart';
import 'package:provider/provider.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  // Convert duration into minutes and seconds
  String formatTime(Duration duration) {
    String twoDigitSeconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "${duration.inMinutes}:$twoDigitSeconds";
  }

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();

    // Set the initial song index to 0 if it's not already set
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PlaylistProvider>(context, listen: false).setCurrentSongIndex(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, value, child) {
        // Get playlist
        final playlist = value.playlist;

        // Check if playlist or current song is valid
        if (playlist.isEmpty || value.currentSongIndex == null) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Center(
              child: Text(
                "No songs available",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          );
        }

        final currentSong = playlist[value.currentSongIndex!];

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Column(
                children: [
                  // App bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                      const Text(
                        'PLAYLIST',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.menu),
                      ),
                    ],
                  ),
                  const SizedBox(height: 35),

                  // Album artwork
                  NeuBox(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            currentSong.albumArtImagePath,
                            height: 250,
                            width: 250,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Song and artist name
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currentSong.songName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    currentSong.artistName,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                              // Favorite icon
                              IconButton(
                                icon: Icon(
                                  isFavorite ? Icons.favorite : Icons.favorite_border,
                                  color: isFavorite ? Colors.red : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isFavorite = !isFavorite;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Song duration progress
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Start time
                            Text(widget.formatTime(value.currentDuration)),
                            const Icon(Icons.shuffle),
                            // End time
                            Text(widget.formatTime(value.totalDuration)),
                          ],
                        ),
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                        ),
                        child: Slider(
                          min: 0,
                          max: value.totalDuration.inSeconds.toDouble(),
                          value: value.currentDuration.inSeconds.toDouble(),
                          activeColor: Colors.green,
                          onChanged: (newValue) {
                            // Optionally handle live sliding
                          },
                          onChangeEnd: (newValue) {
                            // Seek to the specified position
                            value.seek(Duration(seconds: newValue.toInt()));
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  // Playback controls
                  Row(
                    children: [
                      // Skip previous
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            value.playPreviousSong();
                          },
                          child: NeuBox(child: const Icon(Icons.skip_previous)),
                        ),
                      ),
                      const SizedBox(width: 25),

                      // Play/Pause button
                      Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: () {
                            value.pauseOrResume();
                          },
                          child: NeuBox(
                            child: Icon(
                              value.isPlaying ? Icons.pause : Icons.play_arrow,
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 25),

                      // Skip next
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            value.playNextSong();
                          },
                          child: NeuBox(child: const Icon(Icons.skip_next)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
