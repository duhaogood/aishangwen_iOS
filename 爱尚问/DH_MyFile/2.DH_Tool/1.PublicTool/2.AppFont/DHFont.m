//
//  DHFont.m
//  爱尚问
//
//  Created by Mac on 17/8/31.
//  Copyright © 2017年 杜浩. All rights reserved.
//

#import "DHFont.h"

@implementation DHFont


+(UIFont *)systemFontOfSize:(CGFloat)fontSize{
    
    return [UIFont systemFontOfSize:fontSize];
}
+(UIFont *)fontBigWithFontSize:(float)fontSize{
    UIFont * font = [UIFont fontWithName:@"FZLANTY_ZHUNJW--GB1-0" size:fontSize];
    
    return font;
}
+(UIFont *)fontLittleWithFontSize:(float)fontSize{
    UIFont * font = [UIFont fontWithName:@"FZLANTY_XIJW--GB1-0" size:fontSize];
    
    return font;
}


@end
