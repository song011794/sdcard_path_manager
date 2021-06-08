import Flutter
import UIKit

public class SwiftSdcardPathManagerPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "sdcard_path_manager", binaryMessenger: registrar.messenger())
        let instance = SwiftSdcardPathManagerPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
               case "isExistAvailableSDCardMemory":
                   result(false)
                   return
                   
               case "mkdirSDCardMemoryPath":
                   result(false)
                   return
                   
               case "getSDCardMemoryPath":
                   result("")
                   return
                   
               case "getAvailableSDCardMemorySize":
                   let ret: Int64 = 0
                   result(ret)
                   return
                   
                   
               case "mkdirMemoryPath":
                   guard let parms = call.arguments as? [String: Any], let dirName = parms["dirName"] as? String  else {
                       result("")
                       return
                   }
                   let path = getMemoryPath(dirName: dirName)
                   if FileManager.default.fileExists(atPath: path) {
                       result(true)
                       return
                   }
                   else {
                       do {
                           try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: false, attributes: nil)
                       } catch{
                           result(false)
                           return
                       }
                       result(true)
                       return
                   }
               case "getMemoryPath":
                   guard let parms = call.arguments as? [String: Any]  else {
                       result("")
                       return
                   }
                let dirName = parms["dirName"] as? String
                   result(getMemoryPath(dirName:dirName))
                   return
               case "getAvailableMemorySize":
                   result(getDiskSpace(true))
                   return
                   
               default:
                   result("iOS " + UIDevice.current.systemVersion)
                   return
               }
    }
    
    func getMemoryPath(dirName: String?) -> String {
        let documents: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let documentsURL: URL = URL(fileURLWithPath: documents)
        if let checkDirName = dirName {
            let dirUrl = documentsURL.appendingPathComponent(checkDirName)
            return dirUrl.path
        }
        return documentsURL.path
    }
    
    
    
    func getDiskSpace(_ free: Bool) -> Int64 {
        var space: Int64 = 0
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let dictionary = try? FileManager.default.attributesOfFileSystem(forPath: (paths.last)!)
        if dictionary != nil {
            if free {
                let size = dictionary?[.systemFreeSize] as? NSNumber
                space = size?.int64Value ?? 0
            } else {
                let size = dictionary?[.systemSize] as? NSNumber
                space = size?.int64Value ?? 0
            }
        }
        return space
    }
    
    
}
