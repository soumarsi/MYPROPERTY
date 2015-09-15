//
//  PropertyDetails2ViewController.m
//  MyProperty
//
//  Created by soumyajit on 03/07/15.
//  Copyright (c) 2015 kausik jati. All rights reserved.
//

#import "PropertyDetails2ViewController.h"
#import "UIImageView+WebCache.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "RS_PCH.pch"
#import "MPSendToFriendViewController.h"
#import "MPBookAgentViewController.h"

@interface PropertyDetails2ViewController ()<MKMapViewDelegate,UIScrollViewDelegate, UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *picarray;
    UIImageView *media;
    CGFloat lat;
    CGFloat longi;
    UILabel *title;
    UIView *imageDetailView;
    UIButton *imageCloseBtn;
    NSInteger arrcount;
    NSUserDefaults *userinfo;
    NSString *userid, *add_id;
    NSMutableDictionary *favdic;
    UIImage *imageToShare;
    UIView *detalisview;
    BOOL contnumber,isFullScreen;
    NSString *textToShare;
    UIImageView *img;
    UIScrollView *imgscroll,*bigimagescroll;
    NSString *advertise_id;
    NSMutableDictionary *bookingdic;
    CGRect prevFrame;
    UIView *imgView;
    UIPanGestureRecognizer *panRecognizer;
    NSArray *itemsToShare;
}
@property(nonatomic,strong)NSMutableDictionary *dicTab;
@property(nonatomic,strong)NSMutableDictionary *dicBtn;
@property(nonatomic,strong) UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UIScrollView *mainscroll;
@property (strong, nonatomic) IBOutlet UILabel *pricelbl;
@property (strong, nonatomic) IBOutlet UILabel *addrlbl;
@property (strong, nonatomic) IBOutlet UILabel *bedlbl;
@property (strong, nonatomic) IBOutlet UILabel *bathroomlbl;
@property (strong, nonatomic) IBOutlet UILabel *parkinglbl;
@property (strong, nonatomic) IBOutlet UILabel *sellrentlbl;
@property (strong, nonatomic) IBOutlet UILabel *facinglbl;
@property (strong, nonatomic) IBOutlet MKMapView *mapview;
@property (strong, nonatomic) IBOutlet UIScrollView *picturescroll;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) IBOutlet UIButton *favbtn;
@property(nonatomic)NSInteger prev;
@property(nonatomic,strong) NSMutableArray *arr1,*arr2,*arr3;
@property(nonatomic,strong) UIButton *headerButton;

@end

@implementation PropertyDetails2ViewController
@synthesize checkstring,data_dic;
@synthesize dicTab,dicBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    dicTab=[[NSMutableDictionary alloc]init];
    
    dicBtn=[[NSMutableDictionary alloc]init];
    
    
    _arr1=[[NSMutableArray alloc]init];
    
    
    _arr2=[[NSMutableArray alloc]init];
    
    
    _arr3=[[NSMutableArray alloc]init];
    
    
    isFullScreen=false;
    
    
    self.navigationController.navigationBar.hidden = YES;
    
    userinfo=[[NSUserDefaults alloc]init];
    userid = [userinfo objectForKey:@"id"];
    NSLog(@"userid is : %@",userid);
    
    obj = [[FW_JsonClass alloc]init];
    
    [_mainscroll setContentSize:CGSizeMake(self.view.frame.size.width, 798)];
    
    NSLog(@"height----%ld",(long)self.picturescroll.frame.origin.y);
    
    NSLog(@"datadic----%@",data_dic);
    NSLog(@"indexpath-----%ld",(long)_list3indexpath);
    
    _picturescroll.userInteractionEnabled = YES;
    
