//
//  NXSystemaSettingType.h
//  NXJumpToSettingTools
//
//  Created by linyibin on 2017/4/13.
//  Copyright © 2017年 NXAristotle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NXSystemaSettingType : NSObject


/**
 英文名
 */
@property (nonatomic, strong) NSString *EName;

/**
 中文名
 */
@property (nonatomic, strong) NSString *CName;

/**
 设置类型的key
 */
@property (nonatomic, strong) NSString *SettingType;

/**
 通用提示
 */
@property (nonatomic, strong) NSString *TipContent;

/**
 其他（保留字段）
 */
@property (nonatomic, strong) NSString *Other;

@end
