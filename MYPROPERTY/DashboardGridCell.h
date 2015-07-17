//
//  DashboardGridCell.h
//  MYPROPERTY
//
//  Created by Somenath on 10/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboardGridCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *propertyimage;
@property (strong, nonatomic) IBOutlet UILabel *titlelabel;
@property (strong, nonatomic) IBOutlet UILabel *bedroomslabel;
@property (strong, nonatomic) IBOutlet UILabel *pricelabel;
@end
