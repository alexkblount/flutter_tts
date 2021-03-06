#import "TtsPlugin.h"


@implementation TtsPlugin



+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"github.com/blounty-ak/tts"
            binaryMessenger:[registrar messenger]];
  TtsPlugin* instance = [[TtsPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (instancetype)init {
    self.speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    return self;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"speak" isEqualToString:call.method]) {
      [self speak:call.arguments[@"text"]];
  } else if ([@"isLanguageAvailable" isEqualToString:call.method]) {
      BOOL isAvailable = [self isLanguageAvailable:call.arguments[@"language"]];
      result(@(isAvailable));
  } else if ([@"setLanguage" isEqualToString:call.method]) {
      BOOL success = [self setLanguage:call.arguments[@"language"]];
      result(@(success));
  } else if ([@"getAvailableLanguages" isEqualToString:call.method]) {
      result([self getLanguages]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (BOOL) isLanguageAvailable:(NSString*) locale {
    NSArray<AVSpeechSynthesisVoice*> *voices = [AVSpeechSynthesisVoice speechVoices];
    for (AVSpeechSynthesisVoice* voice in voices) {
        if([voice.language isEqualToString:locale])
            return YES;
    }
    return NO;
}

-(BOOL) setLanguage:(NSString*) locale {
    if([self isLanguageAvailable:locale]){
        self.locale = locale;
        return YES;
    }
    return NO;
}

-(NSArray*) getLanguages {
    NSMutableArray* languages = [[NSMutableArray alloc] init];
    for (AVSpeechSynthesisVoice* voice in [AVSpeechSynthesisVoice speechVoices]) {
        [languages addObject:voice.language];
    }
    NSArray *arr = [languages copy];
    return arr;
    
}

-(void)speak:(NSString*) text {
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:text];
    if(self.locale != nil){
        AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:self.locale];
        utterance.voice = voice;
    }
    [self.speechSynthesizer speakUtterance:utterance];
    
}

@end
