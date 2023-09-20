
import 'package:assets_test/image_picker.dart';
import 'package:flutter/material.dart';


void main() {
  runApp( 
    MaterialApp(
      debugShowCheckedModeBanner: false,
    home: MyImagePicker(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Image(image: AssetImage("assets/images/h1.png",),fit:BoxFit.fill,width: 500,),),
    );
  }
}