#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <Foundation/Foundation.h>

// 声明类和方法以便 Hook

@interface HYLiveRoomImmersionVipEnterView : UIControl
- (id)formattedTotalCount:(NSInteger)arg1;
@end

@interface KWLandscapeUserCountView : UIView
- (id)formattedTotalCount:(NSInteger)arg1;
@end

@interface HYYouthModeManager : NSObject
-(BOOL)todayShownYouthWindow;
@end

@interface HUYAAppPatFaceConfig : NSObject
+ (id)new;
+ (id)alloc;
@end


// Hook 实现

// 修改观众人数显示格式
%hook HYLiveRoomImmersionVipEnterView

- (id)formattedTotalCount:(NSInteger)arg1 {
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

%hook KWLandscapeUserCountView

- (id)formattedTotalCount:(NSInteger)arg1 {
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


// 永远不显示青少年模式弹窗
%hook HYYouthModeManager

-(BOOL)todayShownYouthWindow{
    return YES;
}

%end

// 清除广告配置
%hook HUYAAppPatFaceConfig

+ (id)new {
    return nil;
}

+ (id)alloc {
    return nil;
}

%end