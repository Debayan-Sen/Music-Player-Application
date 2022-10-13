import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Player extends StatefulWidget {
  const Player({Key? key}) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {

  List Songs = [
    {
      "name": "Ami sudhu khujechi amay",
      "thumbnail":"https://is1-ssl.mzstatic.com/image/thumb/Music114/v4/4b/26/ef/4b26ef6a-bb5a-50ec-7e68-0baee4c1f83b/5059074614465.jpg/375x375bb.jpg",
      "path":"songs/Ami_sudhu_khujechi_amay.mp3",
      "artist":"Taalpatar Sepai",
      "genre":"Indian Film Pop"
    },
    {
      "name": "Jogi",
      "thumbnail":"https://i.scdn.co/image/ab67616d0000b27316f7c961e44c0116cd736db6",
      "path":"songs/Jogi.mp3",
      "artist":"Akanksha Sharma and Yasser Desai",
      "genre":"Romance"
    },
    {
      "name": "Kesariya",
      "thumbnail":"https://akm-img-a-in.tosshub.com/aajtak/images/story/202207/kesariya_song_alia_bhatt_ranbir_kapoor-sixteen_nine.png",
      "path":"songs/Kesariya.mp3",
      "artist":"Arijit Singh, Amitabh Bhattacharya, Pritam Chakraborty",
      "genre":"Romance"
    },
    {
      "name": "Kun Faya Kun",
      "thumbnail":"https://i.scdn.co/image/ab67616d0000b27354e544672baa16145d67612b",
      "path":"songs/Kun_Faya_Kun.mp3",
      "artist":"A. R. Rahman, Javed Ali, and Mohit Chauhan",
      "genre":"Sufi"
    },
    {
      "name": "Main Agar Kahoon",
      "thumbnail":"https://images.genius.com/cd6e2060b1ec76cc087edde972ef8e28.1000x750x1.jpg",
      "path":"songs/Main_Agar_Kahoon.mp3",
      "artist":"Shreya Ghoshal and Sonu Nigam",
      "genre":"Romance"
    },
    {
      "name": "Mera Mann Kehne Laga",
      "thumbnail":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuxZ8ZDtNdtN3sF9QP-biYSBNt3H93ep-d3Q&usqp=CAU",
      "path":"songs/Mera_Mann_Kehne_Laga.mp3",
      "artist":"Falak Shabir",
      "genre":"Pop"
    },
    {
      "name": "Moddhorate",
      "thumbnail":"https://i.scdn.co/image/ab67616d0000b27319f7a13ec1d7988194e651ad",
      "path":"songs/Moddhorate.mp3",
      "artist":"Taalpatar Sepai",
      "genre":"Indian Film Pop"
    },
    {
      "name": "Sunflower",
      "thumbnail":"https://www.pluggedin.com/wp-content/uploads/2020/01/Post_Malone__Sunflower__Large-1024x587.jpg",
      "path":"songs/Sunflower.mp3",
      "artist":"Post Malone, Swae Lee",
      "genre":"Hip-Hop"
    },
    {
      "name": "The Nights",
      "thumbnail":"https://i.scdn.co/image/ab67616d0000b2730ae4f4d42e4a09f3a29f64ad",
      "path":"songs/The_Nights.mp3",
      "artist":"Avicii",
      "genre":"Electronic dance music"
    },
  ];

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