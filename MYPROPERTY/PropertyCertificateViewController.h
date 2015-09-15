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
#import "AFNetworking.h"
#import "MPMyPropertyViewController.h"
#import "ImageResize.h"

@interface PropertyCertificateViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate>
{
    
    IBOutlet UIScrollView *scroll;
    int check;
    NSString *uesrid;
    
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
    NSMutableData *mutableData;
    NSMutableArray *trucksArray;
    
    
    
    NSData *imageData5,*imageData6,*imageData7,*imageData8;
    
    
    
    int scr;
    
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


@property(strong,nonatomic)NSMutableDictionary *firstpagedata,*thirdpagedata;
@property (strong ,nonatomic) NSMutableArray *secondpagedata;
//@property (strong,nonatomic) NSMutableArray *thirdpageimagearry;
@property (strong,nonatomic)NSString *secondpagevideocode;
@property (strong,nonatomic)NSData *imgdata1,*imgdata2,*imgdata3,*imgdata4,*imgdata5;

@end
