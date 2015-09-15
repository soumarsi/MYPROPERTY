//
//  ForgotPassword.h
//  MYPROPERTY
//
//  Created by soumyajit on 29/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FW_JsonClass.h"

@interface ForgotPassword : UIViewController<UITextFieldDelegate>
{
    
    __weak IBOutlet UITextField *forgotText;
    __weak IBOutlet UIButton *submitbtn;
    FW_JsonClass *obj;
}
- (IBAction)SubmitTap:(id)sender;

@end
