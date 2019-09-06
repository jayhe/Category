# Category
------------

## 功能介绍
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
* UITextField+HCInputType类别
通过指定TextField的类型`hcui_inputType`、输入限制等，来达到处理TextField的输入限制的目的
支持的类型如下：
```objc
typedef NS_ENUM(NSInteger, HCTextFieldInputType) {
    HCTextFieldInputTypeDefault = 0, // 默认输入
    HCTextFieldInputTypePhoneNumber = 1, // 手机号码
    HCTextFieldInputTypeFormatedPhoneNumber, // 格式化的手机号（eg：150 1234 1234）
    HCTextFieldInputTypeFormatedCardNumber, // 格式化的卡号（4位1空格）
    HCTextFieldInputTypePrice, // 货币金额 限制金额通过设置kn_maxValue
    HCTextFieldInputTypeIdentityNo, // 身份证号码
    HCTextFieldInputTypeNumberAuthCode, // 验证码 限制位数通过设置hcui_limitLegnth
    HCTextFieldInputTypePaymentPWD, // 支付密码 限制位数通过设置hcui_limitLegnth
};
```
具体用法参照：[UITextField输入限制](https://www.jianshu.com/p/0dfbe8636115)
