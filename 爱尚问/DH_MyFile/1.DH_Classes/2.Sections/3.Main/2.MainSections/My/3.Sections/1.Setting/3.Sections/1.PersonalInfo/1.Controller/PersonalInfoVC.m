//
//  PersonalInfoVC.m
//  爱尚问
//
//  Created by mac on 2017/9/3.
//  Copyright © 2017年 杜浩. All rights reserved.
//

#import "PersonalInfoVC.h"

@interface PersonalInfoVC ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong)UITableView * tableView;//主tableView
@property(nonatomic,strong)UIImageView * userImgView;//用户头像框
@property(nonatomic,strong)NSMutableDictionary * title_tf_map;//标题为key，文本框为value

@end

@implementation PersonalInfoVC
{
    NSArray * cellShowArray;//cell展示数据
    bool user_icon_change;//头像是否有变化
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //加载主界面
    [self loadMainView];
}
//加载主界面
-(void)loadMainView{
    self.title_tf_map = [NSMutableDictionary new];
    //返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    //右侧按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(submitSaveBtn)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];//白色字体
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = false;
    //加载cell展示数据
    {
        cellShowArray = @[
                          @[
                              @"头像",@"昵称"
                              ],
                          @[
                              @"性别",@"出生日期",@"所在地",@"职业",@"个人签名"
                              ]
                          ];
    }
    //加载表视图
    {
        UITableView * tableView = [UITableView new];
        tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT-64);
        tableView.backgroundColor = [MYTOOL RGBWithRed:247 green:247 blue:247 alpha:1];
        tableView.dataSource = self;
        tableView.delegate = self;
        self.tableView = tableView;
        [self.view addSubview:tableView];
        //不显示分割线
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
}
#pragma mark - UITableViewDataSource,UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    NSString * title = cellShowArray[indexPath.section][indexPath.row];
    UITextField * tf = [self.title_tf_map objectForKey:title];
    if (tf) {
        [tf becomeFirstResponder];
    }else{//头像
        [MYTOOL hideKeyboard];
        [self submitSelectImage];
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 95/667.0*HEIGHT;
    }else{
        return 60/667.0*HEIGHT;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return cellShowArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [cellShowArray[section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [UITableViewCell new];
    float height = indexPath.section == 0 && indexPath.row == 0 ? 95/667.0*HEIGHT : 60/667.0*HEIGHT;
    //标题
    {
        UILabel * title_label = [UILabel new];
        title_label.text = cellShowArray[indexPath.section][indexPath.row];
        title_label.frame = CGRectMake(14/375.0*WIDTH, height/2-9, WIDTH/4, 18);
        title_label.textColor = [MYTOOL RGBWithRed:46 green:42 blue:42 alpha:1];
        [cell addSubview:title_label];
        
    }
    //头像
    {
        if (indexPath.section == 0 && indexPath.row == 0) {
            UIImageView * imgV = [UIImageView new];
            imgV.image = [UIImage imageNamed:@"cam"];
            imgV.frame = CGRectMake(WIDTH - 30-height*0.65, (height - height*0.65)/2, height*0.65, height*0.65);
            imgV.layer.masksToBounds = true;
            imgV.layer.cornerRadius = height*0.65/2;
            [cell addSubview:imgV];
            NSString * url_string = MYUSERINFO[@"head_img_small_url"];
            [MYTOOL setImageIncludePrograssOfImageView:imgV withUrlString:url_string];
            self.userImgView = imgV;
            [imgV setUserInteractionEnabled:YES];
            UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showZoomImageView:)];
            tapGesture.numberOfTapsRequired=1;
            [imgV addGestureRecognizer:tapGesture];
        }
    }
    //文本框
    if (!(indexPath.section == 0 && indexPath.row == 0)) {
        UITextField * tf = [UITextField new];
        tf.frame = CGRectMake(WIDTH/3, height/2-10, WIDTH/3*2-30, 20);
        //        tf.backgroundColor = [UIColor redColor];
        [cell addSubview:tf];
        tf.textAlignment = NSTextAlignmentRight;
        tf.placeholder = @"未设置";
        tf.textColor = [MYTOOL RGBWithRed:181 green:181 blue:181 alpha:1];
        tf.font = [UIFont systemFontOfSize:15];
        NSString * title = cellShowArray[indexPath.section][indexPath.row];
        [self.title_tf_map setObject:tf forKey:title];
        if ([title isEqualToString:@"性别"] || [title isEqualToString:@"出生日期"] || [title isEqualToString:@"所在地"] || [title isEqualToString:@"个人签名"]) {
            tf.delegate = self;
        }
        
    }
    //右侧图标
    {
        UIImageView * imgV = [UIImageView new];
        imgV.image = [UIImage imageNamed:@"arrow_right"];
        imgV.frame = CGRectMake(WIDTH-30, height/2-15, 30, 30);
        [cell addSubview:imgV];
    }
    //分割线
    {
        if (indexPath.row != [cellShowArray[indexPath.section] count] - 1) {
            UIView * spaceView = [UIView new];
            spaceView.backgroundColor = [DHTOOL RGBWithRed:227 green:227 blue:227 alpha:1];
            spaceView.frame = CGRectMake(14/375.0*WIDTH, height-1, WIDTH-14/375.0*WIDTH*2, 1);
            [cell addSubview:spaceView];
        }
    }
    return cell;
}
#pragma mark - cell滚动delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //隐藏键盘
    [MYTOOL hideKeyboard];
}




