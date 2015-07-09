//
//  RightMenu.m
//  MYPROPERTY
//
//  Created by Somenath on 03/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "RightMenu.h"

@implementation RightMenu
@synthesize rightDelegate;

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
        self=[[[NSBundle mainBundle] loadNibNamed:@"RightMenu" owner:self options:nil]objectAtIndex:0];
    }
    return self;
}

- (IBAction)editProfileTap:(id)sender
{
    [rightDelegate rightclk:sender];
}

- (IBAction)changPasswordTapped:(id)sender
{
    [rightDelegate rightclk:sender];
}


@end


