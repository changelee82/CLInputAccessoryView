//
//  CLInputAccessoryView.m
//  CLInputAccessoryView
//
//  Created by 李辉 on 15/12/22.
//  Copyright © 2015年 李辉. All rights reserved.
//  https://github.com/changelee82/CLInputAccessoryView
//

#import "CLInputAccessoryView.h"



@interface CLInputAccessoryView ()

/** 被监控的输入框数组 */
@property (nonatomic, strong) NSMutableArray *textViewArray;

/** 键盘上方工具栏视图 */
@property (nonatomic, strong) UIView *inputAccessoryView;

@end



@implementation CLInputAccessoryView

#pragma mark - 初始化

/** 初始化方法，用于从代码中创建的类实例 */
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self defaultInit];
    }
    return self;
}

/**
 *  初始化方法，用于从代码中创建的类实例
 *
 *  @param leftButtonText   左侧按钮文字
 *  @param rightButtonText  右侧按钮文字
 *  @param leftButtonColor  左侧按钮文字颜色
 *  @param rightButtonColor 右侧按钮文字颜色
 *  @param leftButtonFont   左侧按钮文字字体
 *  @param rightButtonFont  右侧按钮文字字体
 *  @param backgroundColor  背景颜色
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithLeftButtonText:(NSString *)leftButtonText
                       rightButtonText:(NSString *)rightButtonText
                       leftButtonColor:(UIColor *)leftButtonColor
                      rightButtonColor:(UIColor *)rightButtonColor
                        leftButtonFont:(UIFont *)leftButtonFont
                       rightButtonFont:(UIFont *)rightButtonFont
                       backgroundColor:(UIColor *)backgroundColor
{
    self = [super init];
    if (self)
    {
        [self commonInitWithLeftButtonText:leftButtonText
                           rightButtonText:rightButtonText
                           leftButtonColor:leftButtonColor
                          rightButtonColor:rightButtonColor
                            leftButtonFont:leftButtonFont
                           rightButtonFont:rightButtonFont
                           backgroundColor:backgroundColor];
    }
    return self;
}

/** 默认的初始化方法 */
- (void)defaultInit
{
    [self commonInitWithLeftButtonText:@"取消"
                       rightButtonText:@"完成"
                       leftButtonColor:[UIColor blackColor]
                      rightButtonColor:[UIColor blackColor]
                        leftButtonFont:[UIFont systemFontOfSize:15.0]
                       rightButtonFont:[UIFont systemFontOfSize:15.0]
                       backgroundColor:[UIColor whiteColor]];
}

/** 通用初始化方法 */
- (void)commonInitWithLeftButtonText:(NSString *)leftButtonText
                     rightButtonText:(NSString *)rightButtonText
                     leftButtonColor:(UIColor *)leftButtonColor
                    rightButtonColor:(UIColor *)rightButtonColor
                      leftButtonFont:(UIFont *)leftButtonFont
                     rightButtonFont:(UIFont *)rightButtonFont
                     backgroundColor:(UIColor *)backgroundColor
{
    _leftButtonText  = leftButtonText;
    _rightButtonText = rightButtonText;
    _leftButtonColor = leftButtonColor;
    _rightButtonColor = rightButtonColor;
    _leftButtonFont = leftButtonFont;
    _rightButtonFont = rightButtonFont;
    _backgroundColor = backgroundColor;
}


#pragma mark - 添加监控输入框

/**
 *  添加被监控的输入框，目前只支持UITextView和UITextField
 *
 *  @param textView 输入框ID
 *
 *  @return 成功：YES，失败：NO
 */
- (BOOL)addControlledTextView:(id)textView
{
    if ([textView isKindOfClass:[UITextView class]] ||
        [textView isKindOfClass:[UITextField class]] )
    {
        NSUInteger index = [self.textViewArray indexOfObject:textView];
        if(index == NSNotFound)
        {
            [textView setInputAccessoryView:self.inputAccessoryView];
            [self.textViewArray addObject:textView];
            return YES;
        }
    }
    
    return NO;
}

/** 属性变化后，刷新视图 */
- (void)refreshInputAccessoryView
{
    _inputAccessoryView = nil;
    for (id textView in self.textViewArray)
    {
        [textView setInputAccessoryView:self.inputAccessoryView];
    }
}


