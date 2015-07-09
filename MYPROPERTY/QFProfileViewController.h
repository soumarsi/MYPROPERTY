//
//  QFProfileViewController.h
//  MYPROPERTY
//
//  Created by Somenath on 03/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FW_JsonClass.h"
@interface QFProfileViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UITextField *nameUpdate;
    

    IBOutlet UITextField *phonenoUpdate;
   
    IBOutlet UITextField *emailUpdate;
    
    
    IBOutlet UIButton *updatebtn;
    NSString *userid;

    FW_JsonClass *obj;

}

@property (strong, nonatomic) IBOutlet UIImageView *profilepic;
@property (strong, nonatomic) IBOutlet UILabel *profileName;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UIButton *profileEdit;


- (IBAction)update:(id)sender;


@end
