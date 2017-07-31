//
//  DrawingView.m
//  EDC
//
//  Created by fanruliang on 16/6/30.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "DrawingView.h"
#import "MagnifierView.h"
@interface DrawingView ()
{
    NSMutableArray *mutArrLastPoint;
}
@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, strong) UIBezierPath *orginpath;
@property (nonatomic, strong) NSMutableArray *mutArrPoint;
@property (strong , nonatomic) MagnifierView* loop;
@property (strong , nonatomic) NSTimer* touchTimer;
@end

@implementation DrawingView

+(Class)layerClass
{
  //this makes our view create a CAShapeLayer
  //instead of a CALayer for its backing layer
  return [CAShapeLayer class];
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
    }
    return self;
}

-(void)initData
{
    //create a mutable path
    self.path = [[UIBezierPath alloc] init];
    _lineWidth = 5;
    //configure the layer
    CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
    shapeLayer.strokeColor = [UIColor blackColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineWidth = _lineWidth;
    
    _mutArrPoint = [NSMutableArray new];
}

-(void)revocAction
{
    if (_mutArrPoint.count > 0) {
        [_mutArrPoint removeLastObject];
        [self.path removeAllPoints];
        for (NSMutableArray *mutArr in _mutArrPoint) {
            for (int i=0;i<mutArr.count;i++) {
                CGPoint point = CGPointFromString(mutArr[i]);
                if (i==0) {
                    [self.path moveToPoint:point];
                }
                else
                {
                    [self.path addLineToPoint:point];
                }
                
            }
        }
    }
    ((CAShapeLayer *)self.layer).path = self.path.CGPath;
}

-(void)clear
{
    [_mutArrPoint removeAllObjects];
    [self.path removeAllPoints];
    ((CAShapeLayer *)self.layer).path = self.path.CGPath;
}

-(UIImage *)currentImage
{
    float scale = self.image.size.width/self.bounds.size.width;
    if (self.image.size.width < self.image.size.height) {
        scale =self.image.size.height/self.bounds.size.height;
    }
    CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
    CGRect frame = shapeLayer.frame;
    shapeLayer.frame = CGRectMake(0, 0, self.image.size.width, self.image.size.height);
    
    shapeLayer.lineWidth = _lineWidth*scale;
    self.orginpath = [self.path copy];
    [self.path applyTransform:CGAffineTransformMakeScale(scale, scale)];
    shapeLayer.path = self.path.CGPath;
    
    UIGraphicsBeginImageContextWithOptions(self.image.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    shapeLayer.frame = frame;
    shapeLayer.path = self.orginpath.CGPath;
    shapeLayer.lineWidth = _lineWidth;
    return img;
}

//-(UIImage *)currentImage
//{
//    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [self.layer renderInContext:context];
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return img;
//}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if (_isEdit) {
        //get the starting point
        CGPoint point = [[touches anyObject] locationInView:self];
        
        //move the path drawing cursor to the starting point
        [self.path moveToPoint:point];
        mutArrLastPoint = [NSMutableArray new];
        [mutArrLastPoint addObject:NSStringFromCGPoint(point)];
        
        self.touchTimer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(addLoop) userInfo:nil repeats:NO];
        
        if (self.loop == nil) {
            self.loop = [[MagnifierView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, 200, 200)];
            self.loop.viewToMagnify = self.window;
        }
        
        UITouch* touch = [touches anyObject];
        self.loop.touchPoint = [touch locationInView:self.window];
        [self.loop setNeedsDisplay];
    }
    
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    if (_isEdit) {
        //get the current point
        CGPoint point = [[touches anyObject] locationInView:self];
        
        //add a new line segment to our path
        [self.path addLineToPoint:point];
        [mutArrLastPoint addObject:NSStringFromCGPoint(point)];
        //update the layer with a copy of the path
        ((CAShapeLayer *)self.layer).path = self.path.CGPath;
        
        UITouch *touch = [touches anyObject];
        self.loop.touchPoint = [touch locationInView:self.window];
        [self.loop setNeedsDisplay];
    }
  
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if (_isEdit) {
        [_mutArrPoint addObject:mutArrLastPoint];
        
        [self.touchTimer invalidate];
        self.touchTimer = nil;
        
        self.loop = nil;
    }
    
}

- (void)addLoop {
    // add the loop to the superview.  if we add it to the view it magnifies, it'll magnify itself!
    //[self.superview addSubview:loop];
    [self.loop makeKeyAndVisible];
    // here, we could do some nice animation instead of just adding the subview...
}

//- (void)drawRect:(CGRect)rect
//{
//    //draw path
//    [[UIColor clearColor] setFill];
//    [[UIColor redColor] setStroke];
//    [self.path stroke];
//}
@end
