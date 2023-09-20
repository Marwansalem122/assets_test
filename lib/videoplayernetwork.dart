
import 'package:assets_test/videoplayerfiles.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPalyerNetwork extends StatefulWidget {
  const VideoPalyerNetwork({super.key});

  @override
  State<VideoPalyerNetwork> createState() => _VideoPalyerNetworkState();
}

class _VideoPalyerNetworkState extends State<VideoPalyerNetwork> {
  bool ismuted=false;
   late IconData playIcon=Icons.play_arrow;
  late VideoPlayerController controller;
  @override
  void initState() {
    controller=VideoPlayerController.networkUrl(Uri.parse("https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"))..initialize().then((value) {
      
      controller.addListener(() {
          if (controller.value.position >= controller.value.duration) {
            setState(() {
              playIcon = Icons.play_arrow;
            });
          }
          else{
                   playIcon = Icons.pause;
          }
        });
        setState(() {});
      });
   // 
    super.initState();
  }
   @override
  void dispose() {
    super.dispose();
   
    controller.dispose();
  
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
              controller.value.isPlaying
                  ? controller.pause()
                  : controller.play();
                  playIcon = controller.value.isPlaying ? Icons.pause : Icons.play_arrow;
            });
          },
          child: Icon(
           playIcon
          ),
        ),
        SizedBox(height: h*0.02,),
        FloatingActionButton(onPressed: ()async{
                Duration? d=await controller.position;
                var value=d! + Duration(seconds: 10);
                controller.seekTo(value);
              },child: Text(">>")),
        SizedBox(height: h*0.02,),
        FloatingActionButton(onPressed: ()async{
                Duration? d2=await controller.position;
                var value2=d2! - Duration(seconds: 10);
                controller.seekTo(Duration(seconds:value2.inSeconds));
              },child: Text("<<")),
        SizedBox(height: h*0.02,),
        FloatingActionButton(onPressed: (){

                 controller.setVolume(ismuted?1:0);
                 setState(() {
                   
                 });
                 ismuted=!ismuted;
              },child: ismuted?Icon(Icons.volume_off_outlined):Icon(Icons.volume_up),)
        ],
       ),
      body: ListView(
        children: [
         
          controller.value.isInitialized?AspectRatio(
            aspectRatio:controller.value.aspectRatio, 
           child: VideoPlayer(controller)):Container(color: Colors.black
           ,),
            VideoProgressIndicator(controller , allowScrubbing: true),
             Padding(
               padding:  EdgeInsets.symmetric(horizontal:w*0.25,vertical: h*0.1),
               child: MaterialButton(onPressed: (){
                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VidoPlayerFiles()));
               },child: Text("Go Video Assets"),color: Colors.blue,),
             )
        ], 
      ),
    );
  }
}