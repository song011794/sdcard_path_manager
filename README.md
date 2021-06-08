# sdcard_path_manager

Get the path and size of SD from Android.

## Getting Started

Please see the following code

```dart
    var isExistAvailableSDCardMemory = await SdcardPathManager.isExistAvailableSDCardMemory;

    var downPath = await  SdcardPathManager.getMemoryPath(dirName: 'download');
    var freeSize = await SdcardPathManager.getAvailableMemorySize;
    
    var downSDPath = await SdcardPathManager.getSDCardMemoryPath(dirName: 'download') ;
    var freeSDSize = await SdcardPathManager.getAvailableSDCardMemorySize ;
```