//
//  MPEditProperty.m
//  MYPROPERTY
//
//  Created by Somenath on 13/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "MPEditProperty.h"
#import "MPEditMedia.h"

@interface MPEditProperty ()

{
    IBOutlet UIImageView *topbar;
    
    IBOutlet UIButton *bkbtn;
    IBOutlet UILabel *toplbl;
}


@property (strong, nonatomic) IBOutlet UIScrollView *mainscroll;
@end

@implementation MPEditProperty

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    NSLog(@"main dic..........%@",_regisdetail);
    
    
    Array_2 = [[NSMutableArray alloc] init];
    
    
    Array_1 = [[NSMutableArray alloc] init];
    
    
    Array_3 = [[NSMutableArray alloc] init];
    Array_4 = [[NSMutableArray alloc] init];
    
    
    
    Arryid1 = [[NSMutableArray alloc]init];
    Arryid2 = [[NSMutableArray alloc]init];
    Arryid3 = [[NSMutableArray alloc]init];
    Arryid4 = [[NSMutableArray alloc]init];
    
    
    
    
    
    
    
    if ((NSNull *)[self.regisdetail valueForKey:@"relationsip_property_id"]== [NSNull null])
        
    {
        
        sndid1=@"";
        
    }
    
    else
        
    {
        
        sndid1 = [self.regisdetail valueForKey:@"relationsip_property_id"];
        
    }
    if ((NSNull *)[self.regisdetail valueForKey:@"property_type_id"]== [NSNull null])
        
    {
        
        sndid2=@"";
        
    }
    
    else
        
    {
        
        sndid2 = [self.regisdetail valueForKey:@"property_type_id"];
        
    }
    
    if ((NSNull *)[self.regisdetail valueForKey:@"status_val_id"]== [NSNull null])
        
    {
        
        sndid3=@"";
        
    }
    
    else
        
    {
        
        sndid3 = [self.regisdetail valueForKey:@"status_val_id"];
        
    }
    
    
    
    
    
    
    
    if ((NSNull *)[self.regisdetail valueForKey:@"relationsip_property"]== [NSNull null])
        
    {
        
        relationProperty.text = @"";
        
    }
    
    else
        
    {
        
        relationProperty.text = [self.regisdetail valueForKey:@"relationsip_property"];
        
    }
    
    
    
    if ((NSNull *)[self.regisdetail valueForKey:@"property_type"]== [NSNull null])
        
    {
        
        propertytypelbl.text = @"";
        
    }
    
    else
        
    {
        
        propertytypelbl.text = [self.regisdetail valueForKey:@"property_type"];
        
    }
    
    
    
    if ((NSNull *)[self.regisdetail valueForKey:@"status_val"]== [NSNull null])
        
    {
        
        currentstatus.text = @"";
        
    }
    
    else
        
    {
        
        currentstatus.text = [self.regisdetail valueForKey:@"status_val"];
        
    }
    
    
    
    if ((NSNull *)[self.regisdetail valueForKey:@"postcode"]== [NSNull null])
        
    {
        
        _picCodesrch.text = @"";
        
    }
    
    else
        
    {
        
        _picCodesrch.text = [self.regisdetail valueForKey:@"postcode"];
        
    }
    
    
    
    if ((NSNull *)[self.regisdetail valueForKey:@"address1"]== [NSNull null])
        
    {
        
        addresslbl.text = @"";
        
    }
    
    else
        
    {
        
        addresslbl.text = [self.regisdetail valueForKey:@"address1"];
        
    }
    
    
    
    if ((NSNull *)[self.regisdetail valueForKey:@"town"]== [NSNull null])
        
    {
        
        townlbl.text = @"";
        
    }
    
    else
        
    {
        
        townlbl.text = [self.regisdetail valueForKey:@"town"];
        
    }
    
    
    
    if ((NSNull *)[self.regisdetail valueForKey:@"county"]== [NSNull null])
        
    {
        
        countylbl.text = @"";
        
    }
    
    else
        
    {
        
        countylbl.text = [self.regisdetail valueForKey:@"county"];
        
    }
    
    
    
    if ((NSNull *)[self.regisdetail valueForKey:@"postcode"]== [NSNull null])
        
    {
        
        pincodelbl.text = @"";
        
    }
    
    else
        
    {
        
        pincodelbl.text = [self.regisdetail valueForKey:@"postcode"];
        
    }
    
    
    
    if ((NSNull *)[self.regisdetail valueForKey:@"no_of_beds"]== [NSNull null])
        
    {
        
        noofbed.text = @"";
        
    }
    
    else
        
    {
        
        noofbed.text = [self.regisdetail valueForKey:@"no_of_beds"];
        
    }
    
    
    
    if ((NSNull *)[self.regisdetail valueForKey:@"no_of_rooms"]== [NSNull null])
        
    {
        
        noofroom.text = @"";
        
    }
    
    else
        
    {
        
        noofroom.text = [self.regisdetail valueForKey:@"no_of_rooms"];
        
    }
    
    
    
    if ((NSNull *)[self.regisdetail valueForKey:@"no_of_baths"]== [NSNull null])
        
    {
        
        noofbath.text = @"";
        
    }
    
    else
        
    {
        
        noofbath.text = [self.regisdetail valueForKey:@"no_of_baths"];
        
    }
    
    
    
    if ((NSNull *)[self.regisdetail valueForKey:@"property_description"] == [NSNull null])
        
    {
        
        propertysumrylbl.hidden = NO;
        
    }
    
    else
        
    {
        
        propertysumrylbl.hidden = YES;
        
        propertysummary.text = [self.regisdetail valueForKey:@"property_description"];
        
    }
    
    
    
    if ((NSNull *)[self.regisdetail valueForKey:@"property_full_description"] == [NSNull null])
        
    {
        
        propertydescriptionlbl.hidden = NO;
        
    }
    
    else
        
    {
        
        propertydescriptionlbl.hidden = YES;
        
        propertyfulldescription.text = [self.regisdetail valueForKey:@"property_full_description"];
        
    }
    
    
    
    if ([[self.regisdetail valueForKey:@"off_strt_parkng_flag"] isEqualToString:@"Y"])
        
    {
        
        [parking setOn:YES animated:YES];
        parkingflg = @"Y";
        
    }
    
    else
        
    {
        
        [parking setOn:NO animated:YES];
        parkingflg = @"N";
        
    }
    
    
    
    if ([[self.regisdetail valueForKey:@"garden_flag"] isEqualToString:@"Y"])
        
    {
        
        [gardenflg setOn:YES animated:YES];
        gardenflag=@"Y";
        
    }
    
    else
        
    {
        
        [gardenflg setOn:NO animated:YES];
        gardenflag =@"N";
        
    }
    
    
    
    
    
    
    
    
    
    
    obj = [[FW_JsonClass alloc]init];
    _pincodeArray = [[NSMutableArray alloc]init];
    arry = [[NSMutableArray alloc]init];
    pickarry = [[NSArray alloc]init];
    
    dict = [[NSMutableDictionary alloc]init];
    
    
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568  && screenBounds.size.width == 320)
    {
        toplbl.frame =CGRectMake(60, 23, 201, 25);
    }
    
    else  if (screenBounds.size.height == 667  && screenBounds.size.width == 375)
    {
        
        
        topbar.frame=CGRectMake(0, 0, 375, 70);
        bkbtn.frame = CGRectMake(0, 0, 66, 70);
        toplbl.frame =CGRectMake(85, 30, 201, 25);
        
        
    }
    else if (screenBounds.size.height ==736  && screenBounds.size.width == 414)
    {
        topbar.frame=CGRectMake(0, 0, 414, 78);
        bkbtn.frame = CGRectMake(0, 0, 66, 78);
        toplbl.frame =CGRectMake(85, 30, 201, 25);
    }
    
    
    _mainscroll.showsHorizontalScrollIndicator=NO;
    _mainscroll.showsVerticalScrollIndicator = NO;
    
    // Do any additional setup after loading the view.
    
    [_mainscroll setContentSize:CGSizeMake(self.view.frame.size.width, 922)];
    
    //_mainscroll.showsVerticalScrollIndicator = YES;
    
    [pview setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:1]];
    _picCodesrch.delegate=self;
    
    //    myPickerView = [[UIPickerView alloc] init];
    
    //    myPickerView.frame = CGRectMake(0, 638, 162,320);
    
    //myPickerView.tag = i;
    
    //    myPickerView.delegate = self;
    
    //    myPickerView.showsSelectionIndicator = YES;
    
    
    
    app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    
    
    
    
    
    [parking addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
    
    [gardenflg addTarget:self action:@selector(changeSwitch1:) forControlEvents:UIControlEventValueChanged];
    
    
    
    UIView *polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
    polygonView.backgroundColor=[UIColor blackColor];
    polygonView.alpha=0.3;
    [self.view addSubview:polygonView];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
    
    [polygonView addSubview:spinner];
    
    NSString *url = [NSString stringWithFormat:@"%@json_output.php?mode=search_values",App_Domain_Url];
    [spinner startAnimating];
    NSManagedObjectContext *context = [app managedObjectContext];
    NSEntityDescription *entityDesc =[NSEntityDescription entityForName:@"Mpregister"inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    NSError *error;
    NSArray *objects1 = [context executeFetchRequest:request
                                               error:&error];
    
    
    if (objects1.count==0)
    {
        
        [obj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error)
         {
             
             // NSLog(@"result....%@",result);
             NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
             temp = [result mutableCopy];
             Array_1 = [[temp valueForKey:@"relation"]valueForKey:@"relation_name"];
             // Array_1 = [Array_1 valueForKey:@"relation_name"];
             
             NSData *coredata1 = [NSKeyedArchiver archivedDataWithRootObject:Array_1];
             NSManagedObjectContext *context1=[app managedObjectContext];
             NSManagedObject *newUser1=[NSEntityDescription insertNewObjectForEntityForName:@"Mpregister" inManagedObjectContext:context1];
             [newUser1 setValue:coredata1 forKey:@"data1"];
             [app saveContext];
             
             
             Arryid1 = [[temp valueForKey:@"relation"] valueForKey:@"id"];
             
             
             NSData *coredata1id = [NSKeyedArchiver archivedDataWithRootObject:Arryid1];
             NSManagedObjectContext *context1id=[app managedObjectContext];
             NSManagedObject *newUser1id=[NSEntityDescription insertNewObjectForEntityForName:@"Mpregister" inManagedObjectContext:context1id];
             [newUser1id setValue:coredata1id forKey:@"data1id"];
             [app saveContext];
             
             
             NSLog(@"arry1.....%@",Array_1);
             
             Array_2 = [[temp valueForKey:@"type"]valueForKey:@"type_name"];
             
             
             
             
             
             NSData *coredata2 = [NSKeyedArchiver archivedDataWithRootObject:Array_2];
             NSManagedObjectContext *context2=[app managedObjectContext];
             NSManagedObject *newUser2=[NSEntityDescription insertNewObjectForEntityForName:@"Mpregister" inManagedObjectContext:context2];
             [newUser2 setValue:coredata2 forKey:@"data2"];
             [app saveContext];
             
             
             
             
             
             
             
             
             Arryid2 =[[temp valueForKey:@"type"]valueForKey:@"id"];
             
             
             
             NSData *coredata2id = [NSKeyedArchiver archivedDataWithRootObject:Arryid2];
             NSManagedObjectContext *context2id=[app managedObjectContext];
             NSManagedObject *newUser2id=[NSEntityDescription insertNewObjectForEntityForName:@"Mpregister" inManagedObjectContext:context2id];
             [newUser2id setValue:coredata2id forKey:@"data2id"];
             [app saveContext];
             
             
             
             
             
             
             Array_3 = [[temp valueForKey:@"status"]valueForKey:@"status_val"];
             
             NSData *coredata3= [NSKeyedArchiver archivedDataWithRootObject:Array_3];
             NSManagedObjectContext *context3=[app managedObjectContext];
             NSManagedObject *newUser3=[NSEntityDescription insertNewObjectForEntityForName:@"Mpregister" inManagedObjectContext:context3];
             [newUser3 setValue:coredata3 forKey:@"data3"];
             [app saveContext];
             
             
             
             Arryid3 = [[temp valueForKey:@"status"]valueForKey:@"id"];
             
             
             NSData *coredata3id = [NSKeyedArchiver archivedDataWithRootObject:Arryid3];
             NSManagedObjectContext *context3id=[app managedObjectContext];
             NSManagedObject *newUser3id=[NSEntityDescription insertNewObjectForEntityForName:@"Mpregister" inManagedObjectContext:context3id];
             [newUser3id setValue:coredata3id forKey:@"data3id"];
             [app saveContext];
             
             
             Array_4 = [[temp valueForKey:@"room"]valueForKey:@"number_of_rooms"];
             //Array_4 = [Array_4 valueForKey:@"number_of_rooms"];
             
             NSData *coredata4= [NSKeyedArchiver archivedDataWithRootObject:Array_4];
             NSManagedObjectContext *context4=[app managedObjectContext];
             NSManagedObject *newUser4=[NSEntityDescription insertNewObjectForEntityForName:@"Mpregister" inManagedObjectContext:context4];
             [newUser4 setValue:coredata4 forKey:@"data4"];
             [app saveContext];
             
             
             [spinner stopAnimating];
             [spinner removeFromSuperview];
             [polygonView removeFromSuperview];
             
         } ];
        
        
    }
    
    
    else
    {
        [self coredata];
        [spinner stopAnimating];
        [spinner removeFromSuperview];
        [polygonView removeFromSuperview];
    }
    
    
    myPickerView.tag=1;
    
    myPickerView.hidden=YES;
    pview.hidden=YES;
    CGRect scr= pview.frame;
    [self.view addSubview:pview];
    [pview addSubview:myPickerView];
    
    if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
        
    {
        scr.origin.y=self.view.bounds.size.height-scr.size.height;
        pview.frame=scr;
    }
    else if (screenBounds.size.height == 667  && screenBounds.size.width == 375)
    {
        scr.origin.y=self.view.bounds.size.height-scr.size.height;
        pview.frame=scr;
    }
    else
    {
        scr.origin.y=self.view.bounds.size.height-scr.size.height;
        pview.frame=scr;
    }
    
    UIColor *color = [UIColor colorWithRed:36.0f/255.0f green:36.0f/255.0f blue:36.0f/255.0f alpha:1.0f];
    
    _picCodesrch.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter post code" attributes:@{NSForegroundColorAttributeName: color}];
    
    
}

