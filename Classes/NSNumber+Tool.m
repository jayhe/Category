//
//  NSNumber+Tool.m
//  Tool
//
//  Created by hechao on 16/12/2.
//  Copyright © 2016年 hc. All rights reserved.
//

#import "NSNumber+Tool.h"

#define HC_DEFAULT_FORMAT @"yyyy-MM-dd HH:mm:ss"

@implementation NSNumber (Tool)

#pragma mark - Custom Methods

- (NSString *)timeWithFormat:(NSString *)format
{
    return [self timeStringWithFormat:format];
}

- (NSString *)toChineseCharacter
{
    return [self chineseCharacterFromNumber];
}

- (NSString *)toLetter
{
    return [self numberToLetter];
}

- (NSString *)toPrice
{
    return [self numberToPrice];
}

#pragma mark - Private Methods

- (NSString *)timeStringWithFormat:(NSString *)format
{
    NSTimeInterval timeInterval = timeIntervalToShortStyle(self.longLongValue);
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = format?format:HC_DEFAULT_FORMAT;
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans_CN"];
    });
    //只有在format变了之后才重新设置
    if (![format isEqualToString:formatter.dateFormat])
    {
        formatter.dateFormat = format?format:HC_DEFAULT_FORMAT;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    return [formatter stringFromDate:date];
}

- (NSString *)chineseCharacterFromNumber
{
    if (self.integerValue == 0)
    {
        return @"零";
    }
    static NSNumberFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
        NSLocale *zhLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans_CN"];
        formatter.locale = zhLocale;
    });
    NSMutableString *tmpString = [formatter stringFromNumber:self].mutableCopy;
    return [tmpString stringByReplacingOccurrencesOfString:@"〇" withString:@"零"];
}

- (NSString *)numberToLetter
{
    //0-A 1-B类推
    NSMutableString *returnLetter = [NSMutableString string];
    [self reverseNumberToLetter:self.integerValue returnString:returnLetter];
    return returnLetter;
}

- (NSString *)numberToPrice
{
    return [self decimalNumberWithPrice:self.floatValue];
}

- (NSDecimalNumber *)decimalNumberWithString:(NSString *)string
{
    NSDecimalNumber *subtotal = [NSDecimalNumber decimalNumberWithString:string];
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                                                             scale:2
                                                                                  raiseOnExactness:NO
                                                                                   raiseOnOverflow:NO
                                                                                  raiseOnUnderflow:NO
                                                                               raiseOnDivideByZero:YES];
    NSDecimalNumber *total = [subtotal decimalNumberByRoundingAccordingToBehavior:roundUp];
    return total;
}

- (NSString *)decimalNumberWithPrice:(float)price
{
    NSString *string = [NSString stringWithFormat:@"%.2f",price];
    
    NSDecimalNumber *total = [self decimalNumberWithString:string];
    NSString *priceStr = [NSString stringWithFormat:@"%@",total];
    return priceStr;
}


- (void)reverseNumberToLetter:(NSInteger)number returnString:(NSMutableString *)retrunString
{
    NSString * const lettersStr = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSInteger letterCount = lettersStr.length;
    if (number >= 0)
    {
        NSInteger reminder = number%letterCount;
        [retrunString insertString:[lettersStr substringWithRange:NSMakeRange(reminder, 1)] atIndex:0];
        [self reverseNumberToLetter:number/letterCount - 1 returnString:retrunString];
    }
}


long long timeIntervalToShortStyle(long long interval)
{
    return @(interval).stringValue.length > 10?interval/1000:interval;
}


@end
