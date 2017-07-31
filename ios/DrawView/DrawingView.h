//
//  DrawingView.h
//  EDC
//
//  Created by fanruliang on 16/6/30.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawingView : UIImageView
@property(nonatomic) BOOL isEdit;
@property(nonatomic) int lineWidth;
-(void)revocAction;
-(void)clear;
-(UIImage *)currentImage;
@end
