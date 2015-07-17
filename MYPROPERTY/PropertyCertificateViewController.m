//
//  PropertyCertificateViewController.m
//  MYPROPERTY
//
//  Created by soumyajit on 11/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "PropertyCertificateViewController.h"

@interface PropertyCertificateViewController ()

@end

@implementation PropertyCertificateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [scroll setContentSize:CGSizeMake(self.view.frame.size.width, 814)];
    _imagePicker = [[UIImagePickerController alloc]init];
    [scroll setShowsHorizontalScrollIndicator:NO];
    [scroll setShowsVerticalScrollIndicator:NO];
    
    obj = [[FW_JsonClass alloc]init];
    _thirdpagedata = [[NSMutableDictionary alloc]init];
    
    submitbtn.layer.cornerRadius = 3;
    NSLog(@"firpage data%@",_firstpagedata);
    NSLog(@"Second dic.....%@",_secondpagedata);
    
    uesrid = [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
    
    
    NSLog(@"object for key%@",[_firstpagedata objectForKey:@"Latitude"]);
    NSLog(@"value for key%@", [_firstpagedata valueForKey:@"Latitude"]);
    
    
    
    
    
    
    
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


- (IBAction)submitbtn:(id)sender

{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    
    NSInteger day = [components day];
    NSInteger week = [components month];
    NSInteger year = [components year];
    
    NSString *addingdate = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)year, (long)week, (long)day];
    
    
    UIView *polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
    polygonView.backgroundColor=[UIColor blackColor];
    polygonView.alpha=0.3;
    [self.view addSubview:polygonView];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
    
    [polygonView addSubview:spinner];
    
    
    
    if (images1!=NULL)
    {
        [_thirdpagedata setObject:images1 forKey:@"image1"];
    }
    if (images2!=NULL) {
        [_thirdpagedata setObject:images2 forKey:@"image2"];
    }
    
    if (images3!=NULL) {
        [_thirdpagedata setObject:images3 forKey:@"image3"];
    }
    if (images4!=NULL) {
        [_thirdpagedata setObject:images4 forKey:@"image4"];
    }
    
    if (images1!=NULL && images2!=NULL && images3!=NULL && images4!=NULL)
    {
        NSLog(@"if");
        
        [_thirdpagedata setObject:dateEpclbl.text forKey:@"date_epc_taken"];
        [_thirdpagedata setObject:gassafe.text forKey:@"gas_reg_no"];
        [_thirdpagedata setObject:cftserialtxt.text forKey:@"certificate_serial_no"];
        [_thirdpagedata setObject:gastestdata.text forKey:@"gas_test_date"];
        [_thirdpagedata setObject:electricSafedatelbl.text forKey:@"elec_safe_test_date"];
        
        NSString *url = [NSString stringWithFormat:@"%@json_output.php?mode=registry_property&added_by=%@&rel_to_property=%@&property_type=%@&current_status=%@&house_name=czc&address1=%@&latitude=%@&longitude=%@&town=%@s&county=%@&country=Y&postcode=%@&display_addr=%@&no_of_beds=%@&no_of_baths=%@&no_of_rooms=%@&property_description=%@&property_full_description=%@&off_strt_parkng_flag=%@&garden_flag=%@&adding_date=%@&sold_status=Y&video_code=%@&Floorplan_name=Groud_floor&epc_val=Y&date_epc_taken=%@&gas_certificate=dgsd&gas_reg_no=%@&certificate_serial_no=%@&gas_test_date=%@&elec_certificate=jsdh&elec_safe_test_date=%@",App_Domain_Url,uesrid,[_firstpagedata valueForKey:@"rel_to_property"],[_firstpagedata valueForKey:@"property_type"],[_firstpagedata valueForKey:@"current_status"],[_firstpagedata valueForKey:@"address1"],[_firstpagedata valueForKey:@"Latitude"],[_firstpagedata valueForKey:@"Longitude"],[_firstpagedata valueForKey:@"town"],[_firstpagedata valueForKey:@"county"],[_firstpagedata valueForKey:@"postcode"],[_firstpagedata valueForKey:@"address1"],[_firstpagedata valueForKey:@"no_of_beds"],[_firstpagedata valueForKey:@"no_of_baths"],[_firstpagedata valueForKey:@"no_of_rooms"],[_firstpagedata valueForKey:@"property_description"],[_firstpagedata valueForKey:@"property_full_description"],[_firstpagedata valueForKey:@"off_strt_parkng_flag"],[_firstpagedata valueForKey:@"garden_flag"],addingdate,[_secondpagedata valueForKey:@"video_code"],[_thirdpagedata valueForKey:@"date_epc_taken"],[_thirdpagedata valueForKey:@"gas_reg_no"],[_thirdpagedata valueForKey:@"certificate_serial_no"],[_thirdpagedata valueForKey:@"gas_test_date"],[_thirdpagedata valueForKey:@"elec_safe_test_date"]];
        NSLog(@"url %@",url);
        [spinner startAnimating];
        
        NSString* encodedUrl = [url stringByAddingPercentEscapesUsingEncoding:
                                NSUTF8StringEncoding];
        
        
        
        
        
        NSData *imgdata = UIImageJPEGRepresentation([_secondpagedata valueForKey:@"image1"], 90);
        [obj GlobalDict_image:encodedUrl Globalstr_image:@"array" globalimage:imgdata Withblock:^(id result, NSError *error)
         {
             
             NSLog(@"image return%@",result);
             
             if ([[result valueForKey:@"msg"] isEqualToString:@"You property registration has been done successfully"])
             {
                 UIStoryboard *stroy = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                 MPDashBoardViewController *dashboard  = [stroy instantiateViewControllerWithIdentifier:@"dashboard"];
                 
                 [self.navigationController pushViewController:dashboard animated:YES];
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:[result valueForKey:@"msg"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 
                 [alert show];
             }
             
             [spinner startAnimating];
             [spinner removeFromSuperview];
             [polygonView removeFromSuperview];
         }];
        
        
        
        
        
        
        
        
        
        
    }
    
    else
    {
        NSLog(@"else");
        [_thirdpagedata setObject:dateEpclbl.text forKey:@"date_epc_taken"];
        [_thirdpagedata setObject:gassafe.text forKey:@"gas_reg_no"];
        [_thirdpagedata setObject:cftserialtxt.text forKey:@"certificate_serial_no"];
        [_thirdpagedata setObject:gastestdata.text forKey:@"gas_test_date"];
        [_thirdpagedata setObject:electricSafedatelbl.text forKey:@"elec_safe_test_date"];
        
        
        NSString *url = [NSString stringWithFormat:@"%@json_output.php?mode=registry_property&added_by=%@&rel_to_property=%@&property_type=%@&current_status=%@&house_name=czc&address1=%@&latitude=%@&longitude=%@&town=%@s&county=%@&country=Y&postcode=%@&display_addr=%@&no_of_beds=%@&no_of_baths=%@&no_of_rooms=%@&property_description=%@&property_full_description=%@&off_strt_parkng_flag=%@&garden_flag=%@&adding_date=%@&sold_status=Y&video_code=%@&Floorplan_name=Groud_floor&epc_val=Y&date_epc_taken=%@&gas_certificate=dgsd&gas_reg_no=%@&certificate_serial_no=%@&gas_test_date=%@&elec_certificate=jsdh&elec_safe_test_date=%@",App_Domain_Url,uesrid,[_firstpagedata valueForKey:@"rel_to_property"],[_firstpagedata valueForKey:@"property_type"],[_firstpagedata valueForKey:@"current_status"],[_firstpagedata valueForKey:@"address1"],[_firstpagedata valueForKey:@"Latitude"],[_firstpagedata valueForKey:@"Longitude"],[_firstpagedata valueForKey:@"town"],[_firstpagedata valueForKey:@"county"],[_firstpagedata valueForKey:@"postcode"],[_firstpagedata valueForKey:@"address1"],[_firstpagedata valueForKey:@"no_of_beds"],[_firstpagedata valueForKey:@"no_of_baths"],[_firstpagedata valueForKey:@"no_of_rooms"],[_firstpagedata valueForKey:@"property_description"],[_firstpagedata valueForKey:@"property_full_description"],[_firstpagedata valueForKey:@"off_strt_parkng_flag"],[_firstpagedata valueForKey:@"garden_flag"],addingdate,[_secondpagedata valueForKey:@"video_code"],[_thirdpagedata valueForKey:@"date_epc_taken"],[_thirdpagedata valueForKey:@"gas_reg_no"],[_thirdpagedata valueForKey:@"certificate_serial_no"],[_thirdpagedata valueForKey:@"gas_test_date"],[_thirdpagedata valueForKey:@"elec_safe_test_date"]];
        NSLog(@"url %@",url);
        [spinner startAnimating];
        NSString* encodedUrl = [url stringByAddingPercentEscapesUsingEncoding:
                                NSUTF8StringEncoding];
        
        
        
        
        
        NSData *imgdata = UIImageJPEGRepresentation([_secondpagedata valueForKey:@"image1"], 90);
        [obj GlobalDict_image:encodedUrl Globalstr_image:@"array" globalimage:imgdata Withblock:^(id result, NSError *error)
         {
             
             NSLog(@"image return%@",result);
             
             if ([[result valueForKey:@"msg"] isEqualToString:@"You property registration has been done successfully"])
             {
                 UIStoryboard *stroy = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                 MPDashBoardViewController *dashboard  = [stroy instantiateViewControllerWithIdentifier:@"dashboard"];
                 
                 
                 [self.navigationController pushViewController:dashboard animated:YES];
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:[result valueForKey:@"msg"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 
                 [alert show];
             }
             
             
             
             [spinner startAnimating];
             [spinner removeFromSuperview];
             [polygonView removeFromSuperview];
         }];
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    NSLog(@"value...%@",_thirdpagedata);
    
    
    
}

- (IBAction)date1:(id)sender


{
    [gassafe resignFirstResponder];
    [cftserialtxt resignFirstResponder];
    ok=1;
    
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    
    
    if (screenBounds.size.height == 568 && screenBounds.size.width == 320)
    {
        
        CGRect rc=[scroll bounds];
        rc=[scroll convertRect:rc toView:scroll];
        CGPoint pt;
        pt=rc.origin;
        pt.x=0;
        pt.y=90;
        [scroll setContentOffset:pt animated:YES];
    }
    else
    {
        CGRect rc=[scroll bounds];
        rc=[scroll convertRect:rc toView:scroll];
        CGPoint pt;
        pt=rc.origin;
        pt.x=0;
        pt.y=40;
        [scroll setContentOffset:pt animated:YES];
    }
    
    [self datapick];
    data1btn.hidden=YES;
    scroll.scrollEnabled=NO;
    
    
    
}
- (IBAction)date2:(id)sender


{
    [gassafe resignFirstResponder];
    [cftserialtxt resignFirstResponder];
    ok=2;
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568 && screenBounds.size.width == 320)
    {
        
        CGRect rc=[scroll bounds];
        rc=[scroll convertRect:rc toView:scroll];
        CGPoint pt;
        pt=rc.origin;
        pt.x=0;
        pt.y=360;
        [scroll setContentOffset:pt animated:YES];
    }
    else
    {
        CGRect rc=[scroll bounds];
        rc=[scroll convertRect:rc toView:scroll];
        CGPoint pt;
        pt=rc.origin;
        pt.x=0;
        pt.y=250;
        [scroll setContentOffset:pt animated:YES];
    }
    
    [self datapick];
    data2btn.hidden=YES;
    scroll.scrollEnabled=NO;
    
    
}
- (IBAction)date3:(id)sender


{
    [gassafe resignFirstResponder];
    [cftserialtxt resignFirstResponder];
    
    ok=3;
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568 && screenBounds.size.width == 320)
    {
        
        CGRect rc=[scroll bounds];
        rc=[scroll convertRect:rc toView:scroll];
        CGPoint pt;
        pt=rc.origin;
        pt.x=0;
        pt.y=500;
        [scroll setContentOffset:pt animated:YES];
    }
    else
    {
        CGRect rc=[scroll bounds];
        rc=[scroll convertRect:rc toView:scroll];
        CGPoint pt;
        pt=rc.origin;
        pt.x=0;
        pt.y=400;
        [scroll setContentOffset:pt animated:YES];
    }
    
    
    
    [self datapick];
    data3btn.hidden=YES;
    data2btn.hidden=YES;
    scroll.scrollEnabled=NO;
    
}

