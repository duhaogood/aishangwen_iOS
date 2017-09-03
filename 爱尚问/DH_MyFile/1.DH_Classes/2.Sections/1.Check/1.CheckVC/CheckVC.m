//
//  CheckVC.m
//  爱尚问
//
//  Created by Mac on 17/9/1.
//  Copyright © 2017年 杜浩. All rights reserved.
//

#import "CheckVC.h"
#import "Login_Register_navVC.h"
#import "MainVC.h"
@interface CheckVC ()

@end

@implementation CheckVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //判断是否登录
    if (IS_NOT_LOGIN) {
        Login_Register_navVC * vc = [Login_Register_navVC new];
        MY_APP_DELEGATE.window.rootViewController = vc;
    }else{
        MainVC * vc = [MainVC new];
        MY_APP_DELEGATE.window.rootViewController = vc;
    }
    
    
}





@end
