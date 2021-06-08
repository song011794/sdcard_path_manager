#import "SdcardPathManagerPlugin.h"
#if __has_include(<sdcard_path_manager/sdcard_path_manager-Swift.h>)
#import <sdcard_path_manager/sdcard_path_manager-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "sdcard_path_manager-Swift.h"
#endif

@implementation SdcardPathManagerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSdcardPathManagerPlugin registerWithRegistrar:registrar];
}
@end
