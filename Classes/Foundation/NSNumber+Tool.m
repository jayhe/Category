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

- (NSString *)hcf_toChineseCharacter
{
    return [self hcf_chineseCharacterFromNumber];
}

- (NSString *)hcf_toLetter
{
    return [self hcf_numberToLetter];
}

- (NSString *)hcf_toPrice
{
    return [self hcf_numberToPrice];
}

#pragma mark - Private Methods

- (NSString *)hcf_chineseCharacterFromNumber
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

- (NSString *)hcf_numberToLetter
{
    //0-A 1-B类推
    NSMutableString *returnLetter = [NSMutableString string];
    [self hcf_reverseNumberToLetter:self.integerValue returnString:returnLetter];
    return returnLetter;
}

- (NSString *)hcf_numberToPrice
{
    return [self hcf_decimalNumberWithPrice:self.floatValue];
}

- (NSDecimalNumber *)hcf_decimalNumberWithString:(NSString *)string
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

- (NSString *)hcf_decimalNumberWithPrice:(float)price
{
    NSString *string = [NSString stringWithFormat:@"%.2f",price];
    
    NSDecimalNumber *total = [self hcf_decimalNumberWithString:string];
    NSString *priceStr = [NSString stringWithFormat:@"%@",total];
    return priceStr;
}


- (void)hcf_reverseNumberToLetter:(NSInteger)number returnString:(NSMutableString *)retrunString
{
    NSString * const lettersStr = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSInteger letterCount = lettersStr.length;
    if (number >= 0)
    {
        NSInteger reminder = number%letterCount;
        [retrunString insertString:[lettersStr substringWithRange:NSMakeRange(reminder, 1)] atIndex:0];
        [self hcf_reverseNumberToLetter:number/letterCount - 1 returnString:retrunString];
    }
}

@end
