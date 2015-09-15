//
//  MPAppointmentViewController.h
//  MYPROPERTY
//
//  Created by Somenath on 05/08/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FW_JsonClass.h"
#import "AppointmentListCell.h"
#import "AppointmentGridCell.h"

@interface MPAppointmentViewController : UIViewController
{
    FW_JsonClass *obj;
    AppointmentListCell *cell1;
    AppointmentGridCell *cell2;
}

@end
