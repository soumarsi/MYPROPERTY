//
//  MPBookAgentViewController.m
//  MYPROPERTY
//
//  Created by Somenath on 21/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "MPBookAgentViewController.h"
#import "CKCalendarView.h"
#import "MPDashBoardViewController.h"
#import "MPAppointmentViewController.h"

@interface MPBookAgentViewController ()<CKCalendarDelegate>
{
    NSString *chosenDates22,*chosenDates33,*chosenDates44;
    NSMutableArray *datearry,*dateuse, *timmingarr;
    NSDictionary *dic,*dic1;
    NSDate *currentdate;
    NSMutableDictionary *holedata, *tempdata, *bookdic,*nextmonthdata,*nextholedata;
    BOOL calcheck,nextcalapp;
    CKCalendarView *calendarview;
    UIView *calenderBackView,*calenderbackviewsub,*polygonView,*statusview;
    UILabel *nodata;
    NSString *sender_id;
    NSString *advertise_id;
    NSString *property_id;
    UILabel *label1, *label2;
    UIImageView *dot1, *dot2;
    NSUserDefaults *userinfo;
    NSString *userid;
    NSString *finalyear22,*finalmonth22;
    //    NSString *advertise_id;
}

@property (strong, nonatomic) IBOutlet UIImageView *headerview;
@property (strong, nonatomic) IBOutlet UIView *mainview;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UILabel *addresslbl;
@end

