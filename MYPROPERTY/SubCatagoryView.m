//
//  SubCatagoryView.m
//  MYPROPERTY
//
//  Created by Somenath on 05/08/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "SubCatagoryView.h"

@implementation SubCatagoryView
@synthesize SubCatagoryDelegate;

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
        self=[[[NSBundle mainBundle] loadNibNamed:@"SubCatagoryView" owner:self options:nil]objectAtIndex:0];
    }
    return self;
}

-(void)TapCheck:(int)Buttontag
{
    if (Buttontag == 1)
    {
        NSLog(@"%ld",(long)Buttontag);
        [_markerView setFrame:CGRectMake(0, 0, 5, 35)];
    }
    if (Buttontag == 2)
    {
        NSLog(@"aaaa%ld",(long)Buttontag);
        [_markerView setFrame:CGRectMake(0, 35, 5, 35)];
    }
    if (Buttontag == 3)
    {
        [_markerView setFrame:CGRectMake(0, 70, 5, 35)];
    }
    if (Buttontag == 4)
    {
        [_markerView setFrame:CGRectMake(0, 105, 5, 35)];
    }
    if (Buttontag == 5)
    {
        [_markerView setFrame:CGRectMake(0, 140, 5, 35)];
    }
    if (Buttontag == 6)
    {
        [_markerView setFrame:CGRectMake(0, 175, 5, 35)];
    }
}

- (IBAction)searchAlertTapped:(UIButton *)sender
{
    [SubCatagoryDelegate subCatagoryClk:sender];
}

- (IBAction)propertyStatusTapped:(UIButton *)sender
{
    [SubCatagoryDelegate subCatagoryClk:sender];
}


- (IBAction)appointmentTapped:(UIButton *)sender
{
    [SubCatagoryDelegate subCatagoryClk:sender];
}

- (IBAction)offerAlertTapped:(UIButton *)sender
{
    [SubCatagoryDelegate subCatagoryClk:sender];
}

- (IBAction)renewAlertsTapped:(UIButton *)sender
{
    [SubCatagoryDelegate subCatagoryClk:sender];
}

- (IBAction)propertyIssueTapped:(UIButton *)sender
{
    [SubCatagoryDelegate subCatagoryClk:sender];
}


@end
