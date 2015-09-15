//
//  PropertyDetails2ViewController.h
//  MyProperty
//
//  Created by soumyajit on 03/07/15.
//  Copyright (c) 2015 kausik jati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "FW_JsonClass.h"

@interface PropertyDetails2ViewController : UIViewController
{
    IBOutlet UIScrollView *scrollView;
    FW_JsonClass *obj;
}

@property  NSInteger *list3indexpath;
@property (strong, nonatomic) NSString *checkstring;
@property (strong, nonatomic) NSMutableDictionary *data_dic;
- (IBAction)sendtofriend:(id)sender;

- (IBAction)requestmoredetalis:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *propertytype;
- (IBAction)sharebutton:(id)sender;
- (IBAction)arrangeviewing:(id)sender;
@end
