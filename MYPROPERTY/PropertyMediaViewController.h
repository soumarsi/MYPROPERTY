//
//  PropertyMediaViewController.h
//  MYPROPERTY
//
//  Created by soumyajit on 11/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PropertyCertificateViewController.h"

@interface PropertyMediaViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UIActionSheetDelegate>
{
    
    IBOutlet UIScrollView *scroll;
    IBOutlet UIImageView *imageview1;
    IBOutlet UIImageView *imageview2;
    IBOutlet UIImageView *imageview3;
    IBOutlet UIImageView *imageview4;
    IBOutlet UIImageView *imageview5;
    IBOutlet UITextField *codetxt;
    UIImage *img1 ;
    UIImage *img2 ;
    UIImage *img3 ;
    UIImage *img4 ;
    UIImage *img5 ;
    
    int i;
}

@property (strong ,nonatomic) UIImagePickerController *imagePicker;

- (IBAction)upldbtn1:(id)sender;
- (IBAction)upldbtn2:(id)sender;
- (IBAction)upldbtn3:(id)sender;
- (IBAction)upldbtn4:(id)sender;
- (IBAction)upldbtn5:(id)sender;
- (IBAction)nextbtn:(id)sender;
- (IBAction)cambtn1:(id)sender;


@property(strong,nonatomic)NSMutableDictionary *firstdic, *dic;





@end
