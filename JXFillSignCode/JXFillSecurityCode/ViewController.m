//
//  ViewController.m
//  JXFillSecurityCode
//
//  Created by mac on 17/6/13.
//  Copyright © 2017年 ZhJunxia. All rights reserved.
//

#import "ViewController.h"
#import "SignNumView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self adddSignView];
}

- (void)adddSignView
{
    SignNumView *signView = [[SignNumView alloc] initWithFrame:self.view.bounds];
    __weak typeof(self) weakSelf = self;
    signView.block = ^(NSString *numStr){
        //当输完6位验证码的回调
        NSLog(@"输入了密码%@",numStr);
        [weakSelf showSignNumWithNum:numStr];
    };
    [self.view addSubview:signView];
    
}
- (void)showSignNumWithNum:(NSString *)numStr
{
    UIAlertController *alertVC= [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"密码是:%@",numStr] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style: UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:okAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
