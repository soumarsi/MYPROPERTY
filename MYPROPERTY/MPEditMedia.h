//
//  MPEditMedia.h
//  MYPROPERTY
//
//  Created by Somenath on 14/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPEditMedia : UIViewController


@property (strong, nonatomic) NSMutableDictionary *data_dictionary;
@property (strong, nonatomic) IBOutlet UILabel *dateOfEpcTaken;
@property (strong, nonatomic) IBOutlet UILabel *dateOfGasTestTaken;
@property (strong, nonatomic) IBOutlet UILabel *dateOfElecSafeTestTaken;
@property (strong, nonatomic) IBOutlet UILabel *gasRegNo;
@property (strong, nonatomic) IBOutlet UILabel *certificateSerialNo;
@end