//    [_picturescroll setFrame:CGRectMake(0, 0, self.view.frame.size.width, 267)];
    
    if ([checkstring isEqualToString:@"listing3"])
    {
//        _favbtn.hidden = NO;
        add_id = [data_dic valueForKey:@"advert_id"];
        
        if ([[data_dic valueForKey:@"added_by_status"] isEqualToString:@"N"])
        {
            _favbtn.hidden = NO;
            if ([[data_dic valueForKey:@"saved_prop"] isEqualToString:@"Y"])
            {
                [_favbtn setImage:[UIImage imageNamed:@"5"] forState:UIControlStateNormal];
            }
            else
            {
                [_favbtn setImage:[UIImage imageNamed:@"add_to_fav"] forState:UIControlStateNormal];
            }
            _favbtn.tag = _list3indexpath;
            [_favbtn addTarget:self action:@selector(favAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            _favbtn.hidden = YES;
        }
        
        
        picarray = [[NSMutableArray alloc]init];
        picarray = [data_dic valueForKey:@"media"];
        
        
        
//        arrcount = [picarray count];
        
        _pageControl.numberOfPages = [picarray count];
        
        [_picturescroll setContentSize:CGSizeMake(self.view.frame.size.width * [picarray count], self.picturescroll.frame.size.height)];
        _picturescroll.pagingEnabled = YES;
        _picturescroll.delegate = self;
        
        
        int width = 0;
        int i;
        for (i = 0; i<[picarray count]; i++)
        {
            media = [[UIImageView alloc]initWithFrame:CGRectMake(width, 0, self.view.frame.size.width, self.picturescroll.frame.size.height)];
            UIButton *imageclearbtn = [[UIButton alloc]initWithFrame:CGRectMake(width, 0, self.view.frame.size.width, self.picturescroll.frame.size.height)];
            media.userInteractionEnabled = YES;
            imageclearbtn.tag = i;
            
            imageclearbtn.backgroundColor = [UIColor clearColor];
            imageclearbtn.userInteractionEnabled = YES;
            
            [media sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[picarray objectAtIndex:i]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            title = [[UILabel alloc]initWithFrame:CGRectMake(15, self.picturescroll.frame.size.height - 65, 200, 20)];
            title.text = [data_dic valueForKey:@"property_type"];
            title.textColor = [UIColor whiteColor];
            title.font = [UIFont fontWithName:@"Open Sans" size:15];
            width = width + self.view.frame.size.width;
            
            [imageclearbtn addTarget:self action:@selector(imageTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            
            [self.mainscroll addSubview:title];
            [self.picturescroll addSubview:media];
            [self.picturescroll addSubview:imageclearbtn];
            
        }
        
        if ((NSNull *)[data_dic valueForKey:@"latitude"] == [NSNull null])
        {
            NSLog(@"lati null");
        }
        else
        {
            lat = [[data_dic valueForKey:@"latitude"] floatValue];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"longitude"] == [NSNull null])
        {
            NSLog(@"longi null");
        }
        else
        {
            longi = [[data_dic valueForKey:@"longitude"] floatValue];
        }
        
        CLLocationCoordinate2D coord = {.latitude = lat, .longitude = longi};
        MKCoordinateSpan span = {.latitudeDelta =  0.02, .longitudeDelta =  0.02};
        MKCoordinateRegion region = {coord, span};
        [_mapview setRegion:region];
        
        MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
        annotationPoint.coordinate = coord;
        annotationPoint.title = [NSString stringWithFormat:@"%@",[data_dic valueForKey:@"property_type"]];
        annotationPoint.subtitle = [NSString stringWithFormat:@"%@",[data_dic valueForKey:@"address1"]];
        [_mapview addAnnotation:annotationPoint];
        
        
        if ((NSNull *)[data_dic valueForKey:@"property_price"] == [NSNull null])
        {
            NSLog(@"price null");
        }
        else
        {
            _pricelbl.text = [NSString stringWithFormat:@"£%@",[data_dic valueForKey:@"property_price"]];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"address1"] == [NSNull null])
        {
            NSLog(@"add null");
        }
        else
        {
            _addrlbl.text = [data_dic valueForKey:@"address1"];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"no_of_beds"] == [NSNull null])
        {
            NSLog(@"bed null");
        }
        else
        {
            _bedlbl.text = [data_dic valueForKey:@"no_of_beds"];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"no_of_baths"] == [NSNull null])
        {
            NSLog(@"no_of_baths null");
        }
        else
        {
            _bathroomlbl.text = [data_dic valueForKey:@"no_of_baths"];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"off_strt_parkng_flag"] == [NSNull null])
        {
            NSLog(@" null");
        }
        else
        {
            if ([[data_dic valueForKey:@"off_strt_parkng_flag"] isEqualToString:@"Y"])
            {
                _parkinglbl.text = @"1";
            }
            else if ([[data_dic valueForKey:@"off_strt_parkng_flag"] isEqualToString:@"N"])
            {
                _parkinglbl.text = @"0";
            }
        }
        
        
        //subhajit
        
        if ((NSNull *)[data_dic valueForKey:@"property_type"] == [NSNull null])
        {
            _propertytype.text=@"no data";
        }
        else
        {
            _propertytype.text=[data_dic valueForKey:@"property_type"];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"advert_added_for"] == [NSNull null])
        {
            _sellrentlbl.text=@"no data";
        }
        else
        {
            if ([[data_dic valueForKey:@"advert_added_for"] isEqualToString:@"S"])
            {
                _sellrentlbl.text=@"Sell";
            }
            else if ([[data_dic valueForKey:@"advert_added_for"] isEqualToString:@"R"])
            {
                _sellrentlbl.text=@"Rent";
            }
        }
        
        if ((NSNull *)[data_dic valueForKey:@"property_full_description"] == [NSNull null])
        {
            NSString *nodata=@"no Description found";
            [_arr1 addObject:nodata];
        }
        else
        {
            [_arr1 addObject:[data_dic valueForKey:@"property_full_description"]];

        }
        
        if ((NSNull *)[data_dic valueForKey:@"contact_number"] == [NSNull null])
        {
            NSString *nodata=@"no Description found";
            [_arr3 addObject:nodata];
            contnumber=false;
        }
        else
        {
            [_arr3 addObject:[data_dic valueForKey:@"contact_number"]];
            contnumber=true;
        }
        
        
        
        
        
    }
    else if ([checkstring isEqualToString:@"fav"])
    {
        _favbtn.hidden = YES;
        
        picarray = [[NSMutableArray alloc]init];
        picarray = [data_dic valueForKey:@"images"];
        
        _pageControl.numberOfPages = [picarray count];
        
        [_picturescroll setContentSize:CGSizeMake(self.view.frame.size.width * [picarray count], self.picturescroll.frame.size.height)];
        _picturescroll.pagingEnabled = YES;
        _picturescroll.delegate = self;
        
        
        int width = 0;
        int i;
        for (i = 0; i<[picarray count]; i++)
        {
            media = [[UIImageView alloc]initWithFrame:CGRectMake(width, 0, self.view.frame.size.width, self.picturescroll.frame.size.height)];
            UIButton *imageclearbtn = [[UIButton alloc]initWithFrame:CGRectMake(width, 0, self.view.frame.size.width, self.picturescroll.frame.size.height)];
            media.userInteractionEnabled = YES;
            imageclearbtn.tag = i;
            
            imageclearbtn.backgroundColor = [UIColor clearColor];
            imageclearbtn.userInteractionEnabled = YES;
            
            [media sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[picarray objectAtIndex:i]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
           title = [[UILabel alloc]initWithFrame:CGRectMake(15, self.picturescroll.frame.size.height - 65, 200, 20)];
            title.text = [data_dic valueForKey:@"property_type"];
            title.textColor = [UIColor whiteColor];
            title.font = [UIFont fontWithName:@"Open Sans" size:15];
            width = width + self.view.frame.size.width;
            
            [imageclearbtn addTarget:self action:@selector(imageTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            
            [self.mainscroll addSubview:title];
            [self.picturescroll addSubview:media];
            [self.picturescroll addSubview:imageclearbtn];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"latitude"] == [NSNull null])
        {
            NSLog(@"lati null");
        }
        else
        {
            lat = [[data_dic valueForKey:@"latitude"] floatValue];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"longitude"] == [NSNull null])
        {
            NSLog(@"longi null");
        }
        else
        {
            longi = [[data_dic valueForKey:@"longitude"] floatValue];
        }
        
        CLLocationCoordinate2D coord = {.latitude = lat, .longitude = longi};
        MKCoordinateSpan span = {.latitudeDelta =  0.1, .longitudeDelta =  0.1};
        MKCoordinateRegion region = {coord, span};
        [_mapview setRegion:region];
        
        MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
        annotationPoint.coordinate = coord;
        annotationPoint.title = [NSString stringWithFormat:@"%@",[data_dic valueForKey:@"property_type"]];
        annotationPoint.subtitle = [NSString stringWithFormat:@"%@",[data_dic valueForKey:@"address1"]];
        [_mapview addAnnotation:annotationPoint];
        
        
        if ((NSNull *)[data_dic valueForKey:@"property_price"] == [NSNull null])
        {
            NSLog(@"price null");
        }
        else
        {
            _pricelbl.text = [NSString stringWithFormat:@"£%@",[data_dic valueForKey:@"property_price"]];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"address1"] == [NSNull null])
        {
            NSLog(@"add null");
        }
        else
        {
            _addrlbl.text = [data_dic valueForKey:@"address1"];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"no_of_beds"] == [NSNull null])
        {
            NSLog(@"bed null");
        }
        else
        {
            _bedlbl.text = [data_dic valueForKey:@"no_of_beds"];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"no_of_baths"] == [NSNull null])
        {
            NSLog(@"no_of_baths null");
        }
        else
        {
            _bathroomlbl.text = [data_dic valueForKey:@"no_of_baths"];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"off_strt_parkng_flag"] == [NSNull null])
        {
            NSLog(@" null");
        }
        else
        {
            if ([[data_dic valueForKey:@"off_strt_parkng_flag"] isEqualToString:@"Y"])
            {
                _parkinglbl.text = @"1";
            }
            else if ([[data_dic valueForKey:@"off_strt_parkng_flag"] isEqualToString:@"N"])
            {
                _parkinglbl.text = @"0";
            }
        }
        
        
        //subhajit
        
        if ((NSNull *)[data_dic valueForKey:@"property_type"] == [NSNull null])
        {
            _propertytype.text=@"no data";
        }
        else
        {
            _propertytype.text=[data_dic valueForKey:@"property_type"];
        }
        
