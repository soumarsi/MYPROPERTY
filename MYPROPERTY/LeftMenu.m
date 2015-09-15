//
//  LeftMenu.m
//  MYPROPERTY
//
//  Created by Somenath on 08/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "LeftMenu.h"

@implementation LeftMenu
@synthesize leftDelegate;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        self=[[[NSBundle mainBundle] loadNibNamed:@"LeftMenu" owner:self options:nil]objectAtIndex:0];
    }
    return self;
}

- (IBAction)alertsTapped:(id)sender
{
    NSLog(@"sender=%ld",(long)sender);
    [leftDelegate leftclk:sender];
}
- (IBAction)myPropertyTapped:(id)sender
{
    NSLog(@"sender=%ld",(long)sender);
    [leftDelegate leftclk:sender];
}
- (IBAction)myAddTapped:(id)sender
{
    NSLog(@"sender=%ld",(long)sender);
    [leftDelegate leftclk:sender];
}

@end
