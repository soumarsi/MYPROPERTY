//
//  LoginViewController.h
//  MYPROPERTY
//
//  Created by soumyajit on 06/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FW_JsonClass.h"
#import "SearchViewController.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate>


{
    __weak IBOutlet UIButton *loginbtn;
    IBOutlet UIActivityIndicatorView *spinner;
    FW_JsonClass *obj;
    NSUserDefaults *userinfo;
     BOOL check;
    IBOutlet UIView *spinnerview;
}
@property (strong, nonatomic) IBOutlet UITextField *emailtext;
@property (strong, nonatomic) IBOutlet UITextField *passwordtext;
- (IBAction)signupbackbutton:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *label1;
@property (strong, nonatomic) IBOutlet UILabel *label2;
@property (strong, nonatomic) IBOutlet UILabel *label3;
@property (strong ,nonatomic) NSMutableArray *Arry1;
@property (strong,nonatomic) NSString *userid;
- (IBAction)clickLogin:(id)sender;
- (IBAction)forgotbtnTap:(id)sender;


@end
