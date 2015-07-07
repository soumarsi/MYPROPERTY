//
//  LoginViewController.h
//  MYPROPERTY
//
//  Created by soumyajit on 06/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UITextField *emaiid;
    IBOutlet UITextField *pass;
}

@end
