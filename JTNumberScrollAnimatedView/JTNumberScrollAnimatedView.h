//
//  JTNumberScrollAnimatedView.h
//  JTNumberScrollAnimatedView
//
//  Created by Jonathan Tribouharet
//

#import <UIKit/UIKit.h>

@interface JTNumberScrollAnimatedView : UIView

@property (strong, nonatomic) NSNumber *value;

@property (strong, nonatomic) UIColor *textColor;
@property (strong, nonatomic) UIFont *font;
@property (assign, nonatomic) CFTimeInterval duration;
@property (assign, nonatomic) CFTimeInterval durationOffset;
@property (assign, nonatomic) NSUInteger density;
@property (assign, nonatomic) NSUInteger minLength;
@property (assign, nonatomic) BOOL isAscending;
@property (strong, nonatomic) NSMutableArray *numbersText;

- (void)startAnimation;
- (void)stopAnimation;

@end
