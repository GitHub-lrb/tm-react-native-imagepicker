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
        dw.contentMode = UIViewContentModeScaleAspectFit;

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
