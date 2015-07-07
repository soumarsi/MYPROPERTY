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


@interface ViewController : UIViewController
{
    NSUserDefaults *defaults;
}
@property (strong, nonatomic) IBOutlet UILabel *label1;
@property (strong, nonatomic) IBOutlet UILabel *label2;
@property (strong, nonatomic) IBOutlet UILabel *label3;
@property (strong, nonatomic) IBOutlet UILabel *labellogin;
- (IBAction)fbloginbutton:(id)sender;
- (IBAction)twitterloginbutton:(id)sender;
@end

