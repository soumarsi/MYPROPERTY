//
//  Listing3ViewController.h
//  myProfile
//
//  Created by soumyajit on 02/07/15.
//  Copyright (c) 2015 kausik jati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Listing3TableViewCell.h"
#import "FW_JsonClass.h"
#import <MapKit/MapKit.h>

@interface Listing3ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MKMapViewDelegate,MKAnnotation>
{
    FW_JsonClass *obj;
    UIButton *PicButton;
    //  float lati , loni;
    
}

@property (strong, nonatomic) IBOutlet UITableView *tableviewlisting3;
- (IBAction)gridviewbutton:(id)sender;
- (IBAction)listviewbutton:(id)sender;
@property (strong,nonatomic) NSMutableArray *srchdata,*tempsrchdata;
@property (strong ,nonatomic) NSString *srchtext;
@property (strong, nonatomic) IBOutlet UILabel *searchtitle;
@property (strong, nonatomic)IBOutlet MKMapView *mymap;
@property (strong, nonatomic) IBOutlet UIView *mview;
- (IBAction)mapbuttonTap:(id)sender;
@property (strong,nonatomic) NSString *nextstartvalue;
@property (strong,nonatomic) NSString *location;
@property (strong,nonatomic) NSString *radius;
@property (strong,nonatomic) NSString *minprice;
@property (strong,nonatomic) NSString *maxprice;
@property (strong,nonatomic) NSString *minbed;
@property (strong,nonatomic) NSString *maxbed;
@property (strong,nonatomic) NSString *propertytype;
@property (strong,nonatomic) NSString *addedtime;
@property (strong,nonatomic) NSString *soldstatus;
@property (strong,nonatomic) NSString *buyorrent;
@property (strong,nonatomic) NSString *lativalue;
@property (strong,nonatomic) NSString *longvalue;
@property (weak, nonatomic) IBOutlet UILabel *lodinglabel;

@property (strong,nonatomic)NSString *resulttype;

@end
