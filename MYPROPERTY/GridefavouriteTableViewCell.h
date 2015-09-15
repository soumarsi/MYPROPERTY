//
//  GridefavouriteTableViewCell.h
//  MYPROPERTY
//
//  Created by Shwetaa's iMac on 08/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridefavouriteTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *roomslbl;
@property (strong, nonatomic) IBOutlet UILabel *address;

- (IBAction)removebutton:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UILabel *pricelbl;
@property (strong, nonatomic) IBOutlet UIImageView *homepicture;
@property (strong, nonatomic) IBOutlet UIButton *removebutton;

@end
