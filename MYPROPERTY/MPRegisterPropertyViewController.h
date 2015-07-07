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
    NSMutableArray *Array_1;
}
- (IBAction)btn1:(id)sender;

@end
