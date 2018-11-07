package com.blounty.tts;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import android.app.Activity;
import android.speech.tts.TextToSpeech;
import android.speech.tts.TextToSpeech.OnInitListener;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Set;
import java.util.StringTokenizer;

import android.widget.Toast;

/**
 * TtsPlugin
 */
public class TtsPlugin implements MethodCallHandler, OnInitListener {

  private final Activity activity;
  private TextToSpeech myTTS;
  /**
   * Plugin registration.
   */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "github.com/blounty-ak/tts");

    channel.setMethodCallHandler(new TtsPlugin(registrar.activity()));
  }

    private TtsPlugin(Activity activity) {
        this.activity = activity;
        myTTS = new TextToSpeech(activity, this);
    }
//plugin.
  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("speak")) {
      String text = call.argument("text");
      speak(text);
    } else if (call.method.equals("isLanguageAvailable")) {
      String language = call.argument("language");
      final Boolean isAvailable = isLanguageAvailable(language);
      result.success(isAvailable);
    } else if (call.method.equals("setLanguage")) {
        String language = call.argument("language");
        final Boolean success = setLanguage(language);
        result.success(success);
    } else if (call.method.equals("getAvailableLanguages")) {
        result.success(getAvailableLanguages());
    }
    else {
      result.notImplemented();
    }
  }

public void onInit(int initStatus) {
  if (initStatus == TextToSpeech.ERROR) {
    Toast.makeText(this.activity, "Sorry! Text To Speech failed...", Toast.LENGTH_LONG).show();
  }
}

  void speak(String text) {
    myTTS.speak(text, TextToSpeech.QUEUE_FLUSH, null);
  }

  Boolean isLanguageAvailable(String locale) {
    Boolean isAvailable = false;
    try {
      isAvailable = myTTS.isLanguageAvailable(stringToLocale(locale)) == TextToSpeech.LANG_COUNTRY_AVAILABLE;
    } finally {
      return isAvailable;
    }
  }

  Boolean setLanguage(String locale) {
      Boolean success = false;
      try {
          myTTS.setLanguage(stringToLocale(locale));
          success = true;
      } finally {
          return success;
      }

  }

    List<String> getAvailableLanguages() {
      Set<Locale> locales = myTTS.getAvailableLanguages();
      List<String> localeList = new ArrayList<String>();
      for (Locale locale : locales) {
            localeList.add(locale.toString().replace("_", "-"));
      }
      return localeList;
  }

  private Locale stringToLocale(String locale) {
    String l = null;
    String c = null;
    StringTokenizer tempStringTokenizer = new StringTokenizer(locale,"-");
    if(tempStringTokenizer.hasMoreTokens()){
      l = tempStringTokenizer.nextElement().toString();
    }
    if(tempStringTokenizer.hasMoreTokens()){
      c = tempStringTokenizer.nextElement().toString();
    }
    return new Locale(l,c);
}
}
