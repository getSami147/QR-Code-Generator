
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class CustomAudioPlayer extends StatefulWidget {
  final String url;
  const CustomAudioPlayer({required this.url, Key? key}) : super(key: key);

  @override
  _CustomAudioPlayerState createState() => _CustomAudioPlayerState();
}

class _CustomAudioPlayerState extends State<CustomAudioPlayer> {

  late AudioPlayer audioPlayer;
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return '$minutes:$seconds';
  }

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
    audioPlayer.onPositionChanged
    .listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  // late AudioPlayer? currentActivePlayer;
  void activatePlayer(AudioPlayer player) {
    if (audioPlayer == player) {
      audioPlayer.pause();
      audioPlayer = player;
      print("pause+Play");
    }else{
      print("nothing");

    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
color: const Color(0xFFE8E8EE),        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.purple,
              child: IconButton(
                color: Colors.white,
                onPressed: () async {
                 activatePlayer(audioPlayer);

                  if (isPlaying) {
                    await audioPlayer.pause();
                  } else {
                    await audioPlayer.play(UrlSource(widget.url));
                  }
                },
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                iconSize: 20,
              ),
            ),
            const SizedBox(width: 1),
            Text(
              formatTime(position),
            ),
            SliderTheme(
              data: SliderThemeData(
                inactiveTrackColor: const Color(0xff9B22C5).withOpacity(.3),
              ),
              child: Slider(
                min: 0,
                max: duration.inSeconds.toDouble(),
                value: position.inSeconds.toDouble(),
                onChanged: (value) {
                  setState(() {
                    position = Duration(seconds: value.toInt());
                  });
                },
                onChangeEnd: (value) {
                  audioPlayer.seek(Duration(seconds: value.toInt()));
                },
              ),
            ),
            SizedBox(width: 2,),
            Text(
              formatTime(duration - position),
            ),
          ],
        ),
      )
    );
  }
}
