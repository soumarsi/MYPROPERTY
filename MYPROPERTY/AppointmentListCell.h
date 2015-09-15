//
//  AppointmentListCell.h
//  MYPROPERTY
//
//  Created by Somenath on 06/08/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentListCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *appoint_status;
@property (strong, nonatomic) IBOutlet UILabel *timming;
@property (strong, nonatomic) IBOutlet UILabel *datetovisit;
@property (strong, nonatomic) IBOutlet UILabel *bookingstatus;
@property (strong, nonatomic) IBOutlet UILabel *bedroomlbl;
@property (strong, nonatomic) IBOutlet UIButton *newtimebtn;
@property (strong, nonatomic) IBOutlet UIImageView *slidearrow;
@property (strong, nonatomic) IBOutlet UIImageView *propertyimg;
@end
