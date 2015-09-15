//
//  MPBookAgentViewController.h
//  MYPROPERTY
//
//  Created by Somenath on 21/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookAgentCell.h"
#import "FW_JsonClass.h"

@interface MPBookAgentViewController : UIViewController
{
    BookAgentCell *cell;
    FW_JsonClass *obj;
}

@property (strong, nonatomic) NSMutableDictionary *bookingDetailsDic;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *book_id;
@property (strong, nonatomic) NSString *chkdata;
@property (strong, nonatomic) NSString *finaladv_id;
@property (strong,nonatomic) NSString *finalmonth;
@property (strong,nonatomic) NSString *finalyear;
@end
