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
    FW_JsonClass *obj;
    NSUserDefaults *userinfo;
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


@end
