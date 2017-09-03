//
//  ChangePassVC.m
//  爱尚问
//
//  Created by mac on 2017/9/2.
//  Copyright © 2017年 杜浩. All rights reserved.
//

#import "ChangePassVC.h"

@interface ChangePassVC ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField * phoneTF;//手机号码
@property(nonatomic,strong)UITextField * oldPasswordTF;//老密码
@property(nonatomic,strong)UITextField * passwordTF;//密码
@property(nonatomic,strong)UITextField * passwordAgaginTF;//确认密码
@property(nonatomic,strong)UILabel * checkLabel;//检测手机号

@end

@implementation ChangePassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载主界面
    [self loadMainView];
}
//加载主界面
-(void)loadMainView{
    //返回按钮
    self.view.backgroundColor = [UIColor whiteColor];
    //返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStyleDone target:self action:@selector(popUpViewController)];
    //手机号码
    float top = 30;
    float height = 40;
    float left1 = 30;
    float left2 = 55;
    {
        //背景view
        UIView * view = [UIView new];
        {
            view.frame = CGRectMake(20, top, WIDTH - 40, height);
            view.layer.masksToBounds = true;
            view.layer.borderWidth = 1;
            view.layer.borderColor = [MYCOLOR_240_240_240 CGColor];
            [self.view addSubview:view];
            view.layer.cornerRadius = height/2.0;
        }
        //图标
        {
            UIImageView * icon = [UIImageView new];
            icon.image = [UIImage imageNamed:@"phone"];
            [view addSubview:icon];
            icon.frame = CGRectMake(left1, 13, 10, 14);
        }
        //文本框
        {
            UITextField * tf = [UITextField new];
            tf.placeholder = @"手机号码";
            tf.font = [UIFont systemFontOfSize:14];
            tf.frame = CGRectMake(left2, 10, WIDTH/3.0, 20);
            tf.delegate = self;
            tf.tag = 100;
            tf.keyboardType = UIKeyboardTypeNumberPad;
            [view addSubview:tf];
            self.phoneTF = tf;
        }
        //手机号码检测
        {
            UILabel * label = [UILabel new];
            self.checkLabel = label;
            label.frame = CGRectMake(30, top + 45, WIDTH - 60, 15);
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = [MYTOOL RGBWithRed:255 green:101 blue:101 alpha:1];
            [self.view addSubview:label];
            label.text = @"";
        }
        top += height + 25;
    }
    //老密码
    {
        //背景view
        UIView * view = [UIView new];
        {
            view.frame = CGRectMake(20, top, WIDTH - 40, height);
            view.layer.masksToBounds = true;
            view.layer.borderWidth = 1;
            view.layer.borderColor = [MYCOLOR_240_240_240 CGColor];
            [self.view addSubview:view];
            view.layer.cornerRadius = height/2.0;
        }
        //图标
        {
            UIImageView * icon = [UIImageView new];
            icon.image = [UIImage imageNamed:@"pwd"];
            [view addSubview:icon];
            icon.frame = CGRectMake(left1, 13, 10, 14);
        }
        //文本框
        {
            UITextField * tf = [UITextField new];
            tf.placeholder = @"请输入原来密码";
            tf.font = [UIFont systemFontOfSize:14];
            tf.frame = CGRectMake(left2, 10, WIDTH/2.0, 20);
            [view addSubview:tf];
            tf.tag = 200;
            tf.keyboardType = UIKeyboardTypeNumberPad;
            self.oldPasswordTF = tf;
        }
        top += height + 15;
    }
    //信密码
    {
        //背景view
        UIView * view = [UIView new];
        {
            view.frame = CGRectMake(20, top, WIDTH - 40, height);
            view.layer.masksToBounds = true;
            view.layer.borderWidth = 1;
            view.layer.borderColor = [MYCOLOR_240_240_240 CGColor];
            [self.view addSubview:view];
            view.layer.cornerRadius = height/2.0;
        }
        //图标
        {
            UIImageView * icon = [UIImageView new];
            icon.image = [UIImage imageNamed:@"yzma"];
            [view addSubview:icon];
            icon.frame = CGRectMake(left1, 20-11/2.0, 14, 11);
        }
        //文本框
        {
            UITextField * tf = [UITextField new];
            tf.placeholder = @"设置新密码";
            tf.font = [UIFont systemFontOfSize:14];
            tf.frame = CGRectMake(left2, 10, WIDTH/2.0, 20);
            [view addSubview:tf];
            tf.tag = 400;
            tf.delegate = self;
            self.passwordTF = tf;
        }
        
        
        top += height + 15;
    }
    //确认密码
    {
        //背景view
        UIView * view = [UIView new];
        {
            view.frame = CGRectMake(20, top, WIDTH - 40, height);
            view.layer.masksToBounds = true;
            view.layer.borderWidth = 1;
            view.layer.borderColor = [MYCOLOR_240_240_240 CGColor];
            [self.view addSubview:view];
            view.layer.cornerRadius = height/2.0;
        }
        //图标
        {
            UIImageView * icon = [UIImageView new];
            icon.image = [UIImage imageNamed:@"yzma"];
            [view addSubview:icon];
            icon.frame = CGRectMake(left1, 20-11/2.0, 14, 11);
        }
        //文本框
        {
            UITextField * tf = [UITextField new];
            tf.placeholder = @"确认新密码";
            tf.font = [UIFont systemFontOfSize:14];
            tf.frame = CGRectMake(left2, 10, WIDTH/2.0, 20);
            [view addSubview:tf];
            tf.tag = 500;
            tf.delegate = self;
            self.passwordAgaginTF = tf;
        }
        top += height;
    }
    //更改密码
    {
        UIButton * btn = [UIButton new];
        float btn_top = (HEIGHT-64)/2.0;
        if (btn_top - top < 20) {
            btn_top = top + 20;
        }
        btn.frame = CGRectMake(20, btn_top, WIDTH - 40, 40);
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [btn setTitle:@"更改密码" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        btn.titleLabel.font = [MYFONT fontBigWithFontSize:20];
        [btn addTarget:self action:@selector(changePasswordCallback) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
}

-(void)changePasswordCallback{
    NSString * phone_number = self.phoneTF.text;
    NSString * oldPass = self.oldPasswordTF.text;
    NSString * newPass = self.passwordTF.text;
    NSString * newPass2 = self.passwordAgaginTF.text;
    
    bool flag = [MYTOOL isMatchPhoneNumber:phone_number];
    if (!flag) {
        [SVProgressHUD showErrorWithStatus:@"手机号码不合法" duration:2];
        return;
    }
    if (oldPass == nil || oldPass.length < 6) {
        [SVProgressHUD showErrorWithStatus:@"老密码长度不足" duration:2];
        return;
    }
    if (newPass == nil || newPass.length < 6) {
        [SVProgressHUD showErrorWithStatus:@"新密码长度不足" duration:2];
        return;
    }
    if (![newPass isEqualToString:newPass2]) {
        [SVProgressHUD showErrorWithStatus:@"新密码确认有误" duration:2];
        return;
    }
    if ([newPass isEqualToString:oldPass]) {
        [SVProgressHUD showErrorWithStatus:@"新密码和老密码相同" duration:2];
        return;
    }
    [MYTOOL netWorkingWithTitle:@"更改密码……"];
    NSString * interface = @"/user/changePassword.app";
    NSDictionary * send = @{
                            @"phone_number":phone_number,
                            @"old_pass":oldPass,
                            @"new_pass":newPass
                            };
    [MYNETWORKING getDataWithInterfaceName:interface andDictionary:send andSuccess:^(NSDictionary *back_dic, NSString *msg) {
        MYPOPSUCCESS;
        [self popUpViewController];
    } andNoSuccess:^(NSDictionary *back_dic, NSString *msg) {
        MYPOPERROR;
    } andFailure:^(NSURLSessionTask *operation, NSError *error) {
        
    }];
    
    
    
    
}



#pragma mark - UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag != 100) {
        return;
    }
    NSString * mobile = textField.text;
    //正则表达式匹配11位手机号码
    BOOL isMatch = [MYTOOL isMatchPhoneNumber:mobile];
    if (!isMatch) {
        self.checkLabel.text = @"手机格式不正确";
        self.checkLabel.textColor = [MYTOOL RGBWithRed:255 green:101 blue:101 alpha:1];
    }else{
        self.checkLabel.text = @"手机格式正确";
        self.checkLabel.textColor = MYCOLOR_40_199_0;
    }
}
//返回上个界面
-(void)popUpViewController{
    [self.navigationController popViewControllerAnimated:true];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [MYTOOL hideKeyboard];
}
-(void)viewWillAppear:(BOOL)animated{
    [MYTOOL hiddenTabBar];
}
-(void)viewWillDisappear:(BOOL)animated{
    [MYTOOL showTabBar];
}


@end
