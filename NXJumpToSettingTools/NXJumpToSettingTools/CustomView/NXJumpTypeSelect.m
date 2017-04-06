//
//  NXJumpTypeSelect.m
//  NXJumpToSettingTools
//
//  Created by linyibin on 2017/4/6.
//  Copyright © 2017年 NXAristotle. All rights reserved.
//

#import "NXJumpTypeSelect.h"

@interface NXJumpTypeSelect ()<UIPickerViewDataSource,UIPickerViewDelegate>

@end

@implementation NXJumpTypeSelect

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
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

#pragma mark - UIPickerViewDataSource


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 2;
}

#pragma mark - UIPickerViewDelegate


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"did select %zd行",row);
}




@end
