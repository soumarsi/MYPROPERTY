//
//  ViewController.h
//  myProfile
//
//  Created by soumyajit on 02/07/15.
//  Copyright (c) 2015 kausik jati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
//#import <TwitterKit/TwitterKit.h>
#import "FW_JsonClass.h"


@interface ViewController : UIViewController
{
    NSUserDefaults *defaults;
    FW_JsonClass *obj;
    NSString *username;
    NSString *mailid;
    NSString *date;
    NSString *nicename;
    NSString *displayname;
    NSString *fullname;
}
@property (strong, nonatomic) IBOutlet UILabel *label1;
@property (strong, nonatomic) IBOutlet UILabel *label2;
@property (strong, nonatomic) IBOutlet UILabel *label3;
@property (strong, nonatomic) IBOutlet UILabel *labellogin;
- (IBAction)fbloginbutton:(id)sender;
- (IBAction)twitterloginbutton:(id)sender;
- (IBAction)loginbutton:(id)sender;
- (IBAction)signupbutton:(id)sender;


@end

