//
//  JTNumberScrollAnimatedView.m
//  JTNumberScrollAnimatedView
//
//  Created by Jonathan Tribouharet
//

#import "JTNumberScrollAnimatedView.h"

@interface JTNumberScrollAnimatedView(){
    NSMutableArray *numbersText;
    NSMutableArray *scrollLayers;
    NSMutableArray *scrollLabels;
}

@end

@implementation JTNumberScrollAnimatedView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self){
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(!self){
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (void)commonInit
{
    self.duration = 1.5;
    self.durationOffset = .2;
    self.density = 5;
    self.minLength = 0;
    self.isAscending = NO;
    
    self.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    self.textColor = [UIColor blackColor];
    
    numbersText = [NSMutableArray new];
    scrollLayers = [NSMutableArray new];
    scrollLabels = [NSMutableArray new];
}

- (void)setValue:(NSNumber *)value
{
    self->_value = value;
    
    [self prepareAnimations];
}

- (void)startAnimation
{
    [self prepareAnimations];
    [self createAnimations];
}

- (void)stopAnimation
{
    for(CALayer *layer in scrollLayers){
        [layer removeAnimationForKey:@"JTNumberScrollAnimatedView"];
    }
}

- (void)prepareAnimations
{
    for(CALayer *layer in scrollLayers){
        [layer removeFromSuperlayer];
    }
    
    [numbersText removeAllObjects];
    [scrollLayers removeAllObjects];
    [scrollLabels removeAllObjects];
    
    [self createNumbersText];
    [self createScrollLayers];
}

- (void)createNumbersText
{
    NSString *textValue = [self.value stringValue];
    
    for(NSInteger i = 0; i < (NSInteger)self.minLength - (NSInteger)[textValue length]; ++i){
        [numbersText addObject:@"0"];
    }
    
    for(NSUInteger i = 0; i < [textValue length]; ++i){
        [numbersText addObject:[textValue substringWithRange:NSMakeRange(i, 1)]];
    }
}

- (void)createScrollLayers
{
    BOOL allowAlignmentCenter = NO;
    CGFloat totalWidth = CGRectGetWidth(self.frame);
    CGFloat width = roundf(totalWidth / numbersText.count);
    if (self.singleUnitWidthForAlignmentCenter > 0 && self.singleUnitWidthForAlignmentCenter * numbersText.count <= totalWidth) {
        width = self.singleUnitWidthForAlignmentCenter;
        allowAlignmentCenter = YES;
    }
    
    CGFloat height = CGRectGetHeight(self.frame);
    
    for(NSUInteger i = 0; i < numbersText.count; ++i){
        CAScrollLayer *layer = [CAScrollLayer layer];
        CGFloat layerX = allowAlignmentCenter ? (totalWidth - numbersText.count * width) / 2 + i * width : roundf(i * width);
        layer.frame = CGRectMake(layerX, 0, width, height);
        [scrollLayers addObject:layer];
        [self.layer addSublayer:layer];
    }
    
    for(NSUInteger i = 0; i < numbersText.count; ++i){
        CAScrollLayer *layer = scrollLayers[i];
        NSString *numberText = numbersText[i];
        [self createContentForLayer:layer withNumberText:numberText];
    }
}

- (void)createContentForLayer:(CAScrollLayer *)scrollLayer withNumberText:(NSString *)numberText
{
    NSInteger number = [numberText integerValue];
    NSMutableArray *textForScroll = [NSMutableArray new];
    
    for(NSUInteger i = 0; i < self.density + 1; ++i){
        [textForScroll addObject:[NSString stringWithFormat:@"%lu", (number + i) % 10]];
    }
    
    [textForScroll addObject:numberText];

    if(!self.isAscending){
        textForScroll = [[[textForScroll reverseObjectEnumerator] allObjects] mutableCopy];
    }
    
    CGFloat height = 0;
    for(NSString *text in textForScroll){
        UILabel * textLabel = [self createLabel:text];
        textLabel.frame = CGRectMake(0, height, CGRectGetWidth(scrollLayer.frame), CGRectGetHeight(scrollLayer.frame));
        [scrollLayer addSublayer:textLabel.layer];
        [scrollLabels addObject:textLabel];
        height = CGRectGetMaxY(textLabel.frame);
    }
}

- (UILabel *)createLabel:(NSString *)text
{
    UILabel *view = [UILabel new];
    
    view.textColor = self.textColor;
    view.font = self.font;
    view.textAlignment = NSTextAlignmentCenter;
    
    view.text = text;
    
    return view;
}

- (void)createAnimations
{
    CFTimeInterval duration = self.duration - ([numbersText count] * self.durationOffset);
    CFTimeInterval offset = 0;
    
    for(CALayer *scrollLayer in scrollLayers){
        CGFloat maxY = [[scrollLayer.sublayers lastObject] frame].origin.y;
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"sublayerTransform.translation.y"];
        animation.duration = duration + offset;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        
        if(self.isAscending){
            animation.fromValue = [NSNumber numberWithFloat:-maxY];
            animation.toValue = @0;
        }
        else{
            animation.fromValue = @0;
            animation.toValue = [NSNumber numberWithFloat:-maxY];
        }
        
        [scrollLayer addAnimation:animation forKey:@"JTNumberScrollAnimatedView"];
        
        offset += self.durationOffset;
    }
}

@end
