//
//  MPMakeAnOfferViewController.h
//  MYPROPERTY
//
//  Created by Somenath on 25/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FW_JsonClass.h"

@interface MPMakeAnOfferViewController : UIViewController
{
    FW_JsonClass *obj;
}

@property (strong,nonatomic) NSMutableDictionary *data_dic;

@end