#pragma mark - 属性

/** 被监控的输入框数组 */
- (NSMutableArray *)textViewArray
{
    if (!_textViewArray)
        _textViewArray = [[NSMutableArray alloc] init];
    return _textViewArray;
}

/** 键盘上方工具栏视图 */
- (UIView *)inputAccessoryView
{
    if (!_inputAccessoryView)
    {
        CGFloat viewWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat viewHight = 40;
        CGFloat buttonWidth = 40;
        
        UIView *accessoryView = [[UIView alloc] init];
        accessoryView.frame = CGRectMake(0, 0, viewWidth, viewHight);
        accessoryView.backgroundColor = _backgroundColor;

        // 头部分割线
        UIView *headerDividing = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 0.5)];
        headerDividing.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [accessoryView addSubview:headerDividing];

        // 左侧按钮
        if(_leftButtonText)
        {
            UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, buttonWidth, viewHight)];
            leftButton.titleLabel.font = _leftButtonFont;
            [leftButton setTitle:_leftButtonText forState:UIControlStateNormal];
            [leftButton setTitleColor:_leftButtonColor forState:UIControlStateNormal];
            [leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:leftButton];
        }

        // 右侧按钮
        if (_rightButtonText)
        {
            UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(viewWidth - 50, 0, buttonWidth, viewHight)];
            rightButton.titleLabel.font = _rightButtonFont;
            [rightButton setTitle:_rightButtonText forState:UIControlStateNormal];
            [rightButton setTitleColor:_rightButtonColor forState:UIControlStateNormal];
            [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:rightButton];
        }

        _inputAccessoryView = accessoryView;
    }
    
    return _inputAccessoryView;
}


/** 左侧按钮文字 */
- (void)setLeftButtonText:(NSString *)leftButtonText
{
    _leftButtonText = leftButtonText;
    [self refreshInputAccessoryView];
}

/** 右侧按钮文字 */
- (void)setRightButtonText:(NSString *)rightButtonText
{
    _rightButtonText = rightButtonText;
    [self refreshInputAccessoryView];
}

/** 左侧按钮文字颜色 */
- (void)setLeftButtonColor:(UIColor *)leftButtonColor
{
    _leftButtonColor = leftButtonColor;
    [self refreshInputAccessoryView];
}

/** 右侧按钮文字颜色 */
- (void)setRightButtonColor:(UIColor *)rightButtonColor
{
    _rightButtonColor = rightButtonColor;
    [self refreshInputAccessoryView];
}

/** 左侧按钮文字字体 */
- (void)setLeftButtonFont:(UIFont *)leftButtonFont
{
    _leftButtonFont = leftButtonFont;
    [self refreshInputAccessoryView];
}

/** 右侧按钮文字字体 */
- (void)setRightButtonFont:(UIFont *)rightButtonFont
{
    _rightButtonFont = rightButtonFont;
    [self refreshInputAccessoryView];
}

/** 背景颜色 */
- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    _backgroundColor = backgroundColor;
    [self refreshInputAccessoryView];
}

#pragma mark - 按钮点击事件

/** 点击左侧按钮 */
- (void)leftButtonClick:(UIButton *)sender
{
    for (id textView in self.textViewArray)
    {
        if( [textView isFirstResponder] )
        {
            if([self.delegate respondsToSelector:@selector(leftButtonDidClick:)])
            {
                if ([self.delegate leftButtonDidClick:textView])
                {
                    [textView resignFirstResponder];
                };
            }
            else
            {
                [textView resignFirstResponder];
            }
            
            break;
        }
    }
}

/** 点击右侧按钮 */
- (void)rightButtonClick:(UIButton *)sender
{
    for (id textView in self.textViewArray)
    {
        if( [textView isFirstResponder] )
        {
            if([self.delegate respondsToSelector:@selector(rightButtonDidClick:)])
            {
                if ([self.delegate rightButtonDidClick:textView])
                {
                    [textView resignFirstResponder];
                }
            }
            else
            {
                [textView resignFirstResponder];
            }
            
            break;
        }
    }
}





@end
