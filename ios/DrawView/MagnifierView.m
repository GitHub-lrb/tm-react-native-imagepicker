//
//  MagnifierView.m
//  SimplerMaskTest
//

#import "MagnifierView.h"
#import <QuartzCore/QuartzCore.h>

@implementation MagnifierView
@synthesize viewToMagnify, touchPoint;

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		// make the circle-shape outline with a nice border.
		self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
		self.layer.borderWidth = 2;
		self.layer.cornerRadius = frame.size.width/2;
		self.layer.masksToBounds = YES;
		self.windowLevel = UIWindowLevelAlert;
        
        direction = 0;//
	}
	return self;
}

- (void)setTouchPoint:(CGPoint)pt {
	touchPoint = pt;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat y = 0;
	// whenever touchPoint is set, 
	// update the position of the magnifier (to just above what's being magnified)
    
    if(direction == 0)
    {
        y = pt.y-self.frame.size.height/2 - 30;
        if (pt.y < self.frame.size.height/2 + 30)
        {
            direction = 1;
            y = pt.y+self.frame.size.height/2 + 30;
        }
        
    }
    else
    {
        y = pt.y+self.frame.size.height/2 + 30;
        
        if (pt.y > height - self.frame.size.height/2 - 30) {
            direction = 0;
            y = pt.y-self.frame.size.height/2 - 30;
        }
    }
	self.center = CGPointMake(pt.x, y);
}

- (void)drawRect:(CGRect)rect {
	// here we're just doing some transforms on the view we're magnifying,
	// and rendering that view directly into this view,
	// rather than the previous method of copying an image.
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(context,1*(self.frame.size.width*0.5),1*(self.frame.size.height*0.5));
	CGContextScaleCTM(context, 3, 3);
	CGContextTranslateCTM(context,-1*(touchPoint.x),-1*(touchPoint.y));
	[self.viewToMagnify.layer renderInContext:context];
}



@end