//        if ((NSNull *)[data_dic valueForKey:@"advert_added_for"] == [NSNull null])
//        {
//            _sellrentlbl.text=@"no data";
//        }
//        else
//        {
//            if ([[data_dic valueForKey:@"advert_added_for"] isEqualToString:@"S"])
//            {
//                _sellrentlbl.text=@"Sell";
//            }
//            else if ([[data_dic valueForKey:@"advert_added_for"] isEqualToString:@"R"])
//            {
//                _sellrentlbl.text=@"Rent";
//            }
//        }
        if ((NSNull *)[data_dic valueForKey:@"property_full_description"] == [NSNull null])
        {
            NSString *nodata=@"no Description found";
            [_arr1 addObject:nodata];
        }
        else
        {
            [_arr1 addObject:[data_dic valueForKey:@"property_full_description"]];
            
        }
        
//        if ((NSNull *)[data_dic valueForKey:@"contact_number"] == [NSNull null])
//        {
//            NSString *nodata=@"no Description found";
//            [_arr3 addObject:nodata];
//            contnumber=false;
//        }
//        else
//        {
//            [_arr3 addObject:[data_dic valueForKey:@"contact_number"]];
//            contnumber=true;
//        }
        
        
        
        
        
        
        
        
    }
    else if ([checkstring isEqualToString:@"myproperty"])
    {
        _favbtn.hidden = YES;
        
        picarray = [[NSMutableArray alloc]init];
        picarray = [data_dic valueForKey:@"media"];
        
        _pageControl.numberOfPages = [picarray count];
        
        [_picturescroll setContentSize:CGSizeMake(self.view.frame.size.width * [picarray count], self.picturescroll.frame.size.height)];
        _picturescroll.pagingEnabled = YES;
        _picturescroll.delegate = self;
        
        
        int width = 0;
        int i;
        for (i = 0; i<[picarray count]; i++)
        {
            media = [[UIImageView alloc]initWithFrame:CGRectMake(width, 0, self.view.frame.size.width, self.picturescroll.frame.size.height)];
            UIButton *imageclearbtn = [[UIButton alloc]initWithFrame:CGRectMake(width, 0, self.view.frame.size.width, self.picturescroll.frame.size.height)];
            media.userInteractionEnabled = YES;
            imageclearbtn.tag = i;
            
            imageclearbtn.backgroundColor = [UIColor clearColor];
            imageclearbtn.userInteractionEnabled = YES;
            
            [media sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[picarray objectAtIndex:i]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            title = [[UILabel alloc]initWithFrame:CGRectMake(15, self.picturescroll.frame.size.height - 65, 200, 20)];
            title.text = [data_dic valueForKey:@"property_type"];
            title.textColor = [UIColor whiteColor];
            title.font = [UIFont fontWithName:@"Open Sans" size:15];
            width = width + self.view.frame.size.width;
            
            [imageclearbtn addTarget:self action:@selector(imageTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            
            [self.mainscroll addSubview:title];
            [self.picturescroll addSubview:media];
            [self.picturescroll addSubview:imageclearbtn];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"latitude"] == [NSNull null])
        {
            NSLog(@"lati null");
        }
        else
        {
            lat = [[data_dic valueForKey:@"latitude"] floatValue];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"longitude"] == [NSNull null])
        {
            NSLog(@"longi null");
        }
        else
        {
            longi = [[data_dic valueForKey:@"longitude"] floatValue];
        }
        
        CLLocationCoordinate2D coord = {.latitude = lat, .longitude = longi};
        MKCoordinateSpan span = {.latitudeDelta =  0.1, .longitudeDelta =  0.1};
        MKCoordinateRegion region = {coord, span};
        [_mapview setRegion:region];
        
        MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
        annotationPoint.coordinate = coord;
        annotationPoint.title = [NSString stringWithFormat:@"%@",[data_dic valueForKey:@"property_type"]];
        annotationPoint.subtitle = [NSString stringWithFormat:@"%@",[data_dic valueForKey:@"address1"]];
        [_mapview addAnnotation:annotationPoint];
        
        
        if ((NSNull *)[data_dic valueForKey:@"property_price"] == [NSNull null])
        {
            NSLog(@"price null");
        }
        else
        {
            _pricelbl.text = [NSString stringWithFormat:@"%@",[data_dic valueForKey:@"status_val"]];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"address1"] == [NSNull null])
        {
            NSLog(@"add null");
        }
        else
        {
            _addrlbl.text = [data_dic valueForKey:@"address1"];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"no_of_beds"] == [NSNull null])
        {
            NSLog(@"bed null");
        }
        else
        {
            _bedlbl.text = [data_dic valueForKey:@"no_of_beds"];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"no_of_baths"] == [NSNull null])
        {
            NSLog(@"no_of_baths null");
        }
        else
        {
            _bathroomlbl.text = [data_dic valueForKey:@"no_of_baths"];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"off_strt_parkng_flag"] == [NSNull null])
        {
            NSLog(@" null");
        }
        else
        {
            if ([[data_dic valueForKey:@"off_strt_parkng_flag"] isEqualToString:@"Y"])
            {
                _parkinglbl.text = @"1";
            }
            else if ([[data_dic valueForKey:@"off_strt_parkng_flag"] isEqualToString:@"N"])
            {
                _parkinglbl.text = @"0";
            }
        }
        
        //subhajit
        
        
        if ((NSNull *)[data_dic valueForKey:@"property_type"] == [NSNull null])
        {
            _propertytype.text=@"no data";
        }
        else
        {
            _propertytype.text=[data_dic valueForKey:@"property_type"];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"added_for_rent"] == [NSNull null])
        {
            _sellrentlbl.text=@"no data";
        }
        else
        {
            if ([[data_dic valueForKey:@"added_for_rent"] isEqualToString:@"Y"] && [[data_dic valueForKey:@"added_for_sell"] isEqualToString:@"Y"])
            {
                _sellrentlbl.text=@"added for rent and sell";
            }
            else if ([[data_dic valueForKey:@"added_for_rent"] isEqualToString:@"N"]&&[[data_dic valueForKey:@"added_for_sell"] isEqualToString:@"N"])
            {
                _sellrentlbl.text=@"property not added for advertisement";
            }
            else if ([[data_dic valueForKey:@"added_for_rent"] isEqualToString:@"Y"]&&[[data_dic valueForKey:@"added_for_sell"] isEqualToString:@"N"])
            {
                _sellrentlbl.text=@"added for rent";
            }
            else if ([[data_dic valueForKey:@"added_for_rent"] isEqualToString:@"N"]&&[[data_dic valueForKey:@"added_for_sell"] isEqualToString:@"Y"])
            {
                _sellrentlbl.text=@"added for sell";
            }
            
        }
        
        if ((NSNull *)[data_dic valueForKey:@"property_full_description"] == [NSNull null])
        {
            NSString *nodata=@"no Description found";
            [_arr1 addObject:nodata];
        }
        else
        {
            [_arr1 addObject:[data_dic valueForKey:@"property_full_description"]];
            
        }
        
