import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Image Frame Example"),
        ),
        body: Column(
          children: [

            
          ],
        ),
      ),
    );

  }

}