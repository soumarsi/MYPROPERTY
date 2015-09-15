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
@property (strong, nonatomic) IBOutlet UIButton *letme;
@property (strong, nonatomic) IBOutlet UIButton *sellme;
@property (strong, nonatomic) IBOutlet UIButton *edit;
@property (strong, nonatomic) IBOutlet UIButton *renewadd;
@property (strong, nonatomic) IBOutlet UIButton *editadd;
@property (strong, nonatomic) IBOutlet UIButton *removeadd;
@end