- (IBAction)backbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)upldbtn1:(id)sender
{
    check=1;
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Choose option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Galary",
                            @"Camera",nil];
    
    [popup showInView:self.view];
    myview.hidden=YES;
    picker.hidden=YES;
    scroll.scrollEnabled=YES;
    data1btn.hidden=NO;
    data2btn.hidden = NO;
    data3btn.hidden = NO;
    [gassafe resignFirstResponder];
    [cftserialtxt resignFirstResponder];
}
-(IBAction)upldbtn2:(id)sender
{
    check=2;
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Choose option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Galary",
                            @"Camera",nil];
    
    [popup showInView:self.view];
    myview.hidden=YES;
    picker.hidden=YES;
    scroll.scrollEnabled=YES;
    data1btn.hidden=NO;
    data2btn.hidden = NO;
    data3btn.hidden = NO;
    [gassafe resignFirstResponder];
    [cftserialtxt resignFirstResponder];
}
-(IBAction)upldbtn3:(id)sender
{
    check=3;
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Choose option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Galary",
                            @"Camera",nil];
    
    [popup showInView:self.view];
    myview.hidden=YES;
    picker.hidden=YES;
    scroll.scrollEnabled=YES;
    data1btn.hidden=NO;
    data2btn.hidden = NO;
    data3btn.hidden = NO;
    [gassafe resignFirstResponder];
    [cftserialtxt resignFirstResponder];
}
-(IBAction)upldbtn4:(id)sender
{
    check=4;
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Choose option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Galary",
                            @"Camera",nil];
    
    [popup showInView:self.view];
    myview.hidden=YES;
    picker.hidden=YES;
    scroll.scrollEnabled=YES;
    data1btn.hidden=NO;
    data2btn.hidden = NO;
    data3btn.hidden = NO;
    [gassafe resignFirstResponder];
    [cftserialtxt resignFirstResponder];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (check==1)
    {
        images1 = [info valueForKey:UIImagePickerControllerOriginalImage];
        [imageview1 setImage:images1];
    }
    else if (check==2)
    {
        images2 = [info valueForKey:UIImagePickerControllerOriginalImage];
        [imageview2 setImage:images2];
    }
    
    else if (check==3)
    {
        images3 = [info valueForKey:UIImagePickerControllerOriginalImage];
        [imageview3 setImage:images3];
    }
    else if (check==4)
    {
        images4 = [info valueForKey:UIImagePickerControllerOriginalImage];
        [imageview4 setImage:images4];
    }
    [_imagePicker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [_imagePicker dismissViewControllerAnimated:YES completion:nil];
}
- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            _imagePicker.delegate=self;
            [self presentViewController:_imagePicker animated:YES completion:nil];
            _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            break;
        case 1:
            _imagePicker.delegate=self;
            [self presentViewController:_imagePicker animated:YES completion:nil];
            _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
            
        default:
            break;
    }
    
}

