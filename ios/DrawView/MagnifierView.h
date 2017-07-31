//
//  MagnifierView.h
//  SimplerMaskTest
//

#import <UIKit/UIKit.h>

@interface MagnifierView : UIWindow {
	UIView *viewToMagnify;
	CGPoint touchPoint;
    int direction;
}

@property (nonatomic, retain) UIView *viewToMagnify;
@property (assign) CGPoint touchPoint;

@end
