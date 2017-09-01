//
//  DHNetWorking.m
//  绿茵荟
//
//  Created by Mac on 17/3/28.
//  Copyright © 2017年 徐州野马软件. All rights reserved.
//

#import "DHNetWorking.h"
#import "AFNetworking.h"
static id instance;
@implementation DHNetWorking
+(instancetype)sharedDHNetWorking{
    if (!instance) {
        instance = [[self alloc]init];
    }
    return instance;
}
+(instancetype)alloc{
    if (!instance) {
        instance = [[super alloc]init];
    }
    return instance;
}
-(instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

//不管怎样都有回调
-(void)getDataWithInterfaceName:(NSString *)interfaceName andDictionary:(NSDictionary *)send_dic andSuccess:(void(^)(NSDictionary * back_dic , NSString * msg)) back_block andNoSuccess:(void(^)(NSDictionary * back_dic , NSString * msg)) no_block andFailure:(void(^)(NSURLSessionTask *, NSError *)) failure_block{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    NSString * urlString = [NSString stringWithFormat:@"%@%@",SERVER_URL,interfaceName];
    if (![[interfaceName substringToIndex:1] isEqualToString:@"/"]) {
        urlString = [NSString stringWithFormat:@"%@/%@",SERVER_URL,interfaceName];
    }
    NSMutableDictionary * send = [NSMutableDictionary dictionaryWithDictionary:send_dic];
    //验证参数
    
    [manager GET:urlString parameters:send progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        if (![[responseObject valueForKey:@"success"] boolValue]) {
            no_block(responseObject,responseObject[@"msg"]);
        }else{
            back_block(responseObject[@"value"],responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络出错\n或服务器更换\n请检查是否最新版本" duration:3];
        failure_block(operation,error);
    }];
    
}

@end
