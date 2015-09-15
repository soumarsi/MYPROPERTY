//
//  MPAddPropertyAdd.h
//  MYPROPERTY
//
//  Created by Somenath on 14/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FW_JsonClass.h"
#import "MPDashBoardViewController.h"

@interface MPAddPropertyAdd : UIViewController
{
    UITableViewCell *cell;
    FW_JsonClass *obj;
}

@property (strong, nonatomic) NSString *p_id;
@property (strong, nonatomic) NSString *addfinal_id;

@property (strong, nonatomic) NSString *price_text;
@property (strong, nonatomic) NSString *rentofproperty1;
@property (strong, nonatomic) NSString *rentalterm1;
@property (strong, nonatomic) NSString *propertycontent1;
@property (strong, nonatomic) NSString *saleofproperty1;




@property (strong , nonatomic) NSString * mypropertyRent;
@property (strong , nonatomic) NSString * mypropertySell;
@property (strong , nonatomic) NSString * editforRent;
@property (strong , nonatomic) NSString * editforSell;
- (IBAction)submit:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *submit;
@property (strong, nonatomic) IBOutlet UIButton *dateAvailableTapped;



@end
