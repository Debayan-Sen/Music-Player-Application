import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/resources.dart';

class Player extends StatefulWidget {
  const Player({Key? key}) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {

  List Songs = Resources.Songs;

  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  var index = null; 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //for set video imidiately after page load
    setAudio();

    // changing playing state
    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {
        isPlaying = event == PlayerState.playing;
        
      });
     });
    
    // update the song position
    audioPlayer.onPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });

    // update the song duration
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });
  }

  Future setAudio() async {
    //for set video imidiately after page load
  }


  @override
  Widget build(BuildContext context) {
    final routes = ModalRoute.of(context)?.settings.arguments as Map<String, int>;
    index = routes['index'];
    return Scaffold(
      appBar: AppBar(
        title: Text("Music Player"),
      ),
      body: Container(
        color: Colors.grey,
        width: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Image.network(Songs[index??0]["thumbnail"])
              ),
            Slider(
              min:0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(), 
              onChanged: (value) async {
                
              }
              ),
              CircleAvatar(
                child: IconButton(
                  onPressed: () async {
                    if(isPlaying == false){
                      await audioPlayer.play(AssetSource(Songs[index??0]["path"]));
                    }else{
                      await audioPlayer.pause();
                    }
                  }, 
                  icon: Icon(isPlaying==false? Icons.play_arrow:Icons.pause),),
              )
          ],
        ),
      ),
    );
  }
}