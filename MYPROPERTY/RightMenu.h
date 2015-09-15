//
//  RightMenu.h
//  MYPROPERTY
//
//  Created by Somenath on 03/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Footer.h"

@protocol rightDelegate<NSObject>
@optional
-(void)rightclk:(UIButton *)sender;
@end

@interface RightMenu : UIView
{
    NSUserDefaults *userinfo;
}

@property(assign)id<rightDelegate>rightDelegate;

@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UIButton *inviteFriends;
@property (strong, nonatomic) IBOutlet UIButton *EditProfile;
@property (strong, nonatomic) IBOutlet UIButton *changePassword;
@property (strong, nonatomic) IBOutlet UIButton *logOut;

- (IBAction)editProfileTap:(id)sender;

@end
