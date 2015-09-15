//

//  Listing0ViewController.h

//  MyProperty

//

//  Created by soumyajit on 03/07/15.

//  Copyright (c) 2015 kausik jati. All rights reserved.

//



#import <UIKit/UIKit.h>
#import "FW_JsonClass.h"
#import "list0Cell.h"
#import "Listing3ViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"



@interface Listing0ViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,NSURLSessionDataDelegate,NSURLSessionDelegate,NSURLSessionTaskDelegate>





{
    AppDelegate *app;
    
    __weak IBOutlet UILabel *minlbl;
    
    
    __weak IBOutlet UILabel *maxlbl;
    
    
    __weak IBOutlet UIImageView *header;
    
    FW_JsonClass *obj;
    
    IBOutlet UIView *myView;
    
    
    
    IBOutlet UITableView *mytable;
    
    IBOutlet UIView *tablebackview;
    
    IBOutlet UIView *blackview;
    
    
    
    IBOutlet UILabel *lbl3;
    
    
    
    IBOutlet UILabel *lbl1;
    
    
    
    IBOutlet UILabel *lbl2;
    
    
    
    IBOutlet UIPickerView *picker;
    
    
    
    IBOutlet UILabel *lbl5;
    
    IBOutlet UILabel *lbl4;
    
    IBOutlet UIView *pview;
    
    NSString *holedata, *userid;
    
    
    IBOutlet UIView *srchclickview;
    
    IBOutlet UIActivityIndicatorView *spinner1;
    
    
    IBOutlet UILabel *maxbedroom;
    
    
    
    IBOutlet UILabel *maxprice;
    
    
    
    
    
    __weak IBOutlet UILabel *hipen1;
    
    
    
    __weak IBOutlet UILabel *hipen2;
    
    
    
    IBOutlet UIButton *done;
    
    NSMutableDictionary *data;
    
    
    
    NSString *lat,*lng;
    
    
    
    IBOutlet UISwitch *parking;
    
    NSString *status;
    
    
    
    NSMutableArray *arry1 , *arry2,*arry3,*arry4;
    
    NSString *id1 , *id2 , *id3,*id4;
    
    NSString *idmaxprice , *idmaxbed;
    
    
    
    NSMutableArray *searchArray;
    
    NSString *comp0 ,*idzero;
    
    NSString *comp1 ,*idfirst;
    
    
    
    NSMutableDictionary *temp ;
    
    
    //IBOutlet UIActivityIndicatorView *lodertext;
    
    int btntag ;
    
}

@property (strong, nonatomic) IBOutlet UITextField *srchFld;
@property (strong,nonatomic)NSString *check;
@property(strong,nonatomic) NSMutableArray *Arry1,*Arry2,*Arry3,*Arry4,*Arry5,*Arraytable;
@property (strong,nonatomic)NSString *srchtype;
- (IBAction)backBtn:(id)sender;

- (IBAction)btn1:(id)sender;

- (IBAction)btn2:(id)sender;

- (IBAction)btn3:(id)sender;

- (IBAction)btn4:(id)sender;

- (IBAction)btn5:(id)sender;



- (IBAction)Pkrcanclebtn:(id)sender;

- (IBAction)done:(id)sender;

@end