@implementation MPBookAgentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    userinfo=[[NSUserDefaults alloc]init];
    
    userid = [userinfo objectForKey:@"id"];
    NSLog(@"userid is : %@",userid);
    
    calcheck = 0;
    
    holedata=[[NSMutableDictionary alloc]init];
    obj = [[FW_JsonClass alloc]init];
    datearry=[[NSMutableArray alloc]init];
    dateuse=[[NSMutableArray alloc]init];
    tempdata = [[NSMutableDictionary alloc]init];
    nextholedata=[[NSMutableDictionary alloc]init];
    nextcalapp=false;
    
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger week = [components month];
    NSInteger year = [components year];
    finalyear22 = [NSString stringWithFormat:@"%ld",(long)year];
    finalmonth22=[NSString stringWithFormat:@"%ld",(long)week];
    
    
    
    
    
    if ([_chkdata isEqualToString:@"i am from request"])
    {
        polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
        polygonView.backgroundColor=[UIColor blackColor];
        polygonView.alpha=0.3;
        [self.view addSubview:polygonView];
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
        
        [polygonView addSubview:spinner];
        [spinner startAnimating];
        
        
        NSString *url =[NSString stringWithFormat:@"%@json_output.php?mode=show_available_appointment_timing&advert_id=%@&year=%@&month=%@", App_Domain_Url, _finaladv_id, _finalyear, _finalmonth];
        
        [obj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
            NSLog(@"i am from sent request %@",result);
            holedata=[result mutableCopy];
            NSString *available=[holedata valueForKey:@"available_stat"];
            NSLog(@"data chk value%@",available);
            
            datearry= (NSMutableArray *)[holedata valueForKey:@"all_avl_dates"];
            for (int i=0; i<datearry.count; i++)
            {
                dic = (NSDictionary *)[datearry objectAtIndex:i];
                NSString *dic2 = (NSString *) [dic valueForKey:@"date_work"];
                NSLog(@"string %@",dic2);
                
                [dateuse insertObject:dic2 atIndex:i];
                
            }
            
            
            if ([available isEqualToString:@"N"])
            {
                [nodata removeFromSuperview];
                [_tableview setHidden:YES];
                [spinner stopAnimating];
                [spinner removeFromSuperview];
                [polygonView removeFromSuperview];
                
                nodata = [[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width/2) - 50, (self.view.frame.size.height/2) - 10, 100, 20)];
                nodata.textAlignment = NSTextAlignmentCenter;
                nodata.text = @"Not Available";
                nodata.textColor = [UIColor colorWithRed:36.0f/255.0f green:36.0/255.0 blue:36.0f/255.0f alpha:1];
                nodata.font = [UIFont fontWithName:@"open sans" size:14];
                sender_id = [holedata valueForKey:@"sent_request_to"];
                advertise_id = [holedata valueForKey:@"advert_id"];
                property_id = [holedata valueForKey:@"property_id"];
                chosenDates22=[holedata valueForKey:@"current_date"];
                
                [self.mainview addSubview:nodata];
                
            }
            else if([available isEqualToString:@"Y"])
            {
                [nodata removeFromSuperview];
                [_tableview setHidden:NO];
                
                [spinner stopAnimating];
                [spinner removeFromSuperview];
                [polygonView removeFromSuperview];
                
                timmingarr = [[holedata valueForKey:@"timing"] mutableCopy];
                sender_id = [holedata valueForKey:@"sent_request_to"];
                advertise_id = [holedata valueForKey:@"advert_id"];
                property_id = [holedata valueForKey:@"property_id"];
                chosenDates22=[holedata valueForKey:@"current_date"];
                NSLog(@"Timmings are:----%@",timmingarr);
                [_tableview reloadData];
            }
            
            
            
            
            
            NSLog(@"dates final%@",dateuse);
            //    }];
            
            currentdate=[NSDate date];
            
            _tableview.showsVerticalScrollIndicator = NO;
            
            _addresslbl.text = _address;
            
            
            
            NSLog(@"from %@",_chkdata);
            NSLog(@"advid %@",_finaladv_id);
            NSLog(@"mm %@",_finalmonth);
            NSLog(@"yy %@",_finalyear);
            
            
            
        }];
    }
    else
    {
        
        holedata = [_bookingDetailsDic mutableCopy];
        NSString *available=[holedata valueForKey:@"available_stat"];
        NSLog(@"data chk value%@",available);
        
        datearry= (NSMutableArray *)[holedata valueForKey:@"all_avl_dates"];
        for (int i=0; i<datearry.count; i++)
        {
            dic = (NSDictionary *)[datearry objectAtIndex:i];
            NSString *dic2 = (NSString *) [dic valueForKey:@"date_work"];
            NSLog(@"string %@",dic2);
            
            [dateuse insertObject:dic2 atIndex:i];
            
        }
        
        
        if ([available isEqualToString:@"N"])
        {
            [nodata removeFromSuperview];
            [_tableview setHidden:YES];
            
            nodata = [[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width/2) - 50, (self.view.frame.size.height/2) - 10, 100, 20)];
            nodata.textAlignment = NSTextAlignmentCenter;
            nodata.text = @"Not Available";
            nodata.textColor = [UIColor colorWithRed:36.0f/255.0f green:36.0/255.0 blue:36.0f/255.0f alpha:1];
            nodata.font = [UIFont fontWithName:@"open sans" size:14];
            sender_id = [holedata valueForKey:@"sent_request_to"];
            advertise_id = [holedata valueForKey:@"advert_id"];
            property_id = [holedata valueForKey:@"property_id"];
            chosenDates22=[holedata valueForKey:@"current_date"];
            [self.mainview addSubview:nodata];
            
        }
        else if([available isEqualToString:@"Y"])
        {
            [nodata removeFromSuperview];
            [_tableview setHidden:NO];
            
            
            timmingarr = [[holedata valueForKey:@"timing"] mutableCopy];
            sender_id = [holedata valueForKey:@"sent_request_to"];
            advertise_id = [holedata valueForKey:@"advert_id"];
            property_id = [holedata valueForKey:@"property_id"];
            chosenDates22=[holedata valueForKey:@"current_date"];
            
            NSLog(@"Timmings are:----%@",timmingarr);
            [_tableview reloadData];
        }
        
        
        
        
        
        NSLog(@"dates final%@",dateuse);
        //    }];
        
        currentdate=[NSDate date];
        
        _tableview.showsVerticalScrollIndicator = NO;
        
        _addresslbl.text = _address;
        
        
        
        NSLog(@"from %@",_chkdata);
        NSLog(@"advid %@",_finaladv_id);
        NSLog(@"mm %@",_finalmonth);
        NSLog(@"yy %@",_finalyear);
    }
    
}
- (IBAction)backTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//CKCalender delegate

