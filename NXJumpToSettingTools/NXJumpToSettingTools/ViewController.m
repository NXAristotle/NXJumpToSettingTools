//
//  ViewController.m
//  NXJumpToSettingTools
//
//  Created by linyibin on 2017/4/6.
//  Copyright © 2017年 NXAristotle. All rights reserved.
//

#import "ViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation ViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self temp];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method

- (void)temp {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // 设置可用的媒体类型、默认只包含kUTTypeImage，如果想选择视频，请添加kUTTypeMovie
    // 如果选择的是视屏，允许的视屏时长为20秒
    imagePicker.videoMaximumDuration = 20;
    // 允许的视屏质量（如果质量选取的质量过高，会自动降低质量）
//    imagePicker.videoQuality = UIImagePickerControllerQualityTypeHigh;
//    imagePicker.mediaTypes = @[(NSString *)kUTTypeMovie, (NSString *)kUTTypeImage];
    
    [self presentViewController:imagePicker animated:YES completion:^{
        
    }];
    
}

- (IBAction)jumpToSetting:(UIButton *)sender {
    
    /*
     使用该API，必须之前申请过一次权限，否则直接跳转会跳转到桌面
     */
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if( [[UIApplication sharedApplication]canOpenURL:url] ) {
        [[UIApplication sharedApplication]openURL:url options:@{}completionHandler:^(BOOL        success) {
        }];
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
