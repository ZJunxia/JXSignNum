//
//  SignNumView.h
//  doWhat
//
//  Created by mac on 17/3/30.
//  Copyright © 2017年 _. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SuccessBlock)(NSString *numStr);

@interface SignNumView : UIView

@property (nonatomic, copy)SuccessBlock block;



@end
