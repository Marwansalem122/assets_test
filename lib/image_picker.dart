import 'dart:io';

import 'package:assets_test/videoplayer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyImagePicker extends StatefulWidget {
  const MyImagePicker({super.key});

  @override
  State<MyImagePicker> createState() => _MyImagePickerState();
}

class _MyImagePickerState extends State<MyImagePicker> {
   final ImagePicker picker=ImagePicker();
    File? image;
 
   uploadImage(ImageSource source)async{
         var pickedimage = await picker.pickImage(source: source);
         if(pickedimage!=null){
         
          setState(() {
             image=File(pickedimage.path);
          });
         }
  }

  @override
  Widget build(BuildContext context) {
     var w=MediaQuery.of(context).size.width;
    var h=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
               
                // ignore: unnecessary_null_comparison
                Container(width:w ,height:h*0.5,child:image!=null?Image.file(image!):Center(child: const Text("No photo"))),
                 Padding(
                   padding:  EdgeInsets.symmetric(horizontal: w*0.2,),
                           child: MaterialButton(
                            onPressed: ()=>uploadImage(ImageSource.camera),
                            color: Colors.blue,
                            child:const  Text("Camera"),
                            shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)
                            ),
                            ),
                 ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: w*0.2,),
                  child: MaterialButton(
                    onPressed: ()=>uploadImage(ImageSource.gallery),
                    color: Colors.blue,
                    child:Text("Gallary"),
                    shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)
                            ),
                    ),

                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: w*0.2,),
                  child: MaterialButton(
                    onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VideoPalyer()));
                  },color: Colors.blue,
                  child: Text("Video assets"),
                  shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)
                            ),
                  ),
                )
              
        ],
      ),
    );
  }
}