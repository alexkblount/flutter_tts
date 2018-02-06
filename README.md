# tts

A text to speech plugin for flutter. Initial implementation, more to come. :)

## Usage
To use this plugin, add `tts` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

### Example

``` dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(new Scaffold(
    body: new Center(
      child: new RaisedButton(
        onPressed: speak,
        child: new Text('Say Hello'),
      ),
    ),
  ));
}

speak() async {
  Tts.speak('Hello World');
}

```

## Languages

You can get a list of available languages (voices) supported by the OS by calling:

``` dart
final languages = await Tts.getAvailableLanguages();
```

Checking to see if a languge can be used:

``` dart
var isGoodLanguage = await Tts.isLanguageAvailable(lang);
```

Setting a deisred language:

``` dart
var setLanguage = await Tts.setLanguage(lang);
```


