import 'dart:async';

import 'package:flutter/services.dart';

class Tts {
  static const MethodChannel _channel =
      const MethodChannel('github.com/blounty-ak/tts');

    static void speak (String text) => _channel.invokeMethod('speak', <String, Object>{
      'text': text});
}
