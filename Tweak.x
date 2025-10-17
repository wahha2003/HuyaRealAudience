#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <Foundation/Foundation.h>

@interface HYLiveRoomImmersionVipEnterView : UIControl
- (id)formattedToatalCount:(NSInteger)arg1;
@end

%hook HYLiveRoomImmersionVipEnterView

- (id)formattedToatalCount:(NSInteger)arg1 {
    // 参数 <= 9999，执行原方法
    if (arg1 <= 9999) {
        return %orig(arg1);
    }
    
    // 参数 > 9999，返回 x.xxxxw 格式
    double countInW = arg1 / 10000.0;
    
    // 保留四位小数并去掉尾部多余 0
    NSString *result = [NSString stringWithFormat:@"%.4f", countInW];
    
    // 去掉尾部多余 0 和小数点，如果是整数
    NSDecimalNumber *num = [NSDecimalNumber decimalNumberWithString:result];
    result = [num stringValue]; // 自动去掉尾部 0
    result = [result stringByAppendingString:@"w"];
    
    // ARC 友好，直接返回 NSString
    return result;
}

%end