//
//  MPOfferAlertsViewController.h
//  MYPROPERTY
//
//  Created by Somenath on 05/08/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FW_JsonClass.h"
#import "OfferListCell.h"
#import "OfferGridCell.h"

@interface MPOfferAlertsViewController : UIViewController
{
    FW_JsonClass *obj;
    OfferListCell *cell1;
    OfferGridCell *cell2;
}

@end
