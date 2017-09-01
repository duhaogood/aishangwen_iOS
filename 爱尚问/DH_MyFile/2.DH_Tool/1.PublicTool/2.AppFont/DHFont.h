//
//  DHFont.h
//  爱尚问
//
//  Created by Mac on 17/8/31.
//  Copyright © 2017年 杜浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHFont : UIFont

/**
 获取细字体

 @param fontSize 字体大小
 @return 细字体
 */
+(UIFont *)fontLittleWithFontSize:(float)fontSize;

/**
 获取粗字体

 @param fontSize 字体大小
 @return 粗字体
 */
+(UIFont *)fontBigWithFontSize:(float)fontSize;


@end