- (BOOL)calendar:(CKCalendarView *)calendar willSelectDate:(NSDate *)date {
    // don't let people select dates in previous/next month
    return [calendar dateIsInCurrentMonth:date];
}
- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date
{
    [calenderBackView removeFromSuperview];
    polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
    polygonView.backgroundColor=[UIColor blackColor];
    polygonView.alpha=0.3;
    [self.view addSubview:polygonView];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
    
    [polygonView addSubview:spinner];
    [spinner startAnimating];
    
    calcheck = 0;
    NSDateFormatter *dateFormatter;
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    chosenDates22=[dateFormatter stringFromDate:date];
    
    NSString *data = [NSString stringWithFormat:@"%@json_output.php?mode=show_timing_for_another_date&advert_id=%@&date_choosen=%@",App_Domain_Url, [holedata valueForKey:@"advert_id"],chosenDates22];
    [obj GlobalDict:data Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        
        tempdata=[result mutableCopy];
        sender_id = [tempdata valueForKey:@"sent_request_to"];
        advertise_id = [tempdata valueForKey:@"advert_id"];
        property_id = [tempdata valueForKey:@"property_id"];
        if ([[tempdata valueForKey:@"available_stat"]isEqualToString:@"Y"])
        {
            [spinner stopAnimating];
            [spinner removeFromSuperview];
            [polygonView removeFromSuperview];
            [nodata removeFromSuperview];
            [_tableview setHidden:NO];
            
            //            UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"data available"
            //                                                           message: @"~~~~YES~~~~~"
            //                                                          delegate: self
            //                                                 cancelButtonTitle:@"Cancel"
            //                                                 otherButtonTitles:nil,nil];
            //
            //            [alert show];
            timmingarr=nil;
            timmingarr = [[tempdata valueForKey:@"timing"] mutableCopy];
            NSLog(@"Timmings are:----%@",timmingarr);
            [_tableview reloadData];
        }
        else if ([[tempdata valueForKey:@"available_stat"]isEqualToString:@"N"])
        {
            [spinner stopAnimating];
            [spinner removeFromSuperview];
            [polygonView removeFromSuperview];
            [nodata removeFromSuperview];
            [_tableview setHidden:YES];
            //            UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @" sorry no data available"
            //                                                           message: @"~~~~NO~~~~~"
            //                                                          delegate: self
            //                                                 cancelButtonTitle:@"Cancel"
            //                                                 otherButtonTitles:nil,nil];
            //
            //            [alert show];
            
            nodata = [[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width/2) - 50, (self.view.frame.size.height/2) - 10, 100, 20)];
            nodata.textAlignment = NSTextAlignmentCenter;
            nodata.text = @"Not Available";
            nodata.textColor = [UIColor colorWithRed:36.0f/255.0f green:36.0/255.0 blue:36.0f/255.0f alpha:1];
            nodata.font = [UIFont fontWithName:@"open sans" size:14];
            [self.mainview addSubview:nodata];
            
            
        }
        
    }];
    
    
    //        for (int i=0; i<dateuse.count; i++) {
    //            if ([chosenDates22 isEqualToString:[dateuse objectAtIndex:i]])
    //            {
    //                NSLog(@"fire");
    //            }
    //        }
}
- (void)calendar:(CKCalendarView *)calendar didDeselectDate:(NSDate *)date {
    NSLog(@"User didn't like date %@", date);
    // chosenDates=date;
}
- (BOOL)calendar:(CKCalendarView *)calendar willChangeToMonth:(NSDate *)date {
    // Of course we want to let users change months...
    return YES;
}
- (void)calendar:(CKCalendarView *)calendar didChangeToMonth:(NSDate *)date {
    nextcalapp=true;
    NSLog(@"Hurray, the user changed months!");
    NSLog(@"%@",date);
    [calendarview removeFromSuperview];
    polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
    polygonView.backgroundColor=[UIColor blackColor];
    polygonView.alpha=0.3;
    [self.view addSubview:polygonView];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
    
    [polygonView addSubview:spinner];
    [spinner startAnimating];
    
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    
    
    NSInteger week = [components month];
    NSInteger year = [components year];
    
    NSString *finalyear = [NSString stringWithFormat:@"%ld",(long)year];
    NSString *finalmonth=[NSString stringWithFormat:@"%ld",(long)week];
    
    NSLog(@"%@",finalmonth);
    NSLog(@"%@",finalyear);
    
    NSString *data = [NSString stringWithFormat:@"%@json_output.php?mode=show_available_appointment_timing&advert_id=%@&year=%@&month=%@",App_Domain_Url, [holedata valueForKey:@"advert_id"],finalyear,finalmonth];
    [obj GlobalDict:data Globalstr:@"array" Withblock:^(id result, NSError *error) {
        dateuse=[[NSMutableArray alloc]init];
        nextmonthdata=[[NSMutableDictionary alloc]init];
        nextmonthdata=[result mutableCopy];
        
        NSString *available=[nextmonthdata valueForKey:@"available_stat"];
        NSLog(@"data chk value%@",available);
        datearry=nil;
        datearry= (NSMutableArray *)[nextmonthdata valueForKey:@"all_avl_dates"];
        for (int i=0; i<datearry.count; i++)
        {
            dic = (NSDictionary *)[datearry objectAtIndex:i];
            NSString *dic2 = (NSString *) [dic valueForKey:@"date_work"];
            NSLog(@"string %@",dic2);
            [dateuse insertObject:dic2 atIndex:i];
            
        }
        
        NSLog(@"%@",dateuse);
        [spinner stopAnimating];
        [spinner removeFromSuperview];
        [polygonView removeFromSuperview];
        
        [calenderbackviewsub addSubview:calendarview];
        [calenderbackviewsub addSubview:label1];
        [calenderbackviewsub addSubview:label2];
        [calenderbackviewsub addSubview:dot1];
        [calenderbackviewsub addSubview:dot2];
        
    }];
    
}

