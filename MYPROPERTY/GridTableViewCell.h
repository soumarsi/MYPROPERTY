//
//  GridTableViewCell.h
//  MYPROPERTY
//
//  Created by Shwetaa's iMac on 08/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titlelabel;
@property (strong, nonatomic) IBOutlet UILabel *bedroomslabel;
@property (strong, nonatomic) IBOutlet UILabel *pricelabel;
@property (strong, nonatomic) IBOutlet UIButton *booknow;
@property (strong, nonatomic) IBOutlet UIImageView *addToFavImg;
@property (strong, nonatomic) IBOutlet UIButton *addToFavBtn;
@property (strong, nonatomic) IBOutlet UIImageView *homepicture;
@end
