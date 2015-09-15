//
//  Footer.m
//  MYPROPERTY
//
//  Created by Somenath on 03/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "Footer.h"
#import "FavouriteViewController.h"

@implementation Footer
@synthesize footerdelegate;

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
        self=[[[NSBundle mainBundle] loadNibNamed:@"Footer" owner:self options:nil]objectAtIndex:0];
    }
    return self;
}

-(void)TapCheck:(int)Buttontag
{
    if (Buttontag == 1)
    {
        NSLog(@"%ld",(long)Buttontag);
        [_home setSelected:YES];
    }
    if (Buttontag == 2)
    {
        NSLog(@"aaaa%ld",(long)Buttontag);
        [_love setSelected:YES];
    }
    if (Buttontag == 3)
    {
        [_plus setSelected:YES];
    }
    if (Buttontag == 4)
    {
        [_bell setSelected:YES];
    }
    if (Buttontag == 5)
    {
        [_man setSelected:YES];
        [_home setSelected:NO];
        [_love setSelected:NO];
        [_plus setSelected:NO];
        [_bell setSelected:NO];
    }
}

//- (IBAction)Footer_button_action:(UIButton *)sender
//{
//    if ([footerdelegate respondsToSelector:@selector(pushmethod:)])
//    {
//        [footerdelegate pushmethod:sender];
//
//    }
//
//}

- (IBAction)homeTapped:(id)sender
{
    [footerdelegate pushmethod:sender];
    //    [_home setSelected:YES];
}

- (IBAction)favouritesTapped:(id)sender
{
    [footerdelegate pushmethod:sender];
    //    [_love setSelected:YES];
}

- (IBAction)addTapped:(id)sender
{
    [footerdelegate pushmethod:sender];
    //    [_plus setSelected:YES];
}

- (IBAction)notificationTapped:(id)sender
{
    [footerdelegate pushmethod:sender];
    //    [_bell setSelected:YES];
}

- (IBAction)profileTapped:(id)sender
{
    [footerdelegate pushmethod:sender];
    //    [_man setSelected:YES];
}

- (IBAction)homeBigBtn:(id)sender
{
    [footerdelegate pushmethod:sender];
}

- (IBAction)favBigBtn:(id)sender
{
    [footerdelegate pushmethod:sender];
}

- (IBAction)addBigBtn:(id)sender
{
    [footerdelegate pushmethod:sender];
}

- (IBAction)notiBigBtn:(id)sender
{
    [footerdelegate pushmethod:sender];
}

- (IBAction)menuBigBtn:(id)sender
{
    [footerdelegate pushmethod:sender];
}


@end
