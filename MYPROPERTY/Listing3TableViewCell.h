//
//  Listing3TableViewCell.h
//  myProfile
//
//  Created by Shwetaa's iMac on 03/07/15.
//  Copyright (c) 2015 kausik jati. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Listing3TableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titlelabel;
@property (strong, nonatomic) IBOutlet UILabel *bedroomslabel;
@property (strong, nonatomic) IBOutlet UILabel *pricelabel;
@property (strong, nonatomic) IBOutlet UIButton *booknow;
@property (strong, nonatomic) IBOutlet UIButton *addToFavBtn;
@property (strong, nonatomic) IBOutlet UIImageView *addToFavImg;
@property (strong, nonatomic) IBOutlet UIImageView *homepicture;
@end
