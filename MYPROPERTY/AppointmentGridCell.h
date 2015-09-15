//
//  AppointmentGridCell.h
//  MYPROPERTY
//
//  Created by Somenath on 06/08/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentGridCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *appoint_status;
@property (strong, nonatomic) IBOutlet UILabel *timming;
@property (strong, nonatomic) IBOutlet UILabel *datetovisit;
@property (strong, nonatomic) IBOutlet UILabel *bookingstatus;
@property (strong, nonatomic) IBOutlet UIButton *newtimebtn;
@property (strong, nonatomic) IBOutlet UIImageView *propertyimg;
@property (strong, nonatomic) IBOutlet UIButton *feedback;
@property (strong, nonatomic) IBOutlet UIButton *makeoffer;
@property (strong, nonatomic) IBOutlet UIButton *requestreciveconfirm;
@property (strong, nonatomic) IBOutlet UIButton *requestrecivereject;

@end
