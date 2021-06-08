import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:sdcard_path_manager/sdcard_path_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var myTextSyle = TextStyle(fontSize: 20);

  bool _isExistAvailableSDCardMemory = false ;
  String _downPath  = '' ;
  String _downSDPath = '' ;
  int _freeSize = 0 ;
  int _freeSDSize = 0 ;


  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    var isExistAvailableSDCardMemory = await SdcardPathManager.isExistAvailableSDCardMemory;

    var downPath = await  SdcardPathManager.getMemoryPath(dirName: 'download');
    var freeSize = await SdcardPathManager.getAvailableMemorySize;
    
    var downSDPath = await SdcardPathManager.getSDCardMemoryPath(dirName: 'download') ;
    var freeSDSize = await SdcardPathManager.getAvailableSDCardMemorySize ;
    
    if (!mounted) return;
    setState(() {
      _isExistAvailableSDCardMemory = isExistAvailableSDCardMemory ;
      _downPath = downPath ;  
      _freeSize = freeSize ; 
      
      _downSDPath = downSDPath; 
      _freeSDSize = freeSDSize;

    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Text('isExistAvailableSDCardMemory : $_isExistAvailableSDCardMemory', style: myTextSyle,),
              SizedBox(height: 30),
              Text('getMemoryPath : \n$_downPath', style: myTextSyle,),
              SizedBox(height: 30),
              Text('getAvailableMemorySize : $_freeSize',   style: myTextSyle,),
              SizedBox(height: 30),
              Text('getSDCardMemoryPath : \n$_downSDPath', style: myTextSyle,),
              SizedBox(height: 30),
              Text('getAvailableSDCardMemorySize : $_freeSDSize', style: myTextSyle,),
            ],
          )
        ),
      ),
    );
  }
}
