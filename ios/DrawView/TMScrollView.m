//
//  TMScrollView.m
//  TestSign
//
//  Created by fanruliang on 17/7/11.
//  Copyright © 2017年 TM. All rights reserved.
//

#import "TMScrollView.h"
#import "DrawingView.h"
#define Screen_width [UIScreen mainScreen].bounds.size.width
#define Screen_height [UIScreen mainScreen].bounds.size.height
@interface TMScrollView ()<UIScrollViewDelegate>
{
    DrawingView *dw;
}
@end
@implementation TMScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        dw = [[DrawingView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        dw.backgroundColor = [UIColor grayColor];
        dw.userInteractionEnabled = YES;
        dw.clipsToBounds = YES;
        [self addSubview:dw];
        
        self.delegate = self;
        self.maximumZoomScale = 3;
        self.minimumZoomScale = 1;
        
    }
    return self;
}


-(void)setIsEdit:(BOOL)isEdit
{
    _isEdit = isEdit;
    self.scrollEnabled = !_isEdit;
    dw.isEdit = isEdit;
}

-(void)setImage:(UIImage *)image
{
    _image = image;
    dw.image = image;
    if (dw.image.size.width > Screen_width || dw.image.size.height>Screen_height) {
        CGFloat widthSelf = self.bounds.size.width;
        CGFloat heightSelf = self.bounds.size.height;
        CGFloat width = Screen_width;
        CGFloat height = Screen_height;
        if (dw.image.size.width >= dw.image.size.height) {
            height = Screen_width * (dw.image.size.height/dw.image.size.width);
        }
        else
        {
            width = Screen_height * (dw.image.size.width/dw.image.size.height);
        }
        
        dw.frame = CGRectMake((widthSelf-width)/2, (heightSelf - height)/2, width, height);
    }
}

-(void)clear
{
    [dw clear];
}

-(void)revocAction
{
    [dw revocAction];
}

-(UIImage*)cropImage
{
    return [dw currentImage];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    for (UIView *v in scrollView.subviews){
        return v;
    }
    return nil;
}

@end
