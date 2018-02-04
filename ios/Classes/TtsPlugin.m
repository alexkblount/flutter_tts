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
  } else {
    result(FlutterMethodNotImplemented);
  }
}

-(void)speak:(NSString*) text {
    [self.speechSynthesizer speakUtterance:[[AVSpeechUtterance alloc] initWithString:text]];
    
}

@end
