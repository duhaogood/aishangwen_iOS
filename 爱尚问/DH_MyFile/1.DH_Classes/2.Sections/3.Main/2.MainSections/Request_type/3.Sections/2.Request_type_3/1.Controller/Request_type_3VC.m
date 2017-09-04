//
//  Request_type_2VC.m
//  爱尚问
//
//  Created by mac on 2017/9/2.
//  Copyright © 2017年 杜浩. All rights reserved.
//

#import "Request_type_3VC.h"
@interface Request_type_3VC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * cellDataArray;//cell数据
@property(nonatomic,strong)UIView * noDataView;//没有数据显示

@end

@implementation Request_type_3VC
- (void)viewDidLoad {
    [super viewDidLoad];
    //加载主界面
    [self loadMainView];
    [self getRequestTypeList];
}
//加载主界面
-(void)loadMainView{
    //返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_-add"] style:UIBarButtonItemStyleDone target:self action:@selector(addTypeCallback)];
    self.view.backgroundColor = [UIColor whiteColor];
    //表示图
    {
        UITableView * tableView = [UITableView new];
        tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT - 64);
        [self.view addSubview:tableView];
        self.tableView = tableView;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = (HEIGHT - 64)/10.0;
        self.automaticallyAdjustsScrollViewInsets = false;
        //下拉刷新
        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self getRequestTypeList];
            // 结束刷新
            [tableView.mj_header endRefreshing];
        }];
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        tableView.mj_header.automaticallyChangeAlpha = YES;
        //@property(nonatomic,strong)UIView * noDataView;//没有数据显示
        {
            UIView * view = [UIView new];
            self.noDataView = view;
            view.frame = tableView.bounds;
            view.backgroundColor = MYCOLOR_240_240_240;
            [tableView addSubview:view];
            //图片-170*135
            {
                UIImageView * icon = [UIImageView new];
                icon.image = [UIImage imageNamed:@"nodate"];
                icon.frame = CGRectMake(WIDTH/2-169/2.0, (HEIGHT-64)/2-135, 169, 135);
                [view addSubview:icon];
            }
        }
    }
    
}
//增加分类类型会掉
-(void)addTypeCallback{
    UIAlertController * ac = [UIAlertController alertControllerWithTitle:@"新加问题分类" message:@"此为三级分类，请填写分类名称" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        
        [SVProgressHUD showWithStatus:@"增加中\n请稍等…" maskType:SVProgressHUDMaskTypeClear];
        NSString * msg = ac.textFields.firstObject.text;
        NSString * interface = @"/request_type/addType.app";
        //拼接上传参数
        NSMutableDictionary * send_dic = [NSMutableDictionary new];
        [send_dic setValue:msg forKey:@"type_name"];
        [send_dic setValue:self.parent_id forKey:@"parentId"];
        [MYNETWORKING getDataWithInterfaceName:interface andDictionary:send_dic andSuccess:^(NSDictionary *back_dic, NSString *msg) {
            MYPOPSUCCESS;
            [self getRequestTypeList];
        } andNoSuccess:^(NSDictionary *back_dic, NSString *msg) {
            MYPOPERROR;
        } andFailure:^(NSURLSessionTask *operation, NSError *error) {
            
        }];
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [ac addAction:action];
    [ac addTextFieldWithConfigurationHandler:^(UITextField *tf){
        tf.placeholder = @"请输入分类名称";
    }];
    [ac addAction:cancel];
    [self showDetailViewController:ac sender:nil];
}
#pragma mark - UITableViewDataSource,UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellDataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [UITableViewCell new];
    
    NSString * text = self.cellDataArray[indexPath.row][@"type_name"];
    //序号
    float left = 10;
    {
        UIView * view = [UIView new];
        float height = tableView.rowHeight/2.0;
        view.frame = CGRectMake(left, height/2.0, height, height);
        view.backgroundColor = [MYTOOL RGBWithRed:213 green:231 blue:239 alpha:1];
        [cell addSubview:view];
        view.layer.masksToBounds = true;
        view.layer.cornerRadius = height / 3.0;
        left += 10 + height;
        //序号
        UILabel * label = [UILabel new];
        label.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
        label.textColor = [UIColor orangeColor];
        label.frame = CGRectMake(0, view.frame.size.height/4.0, view.frame.size.width, view.frame.size.height/2);
        label.font = [MYFONT fontLittleWithFontSize:view.frame.size.height/2.0];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
    }
    //文字
    {
        UILabel * label = [UILabel new];
        label.text = text;
        label.font = [MYFONT fontBigWithFontSize:tableView.rowHeight/3.0];
        label.textColor = [MYTOOL RGBWithRed:27 green:115 blue:223 alpha:1];
        CGSize size = [MYTOOL getSizeWithLabel:label];
        label.frame = CGRectMake(left, tableView.rowHeight/2.0 - size.height/2.0, size.width, size.height);
        [cell addSubview:label];
    }
    //分割线
    {
        UIView * spaceView = [UIView new];
        spaceView.frame = CGRectMake(15, tableView.rowHeight-1, WIDTH-30, 1);
        spaceView.backgroundColor = [MYTOOL RGBWithRed:226 green:226 blue:226 alpha:1];
        [cell addSubview:spaceView];
    }
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    NSDictionary * map = self.cellDataArray[indexPath.row];
    NSString * json = [MYTOOL getJsonFromDictionaryOrArray:map];
    [SVProgressHUD showSuccessWithStatus:json duration:3];
    
    
    
    
}
/** 确定哪些行的cell可以编辑 (UITableViewDataSource协议中方法). */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return true;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
// 修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除数据
        NSDictionary * map = self.cellDataArray[indexPath.row];
        NSString * request_type_id = map[@"request_type_id"];
        NSString * interface = @"/request_type/deleteType.app";
        NSDictionary * send = @{
                                @"request_type_id":request_type_id
                                };
        [MYTOOL netWorkingWithTitle:@"删除中……"];
        [MYNETWORKING getDataWithInterfaceName:interface andDictionary:send andSuccess:^(NSDictionary *back_dic, NSString *msg) {
            MYPOPSUCCESS;
            [self getRequestTypeList];
        } andNoSuccess:^(NSDictionary *back_dic, NSString *msg) {
            MYPOPERROR;
        } andFailure:^(NSURLSessionTask *operation, NSError *error) {
            
        }];
        
    }
}
//获取当前分类信息
-(void)getRequestTypeList{
    NSString * interface = @"/request_type/getTypeList.app";
    NSDictionary * send = @{
                            @"parentId":self.parent_id
                            };
    [MYNETWORKING getDataWithInterfaceName:interface andDictionary:send andSuccess:^(NSDictionary *back_dic, NSString *msg) {
        NSArray * array = (NSArray *)back_dic;
        self.cellDataArray = array;
        [self.tableView reloadData];
        if (self.cellDataArray && self.cellDataArray.count > 0) {
            self.noDataView.hidden = true;
        }else{
            self.noDataView.hidden = false;
        }
    } andNoSuccess:^(NSDictionary *back_dic, NSString *msg) {
        MYPOPERROR;
    } andFailure:^(NSURLSessionTask *operation, NSError *error) {
        
    }];
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
