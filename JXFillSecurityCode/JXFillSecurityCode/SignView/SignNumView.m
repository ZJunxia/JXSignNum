//
//  SignNumView.m
//  doWhat
//
//  Created by mac on 17/3/30.
//  Copyright © 2017年 _. All rights reserved.
//

#import "SignNumView.h"
#import <Masonry.h>

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface SignNumView ()<UITextFieldDelegate>

@property (nonatomic, strong)UITextField *textfield;

@end

@implementation SignNumView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self layOutUI];
    }
    return self;
    
}

- (void)layOutUI{
    UILabel *lb_fist = [[UILabel alloc] init];
    lb_fist.font = [UIFont systemFontOfSize:15];
    lb_fist.textColor = [UIColor blackColor];
    lb_fist.tag = 500;
    lb_fist.text = @"输入企业提供的签到数字,即可完成签到";
    [self addSubview:lb_fist];
    [lb_fist mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(89);
        make.height.greaterThanOrEqualTo(@15);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    
    UIView *numView = [[UIView alloc] init];
    [self addSubview:numView];
    [numView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.height.equalTo(@35);
        make.width.equalTo(@(kScreenWidth - 112));
        make.top.equalTo(lb_fist.mas_bottom).offset(65);
    }];
    self.textfield = [[UITextField alloc] init];
    _textfield.delegate = self;
    [self addSubview:self.textfield];
    _textfield.keyboardType = UIKeyboardTypeNumberPad;
    [_textfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(40);
        make.left.equalTo(self.mas_left);
        make.height.equalTo(@35);
        make.width.equalTo(@100);
    }];

    for (int i=0; i<6; i++) {
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-112)/6*i+56, CGRectGetMaxY(lb_fist.frame) + 150, (kScreenWidth-112)/6, 35)];
        lable.tag = 100 + i;
        lable.textAlignment = NSTextAlignmentCenter;
        lable.text = @"—";
        lable.font = [UIFont boldSystemFontOfSize:31];
        lable.userInteractionEnabled = YES;
        [self addSubview:lable];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionShowKeyboard:)];
        [lable addGestureRecognizer:tapGesture];
        
        
    }
    
}

- (void)actionShowKeyboard:(UITapGestureRecognizer *)gesture
{
    [self.textfield becomeFirstResponder];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSInteger orLength = textField.text.length;
    NSInteger strLength = textField.text.length - range.length + string.length;
    
    if (strLength > orLength) {
        if (strLength>=1) {
            UILabel *lable = (UILabel *)[self viewWithTag:99+strLength];
            lable.text = string;
            lable.hidden = NO;
        }
    }else{
        if (strLength>=0) {
            UILabel *lable = (UILabel *)[self viewWithTag:99+orLength];
            lable.text = @"—";
            lable.hidden = NO;
        }
    }
    if (strLength<=6) {
        if (strLength==6) {
            if (self.block !=nil) {
                NSString *lastNum = [NSString stringWithFormat:@"%@%@",textField.text,string];
                self.block(lastNum);
            }
            [self.textfield resignFirstResponder];
        }
        return YES;
    }else{
        
        return NO;
    }
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
