import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utils/resources/Image_resources.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';

class CoustomAudioPlayer extends StatefulWidget {
  String message ; 

   CoustomAudioPlayer({super.key , required this.message });

  @override
  State<CoustomAudioPlayer> createState() => _CoustomAudioPlayerState();
}

class _CoustomAudioPlayerState extends State<CoustomAudioPlayer> with ScreenUtils{

  bool playPauseAudio = false ;

  final player = AudioPlayer();


  @override
  void dispose() {

    super.dispose();
    player.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
       child: Row(
         children: [
          const SizedBox(width: 5,),
          GestureDetector(
            onTap: () async {
              if (playPauseAudio == false ) {
                await player.play(UrlSource(widget.message));
                setState(() {playPauseAudio = true ;});
              } else {
                await player.pause();
                setState(() {playPauseAudio = false ;});
              }
            },
            child: Icon(
              playPauseAudio ? Icons.pause_circle : Icons.play_circle,
              size: 26,
              color: primaryShade500,
            ),
          ),
          const SizedBox(width: 15,),
          SvgPicture.asset(
            ImageResources.audiovisual,
            height: super.screenHeightPercentage(context, 6),
          )
         ],
       ),
    );
  }
}