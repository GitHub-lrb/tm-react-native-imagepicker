//
//  DrawViewController.h
//  imageCropPicker
//
//  Created by fanruliang on 2017/7/11.
//  Copyright © 2017年 Ivan Pusic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawViewController : UIViewController
-(void)setImage:(UIImage *)image crop:(void (^)(UIImage *))cropBlock;
@end