//        if ((NSNull *)[data_dic valueForKey:@"contact_number"] == [NSNull null])
//        {
//            NSString *nodata=@"no Description found";
//            [_arr3 addObject:nodata];
//            contnumber=false;
//        }
//        else
//        {
//            [_arr3 addObject:[data_dic valueForKey:@"contact_number"]];
//            contnumber=true;
//        }
        
        
        
        
        
    }
    else if ([checkstring isEqualToString:@"myadvertisement"])
    {
        _favbtn.hidden = YES;
        
        picarray = [[NSMutableArray alloc]init];
        picarray = [data_dic valueForKey:@"media"];
        
        _pageControl.numberOfPages = [picarray count];
        
        [_picturescroll setContentSize:CGSizeMake(self.view.frame.size.width * [picarray count], self.picturescroll.frame.size.height)];
        _picturescroll.pagingEnabled = YES;
        _picturescroll.delegate = self;
        
        
        int width = 0;
        int i;
        for (i = 0; i<[picarray count]; i++)
        {
            media = [[UIImageView alloc]initWithFrame:CGRectMake(width, 0, self.view.frame.size.width, self.picturescroll.frame.size.height)];
            UIButton *imageclearbtn = [[UIButton alloc]initWithFrame:CGRectMake(width, 0, self.view.frame.size.width, self.picturescroll.frame.size.height)];
            media.userInteractionEnabled = YES;
            imageclearbtn.tag = i;
            
            imageclearbtn.backgroundColor = [UIColor clearColor];
            imageclearbtn.userInteractionEnabled = YES;
            
            [media sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[picarray objectAtIndex:i]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            title = [[UILabel alloc]initWithFrame:CGRectMake(15, self.picturescroll.frame.size.height - 65, 200, 20)];
            title.text = [data_dic valueForKey:@"property_type"];
            title.textColor = [UIColor whiteColor];
            title.font = [UIFont fontWithName:@"Open Sans" size:15];
            width = width + self.view.frame.size.width;
            
            [imageclearbtn addTarget:self action:@selector(imageTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            
            [self.mainscroll addSubview:title];
            [self.picturescroll addSubview:media];
            [self.picturescroll addSubview:imageclearbtn];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"latitude"] == [NSNull null])
        {
            NSLog(@"lati null");
        }
        else
        {
            lat = [[data_dic valueForKey:@"latitude"] floatValue];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"longitude"] == [NSNull null])
        {
            NSLog(@"longi null");
        }
        else
        {
            longi = [[data_dic valueForKey:@"longitude"] floatValue];
        }
        
        CLLocationCoordinate2D coord = {.latitude = lat, .longitude = longi};
        MKCoordinateSpan span = {.latitudeDelta =  0.1, .longitudeDelta =  0.1};
        MKCoordinateRegion region = {coord, span};
        [_mapview setRegion:region];
        
        MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
        annotationPoint.coordinate = coord;
        annotationPoint.title = [NSString stringWithFormat:@"%@",[data_dic valueForKey:@"property_type"]];
        annotationPoint.subtitle = [NSString stringWithFormat:@"%@",[data_dic valueForKey:@"address1"]];
        [_mapview addAnnotation:annotationPoint];
        
        
        if ((NSNull *)[data_dic valueForKey:@"property_price"] == [NSNull null])
        {
            NSLog(@"price null");
        }
        else
        {
            _pricelbl.text = [NSString stringWithFormat:@"£%@",[data_dic valueForKey:@"property_price"]];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"address1"] == [NSNull null])
        {
            NSLog(@"add null");
        }
        else
        {
            _addrlbl.text = [data_dic valueForKey:@"address1"];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"no_of_beds"] == [NSNull null])
        {
            NSLog(@"bed null");
        }
        else
        {
            _bedlbl.text = [data_dic valueForKey:@"no_of_beds"];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"no_of_baths"] == [NSNull null])
        {
            NSLog(@"no_of_baths null");
        }
        else
        {
            _bathroomlbl.text = [data_dic valueForKey:@"no_of_baths"];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"no_of_rooms"] == [NSNull null])
        {
            NSLog(@"room null");
        }
        else
        {
            _parkinglbl.text = [data_dic valueForKey:@"no_of_rooms"];
        }
        
        //subhajit
        
        if ((NSNull *)[data_dic valueForKey:@"property_type"] == [NSNull null])
        {
            _propertytype.text=@"no data";
        }
        else
        {
            _propertytype.text=[data_dic valueForKey:@"property_type"];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"advert_added_for"] == [NSNull null])
        {
            _sellrentlbl.text=@"no data";
        }
        else
        {
            if ([[data_dic valueForKey:@"advert_added_for"] isEqualToString:@"S"])
            {
                _sellrentlbl.text=@"Sell";
            }
            else if ([[data_dic valueForKey:@"advert_added_for"] isEqualToString:@"R"])
            {
                _sellrentlbl.text=@"Rent";
            }
        }
        
        if ((NSNull *)[data_dic valueForKey:@"property_full_description"] == [NSNull null])
        {
            NSString *nodata=@"no Description found";
            [_arr1 addObject:nodata];
        }
        else
        {
            [_arr1 addObject:[data_dic valueForKey:@"property_full_description"]];
            
        }
        
