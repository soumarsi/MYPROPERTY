//
//  AppointmentCell.h
//  MYPROPERTY
//
//  Created by Somenath on 20/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *appoint_status;
@property (strong, nonatomic) IBOutlet UILabel *bedroomdetails;
@property (strong, nonatomic) IBOutlet UILabel *datetovisit;
@property (strong, nonatomic) IBOutlet UILabel *timming;
@property (strong, nonatomic) IBOutlet UILabel *bookingstatus;
@property (strong, nonatomic) IBOutlet UIButton *newtimebtn;
@property (strong, nonatomic) IBOutlet UILabel *bookingstatusHeading;
@property (strong, nonatomic) IBOutlet UILabel *offerstatusheading;
@property (strong, nonatomic) IBOutlet UIImageView *propertyimg;
@property (strong, nonatomic) IBOutlet UIImageView *slidearrow;
@end