- (void)changeSwitch:(id)sender{
    
    
    if([sender isOn])
    {
        parkingflg=@"Y";
        
    }
    else
    {
        parkingflg= @"N";
    }
}
- (void)changeSwitch1:(id)sender{
    
    if([sender isOn])
    {
        gardenflag=@"Y";
    } else{
        gardenflag = @"N";
    }
}



- (IBAction)backTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    btn1.hidden=NO;
    btn2.hidden=NO;
    btn3.hidden=NO;
    btn4.hidden=NO;
    btn5.hidden=NO;
    btn6.hidden=NO;
    
    //    CGRect rc=[_mainscroll bounds];
    //    CGPoint pt;
    //    rc=[_mainscroll convertRect:rc toView:_mainscroll];
    
    //    pt=rc.origin;
    //    pt.x=0;
    //    pt.y=0;
    //    [_mainscroll setContentOffset:pt animated:YES];
    
    
    
    [textField resignFirstResponder];
    _mainscroll.scrollEnabled=YES;
    return YES;
}


- (IBAction)pincodeDonebtn:(id)sender
{
    [self.view addSubview:pview];
    [pview addSubview:myPickerView];
    
    
    arry = [[NSMutableArray alloc]init];
    
    /*
     NSString *data = [NSString stringWithFormat:@"%@",[_picCodesrch text]];
     NSString *pinurl = [NSString stringWithFormat:@"https://api.ideal-postcodes.co.uk/v1/postcodes/%@?api_key=ak_icn5cf40QkOlvzuWj8cWwTO4H2eAS",data];
     
     
     UIView *polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
     polygonView.backgroundColor=[UIColor blackColor];
     polygonView.alpha=0.3;
     [self.view addSubview:polygonView];
     UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
     spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
     
     [polygonView addSubview:spinner];
     
     if (_picCodesrch.text.length>6)
     {
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
     message:@"Pincode Not found"
     delegate:self
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
     [alert show];
     }
     
     else if (_picCodesrch.text.length==6)
     
     {
     [spinner startAnimating];
     [obj GlobalDict:pinurl Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
     
     if ([[result valueForKey:@"message"] isEqualToString:@"Success"])
     {
     
     
     //         [dict setObject:[result valueForKey:@"latitude"] forKey:@"Latitude"];
     //         [dict setObject:[result valueForKey:@"longitude"] forKey:@"Longitude"];
     
     NSArray *array1 = (NSArray *) result[@"result"];
     //  NSLog(@"arry1==========%lu",(unsigned long)array1.count);
     for (int j=0; j<array1.count; j++)
     {
     NSDictionary *dic = (NSDictionary *) [array1 objectAtIndex:j];
     NSString *str =(NSString *) [NSString stringWithFormat:@"%@",[dic valueForKey:@"line_1" ]];
     NSString *str1=(NSString *) [NSString stringWithFormat:@"%@",[dic valueForKey:@"post_town"]];
     NSString *str2=(NSString *) [NSString stringWithFormat:@"%@",[dic valueForKey:@"traditional_county"]];
     
     
     //             [dict setObject:[dic valueForKey:@"longitude"] forKey:@"Longitude"];
     //             [dict setObject:[dic valueForKey:@"latitude"] forKey:@"Latitude"];
     
     //[list insertObject:str atIndex:j];
     NSLog(@"Str============%@",str);
     NSLog(@"Str1============%@",str1);
     NSLog(@"Str2=============%@",str2);
     NSString *final = (NSString *)[NSString stringWithFormat:@"%@,%@,%@",str,str1,str2];
     NSLog(@"final============%@",final);
     
     [arry insertObject:final atIndex:j];
     [longArray insertObject:[dic valueForKey:@"longitude"] atIndex:j];
     [latArray insertObject:[dic valueForKey:@"latitude"] atIndex:j];
     }
     
     NSLog(@"List========%@",arry);
     
     
     
     
     myPickerView.tag=10;
     btntag=10;
     myPickerView.hidden=NO;
     pview.hidden=NO;
     myPickerView.dataSource = self;
     myPickerView.delegate = self;
     
     
     }
     else
     {
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
     message:@"Pincode Not found"
     delegate:self
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
     [alert show];
     }
     
     
     [polygonView removeFromSuperview];
     }];
     }
     
     else
     {
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
     message:@"Pincode Not found"
     delegate:self
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
     [alert show];
     }
     
     
     
     */
    
    
    
    
    if (_picCodesrch.text.length==6)
    {
        [_picCodesrch resignFirstResponder];
        UIView *polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
        polygonView.backgroundColor=[UIColor blackColor];
        polygonView.alpha=0.3;
        [self.view addSubview:polygonView];
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
        
        [polygonView addSubview:spinner];
        
        
        NSString *data = [NSString stringWithFormat:@"%@",[_picCodesrch text]];
        NSLog(@"data%@",data);
        NSString *pinurl = [NSString stringWithFormat:@"https://api.getaddress.io/v2/uk/%@?api-key=NJx8d6WMR0qqjqGnb2gZAA1360",data];
        [spinner startAnimating];
        [obj GlobalDict:pinurl Globalstr:@"array" Withblock:^(id result, NSError *error)
         {
             
             
             if ([[result valueForKey:@"Message"] isEqualToString:@"Bad Request"]) {
                 
                 
                 
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                 message:[result valueForKey:@"Message"]
                                                                delegate:self
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil];
                 [alert show];
                 
                 
             }
             else if ([[result valueForKey:@"Message"] isEqualToString:@"You account has expired. Please upgrade your account."])
             {
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                 message:[result valueForKey:@"Message"]
                                                                delegate:self
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil];
                 [alert show];
             }
             else if ([[result valueForKey:@"Message"] isEqualToString:@"Not Found"])
             {
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                 message:[result valueForKey:@"Message"]
                                                                delegate:self
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil];
                 [alert show];
             }
             
             else
             {
                 
                 [dict setObject:[result valueForKey:@"Latitude"] forKey:@"Latitude"];
                 [dict setObject:[result valueForKey:@"Longitude"] forKey:@"Longitude"];
                 
                 _pincodeArray = [[result valueForKey:@"Addresses"]mutableCopy];
                 
                 for (int i=0; i<_pincodeArray.count; i++) {
                     
                     
                     
                     
                     NSString *text = [NSString stringWithFormat:@"%@",_pincodeArray[i]];
                     
                     NSString *check = [text stringByReplacingOccurrencesOfString:@" ," withString:@""];
                     
                     
                     [arry insertObject:check atIndex:i];
                     
                     
                     
                     
                 }
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 NSLog(@"arry ....%@",arry);
                 
                 myPickerView.tag=10;
                 btntag=10;
                 myPickerView.hidden=NO;
                 pview.hidden=NO;
                 myPickerView.dataSource = self;
                 myPickerView.delegate = self;
                 pincodelbl.text =_picCodesrch.text;
                 
             }
             // }
             [spinner stopAnimating];
             [spinner removeFromSuperview];
             [polygonView removeFromSuperview];
         }];
        
        
        
        
        
        
        
    }
    
    
}

