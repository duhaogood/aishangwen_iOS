//
//  Login_Register_navVC.m
//  爱尚问
//
//  Created by Mac on 17/9/1.
//  Copyright © 2017年 杜浩. All rights reserved.
//

#import "Login_Register_navVC.h"
#import "LoginVC.h"


@interface Login_Register_navVC ()

@end

@implementation Login_Register_navVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor * bgColor = [MYTOOL RGBWithRed:0 green:201 blue:25 alpha:1];
    self.navigationBar.barTintColor = bgColor;
    UIColor * titleColor = [UIColor whiteColor];
    NSDictionary * dictColor = @{
                                 NSFontAttributeName:[MYFONT fontBigWithFontSize:20],
                                 NSForegroundColorAttributeName:titleColor
                                 };
    //修改navigationbar背景色
    self.navigationBar.translucent = NO;
    //修改title字体颜色及大小
    self.navigationBar.titleTextAttributes = dictColor;
    
    LoginVC * vc = [LoginVC new];
    vc.title = @"登 录";
    [self pushViewController:vc animated:false];
    
    
    
}


@end
