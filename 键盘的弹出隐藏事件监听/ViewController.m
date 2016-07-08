//
//  ViewController.m
//  键盘的弹出隐藏事件监听
//
//  Created by 王奥东 on 16/7/5.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    //设置一个输入框用来弹出键盘
    UITextField *text = [[UITextField alloc]initWithFrame:CGRectMake(100, 100, 200, 44)];
    text.backgroundColor = [UIColor grayColor];
    //设置View的边框用来测试弹出隐藏效果
    self.view.layer.borderColor = [UIColor blueColor].CGColor;
    self.view.layer.borderWidth = 2;
    [self.view addSubview:text];
    
#pragma mark -- 监听键盘的事件
    //addObserver 设置监听的对象
    //selector:@selector(<#selector#>) 相应的方法
    //name 通知的名字 UIKeyboardWillShowNotification
    //object 传入Nil 代表无论哪个对象,只要发布了相应的通知,我们都进行响应
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeKeyBoard:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark --相应键盘的通知事件
- (void)changeKeyBoard:(NSNotification *)notification{
    
    NSLog(@"%@",notification);
    //获取userInfo信息
    NSDictionary *userInfo = notification.userInfo;
    //    UIKeyboardAnimationCurveUserInfoKey = 7;   动画分为很多中,设置当前动画的样式
    //    UIKeyboardAnimationDurationUserInfoKey = "0.25"; 动画执行的时间
    //    UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {375, 258}}";
    //    UIKeyboardCenterBeginUserInfoKey = "NSPoint: {187.5, 796}";
    //    UIKeyboardCenterEndUserInfoKey = "NSPoint: {187.5, 538}";
    //    UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 667}, {375, 258}}";
    //    UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 409}, {375, 258}}";
    //    UIKeyboardIsLocalUserInfoKey = 1;
    //获取要移动控件的transForm
    CGAffineTransform transForm = self.view.transform;
    
    //获取移动的位置 屏幕的高度 - 最终显示的frame的Y = 移动的位置
    //1. 获取键盘最终显示的y
    NSValue *value = userInfo[UIKeyboardFrameEndUserInfoKey];
    
    CGRect endFrame = [value CGRectValue];
    
    CGFloat moveY = - (self.view.frame.size.height - endFrame.origin.y);
    
    //移动
    transForm = CGAffineTransformMakeTranslation(0, moveY);
    
    
    
    //执行动画移动
    [UIView animateWithDuration:[userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        
        self.view.transform = transForm;
    }];
    
    
}



@end
