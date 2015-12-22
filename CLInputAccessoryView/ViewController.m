//
//  ViewController.m
//  CLInputAccessoryView
//
//  Created by 李辉 on 15/12/22.
//  Copyright © 2015年 李辉. All rights reserved.
//

#import "ViewController.h"
#import "CLInputAccessoryView.h"

@interface ViewController () <CLInputAccessoryViewDelegete>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView;

// 键盘上方工具栏
@property (nonatomic, strong) CLInputAccessoryView *inputAccessoryView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化键盘上方工具栏
    //_inputAccessoryView = [[CLInputAccessoryView alloc] initWithLeftButtonText:nil rightButtonText:@"确认"];
    _inputAccessoryView = [[CLInputAccessoryView alloc] init];
    [_inputAccessoryView addControlledTextView:_textField];
    [_inputAccessoryView addControlledTextView:_textView];
    
    // 如果点击按钮后只隐藏键盘，则不用添加委托
    _inputAccessoryView.delegate = self;
    _inputAccessoryView.leftButtonColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLInputAccessoryViewDelegete 协议

/** 点击左侧按钮后调用此方法 */
- (BOOL)leftButtonDidClick:(id)textView
{
    NSString *text = [textView text];
    [textView setText:[text stringByAppendingString:@"取消 "]];
    
    return YES;
}

/** 点击右侧按钮后触发此方法 */
- (BOOL)rightButtonDidClick:(id)textView
{
    NSString *text = [textView text];
    [textView setText:[text stringByAppendingString:@"完成 "]];
    
    return NO;
}

@end
