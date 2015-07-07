//
//  Listing0ViewController.h
//  MyProperty
//
//  Created by soumyajit on 03/07/15.
//  Copyright (c) 2015 kausik jati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FW_JsonClass.h"

@interface Listing0ViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>

#define _kdata 0;
{
    FW_JsonClass *obj;
    IBOutlet UIView *myView;
    
    
    
    IBOutlet UILabel *lbl3;
    
    IBOutlet UILabel *lbl1;
    
    IBOutlet UILabel *lbl2;
    
    IBOutlet UIPickerView *picker;
    
    IBOutlet UILabel *lbl5;
    IBOutlet UILabel *lbl4;
    IBOutlet UIView *pview;
    NSString *holedata;
    IBOutlet UIButton *done;
    int btntag ;
}
@property(strong,nonatomic) NSMutableArray *Arry1;
- (IBAction)btn1:(id)sender;
- (IBAction)btn2:(id)sender;
- (IBAction)btn3:(id)sender;
- (IBAction)btn4:(id)sender;
- (IBAction)btn5:(id)sender;
- (IBAction)Pkrcanclebtn:(id)sender;
- (IBAction)done:(id)sender;
@end
