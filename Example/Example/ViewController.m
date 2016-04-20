//
//  ViewController.m
//  Example
//
//  Created by Jonathan Tribouharet
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.animatedView.textColor = [UIColor whiteColor];
    self.animatedView.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:42];
    self.animatedView.duration = 5.0;
    self.animatedView.durationOffset = 1.0;
    self.animatedView.minLength = 4;
}

- (IBAction)didStartAnimationTouch:(id)sender
{
    [self.animatedView setValue:0];
    [self.animatedView startAnimation];
}

@end
