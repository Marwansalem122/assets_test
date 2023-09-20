import 'package:assets_test/videoplayernetwork.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPalyer extends StatefulWidget {
  const VideoPalyer({super.key});

  @override
  State<VideoPalyer> createState() => _VideoPalyerState();
}

class _VideoPalyerState extends State<VideoPalyer> {
  late IconData playIcon=Icons.play_arrow;
  bool ismuted=false;
  late VideoPlayerController videocontroller;
  @override
  void initState() {
     videocontroller=VideoPlayerController.asset("assets/videos/v1.mp4")..initialize().then((value) {
      videocontroller.addListener(() {
          if (videocontroller.value.position >= videocontroller.value.duration) {
            setState(() {
              playIcon = Icons.play_arrow;
            });
          }
          else{
                   playIcon = Icons.pause;
          }
        });
      setState(() {
        
      });
     });

    super.initState();
  }
   @override
  void dispose() {
    super.dispose();
    videocontroller.dispose();
    
  }
  @override
  Widget build(BuildContext context) {
     var w=MediaQuery.of(context).size.width;
    var h=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
       floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        //crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
          onPressed: () {
            setState(() {
              videocontroller.value.isPlaying
                  ? videocontroller.pause()
                  : videocontroller.play();
              playIcon = videocontroller.value.isPlaying ? Icons.pause : Icons.play_arrow;
                
            });
          },
          child: Icon(playIcon    ),
        ),
        SizedBox(height: h*0.02,),
        FloatingActionButton(onPressed: ()async{
              
                Duration? d=await videocontroller.position;
                var value=d! + Duration(seconds: 10);
                videocontroller.seekTo(value);
              },child: Text(">>")),
              SizedBox(height: h*0.02,),
            FloatingActionButton(onPressed: ()async{
                Duration? d2=await videocontroller.position;
                var value2=d2! - Duration(seconds: 10);
                videocontroller.seekTo(Duration(seconds:value2.inSeconds));
              },child: Text("<<")),
              SizedBox(height: h*0.02,),
              FloatingActionButton(onPressed: (){

                 videocontroller.setVolume(ismuted?1:0);
                 setState(() {
                   
                 });
                 ismuted=!ismuted;
              },child: ismuted?Icon(Icons.volume_off_outlined):Icon(Icons.volume_up),)
        ],
       ),
      body: ListView(
        children: [
         
          videocontroller.value.isInitialized?Container(
            height: h*0.7, 
           child: VideoPlayer(videocontroller)):Container(color: Colors.black
           ,),
           VideoProgressIndicator(videocontroller , allowScrubbing: true),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal:w*0.25,vertical: h*0.1),
                child: MaterialButton(onPressed: (){
                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VideoPalyerNetwork()));
                           },child: Text("Go Video Networks"),color: Colors.blue ),
              )
            
        ],
      ),
    );
  }
}