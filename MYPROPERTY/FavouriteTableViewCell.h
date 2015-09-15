//
//  FavouriteTableViewCell.h
//  myProfile
//
//  Created by Shwetaa's iMac on 03/07/15.
//  Copyright (c) 2015 kausik jati. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavouriteTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *addresslbl;
@property (strong, nonatomic) IBOutlet UIImageView *homepicture;
@property (strong, nonatomic) IBOutlet UILabel *titlelabel;
@property (strong, nonatomic) IBOutlet UILabel *subtitle;
@property (strong, nonatomic) IBOutlet UILabel *pricelabel;
@property (strong, nonatomic) IBOutlet UIImageView *rentimageview;
- (IBAction)rentbutton:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *likeimage;
@property (strong,nonatomic) IBOutlet UIButton *rentbutton;
@property (strong, nonatomic) IBOutlet UIImageView *rowimage;
@property (strong, nonatomic) IBOutlet UIImageView *rowimageview;
@property (strong, nonatomic) IBOutlet UIButton *checkUncheckBtn;

@end
