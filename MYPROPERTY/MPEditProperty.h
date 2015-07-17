//
//  MPEditProperty.h
//  MYPROPERTY
//
//  Created by Somenath on 13/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPEditProperty : UIViewController

@property (strong, nonatomic) NSMutableDictionary *regisdetail;

@property (strong, nonatomic) IBOutlet UILabel *relationToProperty;
@property (strong, nonatomic) IBOutlet UILabel *propertyType;
@property (strong, nonatomic) IBOutlet UILabel *currentStatus;
@property (strong, nonatomic) IBOutlet UITextField *postCode;
@property (strong, nonatomic) IBOutlet UITextField *address1;
@property (strong, nonatomic) IBOutlet UITextField *town;
@property (strong, nonatomic) IBOutlet UITextField *country;
@property (strong, nonatomic) IBOutlet UITextField *postcodezip;
@property (strong, nonatomic) IBOutlet UILabel *noOfBedRooms;
@property (strong, nonatomic) IBOutlet UILabel *noOfRooms;
@property (strong, nonatomic) IBOutlet UILabel *noOfBathRooms;
@property (strong, nonatomic) IBOutlet UITextView *summaryDescrp;
@property (strong, nonatomic) IBOutlet UITextView *fullDescrp;
@property (strong, nonatomic) IBOutlet UISwitch *parkingFlag;
@property (strong, nonatomic) IBOutlet UISwitch *gardenFlag;
@property (strong, nonatomic) IBOutlet UILabel *prop_desc_lbl;
@property (strong, nonatomic) IBOutlet UILabel *prop_full_desc;

@end
