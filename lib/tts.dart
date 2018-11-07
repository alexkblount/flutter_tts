import 'dart:async';

import 'package:flutter/services.dart';

class Tts {
  static const MethodChannel _channel =
      const MethodChannel('github.com/blounty-ak/tts');

    static Future<bool> isLanguageAvailable (String language) async {
      final bool languageAvailable = await _channel.invokeMethod('isLanguageAvailable', <String, Object>{
      'language': language});
      return languageAvailable;
    }
    
    static Future<bool> setLanguage (String language) async {
      final bool isSet = await _channel.invokeMethod('setLanguage', <String, Object>{
      'language': language});
      return isSet;
    }
    
    static Future<List<String>> getAvailableLanguages () => _channel.invokeMethod('getAvailableLanguages').then((result) => result.cast<String>());

    static void speak (String text) => _channel.invokeMethod('speak', <String, Object>{
      'text': text});
}
