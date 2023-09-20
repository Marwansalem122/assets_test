import 'dart:io';

import 'package:assets_test/videoplayernetwork.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VidoPlayerFiles extends StatefulWidget {
  const VidoPlayerFiles({super.key});

  @override
  State<VidoPlayerFiles> createState() => _VidoPlayerFilesState();
}

class _VidoPlayerFilesState extends State<VidoPlayerFiles> {
   bool ismuted=false;
  late VideoPlayerController controllerfiles;
     late IconData playIcon=Icons.play_arrow;

  void initState() {
    controllerfiles = VideoPlayerController.file(new File(""))
      ..initialize().then((value) {
        controllerfiles.play();
        setState(() {

        });
      });
      controllerfiles.addListener(() {
          if (controllerfiles.value.position >= controllerfiles.value.duration) {
            setState(() {
              playIcon = Icons.play_arrow;
            });
          }
          else{
                   playIcon = Icons.pause;
          }
        });
     
   // 
    super.initState();
  }
   @override
  void dispose() {
    super.dispose();
  
    controllerfiles.dispose();
  }
   Future<File?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if( result ==null)
      return null;
    return File(result.files.single.path.toString());
  }

  @override
  Widget build(BuildContext context) {
      var w=MediaQuery.of(context).size.width;
    var h=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(onPressed: ()async{
             final file=await pickFile();
            if (file ==null) return ;
              else {
                controllerfiles = VideoPlayerController.file(file)
                  ..initialize().then((_) {
                    controllerfiles.play();
                    setState(() {});
                  });
              }
          },child: Icon(Icons.image_aspect_ratio),),
          SizedBox(height: h*0.02,),
             FloatingActionButton(
          onPressed: () {
            setState(() {
              controllerfiles.value.isPlaying
                  ? controllerfiles.pause()
                  : controllerfiles.play();
                  playIcon = controllerfiles.value.isPlaying ? Icons.pause : Icons.play_arrow;
            });
          },
          child: Icon(
           playIcon
          ),
        ),
        SizedBox(height: h*0.02,),
        FloatingActionButton(onPressed: ()async{
                Duration? d=await controllerfiles.position;
                var value=d! + Duration(seconds: 10);
                controllerfiles.seekTo(value);
              },child: Text(">>")),
        SizedBox(height: h*0.02,),
        FloatingActionButton(onPressed: ()async{
                Duration? d2=await controllerfiles.position;
                var value2=d2! - Duration(seconds: 10);
                controllerfiles.seekTo(Duration(seconds:value2.inSeconds));
              },child: Text("<<")),
        SizedBox(height: h*0.02,),
        FloatingActionButton(onPressed: (){

                 controllerfiles.setVolume(ismuted?1:0);
                 setState(() {
                   
                 });
                 ismuted=!ismuted;
              },child: ismuted?Icon(Icons.volume_off_outlined):Icon(Icons.volume_up),)
        ],
      ),
      body: ListView(
        children: [
         
          controllerfiles.value.isInitialized?AspectRatio(
            aspectRatio:controllerfiles.value.aspectRatio, 
           child: VideoPlayer(controllerfiles)):Container(color: Colors.black
           ,),
            VideoProgressIndicator(controllerfiles , allowScrubbing: true),
             Padding(
               padding:  EdgeInsets.symmetric(horizontal:w*0.25,vertical: h*0.1),
               child: MaterialButton(onPressed: (){
                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VideoPalyerNetwork()));
               },child: Text("Go Video Networks"),color: Colors.blue,),
             )
        ], 
      ),
    );
  }
}