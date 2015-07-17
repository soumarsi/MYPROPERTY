//
//  PropertyCertificateViewController.h
//  MYPROPERTY
//
//  Created by soumyajit on 11/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FW_JsonClass.h"
#import "MPDashBoardViewController.h"

@interface PropertyCertificateViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate>
{
    
    IBOutlet UIScrollView *scroll;
    int check;
    
    UIView *myview;
    
    NSString *strday;
    NSString *strmon;
    NSString *stryear;
    UIDatePicker* picker;
    UIView *mainView;
    FW_JsonClass *obj;
    
    
    IBOutlet UIImageView *imageview1;
    IBOutlet UIImageView *imageview2;
    IBOutlet UIImageView *imageview3;
    IBOutlet UIImageView *imageview4;
    
    UIImage *images1 ;
    UIImage *images2 ;
    UIImage *images3 ;
    UIImage *images4 ;
    
    IBOutlet UILabel *dateEpclbl;
    IBOutlet UILabel *gastestdata;
    IBOutlet UILabel *electricSafedatelbl;
    
    IBOutlet UITextField *gassafe;
    
    IBOutlet UITextField *cftserialtxt;
    int ok;
    
    IBOutlet UIButton *submitbtn;
    
    IBOutlet UIButton *data1btn;
    
    IBOutlet UIButton *data3btn;
    IBOutlet UIButton *data2btn;
    
    
    NSString *uesrid;
}
@property (strong ,nonatomic) UIImagePickerController *imagePicker;


- (IBAction)submitbtn:(id)sender;




- (IBAction)date1:(id)sender;
- (IBAction)date2:(id)sender;
- (IBAction)date3:(id)sender;

- (IBAction)upldbtn1:(id)sender;
- (IBAction)upldbtn2:(id)sender;
- (IBAction)upldbtn3:(id)sender;
- (IBAction)upldbtn4:(id)sender;


@property(strong,nonatomic)NSMutableDictionary *firstpagedata,*secondpagedata ,*thirdpagedata;


@end
