# CLInputAccessoryView 1.0
点击输入框后，为弹出键盘添加上方的工具条

<br />
作者：李辉 <br />
联系方式：6545823@qq.com <br />
编译环境：Xcode 7.2 <br />
运行环境：iOS 9.2 运行正常 <br />
您在使用该控件的过程中，如有任何疑问或建议，请通过邮箱联系我，谢谢！ <br />

<br />
![image](https://github.com/changelee82/CLInputAccessoryView/raw/master/Demo.gif)
<br />

使用方法
===============
    #import "CLInputAccessoryView.h"
    
      // 初始化键盘上方工具栏
    _inputAccessoryView = [[CLInputAccessoryView alloc] init];
    [_inputAccessoryView addControlledTextView:_textField];
    [_inputAccessoryView addControlledTextView:_textView];
    _inputAccessoryView.leftButtonColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    
    // 如果点击按钮后只隐藏键盘，则不用添加委托，否则添加协议和委托
    为使用类添加协议 <CLInputAccessoryViewDelegete>
    _inputAccessoryView.delegate = self;
    
    /** 点击左侧按钮后调用此方法，返回YES则隐藏键盘，NO则不隐藏键盘 */
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
    

详细的示例请参考代码。 <br />

历史版本
===============
v1.0 - 2015-12-22 <br />
Added <br />
基础功能完成 <br />
