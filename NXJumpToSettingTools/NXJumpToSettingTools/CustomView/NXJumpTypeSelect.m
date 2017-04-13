//
//  NXJumpTypeSelect.m
//  NXJumpToSettingTools
//
//  Created by linyibin on 2017/4/6.
//  Copyright © 2017年 NXAristotle. All rights reserved.
//

#import "NXJumpTypeSelect.h"
#import "NXSystemaSettingType.h"
#import "MJExtension.h"

@interface NXJumpTypeSelect ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, strong) NSArray *models;  /**< 模型 */

@end

@implementation NXJumpTypeSelect

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        [self setModeldata];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
    [self setModeldata];
}

- (void)setupUI {
    UIPickerView *picker = [[UIPickerView alloc] init];
    self.inputView = picker;
    picker.dataSource = self;
    picker.delegate = self;
    picker.backgroundColor = [UIColor colorFromHexRGB:@"30A8E9"];
    
    UIButton *endBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [endBtn setTitle:@"结束" forState:UIControlStateNormal];
    [endBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [endBtn setBackgroundColor:[UIColor colorFromHexRGB:@"30A8E9"]];
    
    [endBtn setFrame:CGRectMake(0, 0, screenWidth, 44)];
    
    [endBtn addTarget:self action:@selector(endEditing:) forControlEvents:UIControlEventTouchUpInside];
    self.inputAccessoryView = endBtn;
}


- (void)setModeldata {
    
    //  方式一
    //    NSArray *modelArray = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NXSystemaSettingType" ofType:@"plist"]];
    //
    //    NSArray *models = [NXSystemaSettingType mj_objectArrayWithKeyValuesArray:modelArray];
    
    //  方式二：
    self.models = [NXSystemaSettingType mj_objectArrayWithFile:[[NSBundle mainBundle] pathForResource:@"NXSystemaSettingType" ofType:@"plist"]];
    
    NSLog(@"----models :%@",self.models);
    
    
}

#pragma mark - UIPickerViewDataSource


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.models.count;
}

#pragma mark - UIPickerViewDelegate

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NXSystemaSettingType *model = self.models[row];
    return model.CName;
    
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"did select %zd行",row);
    NXSystemaSettingType *model = self.models[row];
    self.text = model.CName;
    
}






@end
