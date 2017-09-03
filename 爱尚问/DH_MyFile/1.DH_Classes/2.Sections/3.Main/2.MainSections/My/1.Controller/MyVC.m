//
//  MyVC.m
//  爱尚问
//
//  Created by mac on 2017/9/2.
//  Copyright © 2017年 杜浩. All rights reserved.
//

#import "MyVC.h"
#import "SettingVC.h"
#import "VipExplainVC.h"
@interface MyVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UIImageView * userImgView;//头像
@property(nonatomic,strong)UILabel * vipLevelLabel;//vip等级
@property(nonatomic,strong)UILabel * nickNameLabel;//昵称
@end

@implementation MyVC
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
    self.view.backgroundColor = [UIColor whiteColor];
    //初始化cell展示数据
    {
       cellDataArray = @[
                         @[@"",@"帐号等级",@"Vip0"],
                         @[@"",@"我的资料"],
                         @[@"",@"",@""],
                         @[@"",@"",@""],
                         ];
    }
    
    //表示图
    {
        UITableView * tableView = [UITableView new];
        tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT - 49);
        [self.view addSubview:tableView];
        self.tableView = tableView;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = (HEIGHT - 49 - (HEIGHT - 49)/3.0)/8.0;
        self.automaticallyAdjustsScrollViewInsets = false;
        //头view
        {
            UIImageView * headView = [UIImageView new];
            headView.frame = CGRectMake(0, 0, WIDTH, (HEIGHT - 49)/3.0);
            tableView.tableHeaderView = headView;
            headView.image = [UIImage imageNamed:@"my_head_bg.jpg"];
            headView.userInteractionEnabled = true;
            //设置按钮
            {
                UIButton * setBtn = [UIButton new];
                [setBtn setImage:[UIImage imageNamed:@"nav_set"] forState:UIControlStateNormal];
                setBtn.frame = CGRectMake(WIDTH - 40, 30, 30, 30);
                [headView addSubview:setBtn];
                [setBtn addTarget:self action:@selector(setBtn_callback) forControlEvents:UIControlEventTouchUpInside];
            }
            float top_img_center = 0;
            float top_img_down = 0;
            float left = 0;
            //头像
            {
                float img_r = (HEIGHT - 49)/3.0/2.0;
                UIImageView * imgV = [UIImageView new];
                self.userImgView = imgV;
                imgV.frame = CGRectMake(WIDTH/6.0, (HEIGHT - 49)/3.0/2.0 - img_r/2.0 + (HEIGHT - 49)/3.0/6.0, img_r, img_r);
                top_img_center = (HEIGHT - 49)/3.0/2.0 - img_r/2.0 + img_r / 3.0 + (HEIGHT - 49)/3.0/6.0;
                left = WIDTH/6.0 + img_r;
                top_img_down = (HEIGHT - 49)/3.0/2.0 - img_r/2.0 + img_r * 2.0 / 3.0 + (HEIGHT - 49)/3.0/6.0;
                imgV.layer.masksToBounds = true;
                imgV.layer.cornerRadius = img_r/2.0;
                [headView addSubview:imgV];
                
                [imgV setUserInteractionEnabled:YES];
                UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showZoomImageView:)];
                tapGesture.numberOfTapsRequired=1;
                [imgV addGestureRecognizer:tapGesture];
            }
            //帐号等级
            {
                float lv_left = left + 10;
                //提示
                {
                    UILabel * label = [UILabel new];
                    label.text = @"帐号等级:";
                    label.font = [MYFONT fontLittleWithFontSize:15];
                    label.textColor = [UIColor orangeColor];
                    CGSize size = MYSIZE_OF_LABEL;
                    label.frame = CGRectMake(lv_left, top_img_center - size.height/2.0, size.width, size.height);
                    [headView addSubview:label];
                    lv_left += size.width + 10;
                }
                //等级
                {
                    UILabel * label = [UILabel new];
                    self.vipLevelLabel = label;
                    label.text = @"VIP_0";
                    label.font = [MYFONT fontBigWithFontSize:15];
                    label.textColor = [UIColor redColor];
                    CGSize size = MYSIZE_OF_LABEL;
                    label.frame = CGRectMake(lv_left, top_img_center - size.height/2.0, size.width, size.height);
                    [headView addSubview:label];
                    lv_left += size.width + 10;
                }
                //问号按钮
                {
                    UIButton * btn = [UIButton new];
                    [btn setImage:[UIImage imageNamed:@"wenhao"] forState:UIControlStateNormal];
                    btn.frame = CGRectMake(lv_left, top_img_center - 10, 20, 20);
                    [btn addTarget:self action:@selector(showVipExplainCallback) forControlEvents:UIControlEventTouchUpInside];
                    [headView addSubview:btn];
                }
            }
            //昵称
            {
                float nick_left = left + 10;
                //提示
                {
                    UILabel * label = [UILabel new];
                    label.text = @"昵称:";
                    label.font = [MYFONT fontLittleWithFontSize:15];
                    label.textColor = [UIColor orangeColor];
                    CGSize size = MYSIZE_OF_LABEL;
                    label.frame = CGRectMake(nick_left, top_img_down, size.width, size.height);
                    [headView addSubview:label];
                    nick_left += size.width + 10;
                }
                //名字
                {
                    UILabel * label = [UILabel new];
                    self.nickNameLabel = label;
                    label.text = @"爱尚网";
                    label.font = [MYFONT fontBigWithFontSize:15];
                    label.textColor = [UIColor redColor];
                    CGSize size = MYSIZE_OF_LABEL;
                    label.frame = CGRectMake(nick_left, top_img_down, size.width, size.height);
                    [headView addSubview:label];
                }
            }
        }
        //下拉刷新
        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            
            // 结束刷新
            [tableView.mj_header endRefreshing];
        }];
        
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        tableView.mj_header.automaticallyChangeAlpha = YES;
        // 上拉刷新
        tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            
            
            [tableView.mj_footer endRefreshing];
        }];
    }
}
//设置按钮回调
-(void)setBtn_callback{
    SettingVC * setVC = [SettingVC new];
    setVC.title = @"设置";
    [self.navigationController pushViewController:setVC animated:true];
}
//查看vip说明
-(void)showVipExplainCallback{
    [MYTOOL netWorkingWithTitle:@"加载中……"];
    [MYNETWORKING getDataWithInterfaceName:@"/system/getVipExplain.app" andDictionary:nil andSuccess:^(NSDictionary *back_dic, NSString *msg) {
        MYPOPSUCCESS;
        VipExplainVC * vc = [VipExplainVC new];
        vc.title = back_dic[@"title"];
        vc.url = back_dic[@"url"];
        [self.navigationController pushViewController:vc animated:true];
    } andNoSuccess:^(NSDictionary *back_dic, NSString *msg) {
        MYPOPERROR;
    } andFailure:^(NSURLSessionTask *operation, NSError *error) {
        
    }];
    
}
#pragma mark - UITableViewDataSource,UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return cellDataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [UITableViewCell new];
    
    NSString * text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    cell.textLabel.text = text;
    
    return cell;
}
//刷新界面
-(void)refreshView{
    //用户头像
    [MYTOOL setImageIncludePrograssOfImageView:self.userImgView withUrlString:MYUSERINFO[@"head_img_small_url"]];
    //vip等级
    self.vipLevelLabel.text = [NSString stringWithFormat:@"VIP_%@",MYUSERINFO[@"vip_level"]];
    //昵称
    self.nickNameLabel.text = MYUSERINFO[@"nick_name"];
    CGSize size = [MYTOOL getSizeWithLabel:self.nickNameLabel];
    self.nickNameLabel.frame = CGRectMake(self.nickNameLabel.frame.origin.x, self.nickNameLabel.frame.origin.y, size.width, size.height);
    
}
//缩放图片
-(void)showZoomImageView:(UITapGestureRecognizer *)tap{
    if (![(UIImageView *)tap.view image]) {
        return;
    }
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = [UIScreen mainScreen].bounds;
    bgView.backgroundColor = [UIColor blackColor];
    [[[UIApplication sharedApplication] keyWindow] addSubview:bgView];
    UITapGestureRecognizer *tapBgView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBgView:)];
    [bgView addGestureRecognizer:tapBgView];
    //必不可少的一步，如果直接把点击获取的imageView拿来玩的话，返回的时候，原图片就完蛋了
    UIImageView *tempImageView = (UIImageView*)tap.view;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:tempImageView.frame];
    [imageView sd_setImageWithURL:[NSURL URLWithString:MYUSERINFO[@"head_img_url"]] placeholderImage:tempImageView.image];
    [bgView addSubview:imageView];
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = imageView.frame;
        frame.size.width = bgView.frame.size.width;
        frame.size.height = frame.size.width * (imageView.image.size.height / imageView.image.size.width);
        frame.origin.x = 0;
        frame.origin.y = (bgView.frame.size.height - frame.size.height) * 0.5;
        imageView.frame = frame;
    }];
}
//再次点击取消全屏预览
-(void)tapBgView:(UITapGestureRecognizer *)tapBgRecognizer{
    [tapBgRecognizer.view removeFromSuperview];
}
#pragma mark - navigationbar隐藏和显示
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:true animated:false];
    NSString * user_id = [MYTOOL getProjectPropertyWithKey:@"user_id"];
    if (user_id) {
        NSString * interface = @"/user/getUserInfo.app";
        NSDictionary * send = @{
                                @"user_id":user_id
                                };
        [MYNETWORKING getDataWithInterfaceName:interface andDictionary:send andSuccess:^(NSDictionary *back_dic, NSString *msg) {
            MYUSERINFO = back_dic;
            //更新界面信息
            [self refreshView];
            NSLog(@"back:%@",back_dic);
        } andNoSuccess:^(NSDictionary *back_dic, NSString *msg) {
            MYPOPERROR;
        } andFailure:^(NSURLSessionTask *operation, NSError *error) {
            
        }];
        
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:false animated:false];
}
@end
