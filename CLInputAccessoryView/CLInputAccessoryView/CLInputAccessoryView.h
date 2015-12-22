//
//  CLInputAccessoryView.h
//  CLInputAccessoryView
//
//  Created by 李辉 on 15/12/22.
//  Copyright © 2015年 李辉. All rights reserved.
//  https://github.com/changelee82/CLInputAccessoryView
//

#import <UIKit/UIKit.h>


/** 键盘上方的工具条协议 */
@protocol CLInputAccessoryViewDelegete <NSObject>

@optional

/** 点击左侧按钮后调用此方法，返回值为YES，则隐藏键盘 */
- (BOOL)leftButtonDidClick:(id)textView;

/** 点击右侧按钮后触发此方法，返回值为YES，则隐藏键盘 */
- (BOOL)rightButtonDidClick:(id)textView;

@end



/** 点击输入框后，为弹出键盘添加上方的工具条 */
@interface CLInputAccessoryView : NSObject

/** 初始化方法，用于从代码中创建的类实例 */
- (instancetype)initWithLeftButtonText:(NSString *)leftButtonText
                       rightButtonText:(NSString *)rightButtonText
                       leftButtonColor:(UIColor *)leftButtonColor
                      rightButtonColor:(UIColor *)rightButtonColor
                        leftButtonFont:(UIFont *)leftButtonFont
                       rightButtonFont:(UIFont *)rightButtonFont
                       backgroundColor:(UIColor *)backgroundColor;

/** 点击按钮事件的委托 */
@property (nonatomic, weak) id<CLInputAccessoryViewDelegete> delegate;


/** 左侧按钮文字 */
@property (nonatomic, copy) NSString *leftButtonText;
/** 左侧按钮文字颜色 */
@property (nonatomic, strong) UIColor *leftButtonColor;
/** 左侧按钮文字字体 */
@property (nonatomic, strong) UIFont *leftButtonFont;

/** 右侧按钮文字 */
@property (nonatomic, copy) NSString *rightButtonText;
/** 右侧按钮文字颜色 */
@property (nonatomic, strong) UIColor *rightButtonColor;
/** 右侧按钮文字字体 */
@property (nonatomic, strong) UIFont *rightButtonFont;


/** 背景颜色 */
@property (nonatomic, strong) UIColor *backgroundColor;


/** 添加被监控的输入框，目前只支持UITextView和UITextField */
- (BOOL)addControlledTextView:(id)textView;

@end
