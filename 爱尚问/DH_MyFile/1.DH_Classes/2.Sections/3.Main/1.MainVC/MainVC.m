//
//  MainVC.m
//  爱尚问
//
//  Created by mac on 2017/9/2.
//  Copyright © 2017年 杜浩. All rights reserved.
//

#import "MainVC.h"
#import "MessageVC.h"
#import "MyVC.h"
#import "Request_typeVC.h"
#import "FirstPageVC.h"
#import "RequestVC.h"
@interface MainVC ()

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor * bgColor = [MYTOOL RGBWithRed:0 green:201 blue:25 alpha:1];
    //改变tabbar选中及未选中的字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[DHTOOL RGBWithRed:48 green:48 blue:48 alpha:1]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[DHTOOL RGBWithRed:40 green:199 blue:0 alpha:1]} forState:UIControlStateSelected];
    //改变字体大小
    //字体 ,UIFontDescriptorTextStyleAttribute:[UIFont systemFontOfSize:12]
    UIColor * titleColor = [UIColor whiteColor];
    NSDictionary * dictColor = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:18],
                                 NSForegroundColorAttributeName:titleColor
                                 };
    //首页
    {
        FirstPageVC * vc = [FirstPageVC new];
        vc.title = @"首页";
        UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:vc];
        //修改navigationbar背景色
        nc.navigationBar.translucent = NO;
        //修改title字体颜色及大小
        nc.navigationBar.titleTextAttributes = dictColor;
        nc.title = @"首页";
        nc.navigationBar.barTintColor = bgColor;
        nc.tabBarItem.image = [UIImage imageNamed:@"tab_-subject_nor.png"];
        nc.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_-subject_sel.png"];
        [nc.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
        [self addChildViewController:nc];
    }
    //问题
    {
        RequestVC * vc = [RequestVC new];
        vc.title = @"问题";
        UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:vc];
        //修改navigationbar背景色
        nc.navigationBar.translucent = NO;
        //修改title字体颜色及大小
        nc.navigationBar.titleTextAttributes = dictColor;
        nc.title = @"问题";
        nc.navigationBar.barTintColor = bgColor;
        nc.tabBarItem.image = [UIImage imageNamed:@"tab_picture_nor.png"];
        nc.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_picture_sel.png"];
        [nc.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
        [self addChildViewController:nc];
    }
    
    //问题分类
    {
        Request_typeVC * vc = [Request_typeVC new];
        vc.title = @"分类";
        UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:vc];
        //修改navigationbar背景色
        nc.navigationBar.translucent = NO;
        //修改title字体颜色及大小
        nc.navigationBar.titleTextAttributes = dictColor;
        nc.title = @"分类";
        nc.navigationBar.barTintColor = bgColor;
        nc.tabBarItem.image = [UIImage imageNamed:@"tab_shop_nor.png"];
        nc.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_shop_sel.png"];
        [self addChildViewController:nc];
    }
    //消息
    {
        MessageVC * vc = [MessageVC new];
        vc.title = @"消息";
        UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:vc];
        //修改navigationbar背景色
        nc.navigationBar.translucent = NO;
        //修改title字体颜色及大小
        nc.navigationBar.titleTextAttributes = dictColor;
        nc.title = @"消息";
        nc.navigationBar.barTintColor = bgColor;
        nc.tabBarItem.image = [UIImage imageNamed:@"tab_chat_nor.png"];
        nc.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_chat_sel.png"];
        [self addChildViewController:nc];
    }
    //我的
    {
        MyVC * myVC = [MyVC new];
        myVC.title = @"我的";
        UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:myVC];
        //修改navigationbar背景色
        nc.navigationBar.translucent = NO;
        //修改title字体颜色及大小
        nc.navigationBar.titleTextAttributes = dictColor;
        nc.title = @"我的";
        nc.navigationBar.barTintColor = bgColor;
        nc.tabBarItem.image = [UIImage imageNamed:@"tab_user_nor.png"];
        nc.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_user_sel.png"];
        [nc.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
        [self addChildViewController:nc];
    }
}



@end
