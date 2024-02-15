import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class CustomAssetAudioPlayer extends StatefulWidget {
  final String url;

  const CustomAssetAudioPlayer({required this.url, Key? key}) : super(key: key);

  @override
  _CustomAssetAudioPlayerState createState() => _CustomAssetAudioPlayerState();
}

class _CustomAssetAudioPlayerState extends State<CustomAssetAudioPlayer> {
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    audioPlayer.currentPosition.listen((position) {
      setState(() {
        this.position = position;
      });
    });
    audioPlayer.current.listen((playing) {
      setState(() {
        isPlaying = playing!.audio.audio.path == widget.url;
      });
    });
    audioPlayer.current.listen((playing) {
      setState(() {
        duration = playing!.audio.duration ?? Duration.zero;
      });
    });
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 225, 223, 223),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Track Name', // Display track title
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.purple,
                  child: IconButton(
                    color: Colors.white,
                    onPressed: () async {
                      if (isPlaying) {
                        await audioPlayer.pause();
                      } else {
                        await audioPlayer.open(Audio(widget.url));
                        await audioPlayer.play();
                      }
                    },
                    icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                    iconSize: 20,
                  ),
                ),
                Expanded(
                  child: Slider(
                    min: 0,
                    max: duration.inSeconds.toDouble(),
                    value: position.inSeconds.toDouble(),
                    onChanged: (value) {
                      audioPlayer.seek(Duration(seconds: value.toInt()));
                    },
                  ),
                ),
                Text(formatTime(position)),
                SizedBox(width: 8),
                Text(formatTime(duration)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
