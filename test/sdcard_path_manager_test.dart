import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sdcard_path_manager/sdcard_path_manager.dart';

void main() {
  const MethodChannel channel = MethodChannel('sdcard_path_manager');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {

  });
}
