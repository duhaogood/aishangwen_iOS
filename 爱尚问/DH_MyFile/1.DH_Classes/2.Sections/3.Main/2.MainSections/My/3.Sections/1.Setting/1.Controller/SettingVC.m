//
//  SettingVC.m
//  爱尚问
//
//  Created by mac on 2017/9/2.
//  Copyright © 2017年 杜浩. All rights reserved.
//

#import "SettingVC.h"
#import "PersonalInfoVC.h"
#import "Login_Register_navVC.h"

@interface SettingVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * tableView;

@end

@implementation SettingVC

{
    NSArray * cellDataArray;//cell展示数据
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //加载主界面
    [self loadMainView];
}
//加载主界面
-(void)loadMainView{
    //返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"退出" style:UIBarButtonItemStyleDone target:self action:@selector(exitCallback)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = false;
    //初始化cell界面数据
    {
        cellDataArray = @[//显示文字，是否可以跳转,跳转的viewcontroller类名字
                          @[@"个人资料",@"1",@"PersonalInfoVC"],
                          @[@"不能跳转",@"0"],
                          ];
    }
    UITableView * tableView = [UITableView new];
    tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT - 64);
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight = (HEIGHT - 64)/10.0;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
}


//退出登录
-(void)exitCallback{
    UIAlertController * ac = [UIAlertController alertControllerWithTitle:@"确定退出登录？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString * interface = @"/user/exitLogin.app";
        NSDictionary * send = @{
                                @"user_id":MYUSERINFO[@"user_id"]
                                };
        [MYTOOL netWorkingWithTitle:@"退出中……"];
        [MYNETWORKING getDataWithInterfaceName:interface andDictionary:send andSuccess:^(NSDictionary *back_dic, NSString *msg) {
            MYPOPSUCCESS;
            Login_Register_navVC * vc = [Login_Register_navVC new];
            MY_APP_DELEGATE.window.rootViewController = vc;
            //把登录状态写进程序
            [MYTOOL setProjectPropertyWithKey:@"isLogin" andValue:@"0"];
            
            
        } andNoSuccess:^(NSDictionary *back_dic, NSString *msg) {
            MYPOPERROR;
        } andFailure:^(NSURLSessionTask *operation, NSError *error) {
            
        }];
    }];
    UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [ac addAction:action1];
    [ac addAction:action3];
    [self presentViewController:ac animated:YES completion:nil];
}






#pragma mark - UITableViewDataSource,UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return cellDataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [UITableViewCell new];
    NSArray * cellArray = cellDataArray[indexPath.row];
    //显示的文字
    NSString * showName = cellArray[0];
    //是否可以跳转
    BOOL isCanNext = [cellArray[1] boolValue];
    
    //显示文字
    {
        UILabel * label = [UILabel new];
        label.text = showName;
        label.font = [MYFONT fontLittleWithFontSize:tableView.rowHeight/3.0];
        label.textColor = MYCOLOR_46_42_42;
        CGSize size = MYSIZE_OF_LABEL;
        label.frame = CGRectMake(14, tableView.rowHeight/2.0 - size.height/2.0, size.width, size.height);
        [cell addSubview:label];
    }
    
    //右侧图标
    if(isCanNext){
        UIImageView * imgV = [UIImageView new];
        imgV.image = [UIImage imageNamed:@"arrow_right"];
        imgV.frame = CGRectMake(WIDTH-30, tableView.rowHeight/2-15, 30, 30);
        [cell addSubview:imgV];
    }
    //分割线
    {
        UIView * spaceView = [UIView new];
        spaceView.backgroundColor = [DHTOOL RGBWithRed:227 green:227 blue:227 alpha:1];
        spaceView.frame = CGRectMake(14, tableView.rowHeight - 1, WIDTH - 24, 1);
        [cell addSubview:spaceView];
        
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    NSArray * cellArray = cellDataArray[indexPath.row];
    //显示的文字
    NSString * showName = cellArray[0];
    //是否可以跳转
    BOOL isCanNext = [cellArray[1] boolValue];
    if (isCanNext) {
        NSString * vcClassName = cellArray[2];
        Class class = NSClassFromString(vcClassName);
        UIViewController * vc = [class new];
        vc.title = showName;
        [self.navigationController pushViewController:vc animated:true];
    }
    
}
//返回上一个界面
-(void)back{
    [self.navigationController popViewControllerAnimated:true];
}
#pragma mark - tabbar隐藏和显示
-(void)viewWillAppear:(BOOL)animated{
    [MYTOOL hiddenTabBar];
}
-(void)viewWillDisappear:(BOOL)animated{
    [MYTOOL showTabBar];
}
@end