//        if ((NSNull *)[data_dic valueForKey:@"contact_number"] == [NSNull null])
//        {
//            NSString *nodata=@"no Description found";
//            [_arr3 addObject:nodata];
//            contnumber=false;
//        }
//        else
//        {
//            [_arr3 addObject:[data_dic valueForKey:@"contact_number"]];
//            contnumber=true;
//        }

        
        
        
        
    }
    else if ([checkstring isEqualToString:@"appoint"])
    {
        _favbtn.hidden = YES;
        
        picarray = [[NSMutableArray alloc]init];
        picarray = [data_dic valueForKey:@"media"];
        
        _pageControl.numberOfPages = [picarray count];
        
        [_picturescroll setContentSize:CGSizeMake(self.view.frame.size.width * [picarray count], self.picturescroll.frame.size.height)];
        _picturescroll.pagingEnabled = YES;
        _picturescroll.delegate = self;
        
        
        int width = 0;
        int i;
        for (i = 0; i<[picarray count]; i++)
        {
            media = [[UIImageView alloc]initWithFrame:CGRectMake(width, 0, self.view.frame.size.width, self.picturescroll.frame.size.height)];
            UIButton *imageclearbtn = [[UIButton alloc]initWithFrame:CGRectMake(width, 0, self.view.frame.size.width, self.picturescroll.frame.size.height)];
            media.userInteractionEnabled = YES;
            imageclearbtn.tag = i;
            
            imageclearbtn.backgroundColor = [UIColor clearColor];
            imageclearbtn.userInteractionEnabled = YES;
            
            [media sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[picarray objectAtIndex:i]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            title = [[UILabel alloc]initWithFrame:CGRectMake(15, self.picturescroll.frame.size.height - 50, 200, 20)];
            title.text = [data_dic valueForKey:@"property_type"];
            title.textColor = [UIColor whiteColor];
            title.font = [UIFont fontWithName:@"Open Sans" size:15];
            width = width + self.view.frame.size.width;
            
            [imageclearbtn addTarget:self action:@selector(imageTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            
            [self.mainscroll addSubview:title];
            [self.picturescroll addSubview:media];
            [self.picturescroll addSubview:imageclearbtn];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"latitude"] == [NSNull null])
        {
            NSLog(@"lati null");
        }
        else
        {
            lat = [[data_dic valueForKey:@"latitude"] floatValue];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"longitude"] == [NSNull null])
        {
            NSLog(@"longi null");
        }
        else
        {
            longi = [[data_dic valueForKey:@"longitude"] floatValue];
        }
        
        CLLocationCoordinate2D coord = {.latitude = lat, .longitude = longi};
        MKCoordinateSpan span = {.latitudeDelta =  0.1, .longitudeDelta =  0.1};
        MKCoordinateRegion region = {coord, span};
        [_mapview setRegion:region];
        
        MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
        annotationPoint.coordinate = coord;
        annotationPoint.title = [NSString stringWithFormat:@"%@",[data_dic valueForKey:@"property_type"]];
        annotationPoint.subtitle = [NSString stringWithFormat:@"%@",[data_dic valueForKey:@"address1"]];
        [_mapview addAnnotation:annotationPoint];
        
        
        if ((NSNull *)[data_dic valueForKey:@"property_price"] == [NSNull null])
        {
            NSLog(@"price null");
        }
        else
        {
            _pricelbl.text = [NSString stringWithFormat:@"£%@",[data_dic valueForKey:@"advert_price"]];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"address1"] == [NSNull null])
        {
            NSLog(@"add null");
        }
        else
        {
            _addrlbl.text = [data_dic valueForKey:@"address1"];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"no_of_beds"] == [NSNull null])
        {
            NSLog(@"bed null");
        }
        else
        {
            _bedlbl.text = [data_dic valueForKey:@"no_of_beds"];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"no_of_baths"] == [NSNull null])
        {
            NSLog(@"no_of_baths null");
        }
        else
        {
            _bathroomlbl.text = [data_dic valueForKey:@"no_of_baths"];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"no_of_rooms"] == [NSNull null])
        {
            NSLog(@"room null");
        }
        else
        {
            _parkinglbl.text = [data_dic valueForKey:@"no_of_rooms"];
        }
    }
    else if ([checkstring isEqualToString:@"offer"])
    {
        _favbtn.hidden = YES;
        
        picarray = [[NSMutableArray alloc]init];
        picarray = [data_dic valueForKey:@"media"];
        
        _pageControl.numberOfPages = [picarray count];
        
        [_picturescroll setContentSize:CGSizeMake(self.view.frame.size.width * [picarray count], self.picturescroll.frame.size.height)];
        _picturescroll.pagingEnabled = YES;
        _picturescroll.delegate = self;
        
        
        int width = 0;
        int i;
        for (i = 0; i<[picarray count]; i++)
        {
            media = [[UIImageView alloc]initWithFrame:CGRectMake(width, 0, self.view.frame.size.width, self.picturescroll.frame.size.height)];
            UIButton *imageclearbtn = [[UIButton alloc]initWithFrame:CGRectMake(width, 0, self.view.frame.size.width, self.picturescroll.frame.size.height)];
            media.userInteractionEnabled = YES;
            imageclearbtn.tag = i;
            
            imageclearbtn.backgroundColor = [UIColor clearColor];
            imageclearbtn.userInteractionEnabled = YES;
            
            [media sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[picarray objectAtIndex:i]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            title = [[UILabel alloc]initWithFrame:CGRectMake(15, self.picturescroll.frame.size.height - 50, 200, 20)];
            title.text = [data_dic valueForKey:@"property_type"];
            title.textColor = [UIColor whiteColor];
            title.font = [UIFont fontWithName:@"Open Sans" size:15];
            width = width + self.view.frame.size.width;
            
            [imageclearbtn addTarget:self action:@selector(imageTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            
            [self.mainscroll addSubview:title];
            [self.picturescroll addSubview:media];
            [self.picturescroll addSubview:imageclearbtn];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"latitude"] == [NSNull null])
        {
            NSLog(@"lati null");
        }
        else
        {
            lat = [[data_dic valueForKey:@"latitude"] floatValue];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"longitude"] == [NSNull null])
        {
            NSLog(@"longi null");
        }
        else
        {
            longi = [[data_dic valueForKey:@"longitude"] floatValue];
        }
        
        CLLocationCoordinate2D coord = {.latitude = lat, .longitude = longi};
        MKCoordinateSpan span = {.latitudeDelta =  0.1, .longitudeDelta =  0.1};
        MKCoordinateRegion region = {coord, span};
        [_mapview setRegion:region];
        
        MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
        annotationPoint.coordinate = coord;
        annotationPoint.title = [NSString stringWithFormat:@"%@",[data_dic valueForKey:@"property_type"]];
        annotationPoint.subtitle = [NSString stringWithFormat:@"%@",[data_dic valueForKey:@"address1"]];
        [_mapview addAnnotation:annotationPoint];
        
        
        if ((NSNull *)[data_dic valueForKey:@"property_price"] == [NSNull null])
        {
            NSLog(@"price null");
        }
        else
        {
            _pricelbl.text = [NSString stringWithFormat:@"£%@",[data_dic valueForKey:@"offer_price"]];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"address1"] == [NSNull null])
        {
            NSLog(@"add null");
        }
        else
        {
            _addrlbl.text = [data_dic valueForKey:@"address1"];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"no_of_beds"] == [NSNull null])
        {
            NSLog(@"bed null");
        }
        else
        {
            _bedlbl.text = [data_dic valueForKey:@"no_of_beds"];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"no_of_baths"] == [NSNull null])
        {
            NSLog(@"no_of_baths null");
        }
        else
        {
            _bathroomlbl.text = [data_dic valueForKey:@"no_of_baths"];
        }
        
        if ((NSNull *)[data_dic valueForKey:@"no_of_rooms"] == [NSNull null])
        {
            NSLog(@"room null");
        }
        else
        {
            _parkinglbl.text = [data_dic valueForKey:@"no_of_rooms"];
        }
    }
}

-(void)favAction:(UIButton *)sender
{
    NSLog(@"sender.tag-----%ld",(long)sender.tag);
    
    NSString *addToFav = [NSString stringWithFormat:@"%@json_output.php?mode=save_property_wishlist&user_id=%@&advert_id=%@",App_Domain_Url,userid,add_id];
    
    [obj GlobalDict:addToFav Globalstr:@"array" Withblock:^(id result, NSError *error) {
        favdic = [result mutableCopy];
        
        if ([[favdic valueForKey:@"message"] isEqualToString:@"property saved"])
        {
            _favbtn.selected = YES;
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Property Saved." message: @"Added to favourites" delegate: self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
            
            [alert show];
        }
        else if ([[favdic valueForKey:@"message"] isEqualToString:@"You have already saved this property"])
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Property already saved." message: @"Already Added to favourites" delegate: self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
            
            [alert show];
        }
    }];

}

