//
//  MPDashBoardViewController.h
//  MYPROPERTY
//
//  Created by Somenath on 08/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FW_JsonClass.h"
#import "DashboardListCell.h"
#import "DashboardGridCell.h"

@interface MPDashBoardViewController : UIViewController
{
    FW_JsonClass *obj;
    DashboardListCell *cell1;
    DashboardGridCell *cell2;
}

@property (strong, nonatomic) IBOutlet UIScrollView *buttonScroll;
@property (strong, nonatomic) IBOutlet UIView *subCatgoryView;
@property (strong, nonatomic) IBOutlet UIButton *alertssearchbtn;
@property (strong, nonatomic) IBOutlet UIButton *mypropertybtn;
@property (strong, nonatomic) IBOutlet UIButton *myadvertisementbtn;
@property (strong, nonatomic) IBOutlet UIButton *subviewbtn;
@property (strong, nonatomic) IBOutlet UIImageView *headerimg;

@end