- (void)calendar:(CKCalendarView *)calendar configureDateItem:(CKDateItem *)dateItem forDate:(NSDate *)date {
    // If the date has been chosen by the user, go ahead and style it differently
    
    NSDateFormatter *dateFormatter;
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    chosenDates33=[dateFormatter stringFromDate:date];
    chosenDates44=[dateFormatter stringFromDate:currentdate];
    
    
    if ([chosenDates33 isEqualToString:chosenDates44])
    {
        //dateItem.backgroundColor = [[UIColor blueColor]colorWithAlphaComponent:.8];
        //dateItem.backgroundColor=[UIColor colorWithRed:31.0f/255.0f green:55.0f/255.0f blue:97.0f/255.0f alpha:1];
        dateItem.textColor = [UIColor redColor];
    }
    
    
    for (int i=0; i<dateuse.count; i++)
    {
        if ([chosenDates33 isEqualToString:[dateuse objectAtIndex:i] ])
        {
            
            
            dateItem.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dot_image"]];
            
        }
    }
}



- (IBAction)calenderTapped:(id)sender
{
    if (nextcalapp==false)
    {
        if (calcheck == 0)
        {
            calenderBackView = [[UIView alloc]initWithFrame:CGRectMake(0, self.headerview.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.headerview.frame.size.height)];
            calenderBackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
            calendarview = [[CKCalendarView alloc] init];
            
            calenderbackviewsub=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.02, self.view.frame.size.height * .1, self.view.frame.size.width*0.96, self.view.frame.size.height * .55)];
            
            
            
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [button addTarget:self
                       action:@selector(closebutton:)
             forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:@"X" forState:UIControlStateNormal];
            button.backgroundColor=[UIColor whiteColor];
            
            if (self.view.frame.size.width == 320)
            {
                button.frame = CGRectMake(self.view.frame.size.width - 50, 10.0, 40, 40.0);
            }
            else
            {
                button.frame = CGRectMake(self.view.frame.size.width - 50, 20.0, 40, 40.0);
            }
            button.layer.cornerRadius=4.0f;
            
            calendarview.frame=CGRectMake(0, 0, calenderbackviewsub.frame.size.width, self.view.frame.size.height * .6);
            
            calenderbackviewsub.backgroundColor=[UIColor whiteColor];
            
            calenderbackviewsub.layer.borderWidth = 1.0f;
            calenderbackviewsub.layer.cornerRadius = 4.0f;
            calenderbackviewsub.layer.borderColor = [UIColor whiteColor].CGColor;
            [calenderbackviewsub.layer setMasksToBounds:YES];
            
            
            statusview = [[UIView alloc]initWithFrame:CGRectMake(40, calenderbackviewsub.frame.size.height+60, 160, 70)];
            
            
            if (self.view.frame.size.width == 320)
            {
                label1 = [[UILabel alloc]initWithFrame:CGRectMake(calenderbackviewsub.frame.size.width - 80,  calenderbackviewsub.frame.size.height - 40, 120, 25)];
                label1.text = @"Fully booked";
                [label1 setFont:[UIFont fontWithName:@"Open Sans" size:10]];
                
                dot1 =[[UIImageView alloc] initWithFrame:CGRectMake(calenderbackviewsub.frame.size.width - 95,calenderbackviewsub.frame.size.height - 32,8,9)];
                dot1.backgroundColor=[UIColor clearColor];
                dot1.image=[UIImage imageNamed:@"fillcolor"];
                
                
                
                label2 = [[UILabel alloc]initWithFrame:CGRectMake(calenderbackviewsub.frame.size.width - 80,  calenderbackviewsub.frame.size.height - 25, 120, 25)];
                label2.text = @"Available";
                [label2 setFont:[UIFont fontWithName:@"Open Sans" size:10]];
                
                
                dot2 =[[UIImageView alloc] initWithFrame:CGRectMake(calenderbackviewsub.frame.size.width - 95,calenderbackviewsub.frame.size.height - 17,8,9)];
                dot2.backgroundColor=[UIColor clearColor];
                dot2.image=[UIImage imageNamed:@"withoutcolor"];
                
            }
            else
            {
                label1 = [[UILabel alloc]initWithFrame:CGRectMake(calenderbackviewsub.frame.size.width - 90,  calenderbackviewsub.frame.size.height - 50, 120, 25)];
                label1.text = @"Fully booked";
                [label1 setFont:[UIFont fontWithName:@"Open Sans" size:12]];
                
                dot1 =[[UIImageView alloc] initWithFrame:CGRectMake(calenderbackviewsub.frame.size.width - 105,calenderbackviewsub.frame.size.height - 42,8,9)];
                dot1.backgroundColor=[UIColor clearColor];
                dot1.image=[UIImage imageNamed:@"fillcolor"];
                
                
                
                label2 = [[UILabel alloc]initWithFrame:CGRectMake(calenderbackviewsub.frame.size.width - 90,  calenderbackviewsub.frame.size.height - 28, 120, 25)];
                label2.text = @"Available";
                [label2 setFont:[UIFont fontWithName:@"Open Sans" size:12]];
                
                
                dot2 =[[UIImageView alloc] initWithFrame:CGRectMake(calenderbackviewsub.frame.size.width - 105,calenderbackviewsub.frame.size.height - 21,8,9)];
                dot2.backgroundColor=[UIColor clearColor];
                dot2.image=[UIImage imageNamed:@"withoutcolor"];
                
            }
            
            
            [self.mainview addSubview:calenderBackView];
            [calenderBackView addSubview:button];
            [calenderBackView addSubview:calenderbackviewsub];
            [calenderbackviewsub addSubview:calendarview];
            [calenderbackviewsub addSubview:label1];
            [calenderbackviewsub addSubview:label2];
            [calenderbackviewsub addSubview:dot1];
            [calenderbackviewsub addSubview:dot2];
            
            calendarview.delegate = self;
            calcheck = 1;
            
        }
        else
        {
            [calenderBackView removeFromSuperview];
            calcheck = 0;
        }
        
    }
    else if (nextcalapp==true)
    {
        NSLog(@"next time load");
        polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
        polygonView.backgroundColor=[UIColor blackColor];
        polygonView.alpha=0.3;
        [self.view addSubview:polygonView];
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
        
        [polygonView addSubview:spinner];
        [spinner startAnimating];
        
        
        
        NSString *url =[NSString stringWithFormat:@"%@json_output.php?mode=show_available_appointment_timing&advert_id=%@&year=%@&month=%@", App_Domain_Url, advertise_id, finalyear22, finalmonth22];
        
        [obj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
            
            
            dateuse=[[NSMutableArray alloc]init];
            nextholedata=[result mutableCopy];
            NSString *available=[nextholedata valueForKey:@"available_stat"];
            NSLog(@"data chk value%@",available);
            datearry=nil;
            datearry= (NSMutableArray *)[nextholedata valueForKey:@"all_avl_dates"];
            for (int i=0; i<datearry.count; i++)
            {
                dic = (NSDictionary *)[datearry objectAtIndex:i];
                NSString *dic2 = (NSString *) [dic valueForKey:@"date_work"];
                NSLog(@"string %@",dic2);
                
                [dateuse insertObject:dic2 atIndex:i];
                
            }
            
            [spinner stopAnimating];
            [spinner removeFromSuperview];
            [polygonView removeFromSuperview];
            
            if (calcheck == 0)
            {
                calenderBackView = [[UIView alloc]initWithFrame:CGRectMake(0, self.headerview.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.headerview.frame.size.height)];
                calenderBackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
                calendarview = [[CKCalendarView alloc] init];
                
                calenderbackviewsub=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.02, self.view.frame.size.height * .1, self.view.frame.size.width*0.96, self.view.frame.size.height * .55)];
                
                
                
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                [button addTarget:self
                           action:@selector(closebutton:)
                 forControlEvents:UIControlEventTouchUpInside];
                [button setTitle:@"X" forState:UIControlStateNormal];
                button.backgroundColor=[UIColor whiteColor];
                
                if (self.view.frame.size.width == 320)
                {
                    button.frame = CGRectMake(self.view.frame.size.width - 50, 10.0, 40, 40.0);
                }
                else
                {
                    button.frame = CGRectMake(self.view.frame.size.width - 50, 20.0, 40, 40.0);
                }
                button.layer.cornerRadius=4.0f;
                
                calendarview.frame=CGRectMake(0, 0, calenderbackviewsub.frame.size.width, self.view.frame.size.height * .6);
                
                calenderbackviewsub.backgroundColor=[UIColor whiteColor];
                
                calenderbackviewsub.layer.borderWidth = 1.0f;
                calenderbackviewsub.layer.cornerRadius = 4.0f;
                calenderbackviewsub.layer.borderColor = [UIColor whiteColor].CGColor;
                [calenderbackviewsub.layer setMasksToBounds:YES];
                
                
                statusview = [[UIView alloc]initWithFrame:CGRectMake(40, calenderbackviewsub.frame.size.height+60, 160, 70)];
                
                
                if (self.view.frame.size.width == 320)
                {
                    label1 = [[UILabel alloc]initWithFrame:CGRectMake(calenderbackviewsub.frame.size.width - 80,  calenderbackviewsub.frame.size.height - 40, 120, 25)];
                    label1.text = @"Fully booked";
                    [label1 setFont:[UIFont fontWithName:@"Open Sans" size:10]];
                    
                    dot1 =[[UIImageView alloc] initWithFrame:CGRectMake(calenderbackviewsub.frame.size.width - 95,calenderbackviewsub.frame.size.height - 32,8,9)];
                    dot1.backgroundColor=[UIColor clearColor];
                    dot1.image=[UIImage imageNamed:@"fillcolor"];
                    
                    
                    
                    label2 = [[UILabel alloc]initWithFrame:CGRectMake(calenderbackviewsub.frame.size.width - 80,  calenderbackviewsub.frame.size.height - 25, 120, 25)];
                    label2.text = @"Available";
                    [label2 setFont:[UIFont fontWithName:@"Open Sans" size:10]];
                    
                    
                    dot2 =[[UIImageView alloc] initWithFrame:CGRectMake(calenderbackviewsub.frame.size.width - 95,calenderbackviewsub.frame.size.height - 17,8,9)];
                    dot2.backgroundColor=[UIColor clearColor];
                    dot2.image=[UIImage imageNamed:@"withoutcolor"];
                    
                }
                else
                {
                    label1 = [[UILabel alloc]initWithFrame:CGRectMake(calenderbackviewsub.frame.size.width - 90,  calenderbackviewsub.frame.size.height - 50, 120, 25)];
                    label1.text = @"Fully booked";
                    [label1 setFont:[UIFont fontWithName:@"Open Sans" size:12]];
                    
                    dot1 =[[UIImageView alloc] initWithFrame:CGRectMake(calenderbackviewsub.frame.size.width - 105,calenderbackviewsub.frame.size.height - 42,8,9)];
                    dot1.backgroundColor=[UIColor clearColor];
                    dot1.image=[UIImage imageNamed:@"fillcolor"];
                    
                    
                    
                    label2 = [[UILabel alloc]initWithFrame:CGRectMake(calenderbackviewsub.frame.size.width - 90,  calenderbackviewsub.frame.size.height - 28, 120, 25)];
                    label2.text = @"Available";
                    [label2 setFont:[UIFont fontWithName:@"Open Sans" size:12]];
                    
                    
                    dot2 =[[UIImageView alloc] initWithFrame:CGRectMake(calenderbackviewsub.frame.size.width - 105,calenderbackviewsub.frame.size.height - 21,8,9)];
                    dot2.backgroundColor=[UIColor clearColor];
                    dot2.image=[UIImage imageNamed:@"withoutcolor"];
                    
                }
                
                
                [self.mainview addSubview:calenderBackView];
                [calenderBackView addSubview:button];
                [calenderBackView addSubview:calenderbackviewsub];
                [calenderbackviewsub addSubview:calendarview];
                [calenderbackviewsub addSubview:label1];
                [calenderbackviewsub addSubview:label2];
                [calenderbackviewsub addSubview:dot1];
                [calenderbackviewsub addSubview:dot2];
                
                calendarview.delegate = self;
                calcheck = 1;
                
            }
            else
            {
                [calenderBackView removeFromSuperview];
                calcheck = 0;
            }
            
            
            
            
            
            
            
        }];
        
        
        
    }
    
    
    
}

