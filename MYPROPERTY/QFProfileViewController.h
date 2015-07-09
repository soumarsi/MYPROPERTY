//
//  QFProfileViewController.h
//  MYPROPERTY
//
//  Created by Somenath on 03/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FW_JsonClass.h"
@interface QFProfileViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    IBOutlet UITextField *nameUpdate;
    
    
    IBOutlet UITextField *phonenoUpdate;
    
    IBOutlet UITextField *emailUpdate;
    
    IBOutlet UITextField *towntxt;
    IBOutlet UILabel *addresslbl;
    
    IBOutlet UIButton *updatebtn;
    NSString *userid;
  
    
    IBOutlet UIScrollView *scrollView;
    FW_JsonClass *obj;
    IBOutlet UILabel *countrylbl;
    NSMutableArray *countryArry;
    IBOutlet UIPickerView *picker;
    IBOutlet UIView *pview;
    NSString *holedata;
    
}

@property (strong, nonatomic) IBOutlet UIImageView *profilepic;
@property (strong, nonatomic) IBOutlet UILabel *profileName;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UIButton *profileEdit;
@property (strong, nonatomic) IBOutlet UITextView *addresstextview;
- (IBAction)okbtn:(id)sender;

- (IBAction)countryBtn:(id)sender;
- (IBAction)cancelbtn:(id)sender;

- (IBAction)update:(id)sender;


@end
