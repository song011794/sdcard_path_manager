
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SdcardPathManager {
  static const MethodChannel _channel =
      const MethodChannel('sdcard_path_manager');


  static Future<bool> get isExistAvailableSDCardMemory async {
    return await _channel.invokeMethod('isExistAvailableSDCardMemory');
  }

  static Future<bool> mkdirMemoryPath({required String dirName}) async {
    return await _channel.invokeMethod('mkdirMemoryPath',<String, dynamic>{
      'dirName': dirName
    }) ;
  }

  static Future<bool> mkdirSDCardMemoryPath({required String dirName}) async {
    return await _channel.invokeMethod('mkdirSDCardMemoryPath',<String, dynamic>{
      'dirName': dirName
    }) ;
  }


  static Future<String> getMemoryPath({String? dirName}) async {
    return await _channel.invokeMethod('getMemoryPath',<String, dynamic>{
      'dirName': dirName
    }) ;
  }

  static Future<String> getSDCardMemoryPath({String? dirName}) async {
    return await _channel.invokeMethod('getSDCardMemoryPath',<String, dynamic>{
      'dirName': dirName
    }) ;
  }


  static Future<int> get getAvailableMemorySize async {
    return await _channel.invokeMethod('getAvailableMemorySize');
  }

  static Future<int> get getAvailableSDCardMemorySize async {
    return await _channel.invokeMethod('getAvailableSDCardMemorySize');
  }
}