-(void)imageTapped:(UIButton *)sender
{
    NSLog(@"gesture sender: %ld",(long)sender.tag);
    
    NSInteger tagId = sender.tag;
    
    imageDetailView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    imageDetailView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.9];
    
    imageCloseBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 100, 0, 100, 100)];
    imageCloseBtn.backgroundColor = [UIColor clearColor];
    [imageCloseBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [imageCloseBtn addTarget:self action:@selector(closeTapped) forControlEvents:UIControlEventTouchUpInside];
    
    imgscroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height * .2, self.view.frame.size.width, self.view.frame.size.height * .6)];
    [imgscroll setContentSize:CGSizeMake(self.view.frame.size.width * [picarray count], imgscroll.frame.size.height)];
    imgscroll.showsHorizontalScrollIndicator = NO;
    imgscroll.pagingEnabled = YES;
    [imgscroll setContentOffset:CGPointMake(tagId * self.view.frame.size.width, 0) animated:NO];
    
    int i;
    float x = 5;
    for (i = 0; i<[picarray count]; i++)
    {
        img = [[UIImageView alloc]initWithFrame:CGRectMake(x, 0, imgscroll.frame.size.width - 10, imgscroll.frame.size.height)];
        img.contentMode = UIViewContentModeScaleAspectFit;
        
        [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[picarray objectAtIndex:i]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        x = x + self.view.frame.size.width;
    
//        img.userInteractionEnabled=YES;
//        
//        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] init];
//        tap.numberOfTapsRequired=2;
//        
//        tap.delegate=self;
//        
//        [tap addTarget:self action:@selector(tapWithGesturewithSender:)];
//        
//        
//        
//        [img addGestureRecognizer:tap];

        
        [imgscroll addSubview:img];
        
    }

    
    [imageDetailView addSubview:imageCloseBtn];
    [imageDetailView addSubview:imgscroll];
    [self.view addSubview:imageDetailView];
    
    UISwipeGestureRecognizer *ges =[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    ges.direction=UISwipeGestureRecognizerDirectionUp;
    ges.delegate=self;
    [imageDetailView  addGestureRecognizer:ges];

    
}




-(void)tapWithGesturewithSender:(UITapGestureRecognizer*)sender
{

    
   imgView=sender.view;
    
    NSLog(@"Imageview frame.height %f",imgView.frame.size.height);
    
    
//   //
//    
//    
//    UIView *blackView=[[UIView alloc]initWithFrame:self.view.frame];
//    
//    [self.view addSubview:blackView];
//    
//    UIScrollView *blackScroll=[[UIScrollView alloc]init];
//    
//    [blackView addSubview:blackScroll];
//    
//    imgView.frame=CGRectMake(imgView.frame.origin.x-200, imgView.frame.origin.y
//                             , 800, imgView.frame.size.height);
//    
//    blackScroll.frame=CGRectMake(imgView.frame.origin.x, imgView.frame.origin.y, self.view.bounds.size.width-(imgView.frame.origin.x), imgView.frame.size.height);
//    
//    [blackScroll addSubview:imgView];
//    
//    blackScroll.contentSize=imgView.frame.size;
//    
//    
//    
//    
//    
//    
//    
//    //
    
    
    
    
    
    
    
    
    if (!isFullScreen)
    {
        [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
            //save previous frame
            prevFrame = imgView.frame;
            [imgView setFrame:CGRectMake(imgView.frame.origin.x-200, imgView.frame.origin.y
                                         , 800, imgView.frame.size.height)];
            [imgscroll setScrollEnabled:NO];
        }completion:^(BOOL finished){
            isFullScreen = TRUE;
            
             NSLog(@"tranformorigin %f",imgView.frame.origin.x);
            
            
            
//            bigimagescroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height * .2, self.view.frame.size.width, self.view.frame.size.height * .6)];
//            [bigimagescroll setContentSize:CGSizeMake(imgView.frame.size.width, 0)];
//            bigimagescroll.showsHorizontalScrollIndicator = NO;
//            bigimagescroll.showsVerticalScrollIndicator=NO;
//            [imageDetailView addSubview:bigimagescroll];
//            [bigimagescroll addSubview:imgView];
            
            
           panRecognizer = [[UIPanGestureRecognizer alloc] init];
            [panRecognizer addTarget:self action:@selector(handlePan:)];
            [panRecognizer setMinimumNumberOfTouches:1];
            [panRecognizer setMaximumNumberOfTouches:1];
            [panRecognizer setDelegate:self];
            [imgView addGestureRecognizer:panRecognizer];
            
            
            
        }];
        return;
        
    }
    else{
        [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
            [imgView removeGestureRecognizer:panRecognizer];
            [imgView setFrame:prevFrame];
            [imgscroll setScrollEnabled:YES];
        }completion:^(BOOL finished){
            isFullScreen = FALSE;
        }];
        return;
    }
    
    
    
 


}


-(void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    

    NSLog(@"origin %f",imgView.frame.origin.x);
    
    
  if(isFullScreen == TRUE)
  {
      NSLog(@"work");
      CGPoint translation = [recognizer translationInView:imgView];
      //recognizer.view.center.x + translation.x>50 && recognizer.view.center.x + translation.x<345
     
      //if (recognizer.view.center.x + translation.x>50 && recognizer.view.center.x + translation.x<345)
      //{
          recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,imgView.frame.size.height-200);
          NSLog(@"point %f",recognizer.view.center.x + translation.x);
          [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
      //}
      
      
      
      
//      if([recognizer velocityInView:imgView].x>0)
//          {
//          
//              NSLog(@"Right pan...");
//              
//              if(imgView.frame.origin.x>0)
//              {
//                  CGRect frame=imgView.frame;
//                  
//                  frame.origin.x=0;
//              
//                  imgView.frame=frame;
//              
//              }
//          
//          
//          }
//      
//      else
//      {
//         NSLog(@"Left pan...");
//          
//          
//          if(imgView.frame.origin.x<0)
//          {
//          
//              if(imgView.frame.origin.x<-400)
//              {
//              
//                  CGRect frame=imgView.frame;
//                  
//                  frame.origin.x=-400;
//                  
//                  imgView.frame=frame;
//
//                 
//              
//              }
//          
//          }
//      
//      }
      
      
//      if (recognizer.state == UIGestureRecognizerStateEnded) {
//          
//          
//          CGPoint velocity = [recognizer velocityInView:imgView];
//          CGFloat magnitude = sqrtf((velocity.x * velocity.x) + imgView.frame.size.height-200);
//          CGFloat slideMult = magnitude / 200;
//          NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult);
//          
//          float slideFactor = 0.1 * slideMult; // Increase for more of a slide
//          CGPoint finalPoint = CGPointMake(recognizer.view.center.x + (velocity.x * slideFactor),
//                                           recognizer.view.center.y + imgView.frame.size.height-200);
//          
//          
//          
//          finalPoint.x = MIN(MAX(finalPoint.x, 0), self.view.bounds.size.width);
//          finalPoint.y = MIN(MAX(finalPoint.y, 0), imgView.frame.size.height-200);
//          
//          [UIView animateWithDuration:slideFactor*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//              recognizer.view.center = finalPoint;
//          } completion:nil];
//      
//      }
  }
    
    
}



