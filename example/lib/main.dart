import 'package:flutter/material.dart';
import 'package:tts/tts.dart';
import 'dart:math';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
final TextEditingController speechTextController = new TextEditingController();
String languageAvailableText = '';
List<String> languages;
Random rng = new Random();
  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    
    languages = await Tts.getAvailableLanguages();
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted)
      return;
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Plugin example app'),
        ),
        body: new Center(
          child: new Column(
            children: <Widget>[
              new TextField(
                controller: speechTextController,
              ),
              new MaterialButton(
                color: Colors.blue,
                  onPressed: () async{
                    var lang = languages[rng.nextInt(languages.length-1)];
                    var isGoodLanguage = await Tts.isLanguageAvailable(lang);
                    var setLanguage = await Tts.setLanguage(lang);
                    Tts.speak(speechTextController.text);
                  },
                child: new Text('Do Speak'),
              ),
              new Text(languageAvailableText)
            ],
          ),
        ),
      ),
    );
  }
}