-(void)closebutton:(UIButton *)sender
{
    [calenderBackView removeFromSuperview];
    calcheck = 0;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return [jsonarray count];
    return timmingarr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = (BookAgentCell *)[tableView dequeueReusableCellWithIdentifier:@"bookcell"];
    //    cell = [[MyMessageCell alloc]init];
    
    //    if (timmingarr.count == 0)
    //    {
    //        UILabel *nodata = [[UILabel alloc]initWithFrame:CGRectMake(0, 200, 300, 20)];
    //        nodata.text = @"Not available";
    //        nodata.textColor = [UIColor blackColor];
    //        [cell addSubview:nodata];
    //    }
    
    cell.timminglbl.text = [[timmingarr objectAtIndex:indexPath.row] valueForKey:@"time_val"];
    if ([[[timmingarr objectAtIndex:indexPath.row] valueForKey:@"bookable_status"] isEqualToString:@"EX"])
    {
        cell.bookbtn.hidden = YES;
        cell.alreadyBooked.hidden = YES;
        cell.nodataavailable.hidden = NO;
    }
    else if ([[[timmingarr objectAtIndex:indexPath.row] valueForKey:@"bookable_status"] isEqualToString:@"B"])
    {
        cell.bookbtn.hidden = YES;
        cell.nodataavailable.hidden = YES;
        cell.alreadyBooked.hidden = NO;
    }
    else if ([[[timmingarr objectAtIndex:indexPath.row] valueForKey:@"bookable_status"] isEqualToString:@"F"])
    {
        cell.bookbtn.hidden = NO;
        cell.nodataavailable.hidden = YES;
        cell.alreadyBooked.hidden = YES;
        cell.bookbtn.tag = indexPath.row;
        [cell.bookbtn addTarget:self action:@selector(bookTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    PropertyDetails2ViewController *prop2 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"propertydetail"];
//    [self.navigationController pushViewController:prop2 animated:YES];
//}




-(void)bookTapped:(UIButton *)sender
{
    NSLog(@"Bookbtn tag is: %ld",(long)sender.tag);
    
    
    
    
    if ([_chkdata isEqualToString:@"i am from request"])
    {
        
        NSString *urlstr = [NSString stringWithFormat:@"%@json_output.php?mode=edit_booking_time&user_id=%@&booking_id=%@&time_slot=%@&date_val=%@",App_Domain_Url,userid,_book_id,[[[timmingarr objectAtIndex:sender.tag] valueForKey:@"time_val"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],chosenDates22];
        
        [obj GlobalDict:urlstr Globalstr:@"array" Withblock:^(id result, NSError *error) {
            bookdic = [result mutableCopy];
            
            MPAppointmentViewController *dash = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"appointment"];
            [self.navigationController pushViewController:dash animated:YES];
            
        }];
        
        
    }
    else
    {
        
        NSString *urlstr = [NSString stringWithFormat:@"%@json_output.php?mode=make_booking&advert_id=%@&sent_to=%@&user_id=%@&property_id=%@&time_slot=%@&date_val=%@",App_Domain_Url,advertise_id, sender_id,userid,property_id,[[[timmingarr objectAtIndex:sender.tag] valueForKey:@"time_val"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],chosenDates22];
        
        
        
        
        [obj GlobalDict:urlstr Globalstr:@"array" Withblock:^(id result, NSError *error) {
            bookdic = [result mutableCopy];
            
            MPAppointmentViewController *dash = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"appointment"];
            [self.navigationController pushViewController:dash animated:YES];
            
        }];
        
        
        
    }
    
    
    
    
    
    
    //    MPDashBoardViewController *dash = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"dashboard"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
