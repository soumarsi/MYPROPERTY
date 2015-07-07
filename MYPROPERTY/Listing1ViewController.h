//
//  Listing1ViewController.h
//  MyProperty
//
//  Created by soumyajit on 03/07/15.
//  Copyright (c) 2015 kausik jati. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Listing1ViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
#define _kARRY1 0
#define _kARRAY2 1

{
    NSArray *Arry1;
    NSArray *Arry2;
    IBOutlet UIPickerView *picker;
    
    IBOutlet UIView *pview;
}
- (IBAction)btn1:(id)sender;
- (IBAction)btn2:(id)sender;
- (IBAction)btn3:(id)sender;
- (IBAction)btn4:(id)sender;
- (IBAction)btn5:(id)sender;
- (IBAction)btn6:(id)sender;
- (IBAction)Pkrcanclebtn:(id)sender;

@end