-(void)swipe:(UISwipeGestureRecognizer *)swipeGes{
    NSLog(@"swipe");
    if(swipeGes.direction == UISwipeGestureRecognizerDirectionUp){
        [UIView animateWithDuration:.5 animations:^{
            // Fade the label
            
            [imageCloseBtn removeFromSuperview];
            imgscroll.frame=CGRectMake(0, 0, self.view.frame.size.width, 0);
            //img.frame=CGRectMake(0, 0, 320, 0);
            imageDetailView.frame =CGRectMake(0, 0, self.view.frame.size.width, 0);
            
        }
                         completion:^(BOOL finished) {
                             
                             [imageDetailView removeFromSuperview];
                             
                         }
         ];
        
    }
    
}


-(void)closeTapped
{
    [imageDetailView removeFromSuperview];
}


-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)loadVisiblePages
{
    CGFloat pageWidth = self.view.frame.size.width;
    NSInteger page = (NSInteger)floor((self.picturescroll.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    self.pageControl.currentPage = page;
//    NSInteger firstPage = page - 1;
//    NSInteger lastPage = page + 1;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Load the pages that are now on screen
    [self loadVisiblePages];
}

- (void)zoomIn: (id)sender
{
    MKUserLocation *userLocation = _mapview.userLocation;
    MKCoordinateRegion region =
    MKCoordinateRegionMakeWithDistance (
                                        userLocation.location.coordinate, 50, 50);
    [_mapview setRegion:region animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self setMapview:Nil];
    _mapview.delegate = Nil;
}

- (IBAction)backTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//- (IBAction)mapType:(id)sender
//{
//    if (_mapview.mapType == MKMapTypeStandard)
//        _mapview.mapType = MKMapTypeSatellite;
//    else
//        _mapview.mapType = MKMapTypeStandard;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sharebutton:(id)sender
{
    if ([checkstring isEqualToString:@"appoint"])
    {
        textToShare=[data_dic valueForKey:@"address1"];
    }
    else
    {
        textToShare = [data_dic valueForKey:@"property_type"];
    }
    
    dispatch_async(dispatch_get_global_queue(2, 0), ^{
        NSURL *imageurl=[NSURL URLWithString:[NSString stringWithFormat:@"%@",[picarray objectAtIndex:0]]];
        NSData *imageToSharedata=[NSData dataWithContentsOfURL:imageurl];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
           
            imageToShare=[UIImage imageWithData:imageToSharedata];
            //UIImage *imageToShare = media.image;
            NSLog(@"image %@",imageToShare);
            if (imageToShare==NULL)
            {
                 itemsToShare = @[textToShare];
            }
            else
            {
                 itemsToShare = @[textToShare,imageToShare];
            }
           
            UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
            activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList]; //or whichever you don't need
            //[self presentViewController:activityVC animated:YES completion:nil];
            
            [self.parentViewController presentViewController:activityVC animated:YES completion:nil];
            
            //[self.navigationController presentViewController:activityVC animated:YES completion:nil];
            
            
        });
        
    });
    
    
   
    
    

}

- (IBAction)arrangeviewing:(id)sender
{
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    
    
    NSInteger week = [components month];
    NSInteger year = [components year];
    
    NSString *finalyear = [NSString stringWithFormat:@"%ld",(long)year];
    NSString *finalmonth=[NSString stringWithFormat:@"%ld",(long)week];
    
    
    
    if ([checkstring isEqualToString:@"fav"])
    {
        advertise_id = [data_dic valueForKey:@"advertisement_id"];
    }
    else
    {
        advertise_id = [data_dic valueForKey:@"advert_id"];
    }
    NSString *url =[NSString stringWithFormat:@"%@json_output.php?mode=show_available_appointment_timing&advert_id=%@&year=%@&month=%@", App_Domain_Url, advertise_id, finalyear, finalmonth];
    
    [obj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
        bookingdic = [result mutableCopy];
        
        
        MPBookAgentViewController *book = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"bookagent"];
        book.bookingDetailsDic = [bookingdic mutableCopy];
        book.address = [data_dic valueForKey:@"address1"];
        
        [self.navigationController pushViewController:book animated:YES];
    }];
    
    
    
}
- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation
{
    static NSString *annotationViewReuseIdentifier = @"annotationViewReuseIdentifier";
    
    MKAnnotationView *annotationView = (MKAnnotationView *)[_mapview dequeueReusableAnnotationViewWithIdentifier:annotationViewReuseIdentifier];
    
    if (annotationView == nil)
    {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewReuseIdentifier];
    }
    
    // here you can assign your friend's image
    annotationView.image = [UIImage imageNamed:@"locator"];
    annotationView.annotation = annotation;
    
    // add below line of code to enable selection on annotation view
    annotationView.canShowCallout = YES;
    
    return annotationView;
}


- (void)applyMapViewMemoryHotFix{
    
    switch (_mapview.mapType) {
        case MKMapTypeHybrid:
        {
            _mapview.mapType = MKMapTypeStandard;
            
            
            
        }
            
            break;
        case MKMapTypeStandard:
        {
            _mapview.mapType = MKMapTypeHybrid;
            
        }
            
            break;
        default:
            break;
    }
    
    
    _mapview.mapType = MKMapTypeStandard;
    
    
    
}
-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    
    [self applyMapViewMemoryHotFix];
    // mymap = [[MKMapView alloc]init];
    NSLog(@"new function");
    //  NSLog(@"Retain count is  From delegate %ld", CFGetRetainCount((__bridge CFTypeRef)mymap));
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)sendtofriend:(id)sender
{
    NSLog(@"send to friend");
    NSString *chakedatastring=@"i am from detalispage";
    MPSendToFriendViewController *send = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"sendtofriend"];
    [send.data_dic removeAllObjects];
    //send.idstring = idjoinedstring;
    send.chakdata=chakedatastring;
    send.finalchackdata=checkstring;
    send.data_dic = [data_dic mutableCopy];
    [self.navigationController pushViewController:send animated:YES];
}

