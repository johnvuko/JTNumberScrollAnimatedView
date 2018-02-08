//
//  JTNumberScrollAnimatedView.h
//  JTNumberScrollAnimatedView
//
//  Created by Jonathan Tribouharet
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    JTNumberScrollAnimatedViewFillerZero,
    JTNumberScrollAnimatedViewFillerSpace,
} JTNumberScrollAnimatedViewFillers;

@interface JTNumberScrollAnimatedView : UIView

@property (strong, nonatomic) NSNumberFormatter *numberFormatter;
@property (strong, nonatomic) NSNumber *value;
@property (strong, nonatomic) NSString *prefix;
@property (strong, nonatomic) NSString *suffix;

@property (nonatomic) JTNumberScrollAnimatedViewFillers filler;

@property (strong, nonatomic) UIColor *textColor;
@property (strong, nonatomic) UIFont *font;
@property (assign, nonatomic) CFTimeInterval duration;
@property (assign, nonatomic) CFTimeInterval durationOffset;
@property (assign, nonatomic) NSUInteger density;
@property (assign, nonatomic) NSUInteger minLength;
@property (assign, nonatomic) BOOL isAscending;

- (void)startAnimation;
- (void)stopAnimation;

@end