- (IBAction)btn1:(id)sender {
    holedata=[[NSString alloc]init];
    holedata=[Array_1 objectAtIndex:0];
    sndid1 = [self.regisdetail valueForKey:@"relationsip_property_id"];
    myPickerView.tag=1;
    myPickerView.hidden=NO;
    pview.hidden=NO;
    myPickerView.dataSource = self;
    myPickerView.delegate = self;
    _mainscroll.scrollEnabled=NO;
    btntag=1;
    
    btn1.hidden=YES;
    btn2.hidden=NO;
    btn3.hidden=NO;
    btn4.hidden=NO;
    btn5.hidden=NO;
    btn6.hidden=NO;
    [myPickerView selectRow:0 inComponent:0 animated:YES];
    
    
    [_picCodesrch resignFirstResponder];
    [propertyfulldescription resignFirstResponder ];
    [propertysummary resignFirstResponder];
}

- (IBAction)btn2:(id)sender {
    
    [_picCodesrch resignFirstResponder];
    [propertyfulldescription resignFirstResponder ];
    [propertysummary resignFirstResponder];
    holedata=[[NSString alloc]init];
    holedata=[Array_2 objectAtIndex:0];
    sndid2 = [self.regisdetail valueForKey:@"property_type_id"];
    myPickerView.tag=2;
    myPickerView.hidden=NO;
    pview.hidden=NO;
    myPickerView.dataSource = self;
    myPickerView.delegate = self;
    
    
    btn1.hidden=NO;
    btn2.hidden=YES;
    btn3.hidden=NO;
    btn4.hidden=NO;
    btn5.hidden=NO;
    btn6.hidden=NO;
    [myPickerView selectRow:0 inComponent:0 animated:YES];
    
    [_picCodesrch resignFirstResponder];
    
    _mainscroll.scrollEnabled=NO;
    
    
    btntag=2;
    
}
- (IBAction)btn3:(id)sender {
    
    [_picCodesrch resignFirstResponder];
    [propertyfulldescription resignFirstResponder ];
    [propertysummary resignFirstResponder];
    holedata=[[NSString alloc]init];
    holedata=[Array_3 objectAtIndex:0];
    sndid3 = [self.regisdetail valueForKey:@"status_val_id"];
    myPickerView.tag=3;
    myPickerView.hidden=NO;
    pview.hidden=NO;
    myPickerView.dataSource = self;
    myPickerView.delegate = self;
    
    [myPickerView selectRow:0 inComponent:0 animated:YES];
    
    
    
    btn1.hidden=NO;
    btn2.hidden=NO;
    btn3.hidden=YES;
    btn4.hidden=NO;
    btn5.hidden=NO;
    btn6.hidden=NO;
    
    _mainscroll.scrollEnabled=NO;
    btntag=3;
    [_picCodesrch resignFirstResponder];
    
}
- (IBAction)btn4:(id)sender {
    [_picCodesrch resignFirstResponder];
    [propertyfulldescription resignFirstResponder ];
    [propertysummary resignFirstResponder];
    holedata=[[NSString alloc]init];
    holedata=[Array_4 objectAtIndex:0];
    myPickerView.tag=4;
    myPickerView.hidden=NO;
    pview.hidden=NO;
    myPickerView.dataSource = self;
    myPickerView.delegate = self;
    [_picCodesrch resignFirstResponder];
    _mainscroll.scrollEnabled=NO;
    btntag=4;
    
    btn1.hidden=NO;
    btn2.hidden=NO;
    btn3.hidden=NO;
    btn4.hidden=YES;
    btn5.hidden=NO;
    btn6.hidden=NO;
    [myPickerView selectRow:0 inComponent:0 animated:YES];
    
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    if(screenBounds.size.height == 667  && screenBounds.size.width == 375)
        
    {
        CGRect rc=[_mainscroll bounds];
        CGPoint pt;
        rc=[_mainscroll convertRect:rc toView:_mainscroll];
        
        pt=rc.origin;
        pt.x=0;
        pt.y=100;
        [_mainscroll setContentOffset:pt animated:YES];
        
        
    }
    else
    {
        CGRect rc=[_mainscroll bounds];
        CGPoint pt;
        rc=[_mainscroll convertRect:rc toView:_mainscroll];
        
        pt=rc.origin;
        pt.x=0;
        pt.y=200;
        [_mainscroll setContentOffset:pt animated:YES];
        
    }
    [self.view addSubview:pview];
    [pview addSubview:myPickerView];
}
- (IBAction)btn5:(id)sender {
    _mainscroll.scrollEnabled=YES;
    [_picCodesrch resignFirstResponder];
    [propertyfulldescription resignFirstResponder ];
    [propertysummary resignFirstResponder];
    holedata=[[NSString alloc]init];
    holedata=[Array_4 objectAtIndex:0];
    myPickerView.tag=5;
    myPickerView.hidden=NO;
    pview.hidden=NO;
    myPickerView.dataSource = self;
    myPickerView.delegate = self;
    [myPickerView selectRow:0 inComponent:0 animated:YES ];
    
    btntag=5;
    
    
    btn1.hidden=NO;
    btn2.hidden=NO;
    btn3.hidden=NO;
    btn4.hidden=NO;
    btn5.hidden=YES;
    btn6.hidden=NO;
    
    
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
        
    {
        CGRect rc=[_mainscroll bounds];
        CGPoint pt;
        rc=[_mainscroll convertRect:rc toView:_mainscroll];
        
        pt=rc.origin;
        pt.x=0;
        pt.y=200;
        [_mainscroll setContentOffset:pt animated:YES];
        
    }
    else
    {
        CGRect rc=[_mainscroll bounds];
        CGPoint pt;
        rc=[_mainscroll convertRect:rc toView:_mainscroll];
        
        pt=rc.origin;
        pt.x=0;
        pt.y=100;
        [_mainscroll setContentOffset:pt animated:YES];
        
        
    }
    
    [self.view addSubview:pview];
    [pview addSubview:myPickerView];
    
    
    
}
- (IBAction)btn6:(id)sender {
    
    [_picCodesrch resignFirstResponder];
    [propertyfulldescription resignFirstResponder ];
    [propertysummary resignFirstResponder];
    holedata=[[NSString alloc]init];
    holedata=[Array_4 objectAtIndex:0];
    myPickerView.tag=6;
    myPickerView.hidden=NO;
    pview.hidden=NO;
    myPickerView.dataSource = self;
    myPickerView.delegate = self;
    [_picCodesrch resignFirstResponder];
    _mainscroll.scrollEnabled=YES;
    btntag=6;
    
    btn1.hidden=NO;
    btn2.hidden=NO;
    btn3.hidden=NO;
    btn4.hidden=NO;
    btn5.hidden=NO;
    btn6.hidden=YES;
    
    [myPickerView selectRow:0 inComponent:0 animated:YES];
    
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 667  && screenBounds.size.width == 375) {
        CGPoint pt1;
        
        CGRect rc1=[_mainscroll bounds];
        rc1=[_mainscroll convertRect:rc1 toView:_mainscroll];
        
        pt1=rc1.origin;
        pt1.x=0;
        pt1.y=200;
        [_mainscroll setContentOffset:pt1 animated:YES];
    }
    else  if (screenBounds.size.height == 568  && screenBounds.size.width == 320) {
        CGPoint pt1;
        
        CGRect rc1=[_mainscroll bounds];
        rc1=[_mainscroll convertRect:rc1 toView:_mainscroll];
        
        pt1=rc1.origin;
        pt1.x=0;
        pt1.y=270;
        [_mainscroll setContentOffset:pt1 animated:YES];
    }
    else
    {
        CGPoint pt1;
        
        CGRect rc1=[_mainscroll bounds];
        rc1=[_mainscroll convertRect:rc1 toView:_mainscroll];
        
        pt1=rc1.origin;
        pt1.x=0;
        pt1.y=200;
        [_mainscroll setContentOffset:pt1 animated:YES];
        
    }
    
    [self.view addSubview:pview];
    [pview addSubview:myPickerView];
    
}

