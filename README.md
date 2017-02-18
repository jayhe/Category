# Category
------------
[TOC]
## 功能介绍
 用类别扩展原生类的功能

* NSNumber+Tool类别
```swift
@interface NSNumber (Tool)

/**
 返回时间戳按照一定格式的时间字符串

 @param format 时间格式
 @return 时间字符串
 */
- (NSString *)timeWithFormat:(NSString *)format;


/**
 将number转换成汉字

 @return 汉字
 */
- (NSString *)toChineseCharacter;


/**
 将整形的数字转换为字母
 
 @return 字母
 */
- (NSString *)toLetter;

/**
 数字转换成价格字符串

 @return 返回价格样式的字符串
 */
- (NSString *)toPrice;

@end

```
------------------
