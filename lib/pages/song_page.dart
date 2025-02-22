import 'package:flutter/material.dart';
import 'package:get_secure_storage/get_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:repro/components/neu_box.dart';
import 'package:repro/models/playlist_provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(builder: (context, value, child) {
      //get playlist
      final playlist = value.playlist;

      //get cancion actual
      final currentSong = playlist[value.currentSongIndex ?? 0];

      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //appbar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const Text("P L A Y L I S T"),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.menu),
                    )
                  ],
                ),

                //albu,artwork
                NeuBox(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(currentSong.albumArtImagePath),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentSong.songName,
                                ),
                                Text(currentSong.artistName),
                              ],
                            ),
                            const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),
                //progressbar

                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //start
                          Text(value.currentDureation.toString()),
                          //mesclar
                          Icon(Icons.shuffle),

                          //repetir
                          Icon(Icons.repeat),

                          //final
                          Text(value.totalDuration.toString()),
                        ],
                      ),
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape:
                            const RoundSliderThumbShape(enabledThumbRadius: 0),
                      ),
                      child: Slider(
                        min: 0,
                        max: value.totalDuration.inSeconds.toDouble(),
                        value: value.currentDureation.inSeconds.toDouble(),
                        activeColor: Colors.green,
                        onChanged: (double double) {},
                        onChangeEnd: (double double) {
                          value.seek(Duration(seconds: double.toInt()));
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                Row(children: [
                  //atras
                  Expanded(
                    child: GestureDetector(
                      onTap: value.playPreviusSong,
                      child: NeuBox(
                        child: Icon(Icons.skip_previous),
                      ),
                    ),
                  ),

                  //pausa
                  const SizedBox(height: 20),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: value.pauseOrResume,
                      child: const NeuBox(
                        child: Icon(Icons.play_arrow),
                      ),
                    ),
                  ),
                  //skip
                  const SizedBox(height: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: value.playNextSong,
                      child: const NeuBox(
                        child: Icon(Icons.skip_next),
                      ),
                    ),
                  ),
                ])
              ],
            ),
          ),
        ),
      );
    });
  }
}
