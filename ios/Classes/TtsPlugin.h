#import <Flutter/Flutter.h>
@import AVFoundation;

@interface TtsPlugin : NSObject<FlutterPlugin>
@property (readwrite, nonatomic, strong) AVSpeechSynthesizer *speechSynthesizer;
@property (strong) NSString *locale;
@end
