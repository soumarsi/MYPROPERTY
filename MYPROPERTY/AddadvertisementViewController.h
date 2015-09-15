//
//  AddadvertisementViewController.h
//  MYPROPERTY
//
//  Created by Shwetaa's iMac on 14/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FW_JsonClass.h"

@interface AddadvertisementViewController : UIViewController
{
    FW_JsonClass *obj;
    
}
@property (strong,nonatomic) NSString *chkdata;
@property (strong,nonatomic) NSString *prevprice;
@property (strong, nonatomic) IBOutlet UILabel *PMlabel;
@property (strong, nonatomic) IBOutlet UILabel *monthslabel;
@property (strong, nonatomic) IBOutlet UILabel *furnishedlabel;
- (IBAction)pmbutton:(id)sender;
- (IBAction)monthsbutton:(id)sender;
- (IBAction)furnishedbutton:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *myview;
@property (strong, nonatomic) IBOutlet UIPickerView *mainpicker;
@property (strong, nonatomic) IBOutlet UIButton *pmbutton;
@property (strong, nonatomic) IBOutlet UIButton *monthsbutton;
- (IBAction)pickerdonebutton:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *pickercancelbutton;
@property (strong, nonatomic) IBOutlet UIButton *furnishedbutton;
- (IBAction)pickercancelbutton:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *pricetextfield;
- (IBAction)nextbutton:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *nextbutton;
- (IBAction)backtodashbordbutton:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *saleofpropertylabel;
@property (strong, nonatomic) IBOutlet UILabel *offerslabel;
@property (strong, nonatomic) IBOutlet UIImageView *offerarrowimage;
@property (strong, nonatomic) IBOutlet UILabel *rentofpropertylabel;
@property (strong, nonatomic) IBOutlet UILabel *rentofpropertysublabel;
@property (strong, nonatomic) IBOutlet UIImageView *rentofpropertysubimage;
@property (strong, nonatomic) IBOutlet UILabel *rentaltermlabel;
@property (strong, nonatomic) IBOutlet UILabel *rentaltermsublabel;
@property (strong, nonatomic) IBOutlet UIImageView *rentaltermssubimage;
@property (strong, nonatomic) IBOutlet UILabel *propertycontentslabel;
@property (strong, nonatomic) IBOutlet UIImageView *propertycontentssubimage;
- (IBAction)saleofpropertybutton:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *saleofpropertybutton;
@property (strong, nonatomic) IBOutlet UILabel *pagetitle;

@property (strong , nonatomic) NSString * mypropertyRent;
@property (strong , nonatomic) NSString * mypropertySell;
@property (strong , nonatomic) NSString * editforRent;
@property (strong , nonatomic) NSString * editforSell;


@property (strong,nonatomic) NSString *property_id;
@property (strong,nonatomic) NSString *advert_id;

@end
