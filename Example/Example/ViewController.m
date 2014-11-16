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
    
    self.animatedView.minLength = 3;
}

- (IBAction)didStartAnimationTouch:(id)sender
{
    [self.animatedView setValue:[NSNumber numberWithInt:(rand() % 5000)]];
    [self.animatedView startAnimation];
}

@end
