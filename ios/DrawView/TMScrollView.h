//
//  TMScrollView.h
//  TestSign
//
//  Created by fanruliang on 17/7/11.
//  Copyright © 2017年 TM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMScrollView : UIScrollView
@property(nonatomic) BOOL isEdit;
@property(nonatomic,strong) UIImage *image;
-(UIImage*)cropImage;
-(void)revocAction;
-(void)clear;
@end