#pragma mark - 用户事件回调
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
    //
    
}
//再次点击取消全屏预览
-(void)tapBgView:(UITapGestureRecognizer *)tapBgRecognizer{
    [tapBgRecognizer.view removeFromSuperview];
}
//提交保存按钮
-(void)submitSaveBtn{
    [MYTOOL hideKeyboard];
    if (user_icon_change) {//先上传图片
        //截取图片
        float rate = 1.0;
        NSData * imageData = UIImageJPEGRepresentation([MYTOOL fixOrientationOfImage:self.userImgView.image],rate);
        if (imageData.length > 300 * 1024) {
            rate =  (300 * 1024) / (imageData.length * 1.0);
            imageData = UIImageJPEGRepresentation([MYTOOL fixOrientationOfImage:self.userImgView.image],rate);
        }
        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil];
        // 参数@"image":@"image",
        NSDictionary * parameter = @{@"image":@"user",@"user_id":MYUSERINFO[@"user_id"]};
        // 访问路径
        NSString *stringURL = [NSString stringWithFormat:@"%@%@",SERVER_URL,@"/image/upload.app"];
        [manager POST:stringURL parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            // 上传文件
            [formData appendPartWithFileData:imageData name:@"image" fileName:@"iOS" mimeType:@"image/png"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"上传进度:%.2f%%",uploadProgress.fractionCompleted*100] maskType:SVProgressHUDMaskTypeClear];
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [SVProgressHUD dismiss];
            if ([responseObject[@"success"] boolValue]) {
                NSLog(@"恭喜你哈");
                [SVProgressHUD showSuccessWithStatus:responseObject[@"msg"] duration:1];
            }else{
                [SVProgressHUD showErrorWithStatus:responseObject[@"msg"] duration:2];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"上传失败:%@",error);
            [SVProgressHUD showErrorWithStatus:@"上传失败" duration:2];
        }];
    }else{
        //图片不改，改变其他的
        [SVProgressHUD showErrorWithStatus:@"不用闪传" duration:2];
    }
}
//点击更换头像
-(void)submitSelectImage{
    UIAlertController * ac = [UIAlertController alertControllerWithTitle:@"选择头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //        NSLog(@"相册");
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        [self  presentViewController:imagePicker animated:YES completion:^{
        }];
    }];
    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //        NSLog(@"拍照");
        // UIImagePickerControllerCameraDeviceRear 后置摄像头
        // UIImagePickerControllerCameraDeviceFront 前置摄像头
        BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (!isCamera) {
            [SVProgressHUD showErrorWithStatus:@"无法打开摄像头" duration:2];
            return ;
        }
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        // 编辑模式
        imagePicker.allowsEditing = YES;
        
        [self  presentViewController:imagePicker animated:YES completion:^{
        }];
        
    }];
    UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [ac addAction:action1];
    [ac addAction:action2];
    [ac addAction:action3];
    
    [self presentViewController:ac animated:YES completion:nil];
    
}
#pragma mark - UIImagePickerController代理
//确定选择图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    // UIImagePickerControllerOriginalImage 原始图片
    // UIImagePickerControllerEditedImage 编辑后图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.userImgView.image = image;
    [self.userImgView setImage:image];
    user_icon_change = true;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
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
