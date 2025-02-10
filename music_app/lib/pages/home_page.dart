import 'package:flutter/material.dart';
import 'package:music_app/Model/playlist_provider.dart';
import 'package:music_app/components/MyDrawer.dart';
import 'package:provider/provider.dart';
import 'package:music_app/pages/song_page.dart';
import '../Model/song_page.dart'; // Import your Song model

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PlaylistProvider playlistProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  void goToSong(int songIndex) {
    // Update the current song index
    playlistProvider.setCurrentSongIndex(songIndex);
    // Navigate to the song page
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SongPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('P L A Y L I S T'),
        centerTitle: true,
        backgroundColor: Colors.grey.shade500,
      ),
      drawer: const Mydrawer(),
      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) {
          // Get the playlist from the provider
          final List<Song> playlist = value.playlist;

          return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index) {
              final Song song = playlist[index];
              return ListTile(
                title: Text(song.songName),
                subtitle: Text(song.artistName),
                leading: Card(child: Image.asset(song.albumArtImagePath)),
                onTap: () {
                  Provider.of<PlaylistProvider>(context, listen: false).setCurrentSongIndex(0); // Example index

                  goToSong(index);
                },
              );
            },
          );
        },
      ),
    );
  }
}
