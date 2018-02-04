package com.blounty.tts;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import android.app.Activity;
import android.speech.tts.TextToSpeech;
import android.speech.tts.TextToSpeech.OnInitListener;
import android.content.Intent;
import java.util.Locale;
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
    Intent checkTTSIntent = new Intent();

    checkTTSIntent.setAction(TextToSpeech.Engine.ACTION_CHECK_TTS_DATA);
      registrar.activity().startActivityForResult(checkTTSIntent, MY_DATA_CHECK_CODE);
  }

    private TtsPlugin(Activity activity) {
        this.activity = activity;
        myTTS = new TextToSpeech(activity, this);
    }
//plugin.
  @Override
  public void onMethodCall(MethodCall call, Result result) {
    String text = call.argument("text");
    if (call.method.equals("speak")) {
      speak(text);
    } else {
      result.notImplemented();
    }
  }

public void onInit(int initStatus) {
  if (initStatus == TextToSpeech.SUCCESS) {
      myTTS.setLanguage(Locale.US);
  }
  else if (initStatus == TextToSpeech.ERROR) {
    Toast.makeText(this.activity, "Sorry! Text To Speech failed...", Toast.LENGTH_LONG).show();
  }
}

  void speak(String text) {
    myTTS.speak(text, TextToSpeech.QUEUE_FLUSH, null);
  }
}