-(void)datapick
{
    
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    
    
    if (screenBounds.size.height == 568 && screenBounds.size.width == 320) {
        
        
        
        
        
        myview = [[UIView alloc] initWithFrame:CGRectMake(0, 300, self.view.bounds.size.width, self.view.bounds.size.height)];
        [myview setBackgroundColor:[UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:.7f]];
        
        
        picker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,10,self.view.bounds.size.width, self.view.bounds.size.height)];
        [picker setBackgroundColor:[UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:.7f]];
        [myview addSubview:picker];
        
        //[picker setBackgroundColor:[UIColor clearColor]];
        [picker setBackgroundColor: [UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:.7f]];
        
        picker.datePickerMode=UIDatePickerModeDate;
        //    picker.hidden=NO;
        picker.date=[NSDate date];
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(-15,225,187,42)];
        btn.backgroundColor=[UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:.7f];
        [btn setTitle: @"OK" forState: UIControlStateNormal];
        [btn addTarget:self action:@selector(ok:) forControlEvents:UIControlEventTouchUpInside];
        [picker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
        [myview addSubview:btn];
        
        
        UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(150,225,188,42)];
        btn1.backgroundColor=[UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:.7f];
        [btn1 addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 setTitle: @"CANCEL" forState: UIControlStateNormal];
        [myview addSubview:btn1];
        
        [self.view addSubview:myview];
        
    }
    else if(screenBounds.size.height == 667 && screenBounds.size.width == 375)
    {
        
        myview = [[UIView alloc] initWithFrame:CGRectMake(0, 400, self.view.bounds.size.width, self.view.bounds.size.height)];
        [myview setBackgroundColor:[UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:.7f]];
        
        
        picker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,10,self.view.bounds.size.width, self.view.bounds.size.height)];
        [picker setBackgroundColor:[UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:.7f]];
        [myview addSubview:picker];
        
        //[picker setBackgroundColor:[UIColor clearColor]];
        [picker setBackgroundColor: [UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:.7f]];
        
        picker.datePickerMode=UIDatePickerModeDate;
        //    picker.hidden=NO;
        picker.date=[NSDate date];
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0,225,190,40)];
        btn.backgroundColor=[UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:1];
        [btn setTitle: @"OK" forState: UIControlStateNormal];
        [btn addTarget:self action:@selector(ok:) forControlEvents:UIControlEventTouchUpInside];
        [picker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
        [myview addSubview:btn];
        
        
        UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(187,225,190,40)];
        btn1.backgroundColor=[UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:1];
        [btn1 addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 setTitle: @"CANCEL" forState: UIControlStateNormal];
        [myview addSubview:btn1];
        
        [self.view addSubview:myview];
        
    }
    
    
    else if(screenBounds.size.height == 480 && screenBounds.size.width == 320)
    {
        myview = [[UIView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, self.view.bounds.size.height)];
        [myview setBackgroundColor:[UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:1]];
        
        
        picker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,10,self.view.bounds.size.width, self.view.bounds.size.height)];
        [picker setBackgroundColor:[UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:1]];;
        [myview addSubview:picker];
        
        //[picker setBackgroundColor:[UIColor clearColor]];
        [picker setBackgroundColor: [UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:1]];;
        
        picker.datePickerMode=UIDatePickerModeDate;
        //    picker.hidden=NO;
        picker.date=[NSDate date];
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(-7,225,187,42)];
        btn.backgroundColor=[UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:1];
        [btn setTitle: @"OK" forState: UIControlStateNormal];
        [btn addTarget:self action:@selector(ok:) forControlEvents:UIControlEventTouchUpInside];
        [picker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
        [myview addSubview:btn];
        
        
        UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(150,225,188,42)];
        btn1.backgroundColor=[UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:1];
        [btn1 addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 setTitle: @"CANCEL" forState: UIControlStateNormal];
        [myview addSubview:btn1];
        
        [self.view addSubview:myview];
    }
    else
    {
        myview = [[UIView alloc] initWithFrame:CGRectMake(0, 450, self.view.bounds.size.width, self.view.bounds.size.height)];
        [myview setBackgroundColor:[UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:1]];
        
        
        picker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,10,self.view.bounds.size.width, self.view.bounds.size.height)];
        [picker setBackgroundColor:[UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:1]];
        [myview addSubview:picker];
        
        //[picker setBackgroundColor:[UIColor clearColor]];
        [picker setBackgroundColor: [UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:1]];
        
        picker.datePickerMode=UIDatePickerModeDate;
        //    picker.hidden=NO;
        picker.date=[NSDate date];
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(15,225,187,42)];
        btn.backgroundColor=[UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:1];
        [btn setTitle: @"OK" forState: UIControlStateNormal];
        [btn addTarget:self action:@selector(ok:) forControlEvents:UIControlEventTouchUpInside];
        [picker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
        [myview addSubview:btn];
        
        
        UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(210,225,188,42)];
        btn1.backgroundColor=[UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:1];
        [btn1 addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 setTitle: @"CANCEL" forState: UIControlStateNormal];
        [myview addSubview:btn1];
        
        [self.view addSubview:myview];
        
    }
    
}
-(void)ok:(id)sender
{
    scroll.scrollEnabled=YES;
    data2btn.hidden=NO;
    if (ok==1) {
        
        
        [self LabelTitle:sender];
        [picker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
        NSLog(@".....%@",strday);
        [self monthcheck];
        NSLog(@"date....%@",[NSString stringWithFormat:@"%@.%@.%@",strday,strmon,stryear]);
        
        dateEpclbl.text =[NSString stringWithFormat:@"%@.%@.%@",strday,strmon,stryear];
        data1btn.hidden=NO;
    }
    else  if (ok==2) {
        
        
        [self LabelTitle:sender];
        [picker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
        NSLog(@".....%@",strday);
        [self monthcheck];
        NSLog(@"date....%@",[NSString stringWithFormat:@"%@.%@.%@",strday,strmon,stryear]);
        
        gastestdata.text =[NSString stringWithFormat:@"%@.%@.%@",strday,strmon,stryear];
        data2btn.hidden=NO;
    }
    else if (ok==3) {
        
        
        [self LabelTitle:sender];
        [picker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
        NSLog(@".....%@",strday);
        [self monthcheck];
        NSLog(@"date....%@",[NSString stringWithFormat:@"%@.%@.%@",strday,strmon,stryear]);
        
        electricSafedatelbl.text =[NSString stringWithFormat:@"%@.%@.%@",strday,strmon,stryear];
        data3btn.hidden=NO;
    }
    //    CGRect rc=[scroll bounds];
    //    rc=[scroll convertRect:rc toView:scroll];
    //    CGPoint pt;
    //    pt=rc.origin;
    //    pt.x=0;
    //    pt.y=0;
    //    [scroll setContentOffset:pt animated:YES];
    
    myview.hidden=YES;
    picker.hidden=YES;
    
}
-(void)cancel:(id)sender
{
    scroll.scrollEnabled=YES;
    myview.hidden=YES;
    picker.hidden=YES;
    
    data1btn.hidden=NO;
    data2btn.hidden = NO;
    data3btn.hidden = NO;
    //
    //    CGRect rc=[scroll bounds];
    //    rc=[scroll convertRect:rc toView:scroll];
    //    CGPoint pt;
    //    pt=rc.origin;
    //    pt.x=0;
    //    pt.y=0;
    //    [scroll setContentOffset:pt animated:YES];
}

-(void)LabelTitle:(id)sender
{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"MMM/dd/yyyy"];
    strday=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:picker.date]];
    strmon=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:picker.date]];
    stryear=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:picker.date]];
    strday = [strday substringWithRange:NSMakeRange(4,2)];
    strmon = [strmon substringWithRange:NSMakeRange(0,3)];
    stryear = [stryear substringWithRange:NSMakeRange(7,4)];
    
}
-(void)monthcheck
{
    if ([strmon isEqualToString:@"Jan"]) {
        strmon=@"1";
    }
    else if ([strmon isEqualToString:@"Feb"]) {
        strmon=@"2";
    }
    else if ([strmon isEqualToString:@"Mar"]) {
        strmon=@"3";
    }
    else if ([strmon isEqualToString:@"Apr"]) {
        strmon=@"4";
    }
    else if ([strmon isEqualToString:@"May"]) {
        strmon=@"5";
    }
    else if ([strmon isEqualToString:@"Jun"]) {
        strmon=@"6";
    }
    else if ([strmon isEqualToString:@"Jul"]) {
        strmon=@"7";
    }
    else if ([strmon isEqualToString:@"Aug"]) {
        strmon=@"8";
    }
    else if ([strmon isEqualToString:@"Sep"]) {
        strmon=@"9";
    }
    else if ([strmon isEqualToString:@"Oct"]) {
        strmon=@"10";
    }
    else if ([strmon isEqualToString:@"Nov"]) {
        strmon=@"11";
    }
    else if ([strmon isEqualToString:@"Dec"]) {
        strmon=@"12";
    }
}


