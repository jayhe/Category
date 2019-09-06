# Category
------------

## 功能介绍
 用类别扩展原生类的功能

* NSNumber+Tool类别
```swift
@interface NSNumber (Tool)

/**
 将number转换成汉字

 @return 汉字
 */
- (NSString *)hcf_toChineseCharacter;


/**
 将整形的数字转换为字母
 
 @return 字母
 */
- (NSString *)hcf_toLetter;

/**
 数字转换成价格字符串

 @return 返回价格样式的字符串
 */
- (NSString *)hcf_toPrice;

@end

```
------------------
