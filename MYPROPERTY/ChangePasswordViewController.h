//
//  ChangePasswordViewController.h
//  MYPROPERTY
//
//  Created by soumyajit on 08/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FW_JsonClass.h"

@interface ChangePasswordViewController : UIViewController
{
    FW_JsonClass *obj;
}
@property (strong, nonatomic) IBOutlet UIButton *chngbtn;
@property (strong, nonatomic) IBOutlet UITextField *newpwd;
@property (strong, nonatomic) IBOutlet UITextField *confrmpwd;
- (IBAction)chngpwdbtn:(id)sender;

@end