- (IBAction)next:(id)sender
{
    
    
    if (relationProperty.text.length==0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Relationship to property" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
    else if (propertytypelbl.text.length==0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Property Type" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
    else if (currentstatus.text.length==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Current Status" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
    //    else if ([addresslbl.text isEqualToString:@"ADDRESS LINE"])
    //    {
    //
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Address Line " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //
    //        [alert show];
    //    }
    else if (noofbed.text.length==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Number of Bedrooms" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
    else if (noofbath.text.length==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Number of Bathrooms" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
    else if (noofroom.text.length==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Number of Bathrooms" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
    else if (propertysummary.text.length==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Property Summary Description" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
    else if (propertyfulldescription.text.length==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Property Full Description" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
    
    
    else
    {
        
        
        [dict setObject:sndid1 forKey:@"rel_to_property"];
        [dict setObject:sndid2 forKey:@"property_type"];
        [dict setObject:sndid3 forKey:@"current_status"];
        [dict setObject:addresslbl.text forKey:@"address1"];
        [dict setObject:townlbl.text forKey:@"town"];
        [dict setObject:countylbl.text forKey:@"county"];
        [dict setObject:pincodelbl.text forKey:@"postcode"];
        [dict setObject:addresslbl.text forKey:@"display_addr"];
        [dict setObject:noofbed.text forKey:@"no_of_beds"];
        [dict setObject:noofbath.text forKey:@"no_of_baths"];
        [dict setObject:noofroom.text forKey:@"no_of_rooms"];
        [dict setObject:propertysummary.text forKey:@"property_description"];
        [dict setObject:propertyfulldescription.text forKey:@"property_full_description"];
        [dict setObject:parkingflg forKey:@"off_strt_parkng_flag"];
        [dict setObject:gardenflag forKey:@"garden_flag"];
        
        UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MPEditPropertyMediaZero *next =[story instantiateViewControllerWithIdentifier:@"editpropertymediazero"];
        next.firstdic=[dict mutableCopy];
        next.josndic = [_regisdetail mutableCopy];
        [self.navigationController pushViewController:next animated:YES];
        
        
    }
    
}









//picker View delegate and data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    
    
    return 1;
    
    
    
}



- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component {
    
    
    
    
    
    if ( myPickerView.tag==1) // this is otherPickerview
        
    {
        
        return [Array_1 count];
        
        
        
        
        
        
    }
    
    else if(myPickerView.tag==2)
        
    {
        
        return [Array_2 count];
        
    }
    
    else if (myPickerView.tag==3)
    {
        //[myPickerView reloadAllComponents];
        return [Array_3 count];
    }
    else if (pickerView.tag==4 || pickerView.tag==5 || pickerView.tag==6)
        
    {
        return Array_4.count;
    }
    
    else
        return arry.count;
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)

component

{
    
    if (pickerView.tag==1) {
        
        
        return Array_1[row];
        
        
        
    }
    
    else if (pickerView.tag==2)
        
    {
        
        return Array_2[row];
        
        
        
    }
    
    
    else if (pickerView.tag==3)
        
    {
        // [myPickerView reloadAllComponents];
        return Array_3[row];
        
    }
    
    else if (pickerView.tag==4 || pickerView.tag==5 || pickerView.tag==6)
        
    {
        //[myPickerView reloadAllComponents];
        return Array_4[row];
        
    }
    
    else if (pickerView.tag==10)
    {
        //[myPickerView reloadAllComponents];
        return arry[row];
        
        
    }
    
    return nil;
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    if (pickerView.tag==1) {
        
        
        holedata = [[NSString alloc] initWithFormat:
                    @"%@", [Array_1 objectAtIndex:row]];
        sndid1 =[[NSString alloc] initWithFormat:
                 @"%@", [Arryid1 objectAtIndex:row]];
        NSLog(@"%@", sndid1);
        
    }
    
    else if (pickerView.tag==2)
        
    {
        
        holedata = [[NSString alloc] initWithFormat:
                    @"%@", [Array_2 objectAtIndex:row]];
        sndid2 =[[NSString alloc] initWithFormat:
                 @"%@", [Arryid2 objectAtIndex:row]];
        NSLog(@"%@", sndid2);
        
    }
    
    
    else if (pickerView.tag==3)
        
    {
        
        
        holedata = [[NSString alloc] initWithFormat:
                    @"%@", [Array_3 objectAtIndex:row]];
        sndid3 =[[NSString alloc] initWithFormat:
                 @"%@", [Arryid3 objectAtIndex:row]];
        NSLog(@"%@", sndid3);
        
    }
    
    else if (pickerView.tag==4 || pickerView.tag==5 || pickerView.tag==6)
        
    {
        
        holedata = [[NSString alloc] initWithFormat:
                    @"%@", [Array_4 objectAtIndex:row]];
        NSLog(@"%@", holedata);
        
    }
    else  if(pickerView.tag == 10)
    {
        //        data1= [[NSString alloc] initWithFormat:
        //                    @"%@", [arry objectAtIndex:row]];
        //        data2=data1;
        //        data3=data2;
        //        NSLog(@"data1.......%@",data1);
        //        NSLog(@"data2.......%@",data2);
        //        NSLog(@"data3.......%@",data3);
        
        holddata = [arry objectAtIndex:row];
        
        
        NSLog(@"pickerarry...%@",holddata);
        
        
    }
    
    
    
}

/*- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
 
 
 
 
 
 
 
 
 
 if (btntag==10  && pickerView.tag==10)
 {
 UILabel* tView = (UILabel*)view;
 
 if (!tView){
 tView = [[UILabel alloc] init];
 // Setup label properties - frame, font, colors etc
 
 [tView setFont:[UIFont fontWithName:@"Open Sans" size:20]];
 tView.textAlignment = NSTextAlignmentCenter;
 tView.backgroundColor = [UIColor clearColor];
 }
 
 
 
 tView.text = [arry objectAtIndex:row];
 
 
 
 return tView;
 }
 
 else
 {
 if (btntag==1 && pickerView.tag==1) {
 UILabel* tView = (UILabel*)view;
 if (!tView){
 tView = [[UILabel alloc] init];
 
 tView.backgroundColor = [UIColor clearColor];
 [tView setFont:[UIFont fontWithName:@"Open Sans" size:24]];
 tView.textAlignment = NSTextAlignmentCenter;
 }
 
 
 
 tView.text = [Array_1 objectAtIndex:row];
 
 
 
 return tView;
 
 }
 
 else if (btntag==2 && pickerView.tag==2)
 {
 UILabel* tView = (UILabel*)view;
 if (!tView){
 tView = [[UILabel alloc] init];
 // Setup label properties - frame, font, colors etc
 
 [tView setFont:[UIFont fontWithName:@"Open Sans" size:24]];
 tView.textAlignment = NSTextAlignmentCenter;
 tView.backgroundColor = [UIColor clearColor];
 }
 
 
 
 tView.text = [Array_2 objectAtIndex:row];
 
 
 
 return tView;
 }
 else if (btntag==3  && pickerView.tag==3)
 {
 UILabel* tView = (UILabel*)view;
 
 if (!tView){
 tView = [[UILabel alloc] init];
 // Setup label properties - frame, font, colors etc
 
 [tView setFont:[UIFont fontWithName:@"Open Sans" size:24]];
 tView.textAlignment = NSTextAlignmentCenter;
 tView.backgroundColor = [UIColor clearColor];
 }
 
 
 
 tView.text = [Array_3 objectAtIndex:row];
 
 
 
 return tView;
 }
 
 else if (pickerView.tag==4 || pickerView.tag==5 || pickerView.tag==6)
 {
 UILabel* tView = (UILabel*)view;
 
 if (!tView){
 tView = [[UILabel alloc] init];
 // Setup label properties - frame, font, colors etc
 
 [tView setFont:[UIFont fontWithName:@"Open Sans" size:24]];
 tView.textAlignment = NSTextAlignmentCenter;
 tView.backgroundColor = [UIColor clearColor];
 }
 
 
 
 tView.text = [Array_4 objectAtIndex:row];
 
 
 
 return tView;
 }
 
 
 
 }
 
 
 return nil;
 }
 */

- (IBAction)done:(id)sender
{
    if (btntag==1) {
        
        
        relationProperty.text=holedata;
        
    }
    else if (btntag==2)
    {
        propertytypelbl.text=holedata;
        
    }
    else if (btntag==3)
    {
        currentstatus.text=holedata;
        
    }
    
    else if (btntag==4)
    {
        noofbed.text=holedata;
    }
    else if (btntag==5)
    {
        noofroom.text=holedata;
    }
    else if (btntag==6)
    {
        noofbath.text=holedata;
        
    }
    else if (btntag==10)
    {
        
        //        [dict setObject:Latitude forKey:@"Latitude"];
        //        [dict setObject:Longitude forKey:@"Longitude"];
        
        
        NSLog(@"dict===============>%@",dict);
        
        pickarry= [holddata componentsSeparatedByString:@","] ;
        
        if (pickarry.count>0)
        {
            
            for (int i=0;  i<pickarry.count; i++)
            {
                if (i==0)
                {
                    addresslbl.text = [pickarry objectAtIndex:i];
                }
                
                if (i==pickarry.count-2)
                {
                    townlbl.text=[pickarry objectAtIndex:i];
                }
                
                if (i==pickarry.count-1)
                {
                    countylbl.text= [pickarry objectAtIndex:i];
                }
                
                pincodelbl.text =_picCodesrch.text;
            }
            
        }
        
        
        
        
        
        
        
        
        
    }
    myPickerView.hidden=YES;
    pview.hidden=YES;
    _mainscroll.scrollEnabled=YES;
    
    
    btn1.hidden=NO;
    btn2.hidden=NO;
    btn3.hidden=NO;
    btn4.hidden=NO;
    btn5.hidden=NO;
    btn6.hidden=NO;
    
    
    //    CGPoint pt;
    //
    //    CGRect rc=[_mainscroll bounds];
    //    rc=[_mainscroll convertRect:rc toView:_mainscroll];
    //
    //    pt=rc.origin;
    //    pt.x=0;
    //    pt.y=0;
    //    [_mainscroll setContentOffset:pt animated:YES];
    
    [self.view addSubview:pview];
    [pview addSubview:myPickerView];
}


-(IBAction)cancel:(id)sender
{
    pview.hidden=YES;
    _mainscroll.scrollEnabled=YES;
    [myPickerView selectRow:0 inComponent:0 animated:YES];
    
    btn1.hidden=NO;
    btn2.hidden=NO;
    btn3.hidden=NO;
    btn4.hidden=NO;
    btn5.hidden=NO;
    btn6.hidden=NO;
    
    //    CGPoint pt;
    //
    //    CGRect rc=[_mainscroll bounds];
    //    rc=[_mainscroll convertRect:rc toView:_mainscroll];
    //
    //    pt=rc.origin;
    //    pt.x=0;
    //    pt.y=0;
    //    [_mainscroll setContentOffset:pt animated:YES];
    
    [self.view addSubview:pview];
    [pview addSubview:myPickerView];
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField

{
    btn1.hidden=NO;
    btn2.hidden=NO;
    btn3.hidden=NO;
    btn4.hidden=NO;
    btn5.hidden=NO;
    btn6.hidden=NO;
    
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    pview.hidden=YES;
    myPickerView.hidden=YES;
    return YES;
}



-(void)textViewDidBeginEditing:(UITextView *)textView
{
    pview.hidden=YES;
    myPickerView.hidden=YES;
    btn1.hidden=NO;
    btn2.hidden=NO;
    btn3.hidden=NO;
    btn4.hidden=NO;
    btn5.hidden=NO;
    btn6.hidden=NO;
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    
    if (textView==propertyfulldescription)
    {
        propertydescriptionlbl.hidden=YES;
        
        CGRect rc=[_mainscroll bounds];
        CGPoint pt;
        rc=[_mainscroll convertRect:rc toView:_mainscroll];
        
        pt=rc.origin;
        pt.x=0;
        pt.y=500;
        [_mainscroll setContentOffset:pt animated:YES];
    }
    if (textView ==propertysummary)
    {
        propertysumrylbl.hidden=YES;
        CGRect screenBounds=[[UIScreen mainScreen] bounds];
        if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
        {
            [self.mainscroll setContentOffset:CGPointMake(0.0f, 390.0f) animated:YES];
        }
        else if (screenBounds.size.height == 667  && screenBounds.size.width == 375)
        {
            [self.mainscroll setContentOffset:CGPointMake(0.0f, 300.0f) animated:YES];
        }
        else
        {
            
            [self.mainscroll setContentOffset:CGPointMake(0.0f, 220.0f) animated:YES];
        }
        
    }
    
    
    
    //  [self.mainscroll setContentSize:CGSizeMake(320, 1075)];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        if (textView ==propertyfulldescription) {
            CGRect screenBounds=[[UIScreen mainScreen] bounds];
            if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
            {
                [self.mainscroll setContentOffset:CGPointMake(0.0f, 414.0f) animated:YES];
            }
            else if (screenBounds.size.height == 667  && screenBounds.size.width == 375)
            {
                [self.mainscroll setContentOffset:CGPointMake(0.0f, 315.0f) animated:YES];
            }
            else
            {
                
                [self.mainscroll setContentOffset:CGPointMake(0.0f, 245.0f) animated:YES];
            }
            
        }
        
        
        
        
        [textView resignFirstResponder];
        
        if (textView.text.length==0)
        {
            propertysumrylbl.hidden=NO;
            propertydescriptionlbl.hidden = NO;
        }
        
    }
    
    return YES;
}
-(void)coredata
{
    
    NSManagedObjectContext *context0 = [app managedObjectContext];
    NSEntityDescription *entityDesc0 =[NSEntityDescription entityForName:@"Mpregister"inManagedObjectContext:context0];
    NSFetchRequest *request0 = [[NSFetchRequest alloc] init];
    [request0 setEntity:entityDesc0];
    
    NSError *error;
    NSArray *objects0 = [context0 executeFetchRequest:request0
                                                error:&error];
    
    objects0 = [NSKeyedUnarchiver unarchiveObjectWithData:[[objects0 objectAtIndex:0]valueForKey:@"data1"]];
    
    [Array_1 addObjectsFromArray:objects0];
    
    
    
    
    NSManagedObjectContext *context01 = [app managedObjectContext];
    NSEntityDescription *entityDesc01 =[NSEntityDescription entityForName:@"Mpregister"inManagedObjectContext:context01];
    NSFetchRequest *request01 = [[NSFetchRequest alloc] init];
    [request01 setEntity:entityDesc01];
    
    NSArray *objects01 = [context01 executeFetchRequest:request01
                                                  error:&error];
    
    objects01 = [NSKeyedUnarchiver unarchiveObjectWithData:[[objects01 objectAtIndex:1]valueForKey:@"data1id"]];
    
    [Arryid1 addObjectsFromArray:objects01];
    
    
    
    
    
    
    
    
    
    
    
    NSManagedObjectContext *context = [app managedObjectContext];
    NSEntityDescription *entityDesc =[NSEntityDescription entityForName:@"Mpregister"inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    // NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    objects = [NSKeyedUnarchiver unarchiveObjectWithData:[[objects objectAtIndex:2]valueForKey:@"data2"]];
    
    [Array_2 addObjectsFromArray:objects];
    
    
    
    
    NSManagedObjectContext *context1 = [app managedObjectContext];
    NSEntityDescription *entityDesc1 =[NSEntityDescription entityForName:@"Mpregister"inManagedObjectContext:context1];
    NSFetchRequest *request1 = [[NSFetchRequest alloc] init];
    [request1 setEntity:entityDesc1];
    
    
    NSArray *objects1 = [context1 executeFetchRequest:request1
                                                error:&error];
    
    objects1 = [NSKeyedUnarchiver unarchiveObjectWithData:[[objects1 objectAtIndex:3]valueForKey:@"data2id"]];
    
    [Arryid2 addObjectsFromArray:objects1];
    
    
    
    
    
    
    
    NSManagedObjectContext *context2 = [app managedObjectContext];
    NSEntityDescription *entityDesc2 =[NSEntityDescription entityForName:@"Mpregister"inManagedObjectContext:context2];
    NSFetchRequest *request2 = [[NSFetchRequest alloc] init];
    [request2 setEntity:entityDesc2];
    
    
    NSArray *objects2 = [context2 executeFetchRequest:request2
                                                error:&error];
    
    objects2 = [NSKeyedUnarchiver unarchiveObjectWithData:[[objects2 objectAtIndex:4]valueForKey:@"data3"]];
    
    [Array_3 addObjectsFromArray:objects2];
    
    
    
    
    NSManagedObjectContext *context2id = [app managedObjectContext];
    NSEntityDescription *entityDesc2id =[NSEntityDescription entityForName:@"Mpregister"inManagedObjectContext:context2id];
    NSFetchRequest *request2id = [[NSFetchRequest alloc] init];
    [request2id setEntity:entityDesc2id];
    
    NSArray *objects2id = [context2id executeFetchRequest:request2id
                                                    error:&error];
    
    objects2id = [NSKeyedUnarchiver unarchiveObjectWithData:[[objects2id objectAtIndex:5]valueForKey:@"data3id"]];
    
    [Arryid3 addObjectsFromArray:objects2id];
    
    
    
    
    
    
    
    
    NSManagedObjectContext *context3 = [app managedObjectContext];
    NSEntityDescription *entityDesc3 =[NSEntityDescription entityForName:@"Mpregister"inManagedObjectContext:context3];
    NSFetchRequest *request3 = [[NSFetchRequest alloc] init];
    [request3 setEntity:entityDesc3];
    
    
    NSArray *objects3 = [context3 executeFetchRequest:request
                                                error:&error];
    
    objects3 = [NSKeyedUnarchiver unarchiveObjectWithData:[[objects3 objectAtIndex:6]valueForKey:@"data4"]];
    
    [Array_4 addObjectsFromArray:objects3];
    
    
    
    
    
    
    
    
}


@end
