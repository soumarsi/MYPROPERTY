//
//  OfferGridCell.h
//  MYPROPERTY
//
//  Created by Somenath on 06/08/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfferGridCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *appoint_status;
@property (strong, nonatomic) IBOutlet UILabel *pricelbl;
@property (strong, nonatomic) IBOutlet UILabel *timming;
@property (strong, nonatomic) IBOutlet UILabel *datetovisit;
@property (strong, nonatomic) IBOutlet UILabel *bookingstatus;
@property (strong, nonatomic) IBOutlet UIImageView *propertyimg;
@property (strong, nonatomic) IBOutlet UIButton *confirmoffer;
@property (strong, nonatomic) IBOutlet UIButton *rejectoffer;
@end
