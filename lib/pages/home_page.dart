import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:repro/components/my_drawer.dart';
import 'package:repro/models/playlist_provider.dart';
import 'package:repro/models/song.dart';
import 'package:repro/pages/song_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final dynamic playlistProvider;

  @override
  void initState() {
    super.initState();

    //obtener el playlist provider
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  //nos permite navegar  

  void GoToSong(int songIndex) {
    //update de cancion actual
    playlistProvider.currentSongIndex = songIndex;
    //navigate
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SongPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: Text("P L A Y L I S T")),
      drawer: MyDrawer(),
      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) {
          //get playlist

          final List<Song> playlist = value.playlist;

          return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index) {
              // obtener la cancion individual
              final Song song = playlist[index];

              return ListTile(
                title: Text(song.songName),
                subtitle: Text(song.artistName),
                leading: Image.asset(song.albumArtImagePath),
                onTap: () => GoToSong(index),
              );
            },
          );
        },
      ),
    );
  }
}
