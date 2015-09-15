//
//  MPSendToFriendViewController.h
//  MYPROPERTY
//
//  Created by Somenath on 30/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FW_JsonClass.h"

@interface MPSendToFriendViewController : UIViewController
{
    FW_JsonClass *obj;
}

@property (strong,nonatomic) NSString *idstring;
@property (strong,nonatomic) NSMutableDictionary *data_dic;
@property (strong,nonatomic) NSString *chakdata;
@property (strong,nonatomic) NSString *finalchackdata;
@end