- (IBAction)requestmoredetalis:(id)sender
{
    detalisview = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
    detalisview.backgroundColor=[UIColor whiteColor];
    detalisview.alpha=1;
    [self.view addSubview:detalisview];
    
    
    detalisview.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.002, 0.002);
    
    
    
    [UIView animateWithDuration:0.8/1.5 animations:^{
        detalisview.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            detalisview.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                detalisview.transform = CGAffineTransformIdentity;
                [self createTable];
            }];
        }];
    }];
    
}
-(void)createTable
{
    
//    UIImageView *back=[[UIImageView alloc]initWithFrame:_myTableView.bounds];
//    back.image=[UIImage imageNamed:@"Solid_black"];
//    [self.view addSubview:back];
    
    UIImage *topimage = [UIImage imageNamed: @"topbar-1-1"];
    
    UIImageView *topview=[[UIImageView alloc] init];
    [topview setFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    [topview setImage:topimage];
    
    
    
    
    
    
    
    imageCloseBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, -10, 100, 100)];
    imageCloseBtn.backgroundColor = [UIColor clearColor];
    [imageCloseBtn setImage:[UIImage imageNamed:@"back-arrow"] forState:UIControlStateNormal];
    [imageCloseBtn addTarget:self action:@selector(closedetailsview) forControlEvents:UIControlEventTouchUpInside];
    
    [imageCloseBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 10, 10)];
    [imageCloseBtn setContentMode:UIViewContentModeCenter];
    
    
    
    _myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 61, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    
    
   // _myTableView=[[UITableView alloc]initWithFrame:CGRectMake(30, 61, self.view.bounds.size.width-60, self.view.bounds.size.height-60) style:UITableViewStylePlain];
     
    
    _myTableView.delegate=self;
    //_myTableView.backgroundView=back;
    //back.layer.opacity=0.5;
    _myTableView.backgroundColor=[UIColor clearColor];
    _myTableView.dataSource=self;
    
    
    _myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [detalisview addSubview:topview];
    [detalisview addSubview:imageCloseBtn];
    [self.view addSubview:_myTableView];
    
    _myTableView.showsVerticalScrollIndicator=NO;

    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    
    return 3;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    
    if(section==0)
    {
        
        
        if([dicTab valueForKey:@"0"])
            return _arr1.count;
        else
            return 0;
        
        
    }
    
    
    
    
    if(section==1)
    {
        
        
        if([dicTab valueForKey:@"1"])
            return _arr2.count;
        else
            return 3;
        
        
    }
    
    
    
    
    if(section==2)
    {
        
        
        if([dicTab valueForKey:@"2"])
            return _arr3.count;
        else
            return 0;
        
        
    }
    
    return 0;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 40;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _myTableView.frame.size.width, 40)];
    headerView.backgroundColor=[UIColor clearColor];
    UIImageView *sectionimg = [[UIImageView alloc]initWithFrame:CGRectMake (0, 0,[UIScreen mainScreen].bounds.size.width, 39)];
    sectionimg.image = [UIImage imageNamed:@"rowlbl"];
    headerView.tag=section;
    UILabel *headLbl=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 120, 40)];
    headLbl.textColor=[UIColor colorWithRed:36.0f/255.0f green:36.0f/255.0f blue:36.0f/255.0f alpha:1];
    headLbl.font=[UIFont fontWithName:@"Open Sans" size:14.0f];
    
    //UILabel *blacklabel=[[UILabel alloc]initWithFrame:CGRectMake(0, headerView.frame.size.height-5, _myTableView.frame.size.width, 2)];
   // blacklabel.backgroundColor=[UIColor blackColor];
    
    //    headLbl.text=[NSString stringWithFormat:@"Section %ld",(long)section];
    
    if (section == 0)
    {
        headLbl.text = @"DESCRIPTION";
    }
    else if(section == 1)
    {
        headLbl.text = @"FLOORPLANS";
    }
    else if(section == 2)
    {
        headLbl.text = @"CONTACT SELLER";
    }
    
    
    UIImageView *plusimg = [[UIImageView alloc]initWithFrame:CGRectMake(headerView.bounds.size.width-35, (headerView.bounds.size.height-20)/2, 20, 20)];
   
    
    plusimg.image = [UIImage imageNamed:@"plus_grey"];
    
    
   UIButton *headerTapped = [[UIButton alloc]initWithFrame:CGRectMake(headerView.bounds.size.width-110, 0, 50, 39)];
    headerTapped.backgroundColor = [UIColor clearColor];
    [headerTapped addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    _headerButton=[[UIButton alloc]initWithFrame:CGRectMake(headerView.bounds.size.width-60, 0, 60, 39)];
    _headerButton.backgroundColor = [UIColor clearColor];
    _headerButton.tag=section;
    NSString *key=[NSString stringWithFormat:@"%ld",(long)section];
    if([dicBtn valueForKey:key])
    {
        plusimg.image = [UIImage imageNamed:@"minus_grey"];
    }
    else
    {
        plusimg.image = [UIImage imageNamed:@"plus_grey"];
        
    }
    
    
    
    
    [_headerButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [headerView addSubview:sectionimg];
    [headerView addSubview:plusimg];
    [headerView addSubview:_headerButton];
    [headerView addSubview:headerTapped];
    [headerView addSubview:headLbl];
    //[headerView addSubview:blacklabel];
    
    // NSLog(@"Button for section %ld is created",(long)section);
    
    return headerView;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    if(section==0 )
        return @"PROPERTY DESCRIPTION";
    
    
    if(section==1 )
        return @"PROPERTY FLOORPLANS";
    
    
    if(section==2 )
        return @"Contact Seller";
    
    else return 0;
    
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *cellIden=[NSString stringWithFormat:@"Cell for section %ld",(long)indexPath.section];
    
    
    
    
    UITableViewCell *myCell=[tableView dequeueReusableCellWithIdentifier:cellIden];
    
    //    if (indexPath.row % 2)
    //    {
    //        myCell.backgroundColor=[UIColor grayColor];
    //    }
    //
    
    
    
    if(myCell==nil)
        
    {
        myCell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
        //
        //        if (indexPath.row % 2) {
        //            myCell.backgroundColor=[UIColor blueColor];
        //        }
        //
        
    }
    
    
    
   // NSLog(@"%f",myCell.frame.size.width);
    
    
    
    if(indexPath.section==0)
    {
        NSLog(@"cell created");
        UITextView *description=[[UITextView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 100)];
        description.text=_arr1[indexPath.row];
        [myCell addSubview:description];
        //myCell.textLabel.text=_arr1[indexPath.row];
    }
    
    if(indexPath.section==1)
    {
        //myCell.textLabel.text=_arr2[indexPath.row];
        if (indexPath.row==0) {
            myCell.textLabel.text=@"Floor Plan Certificate";
        }
        if (indexPath.row==1)
        {
            myCell.textLabel.text=@"EPC Certificate";
        }
        if (indexPath.row==2) {
            myCell.textLabel.text=@"GAS Certificate";
            
        }
    }
    
        
    
    if(indexPath.section==2)
    {
        myCell.textLabel.text=_arr3[indexPath.row];
        
    }
    [myCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return myCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==2 && indexPath.row==0)
    {
        NSLog(@"working");
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[data_dic valueForKey:@"contact_number"]]];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[data_dic valueForKey:@"contact_number"]]]];
        
        
    }
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     if(indexPath.section==0)
     {
         return 100;
     }
    return 50;
}

-(void)buttonTapped:(id)sender
{
    
    
    UIButton *tapped_button=(UIButton *)(id)sender;
    
    UIView *supView=[tapped_button superview];
    
    NSLog(@"Superview tag is: %ld and prev value is: %ld",(long)supView.tag,(long)_prev);
    
    NSString *key=[NSString stringWithFormat:@"%ld",(long)supView.tag];
    
    
    NSInteger section=supView.tag;
    
    
    
    if(![dicBtn valueForKey:key])
    {
        
        _prev=supView.tag;
        
        NSString *key=[NSString stringWithFormat:@"%ld",(long)supView.tag];
        
        [dicTab setObject:@"YES" forKey:key];
        
        [dicBtn setObject:@"YES" forKey:key];
        
        [_myTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    
    else
    {
        NSLog(@"Entering second condition...");
        
        
        NSString *key=[NSString stringWithFormat:@"%ld",(long)supView.tag];
        
        
        [dicTab removeObjectForKey:key];
        
        [dicBtn removeObjectForKey:key];
        
        [_myTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    
    
    
}



-(void)closedetailsview
{
    [detalisview removeFromSuperview];
    [_myTableView removeFromSuperview];
}

@end
