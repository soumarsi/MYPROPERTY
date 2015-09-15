//
//  MPEditPropertyMediaZero.h
//  MYPROPERTY
//
//  Created by soumyajit on 22/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPEditMedia.h"
#import "UIImageView+WebCache.h"
#import "ImageResize.h"

@interface MPEditPropertyMediaZero : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UIActionSheetDelegate>
{
    
    IBOutlet UIScrollView *scroll;
    IBOutlet UIImageView *imageview1;
    IBOutlet UIImageView *imageview2;
    IBOutlet UIImageView *imageview3;
    IBOutlet UIImageView *imageview4;
    IBOutlet UIImageView *imageview5;
    IBOutlet UITextField *codetxt;
    
    
    NSData *imagedata;
    NSMutableArray *imageArry;
    
    int i;
    NSInteger j ;
    
    int check;
    int remove;
    
    NSMutableArray *mediaArry;
    
}

@property (strong ,nonatomic) UIImagePickerController *imagePicker;

- (IBAction)upldbtn1:(id)sender;
- (IBAction)upldbtn2:(id)sender;
- (IBAction)upldbtn3:(id)sender;
- (IBAction)upldbtn4:(id)sender;
- (IBAction)upldbtn5:(id)sender;
- (IBAction)nextbtn:(id)sender;
@property(strong,nonatomic) UIImage *img1 ;
@property(strong,nonatomic) UIImage *img2 ;
@property(strong,nonatomic) UIImage *img3 ;
@property(strong,nonatomic) UIImage *img4 ;
@property(strong,nonatomic) UIImage *img5 ;

@property(strong,nonatomic)NSMutableDictionary *firstdic, *josndic;
@property (strong,nonatomic)NSMutableArray *dic;
- (IBAction)BackTap:(id)sender;

@end
