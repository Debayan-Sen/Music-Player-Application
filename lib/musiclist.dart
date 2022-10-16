import 'package:flutter/material.dart';
import 'package:musicplayer/resources.dart';

class MusicList extends StatefulWidget {
  const MusicList({Key? key}) : super(key: key);

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {

    List Songs = Resources.Songs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Music List"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: Songs.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(15),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Image.network(Songs[index]["thumbnail"],width: 60,),
                Column(
                  children: [
                    Text(Songs[index]["name"], 
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20, 
                      fontWeight: FontWeight.bold
                      ),),
                    Text(Songs[index]["artist"], 
                    textAlign: TextAlign.left,),
                  ],
                ),
                CircleAvatar(
                  child: IconButton(onPressed: () {
                    Navigator.pushNamed(context, "/player", arguments: {'index':index});
                  },
                  icon: Icon(Icons.play_arrow),),
                )
              ],)
            );
          }
        ),
      ),
    );
  }
}