import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:widget_to_image/widget_to_image.dart';
import 'package:permission_handler/permission_handler.dart';

void main(){
  runApp(MaterialApp(
    home: Home(),
    showSemanticsDebugger: false,
  ));
}
class Home extends StatefulWidget{
  HomeState createState()=>HomeState();
}
class HomeState extends State<Home>{

  var _image;
  GlobalKey _key=GlobalKey();

   PickImage()async{
     XFile? image=await ImagePicker().pickImage(source: ImageSource.gallery);
     
     setState(() {
       _image=File(image!.path);
     });
   }


   ImageSavePermission()async{
await [Permission.storage].request();
   }


   SaveImage()async{
     ImageSavePermission();
     ByteData image=await WidgetToImage.repaintBoundaryToImage(_key,pixelRatio: 3.0);

    await ImageGallerySaver.saveImage(image.buffer.asUint8List(),quality: 100);

    Fluttertoast.showToast(msg: "Image Saved Successfully");


   }
  
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text("Image Frame Example"),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [


              Card(
                child: Container(
                  height: 350,
                  width: MediaQuery.of(context).size.width,
                  child: RepaintBoundary(
                    key: _key,
                    child: Stack(
                      children: [
                        _image==null?Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child:Opacity(
                                opacity: 0.6,
                                child: Image.asset("assets/image_picker.jpg",scale: 9,))):Image.file(_image,fit: BoxFit.cover,width: MediaQuery.of(context).size.width,height: 350,),
                                  GestureDetector(
                                    onTap: (){
                                      PickImage();
                                    },
                                      child: Image.asset("assets/frame.png",fit: BoxFit.contain,
                                  )),

                      ],
                    ),
                  )
                ),
              ),

              RaisedButton(onPressed: (){

SaveImage();

              },child: Text("Save",style: TextStyle(color: Colors.white),),color: Colors.deepPurpleAccent,),


            ],
          ),
        ),
      ),
    );

  }

}