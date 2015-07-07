//
//  MPNotificationViewController.h
//  MYPROPERTY
//
//  Created by Somenath on 03/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationCell.h"

@interface MPNotificationViewController : UIViewController
{
    NotificationCell *cell;
}

@property (strong, nonatomic) IBOutlet UIButton *messagebtn;
@property (strong, nonatomic) IBOutlet UIButton *settingbtn;
@property (strong, nonatomic) IBOutlet UITableView *msgtableview;
@property (strong, nonatomic) IBOutlet UIView *searchalert;
@property (strong, nonatomic) IBOutlet UIView *bookingalert;
@property (strong, nonatomic) IBOutlet UIView *renewalert;
@property (strong, nonatomic) IBOutlet UIView *offeralert;
@property (strong, nonatomic) IBOutlet UIView *propertyalert;
@end
