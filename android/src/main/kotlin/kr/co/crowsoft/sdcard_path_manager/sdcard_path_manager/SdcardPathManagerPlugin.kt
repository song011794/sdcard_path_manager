package kr.co.crowsoft.sdcard_path_manager.sdcard_path_manager

import android.content.Context
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** SdcardPathManagerPlugin */
class SdcardPathManagerPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var context: Context
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "sdcard_path_manager")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "isExistAvailableSDCardMemory" -> {
        result.success(Storage.isExistAvailableSDCardMemory(context))
      }

      "mkdirMemoryPath" -> {
        val dirName = call.argument<String>("dirName")
        result.success(Storage.mkdirMemoryPath(context, dirName!!))
      }

      "mkdirSDCardMemoryPath" -> {
        val dirName = call.argument<String>("dirName")
        result.success(Storage.mkdirSDCardMemoryPath(context, dirName!!))
      }

      "getMemoryPath" -> {
        val dirName = call.argument<String>("dirName")
        result.success(Storage.getMemoryPath(context, dirName))
      }

      "getSDCardMemoryPath" -> {
        val dirName = call.argument<String>("dirName")
        result.success(Storage.getSDCardMemoryPath(context, dirName))
      }

      "getAvailableMemorySize"-> {
        result.success(Storage.getAvailableMemorySize(context))
      }
      "getAvailableSDCardMemorySize"-> {
        result.success(Storage.getAvailableSDCardMemorySize(context))
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
