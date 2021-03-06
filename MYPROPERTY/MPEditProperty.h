//
//  MPEditProperty.h
//  MYPROPERTY
//
//  Created by Somenath on 13/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPEditPropertyMediaZero.h"
#import "FW_JsonClass.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface MPEditProperty : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UITextViewDelegate>


{
    FW_JsonClass *obj;
    AppDelegate *app;
    
    IBOutlet  UIPickerView *myPickerView;
    
    IBOutlet UILabel *relationProperty;
    IBOutlet UILabel *propertytypelbl;
    IBOutlet UILabel *currentstatus;
    IBOutlet UILabel *noofbed;
    IBOutlet UILabel *noofroom;
    NSMutableArray *arry;
    IBOutlet UILabel *noofbath;
    
    IBOutlet UILabel *addresslbl;
    NSString *holedata,*holddata;
    NSString *newAddress;
    
    
    IBOutlet UITextView *propertysummary;
    
    IBOutlet UITextView *propertyfulldescription;
    
    
    
    
    NSMutableArray *Array_1,*Array_2,*Array_3,*Array_4,*Array_5;
    IBOutlet UILabel *townlbl;
    
    IBOutlet UILabel *countylbl;
    IBOutlet UIView *pview;
    IBOutlet UIImageView *secondarrow;
    
    IBOutlet UILabel *pincodelbl;
    IBOutlet UIButton *done;
    int btntag;
    
    CGPoint scroll;
    NSArray *pickarry;
    NSMutableArray *data1,*data2,*data3;
    
    IBOutlet UISwitch *parking;
    NSString *parkingflg;
    
    IBOutlet UISwitch *gardenflg;
    NSString *gardenflag;
    
    IBOutlet UIButton *btn1;
    IBOutlet UIButton *btn2;
    IBOutlet UIButton *btn3;
    IBOutlet UIButton *btn4;
    IBOutlet UIButton *btn5;
    IBOutlet UIButton *btn6;
    
    NSMutableDictionary *dict;
    
    IBOutlet UILabel *propertysumrylbl;
    
    IBOutlet UILabel *propertydescriptionlbl;
    NSMutableArray *Arryid1 , *Arryid2 ,*Arryid3 , *Arryid4 ;
    NSString *sndid1 , *sndid2 ,*sndid3;
    
    
    
    NSString *Longitude;
    NSString *Latitude;
    NSMutableArray *latArray;
    NSMutableArray *longArray;
    
    
}

@property(strong,nonatomic)IBOutlet UITextField *picCodesrch;
@property (strong, nonatomic) NSMutableDictionary *regisdetail;

@property (strong,nonatomic)NSMutableArray *pincodeArray,*ary;;
- (IBAction)pincodeDonebtn:(id)sender;

- (IBAction)btn1:(id)sender;
- (IBAction)btn2:(id)sender;
- (IBAction)btn3:(id)sender;
- (IBAction)btn4:(id)sender;
- (IBAction)btn5:(id)sender;
- (IBAction)btn6:(id)sender;

- (IBAction)next:(id)sender;

- (IBAction)cancel:(id)sender;

- (IBAction)done:(id)sender;

@end
