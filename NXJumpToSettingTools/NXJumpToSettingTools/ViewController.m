//
//  ViewController.m
//  NXJumpToSettingTools
//
//  Created by linyibin on 2017/4/6.
//  Copyright © 2017年 NXAristotle. All rights reserved.
//

#import "ViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "NXSystemaSettingType.h"
#import "MJExtension.h"
#import "NXJumpTypeSelect.h"

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>

@property (nonatomic, strong) NSArray *models;  /**< 模型 */
@property (weak, nonatomic) IBOutlet NXJumpTypeSelect *settingInput;

@property (nonatomic, strong) NSString *selectedStr;   /**< 记录选择项 */

@end

@implementation ViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self temp];
    [self setModeldata];
    self.settingInput.delegate = self;
    //  初始化选中行数为第0行
   
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (self.selectedStr == nil || [self.selectedStr isEqualToString:@""]) {
        self.settingInput.text = [self.models[0] CName];
    }else
    {
        self.settingInput.text = self.selectedStr;
    }
  
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.selectedStr = textField.text;
}

#pragma mark - private method

- (void)setModeldata {
    
    //  方式一
//    NSArray *modelArray = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NXSystemaSettingType" ofType:@"plist"]];
//    
//    NSArray *models = [NXSystemaSettingType mj_objectArrayWithKeyValuesArray:modelArray];
    
    //  方式二：
    self.models = [NXSystemaSettingType mj_objectArrayWithFile:[[NSBundle mainBundle] pathForResource:@"NXSystemaSettingType" ofType:@"plist"]];
    
//    NSLog(@"----models :%@",self.models);
    
    
   
}

- (void)temp {
    
    if (TARGET_IPHONE_SIMULATOR == 1 && TARGET_OS_IPHONE == 1) {
        //模拟器
        
    }else{
        //真机
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        //            [self presentModalViewController:imagePicker animated:YES];
        [self presentViewController:imagePicker animated:YES completion:^{
            
        }];

        
    }


    /*
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // 设置可用的媒体类型、默认只包含kUTTypeImage，如果想选择视频，请添加kUTTypeMovie
    // 如果选择的是视屏，允许的视屏时长为20秒
    imagePicker.videoMaximumDuration = 20;

    
    [self presentViewController:imagePicker animated:YES completion:^{
        
    }];
    */
}


/**
 处理跳转的逻辑

 @param sender 跳转按钮
 */
- (IBAction)jumpToSetting:(UIButton *)sender {
    
    //  1.获取跳转的需求key
    NSString *setName = self.settingInput.text;
    
    if (setName == nil || [setName isEqualToString:@""]) {
        NSLog(@"未选择跳转项");
        return;
    }
    
    NSString *settingKey = @"";
    for (NXSystemaSettingType *obj in self.models) {
        if ([obj.CName isEqualToString:setName]) {
            settingKey = obj.SettingType;
            NSLog(@"--- : %@",obj.SettingType);
            break;
        }
        NSLog(@"--------");
    }
    
    if ([settingKey isEqualToString:@""]) {
        NSLog(@"未包含所选项");
        return;
    }
    
    // 2.根据当前的系统版本做跳转的分类处理
    //  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    //     跳转前必须至少申请过一次权限，否则会crash（模拟器上是跳转到桌面）
    //  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    if (iOS10) {
        //  10以上的系统处理
        //  该方法在iOS 10上会被出错，已经被弃用
//        NSURL *appURL = [NSURL URLWithString:settingKey];
//        if( [[UIApplication sharedApplication] canOpenURL:appURL] ) {
//            
//            [[UIApplication sharedApplication]openURL:appURL options:@{}completionHandler:^(BOOL        success) {
//                
//            }];
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if( [[UIApplication sharedApplication]canOpenURL:url] ) {
                [[UIApplication sharedApplication]openURL:url options:@{}completionHandler:^(BOOL        success) {
                }];
            }
        
    }else if (iOS9)
    {
        //  9以上的系统处理
        //  方法一
        //        NSURL *appURL = [NSURL URLWithString:settingKey];
        //        if( [[UIApplication sharedApplication] canOpenURL:appURL] ) {
        //
        //            [[UIApplication sharedApplication]openURL:appURL options:@{}completionHandler:^(BOOL        success) {
        //
        //            }];
        //  方法二（跳转到本app内的设置项）
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if( [[UIApplication sharedApplication]canOpenURL:url] ) {
            [[UIApplication sharedApplication]openURL:url options:@{}completionHandler:^(BOOL        success) {
            }];
        }
    }else if (iOS8)
    {
        //  8以上的系统处理
        //  方法一
        //        NSURL *appURL = [NSURL URLWithString:settingKey];
        //        if( [[UIApplication sharedApplication] canOpenURL:appURL] ) {
        //
        //            [[UIApplication sharedApplication]openURL:appURL options:@{}completionHandler:^(BOOL        success) {
        //
        //            }];
        //  方法二（跳转到本app内的设置项）
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if( [[UIApplication sharedApplication]canOpenURL:url] ) {
            [[UIApplication sharedApplication]openURL:url options:@{}completionHandler:^(BOOL        success) {
            }];
        }

    }else {
        //  7系列系统的处理
        NSURL *appURL = [NSURL URLWithString:settingKey];
        if ([[UIApplication sharedApplication] canOpenURL:appURL])
        {
            [[UIApplication sharedApplication] openURL:appURL];
        }
    }
    
}

- (BOOL)checkoutAuthorization {
    NSString *tipTextWhenNoPhotosAuthorization; // 提示语
    // 获取当前应用对照片的访问授权状态
    ALAuthorizationStatus authorizationStatus = [ALAssetsLibrary authorizationStatus];
    // 如果没有获取访问授权，或者访问授权状态已经被明确禁止，则显示提示语，引导用户开启授权
    if (authorizationStatus == ALAuthorizationStatusRestricted || authorizationStatus == ALAuthorizationStatusDenied) {
        NSDictionary *mainInfoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *appName = [mainInfoDictionary objectForKey:@"CFBundleDisplayName"];
        tipTextWhenNoPhotosAuthorization = [NSString stringWithFormat:@"请在设备的\"设置-隐私-照片\"选项中，允许%@访问你的手机相册", appName];
        // 展示提示语
        UIAlertView *tipAlert = [[UIAlertView alloc] initWithTitle:@"没有访问权限" message:tipTextWhenNoPhotosAuthorization delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
        [tipAlert show];
        return NO;
    }
    return YES;
}

@end
