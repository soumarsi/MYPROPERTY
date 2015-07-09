//

//  MPRegisterPropertyViewController.h

//  MYPROPERTY

//

//  Created by Somenath on 03/07/15.

//  Copyright (c) 2015 Esolz. All rights reserved.

//



#import <UIKit/UIKit.h>



@interface MPRegisterPropertyViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>

{
    
    IBOutlet  UIPickerView *myPickerView;
    
    IBOutlet UILabel *relationProperty;
    IBOutlet UILabel *propertytypelbl;
    IBOutlet UILabel *currentstatus;
    IBOutlet UILabel *noofbed;
    IBOutlet UILabel *noofroom;
    
    IBOutlet UILabel *noofbath;
    
    NSString *holedata;
    
    
    NSMutableArray *Array_1,*Array_2,*Array_3,*Array_4,*Array_5;
    
    IBOutlet UIView *pview;
    IBOutlet UIImageView *secondarrow;
    
    IBOutlet UIButton *done;
    int btntag;
    
    CGPoint scroll;
    
}

- (IBAction)btn1:(id)sender;
- (IBAction)btn2:(id)sender;
- (IBAction)btn3:(id)sender;
- (IBAction)btn4:(id)sender;
- (IBAction)btn5:(id)sender;
- (IBAction)btn6:(id)sender;


- (IBAction)cancel:(id)sender;

- (IBAction)done:(id)sender;


@end

