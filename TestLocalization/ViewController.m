//
//  ViewController.m
//  TestLocalization
//
//  Created by ivy on 16/10/24.
//  Copyright © 2016年 ivy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

-(void )testDataDetectorNumber{
    NSString * string = @"欢迎访问http://www.jianshu.com/users/72ee5da886ff/latest_articles. 咱的电话是012-1304445928.ps:电话随便写的哟.今天是2016-10-25,天气(weather)不错";
    
    NSError * error = nil;
    NSDataDetector * detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink|NSTextCheckingTypePhoneNumber error:&error];
    
    
    NSUInteger numberOfMatches = [detector numberOfMatchesInString:string
                                                           options:0
                                                             range:NSMakeRange(0, [string length])];
    
    NSLog(@"共找到%lu处匹配",(unsigned long)numberOfMatches);
}


-(void )testDataDetectorMatches{
    
    NSString * string = @"欢迎访问http://www.jianshu.com/users/72ee5da886ff/latest_articles. 咱的电话是012-1304445928.ps:电话随便写的哟.今天是2016-10-25,天气(weather)不错";
    NSError * error = nil;
    NSDataDetector * detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink|NSTextCheckingTypePhoneNumber error:&error];
    
    NSArray *matches = [detector matchesInString:string
                                         options:0
                                           range:NSMakeRange(0, [string length])];
    for (NSTextCheckingResult *match in matches) {
        NSRange matchRange = [match range];
        if ([match resultType] == NSTextCheckingTypeLink) {
            NSURL *url = [match URL];
            NSLog(@"url:%@", url);
        } else if ([match resultType] == NSTextCheckingTypePhoneNumber) {
            NSString *phoneNumber = [match phoneNumber];
            NSLog(@"phoneNumber:%@", phoneNumber);
        }
    }
    
    
}


-(void )testDataDetectorBlock{
    NSString * string = @"欢迎访问http://www.jianshu.com/users/72ee5da886ff/latest_articles. 咱的电话是012-1304445928.ps:电话随便写的哟.今天是2016-10-25,天气(weather)不错";
    NSError * error = nil;
    NSDataDetector * detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeRegularExpression error:&error];
    
    
    __block NSUInteger count = 0;
    [detector enumerateMatchesInString:string options:0 range:NSMakeRange(0, [string length]) usingBlock:^(NSTextCheckingResult * _Nullable match, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        
        NSLog(@"flag:%lu",(unsigned long)flags);
        NSRange matchRange = [match range];
        
        if ([match resultType] == NSTextCheckingTypeLink) {
            NSURL *url = [match URL];
            NSLog(@"url:%@", url);
            
            //NSRange matchRange = [match range];
           
            
        }
        //if (count == 0) *stop = YES;
        
        if ([match resultType] == NSTextCheckingTypePhoneNumber) {
            NSString *phoneNumber = [match phoneNumber];
            NSLog(@"phoneNumber:%@", phoneNumber);
        }
        
        if ([match resultType] == NSTextCheckingTypeDate) {
            NSDate *date = [match date];
            NSLog(@"date:%@", date);
            
            NSTimeZone * timezone = [match timeZone];
            NSLog(@"time zone:%@", timezone);

            CFTimeInterval duration = [match duration];
            NSLog(@"duration:%f", duration);

            
        }
        
        if ([match resultType] == NSTextCheckingTypeAddress) {
             NSDictionary<NSString *, NSString *> * addressComponent = [match addressComponents];
            NSLog(@"城市:%@, 街道:%@", addressComponent[NSTextCheckingCityKey], addressComponent[NSTextCheckingStreetKey]);
        }
        

        
    }];
}

-(BOOL) verifyURL{
    NSString * string = @"http://www.jianshu.com/users/72ee5da886ff/latest_articles";
    NSError * error = nil;
    NSDataDetector * detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:&error];
    
    NSArray<NSTextCheckingResult *> * matches = [detector matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    if ([matches count] == 1 &&  matches[0].range.location == 0) {
        return YES;
    }
    
    return NO;
}

- (IBAction)click:(id)sender {
   // [self testDataDetectorBlock];
    [self verifyURL];
}

- ( void) testString{
    NSString * str = @"ivy是个,不错 的鸟儿";
    NSString * str1 = @"ivy是个不错的鸟儿";
    
    [str enumerateSubstringsInRange:NSMakeRange(0, str.length) options:NSStringEnumerationByWords usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        NSLog(@"%@",substring);
    }];
    
    [str1 enumerateSubstringsInRange:NSMakeRange(0, str1.length) options:NSStringEnumerationByWords usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        NSLog(@"%@",substring);
    }];
    
    NSRange range =  [str1 rangeOfComposedCharacterSequenceAtIndex:5];
    NSString * tmp = [str1 substringWithRange:range];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    
    NSString * languageID = [[[UIApplication sharedApplication ] textInputMode] primaryLanguage];
    NSLog(@"did begin : %@,-- %@", languageID, textView.markedTextRange );
    return YES;
}

@end
