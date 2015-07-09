//
//  SignupViewController.h
//  MYPROPERTY
//
//  Created by soumyajit on 06/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "FW_JsonClass.h"
#import "LoginViewController.h"

@interface SignupViewController : UIViewController<UITextFieldDelegate>

{
    FW_JsonClass *obj;
    IBOutlet UIButton *signup;
}

- (IBAction)signupback:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *titletextfield;
@property (strong, nonatomic) IBOutlet UITextField *firstnametextfield;
@property (strong, nonatomic) IBOutlet UITextField *lastnametextfield;
@property (strong, nonatomic) IBOutlet UITextField *emailtextfield;
@property (strong, nonatomic) IBOutlet UITextField *passwordtextfield;
@property (strong, nonatomic) IBOutlet UITextField *confirmpasswordtextfield;
@property(strong ,nonatomic) NSMutableArray *Arry1;
- (IBAction)clickSignup:(id)sender;
- (IBAction)loginbuttonpushfromsignup:(id)sender;

@end
