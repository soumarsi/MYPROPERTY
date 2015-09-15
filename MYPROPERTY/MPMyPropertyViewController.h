//
//  MPMyPropertyViewController.h
//  MYPROPERTY
//
//  Created by Somenath on 23/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FW_JsonClass.h"
#import "DashboardListCell.h"
#import "DashboardGridCell.h"

@interface MPMyPropertyViewController : UIViewController
{
    FW_JsonClass *obj;
    DashboardListCell *cell1;
    DashboardGridCell *cell2;
}
@property (strong,nonatomic)NSString *datachangestring;
@property (strong, nonatomic) IBOutlet UIProgressView *processview;

@end