////textfield

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //    CGRect rc=[scroll bounds];
    //    rc=[scroll convertRect:rc toView:scroll];
    //    CGPoint pt;
    //    pt=rc.origin;
    //    pt.x=0;
    //    pt.y=0;
    //    [scroll setContentOffset:pt animated:YES];
    [textField resignFirstResponder];
    data1btn.hidden=NO;
    data2btn.hidden = NO;
    data3btn.hidden = NO;
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    data1btn.hidden=NO;
    data2btn.hidden = NO;
    data3btn.hidden = NO;
    
    myview.hidden=YES;
    picker.hidden=YES;
    scroll.scrollEnabled=YES;
    
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568 && screenBounds.size.width == 320)
    {
        if (textField== gassafe)
        {
            CGRect rc=[scroll bounds];
            rc=[scroll convertRect:rc toView:scroll];
            CGPoint pt;
            pt=rc.origin;
            pt.x=0;
            pt.y=300;
            [scroll setContentOffset:pt animated:YES];
            
        }
        else
        {
            CGRect rc=[scroll bounds];
            rc=[scroll convertRect:rc toView:scroll];
            CGPoint pt;
            pt=rc.origin;
            pt.x=0;
            pt.y=300;
            [scroll setContentOffset:pt animated:YES];
        }
        return YES;
    }
    else
    {
        CGRect rc=[scroll bounds];
        rc=[scroll convertRect:rc toView:scroll];
        CGPoint pt;
        pt=rc.origin;
        pt.x=0;
        pt.y=200;
        [scroll setContentOffset:pt animated:YES];
        return YES;
    }
    
}


@end
