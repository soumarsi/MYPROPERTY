//
//  RightMenu.h
//  MYPROPERTY
//
//  Created by Somenath on 03/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightMenu : UIView

@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UIButton *inviteFriends;
@property (strong, nonatomic) IBOutlet UIButton *EditProfile;
@property (strong, nonatomic) IBOutlet UIButton *changePassword;
@property (strong, nonatomic) IBOutlet UIButton *logOut;

@end
