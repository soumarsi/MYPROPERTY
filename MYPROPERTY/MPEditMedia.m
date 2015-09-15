//
//  MPEditMedia.m
//  MYPROPERTY
//
//  Created by Somenath on 14/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "MPEditMedia.h"
#import "UIImageView+WebCache.h"

@interface MPEditMedia ()
{
    IBOutlet UIButton *bkbtn;
    IBOutlet UILabel *toplbl;
    IBOutlet UIImageView *topbar;
    
}

@end

@implementation MPEditMedia

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568  && screenBounds.size.width == 320)
    {
        toplbl.frame =CGRectMake(60, 23, 221, 35);
        scroll.frame=CGRectMake(0, 60, 320,568);
        [scroll setContentSize:CGSizeMake(self.view.frame.size.width, 849)];
    }
    
    else  if (screenBounds.size.height == 667  && screenBounds.size.width == 375)
    {
        
        
        topbar.frame=CGRectMake(0, 0, 375, 70);
        bkbtn.frame = CGRectMake(0, 0, 66, 70);
        toplbl.frame =CGRectMake(85, 30, 221, 25);
        scroll.frame=CGRectMake(0, 70, 375,667);
        [scroll setContentSize:CGSizeMake(self.view.frame.size.width, 859)];
        
        
    }
    else if (screenBounds.size.height ==736  && screenBounds.size.width == 414)
    {
        topbar.frame=CGRectMake(0, 0, 414, 78);
        bkbtn.frame = CGRectMake(0, 0, 66, 78);
        toplbl.frame =CGRectMake(85, 30, 221, 25);
        
        
        scroll.frame=CGRectMake(0, 78, 414,736);
        [scroll setContentSize:CGSizeMake(self.view.frame.size.width, 867)];
        
    }

    _imagePicker = [[UIImagePickerController alloc]init];
    [scroll setShowsHorizontalScrollIndicator:NO];
    [scroll setShowsVerticalScrollIndicator:NO];
    
    // obj = [[FW_JsonClass alloc]init];
    _thirdpagedata = [[NSMutableDictionary alloc]init];
    
   // trucksArray = [[NSMutableArray alloc]init];
    uesrid = [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
    
    //  submitbtn.layer.cornerRadius = 3;
    NSLog(@"firpage data%@",_firstpagedata);
    //    NSLog(@"Second dic.....%@",_data1);
    //    NSLog(@"Second dic.....%@",_data2);
    NSLog(@"json result......%@",_jsonresult);
    
    
    
    [imageview1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[_jsonresult valueForKey:@"Floorplan_name"]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
    
    [imageview2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[_jsonresult valueForKey:@"epc_val"]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
    
    [imageview3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[_jsonresult valueForKey:@"gas_certificate"]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
    
    [imageview4 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[_jsonresult valueForKey:@"elec_certificate"]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
    
    
    
    
    
    
    
    
    
    
    //    UIView *polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
    //    polygonView.backgroundColor=[UIColor blackColor];
    //    polygonView.alpha=0.3;
    //    [self.view addSubview:polygonView];
    //    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //    spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
    //
    //    [polygonView addSubview:spinner];
    //
    //
    //    NSOperationQueue *myQueue = [[NSOperationQueue alloc] init];
    //    [spinner startAnimating];
    //    [myQueue addOperationWithBlock:^{
    //
    //        //    if ([[_jsonresult valueForKey:@"Floorplan_name"] isEqualToString:@"http://esolz.co.in/lab6/myproperty/wp-content/uploads/property_documents/"])
    //        //    {
    //        //        NSLog(@"working================");
    //        //    }
    //        //
    //        //    else
    //        //    {
    //
    //
    //
    //
    //
    //        [ima sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[detail_dic valueForKey:@"property_media"]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
    //
    //        NSURL *url=[NSURL URLWithString:[_jsonresult valueForKey:@"Floorplan_name"]];
    //        NSLog(@"k.........%@",url);
    //        NSData *imgdata = [NSData dataWithContentsOfURL:url];
    //        UIImage *image = [UIImage imageWithData:imgdata];
    //
    //        //  }
    //
    //        NSURL *url1=[NSURL URLWithString:[_jsonresult valueForKey:@"epc_val"]];
    //        NSLog(@"k.........%@",url1);
    //        NSData *imgdata1 = [NSData dataWithContentsOfURL:url1];
    //        UIImage *image1 = [UIImage imageWithData:imgdata1];
    //
    //
    //        NSURL *url2=[NSURL URLWithString:[_jsonresult valueForKey:@"gas_certificate"]];
    //        NSLog(@"k.........%@",url2);
    //        NSData *imgdata2 = [NSData dataWithContentsOfURL:url2];
    //        UIImage *image2 = [UIImage imageWithData:imgdata2];
    //
    //
    //        NSURL *url3=[NSURL URLWithString:[_jsonresult valueForKey:@"elec_certificate"]];
    //        NSLog(@"k.........%@",url3);
    //        NSData *imgdata3 = [NSData dataWithContentsOfURL:url3];
    //        UIImage *image3 = [UIImage imageWithData:imgdata3];
    //
    //
    //
    //
    //
    //        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
    //
    //            imageview1.image=image;
    //            imageview2.image=image1;
    //            imageview3.image=image2;
    //            imageview4.image=image3;
    //
    //
    //
    //
    //
    //            [spinner stopAnimating];
    //            [polygonView removeFromSuperview];
    //        }];
    //    }];
    //
    
    //
    //    NSURL *url1=[NSURL URLWithString:[_jsonresult valueForKey:@"epc_val"]];
    //
    //    NSData *imgdata1 = [NSData dataWithContentsOfURL:url1];
    //    UIImage *image1 = [UIImage imageWithData:imgdata1];
    //    imageview2.image=image1;
    //
    //    NSURL *url2=[NSURL URLWithString:[_jsonresult valueForKey:@"gas_certificate"]];
    //    NSLog(@"k.........%@",url);
    //    NSData *imgdata2 = [NSData dataWithContentsOfURL:url2];
    //    UIImage *image2 = [UIImage imageWithData:imgdata2];
    //    imageview3.image=image2;
    //
    //    NSURL *url3=[NSURL URLWithString:[_jsonresult valueForKey:@"elec_certificate"]];
    //    NSLog(@"k.........%@",url);
    //    NSData *imgdata3 = [NSData dataWithContentsOfURL:url3];
    //    UIImage *image3 = [UIImage imageWithData:imgdata3];
    //    imageview4.image=image3;
    
    
    if ((NSNull *)[self.jsonresult valueForKey:@"date_epc_taken"]== [NSNull null])
        
    {
        
        dateEpclbl.text = @"";
        
    }
    
    else
        
    {
        
        dateEpclbl.text = [self.jsonresult valueForKey:@"date_epc_taken"];
        
    }
    if ((NSNull *)[self.jsonresult valueForKey:@"elec_safe_test_date"]== [NSNull null])
        
    {
        
        electricSafedatelbl.text = @"";
        
    }
    
    else
        
    {
        
        electricSafedatelbl.text = [self.jsonresult valueForKey:@"elec_safe_test_date"];
        
    }
    if ((NSNull *)[self.jsonresult valueForKey:@"gas_test_date"]== [NSNull null])
        
    {
        
        gastestdata.text = @"";
        
    }
    
    else
        
    {
        
        gastestdata.text = [self.jsonresult valueForKey:@"gas_test_date"];
        
    }
    
    if ((NSNull *)[self.jsonresult valueForKey:@"gas_reg_no"]== [NSNull null])
        
    {
        
        gassafe.text = @"";
        
    }
    
    else
        
    {
        
        gassafe.text = [self.jsonresult valueForKey:@"gas_reg_no"];
        
    }
    
    if ((NSNull *)[self.jsonresult valueForKey:@"certificate_serial_no"]== [NSNull null])
        
    {
        
        cftserialtxt.text = @"";
        
    }
    
    else
        
    {
        
        cftserialtxt.text = [self.jsonresult valueForKey:@"certificate_serial_no"];
        
    }
    
    
    
    
    
    
    
    
    
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
    //    NSLog(@"image arry.....%@",imageArry);
    //
    //    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    //
    //    NSInteger day = [components day];
    //    NSInteger week = [components month];
    //    NSInteger year = [components year];
    //
    //    NSString *addingdate = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)year, (long)week, (long)day];
    
    
    UIView *polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
    polygonView.backgroundColor=[UIColor blackColor];
    polygonView.alpha=0.3;
    [self.view addSubview:polygonView];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
    
    [polygonView addSubview:spinner];
    
    [spinner startAnimating];
    
    
    //    if (images1!=NULL && images2!=NULL && images3!=NULL && images4!=NULL)
    //    {
    //
    NSLog(@"if");
    
    
    [_thirdpagedata setObject:dateEpclbl.text forKey:@"date_epc_taken"];
    [_thirdpagedata setObject:gassafe.text forKey:@"gas_reg_no"];
    [_thirdpagedata setObject:cftserialtxt.text forKey:@"certificate_serial_no"];
    [_thirdpagedata setObject:gastestdata.text forKey:@"gas_test_date"];
    [_thirdpagedata setObject:electricSafedatelbl.text forKey:@"elec_safe_test_date"];
    
    NSOperationQueue *myQueue11 = [[NSOperationQueue alloc] init];
    
    [myQueue11 addOperationWithBlock:^{
        
        
        
        NSString *displayaddress = [NSString stringWithFormat:@"%@,%@,%@",[_firstpagedata valueForKey:@"town"],[_firstpagedata valueForKey:@"county"],[_firstpagedata valueForKey:@"address1"] ];
        
        
        
        
        
        NSString *parameter = [NSString stringWithFormat:@"%@json_output.php?mode=edit_property_details&property_id=%@&added_by=%@&rel_to_property=%@&property_type=%@  &current_status=%@  &house_name=%@&address1=%@ &latitude=%@&longitude=%@&town=%@&county=%@  &country=Y  &postcode=%@  &display_addr=%@&no_of_beds=%@&no_of_baths=%@&no_of_rooms=%@   &property_description=%@&property_full_description=%@&off_strt_parkng_flag=%@&garden_flag=%@  &video_code=%@  &Floorplan_name=Groud_floor&epc_val=&date_epc_taken=%@  &gas_certificate=&gas_reg_no=%@&certificate_serial_no=%@&gas_test_date=%@  &elec_certificate=&elec_safe_test_date=%@",App_Domain_Url,
                               [_jsonresult valueForKey:@"id"],
                               uesrid,
                               [_firstpagedata valueForKey:@"rel_to_property"],
                               [_firstpagedata valueForKey:@"property_type"],
                               [_firstpagedata valueForKey:@"current_status"],
                               [_firstpagedata valueForKey:@"address1"],
                               [_firstpagedata valueForKey:@"address1"],
                               [_jsonresult valueForKey:@"latitude"],
                               [_jsonresult valueForKey:@"longitude"],
                               [_firstpagedata valueForKey:@"town"],
                               [_firstpagedata valueForKey:@"county"],
                               [_firstpagedata valueForKey:@"postcode"],
                               displayaddress,
                               [_firstpagedata valueForKey:@"no_of_beds"],
                               [_firstpagedata valueForKey:@"no_of_baths"],
                               [_firstpagedata valueForKey:@"no_of_rooms"],
                               [_firstpagedata valueForKey:@"property_description"],
                               [_firstpagedata valueForKey:@"property_full_description"],
                               [_firstpagedata valueForKey:@"off_strt_parkng_flag"],
                               [_firstpagedata valueForKey:@"garden_flag"],
                               _secondpagevideocode,
                               [_thirdpagedata valueForKey:@"date_epc_taken"],
                               [_thirdpagedata valueForKey:@"gas_reg_no"],
                               [_thirdpagedata valueForKey:@"certificate_serial_no"],
                               [_thirdpagedata valueForKey:@"gas_test_date"],
                               [_thirdpagedata valueForKey:@"elec_safe_test_date"]];
        NSString* encodedUrl = [parameter stringByAddingPercentEscapesUsingEncoding:
                                NSUTF8StringEncoding];
        
        
        NSLog(@"parameter=%@",parameter);
        
        
        
        
        
        
        
        if (_firstpagedata.count > 0)
            
        {
            NSLog(@"truck array count >0");
            
            
            
            AFHTTPClient *client= [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:encodedUrl]];
            
            
            
            
            
            
            NSMutableURLRequest *request = [client multipartFormRequestWithMethod:@"POST" path:nil parameters:nil constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
                
                
                if (images1 !=NULL)
                {
                    imageData5 = UIImagePNGRepresentation(images1);
                    
                    [formData appendPartWithFileData:imageData5 name:@"Floorplan_name" fileName:@"temp.jpeg" mimeType:@"image/jpeg"];
                    // NSLog(@"Image1.......%@",imageData5);
                }
                
                if (images2!=NULL)
                {
                    imageData6 = UIImagePNGRepresentation(images2);
                    [formData appendPartWithFileData:imageData6 name:@"epc_val" fileName:@"temp.jpeg" mimeType:@"image/jpeg"];
                    // NSLog(@"Image2.......%@",imageData6);
                    
                }
                if (images3!=NULL)
                {
                    imageData7=UIImagePNGRepresentation(images3);
                    
                    [formData appendPartWithFileData:imageData7 name:@"gas_certificate" fileName:@"temp.jpeg" mimeType:@"image/jpeg"];
                    // NSLog(@"Image3.......%@",imageData7);
                }
                
                if (images4!=NULL)
                {
                    imageData8=UIImagePNGRepresentation(images4);
                    
                    [formData appendPartWithFileData:imageData8 name:@"elec_certificate" fileName:@"temp.jpeg" mimeType:@"image/jpeg"];
                    //NSLog(@"Image4.......%@",imageData8);
                }
                
                
                if (_data1>0)
                {
                    
                    [formData appendPartWithFileData:_data1 name:@"media1" fileName:@"temp.jpeg" mimeType:@"image/jpeg"];
                    NSLog(@"kausik1============ %@",_data1);
                }
                
                if (_data2>0)
                {
                    
                    
                    [formData appendPartWithFileData:_data2 name:@"media2" fileName:@"temp.jpeg" mimeType:@"image/jpeg"];
                    NSLog(@"kausik2============ %@",_data2);
                }
                if (_data3>0)
                {
                    
                    [formData appendPartWithFileData:_data3 name:@"media3" fileName:@"temp.jpeg" mimeType:@"image/jpeg"];
                    NSLog(@"kausik3============ %@",_data3);                }
                
                if (_data4>0)
                {
                    
                    [formData appendPartWithFileData:_data4 name:@"media4" fileName:@"temp.jpeg" mimeType:@"image/jpeg"];
                    NSLog(@"kausik3============ %@",_data4);
                }
                if (_data5>0)
                {
                    
                    
                    [formData appendPartWithFileData:_data5 name:@"media5" fileName:@"temp.jpeg" mimeType:@"image/jpeg"];
                    NSLog(@"kausik4============ %@",_data5);
                }
                
                
                
                
                
                
                
                
                
            }];
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
            
            
            
            
            
            
            
            [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _operation, id responseObject) {
                
                
                
                
                
                
                
                NSString *response = [_operation responseString];
                
                
                
                
                
                
                
                NSLog(@"response:.... %@",response);
                
                NSError *error;
                
                NSString *dictString=[NSString stringWithFormat:@"%@", response];//or ur dict reference..
                
                NSData *jsonData = [dictString dataUsingEncoding:NSUTF8StringEncoding];
                
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData
                                      
                                                                     options:NSJSONReadingMutableContainers
                                      
                                                                       error:&error];
                
                
                NSLog(@"json.....%@",json);
                [spinner stopAnimating];
                [polygonView removeFromSuperview];
                
                
                if ([[json valueForKey:@"msg"]isEqualToString:@"You property registration has been successfully updated"])
                {
                    
                    MPMyPropertyViewController *property = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"myproperty"];
                    
                    
                    property.datachangestring=@"data change";
                    
                    [self.navigationController pushViewController:property animated:YES];
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:[json valueForKey:@"msg"]delegate:self   cancelButtonTitle:@"OK"  otherButtonTitles:nil];
                    [alert show];
                    
                }
                
                else
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Faild" message:@"Update Faild" delegate:self   cancelButtonTitle:@"OK"  otherButtonTitles:nil];
                    [alert show];
                }
                
                
                
            } failure:^(AFHTTPRequestOperation * _operation, NSError *error) {
                
                
                
                
                
                
                
                if([_operation.response statusCode] == 403){
                    
                    
                    
                    
                    
                    //  [self checkLoader];
                    
                    NSLog(@"Upload Failed");
                    
                    
                    
                    
                    
                    
                    
                    return;
                    
                    
                    
                    
                    
                    
                    
                }
                
                
                
                
                
                
                
            }];
            
            
            
            
            
            
            
            [operation start];
            
        }
        
        /* else if (_secondpagedata.count==0)
         {
         
         NSLog(@"truck array count >0");
         
         
         
         AFHTTPClient *client= [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:encodedUrl]];
         
         
         
         
         
         
         NSMutableURLRequest *request = [client multipartFormRequestWithMethod:@"POST" path:nil parameters:nil constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
         
         
         
         if (_data1 !=NULL)
         {
         
         [formData appendPartWithFileData:_data1 name:@"media1" fileName:@"temp.jpeg" mimeType:@"image/jpeg"];
         NSLog(@"kausik1============ %@",_data1);
         }
         
         if (_data2 !=NULL)
         {
         
         
         [formData appendPartWithFileData:_data2 name:@"media2" fileName:@"temp.jpeg" mimeType:@"image/jpeg"];
         NSLog(@"kausik2============ %@",_data2);
         }
         if (_data3 !=NULL)
         {
         
         [formData appendPartWithFileData:_data3 name:@"media3" fileName:@"temp.jpeg" mimeType:@"image/jpeg"];
         NSLog(@"kausik3============ %@",_data3);                }
         
         if (_data4 !=NULL)
         {
         
         [formData appendPartWithFileData:_data4 name:@"media4" fileName:@"temp.jpeg" mimeType:@"image/jpeg"];
         NSLog(@"kausik4============ %@",_data4);
         }
         if (_data5 !=NULL)
         {
         
         
         [formData appendPartWithFileData:_data5 name:@"media5" fileName:@"temp.jpeg" mimeType:@"image/jpeg"];
         NSLog(@"kausik5============ %@",_data5);
         }
         
         
         
         
         
         if (images1 !=NULL)
         {
         imageData5 = UIImagePNGRepresentation(images1);
         
         [formData appendPartWithFileData:imageData5 name:@"Floorplan_name" fileName:@"temp.jpeg" mimeType:@"image/jpeg"];
         // NSLog(@"Image1.......%@",imageData5);
         }
         
         if (images2!=NULL)
         {
         imageData6 = UIImagePNGRepresentation(images2);
         [formData appendPartWithFileData:imageData6 name:@"epc_val" fileName:@"temp.jpeg" mimeType:@"image/jpeg"];
         // NSLog(@"Image2.......%@",imageData6);
         
         }
         if (images3!=NULL)
         {
         imageData7=UIImagePNGRepresentation(images3);
         
         [formData appendPartWithFileData:imageData7 name:@"gas_certificate" fileName:@"temp.jpeg" mimeType:@"image/jpeg"];
         // NSLog(@"Image3.......%@",imageData7);
         }
         
         if (images4!=NULL)
         {
         imageData8=UIImagePNGRepresentation(images4);
         
         [formData appendPartWithFileData:imageData8 name:@"elec_certificate" fileName:@"temp.jpeg" mimeType:@"image/jpeg"];
         //NSLog(@"Image4.......%@",imageData8);
         }
         
         
         
         
         
         
         
         
         
         }];
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
         
         
         
         
         
         
         
         [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _operation, id responseObject) {
         
         
         
         
         
         
         
         NSString *response = [_operation responseString];
         
         
         
         
         
         
         
         NSLog(@"response:.... %@",response);
         
         NSError *error;
         
         NSString *dictString=[NSString stringWithFormat:@"%@", response];//or ur dict reference..
         
         NSData *jsonData = [dictString dataUsingEncoding:NSUTF8StringEncoding];
         
         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData
         
         options:NSJSONReadingMutableContainers
         
         error:&error];
         
         
         NSLog(@"json.....%@",json);
         [spinner stopAnimating];
         [polygonView removeFromSuperview];
         
         
         if ([[json valueForKey:@"msg"]isEqualToString:@"You property registration has been successfully updated"])
         {
         
         MPMyPropertyViewController *property = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"myproperty"];
         
         
         
         
         [self.navigationController pushViewController:property animated:YES];
         
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:[json valueForKey:@"msg"]delegate:self   cancelButtonTitle:@"OK"  otherButtonTitles:nil];
         [alert show];
         
         }
         
         else
         {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Faild" message:@"Update Faild" delegate:self   cancelButtonTitle:@"OK"  otherButtonTitles:nil];
         [alert show];
         }
         
         
         
         } failure:^(AFHTTPRequestOperation * _operation, NSError *error) {
         
         
         
         
         
         
         
         if([_operation.response statusCode] == 403){
         
         
         
         
         
         //  [self checkLoader];
         
         NSLog(@"Upload Failed");
         
         
         
         
         
         
         
         return;
         
         
         
         
         
         
         
         }
         
         
         
         
         
         
         
         }];
         
         
         
         
         
         
         
         [operation start];
         
         
         }
         */
        else
            
        {
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            
            
            
            [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
            
            
            
            [request setHTTPShouldHandleCookies:NO];
            
            
            
            [request setURL:[NSURL URLWithString:parameter]];
            
            
            
            [request setTimeoutInterval:100];
            
            
            
            [request setHTTPMethod:@"POST"];
            
            
            
            
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                
                
                NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
                
                
                
                if( connection )
                    
                {
                    
                    mutableData = [[NSMutableData alloc] init];
                    
                    
                    
                }
                
                
                
            }];
            
        }
        
        
        
        
        
        
        
        
        
    }];
    
    
    
}
















- (IBAction)date1:(id)sender


{
    [myview removeFromSuperview];
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
    //  [self OpenDatePicker];
    
    scroll.scrollEnabled=NO;
    
    
    
}
- (IBAction)date2:(id)sender


{
    [myview removeFromSuperview];
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
    
    scroll.scrollEnabled=NO;
    
    
}
- (IBAction)date3:(id)sender


{
    [myview removeFromSuperview];
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
    
    [gassafe resignFirstResponder];
    [cftserialtxt resignFirstResponder];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    if (check==1)
    {
        images1 = [info valueForKey:UIImagePickerControllerOriginalImage];
        UIImage *tempimg = [ImageResize imageWithImage:images1 scaledToSize:CGSizeMake(120,150)];
        
        [imageview1 setImage:tempimg];
        
       images1= [ImageResize imageWithImage:images1 scaledToSize:CGSizeMake(450,300)];

        
        
        
        
    }
    else if (check==2)
    {
        images2 = [info valueForKey:UIImagePickerControllerOriginalImage];
        UIImage *tempimg = [ImageResize imageWithImage:images2 scaledToSize:CGSizeMake(120,150)];
        
        [imageview2 setImage:tempimg];
        
        images2= [ImageResize imageWithImage:images2 scaledToSize:CGSizeMake(450,300)];
        
    }
    
    else if (check==3)
    {
        images3 = [info valueForKey:UIImagePickerControllerOriginalImage];
        
        UIImage *tempimg = [ImageResize imageWithImage:images3 scaledToSize:CGSizeMake(120,150)];
        
        [imageview3 setImage:tempimg];
        
        images3= [ImageResize imageWithImage:images3 scaledToSize:CGSizeMake(450,300)];
    }
    else if (check==4)
    {
        images4 = [info valueForKey:UIImagePickerControllerOriginalImage];
        
        UIImage *tempimg = [ImageResize imageWithImage:images4 scaledToSize:CGSizeMake(120,150)];
        
        [imageview4 setImage:tempimg];
        
        images4= [ImageResize imageWithImage:images4 scaledToSize:CGSizeMake(450,300)];
        
        scroll.scrollEnabled =YES;
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
            if (check==4 || check==3)
            {
                
                CGRect screenBounds=[[UIScreen mainScreen] bounds];
                if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
                {
                    [scroll setContentOffset:CGPointMake(0.0f, 280.0f) animated:YES];
                    
                }
                else if(screenBounds.size.height == 667 && screenBounds.size.width == 375)
                {
                    [scroll setContentOffset:CGPointMake(0.0f, 182.0f) animated:YES];
                }
                else
                {
                    [scroll setContentOffset:CGPointMake(0.0f, 110.0f) animated:YES];
                }
            }
            
            break;
        case 1:
            _imagePicker.delegate=self;
            [self presentViewController:_imagePicker animated:YES completion:nil];
            _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            if (check==4 || check==3)
            {
                
                CGRect screenBounds=[[UIScreen mainScreen] bounds];
                if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
                {
                    [scroll setContentOffset:CGPointMake(0.0f, 280.0f) animated:YES];
                    
                }
                else if(screenBounds.size.height == 667 && screenBounds.size.width == 375)
                {
                    [scroll setContentOffset:CGPointMake(0.0f, 182.0f) animated:YES];
                }
                else
                {
                    [scroll setContentOffset:CGPointMake(0.0f, 110.0f) animated:YES];
                }
            }
            
            break;
            
        default:
            
            if (check==4 || check==3)
            {
                
                CGRect screenBounds=[[UIScreen mainScreen] bounds];
                if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
                {
                    [scroll setContentOffset:CGPointMake(0.0f, 280.0f) animated:YES];
                    
                }
                else if(screenBounds.size.height == 667 && screenBounds.size.width == 375)
                {
                    [scroll setContentOffset:CGPointMake(0.0f, 182.0f) animated:YES];
                }
                else
                {
                    [scroll setContentOffset:CGPointMake(0.0f, 110.0f) animated:YES];
                }
            }
            //[scroll setContentOffset:CGPointMake(0.0f, 300.0f) animated:YES];
            scroll.scrollEnabled =YES;
            
            break;
    }
    
}


-(void)datapick
{
    
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    
    
    if (screenBounds.size.height == 568 && screenBounds.size.width == 320) {
        
        
        
        
        
        myview = [[UIView alloc] initWithFrame:CGRectMake(0, 300, self.view.bounds.size.width, self.view.bounds.size.height)];
        // [myview setBackgroundColor:[UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:.7f]];
        myview.backgroundColor = [UIColor lightGrayColor];
        
        
        picker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,10,self.view.bounds.size.width, self.view.bounds.size.height)];
        //[picker setBackgroundColor:[UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:.7f]];
        picker.backgroundColor = [UIColor lightGrayColor];
        [myview addSubview:picker];
        
        //[picker setBackgroundColor:[UIColor clearColor]];
        //[picker setBackgroundColor: [UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:.7f]];
        
        picker.datePickerMode=UIDatePickerModeDate;
        //    picker.hidden=NO;
        picker.date=[NSDate date];
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(-15,225,187,42)];
        //btn.backgroundColor=[UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:.7f];
        btn.backgroundColor=[UIColor blackColor];
        [btn setTitle: @"OK" forState: UIControlStateNormal];
        [btn addTarget:self action:@selector(ok:) forControlEvents:UIControlEventTouchUpInside];
        [picker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
        [myview addSubview:btn];
        
        
        UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(150,225,188,42)];
        btn1.backgroundColor=[UIColor blackColor];
        [btn1 addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 setTitle: @"CANCEL" forState: UIControlStateNormal];
        [myview addSubview:btn1];
        
        [self.view addSubview:myview];
        
    }
    else if(screenBounds.size.height == 667 && screenBounds.size.width == 375)
    {
        
        myview = [[UIView alloc] initWithFrame:CGRectMake(0, 400, self.view.bounds.size.width, self.view.bounds.size.height)];
        // [myview setBackgroundColor:[UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:.7f]];
        myview.backgroundColor = [UIColor lightGrayColor];
        
        picker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,10,self.view.bounds.size.width, self.view.bounds.size.height)];
        //[picker setBackgroundColor:[UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:.7f]];
        picker.backgroundColor = [UIColor lightGrayColor];
        [myview addSubview:picker];
        
        //[picker setBackgroundColor:[UIColor clearColor]];
        // [picker setBackgroundColor: [UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:.7f]];
        
        picker.datePickerMode=UIDatePickerModeDate;
        //    picker.hidden=NO;
        picker.date=[NSDate date];
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0,225,190,40)];
        btn.backgroundColor=[UIColor blackColor];
        [btn setTitle: @"OK" forState: UIControlStateNormal];
        [btn addTarget:self action:@selector(ok:) forControlEvents:UIControlEventTouchUpInside];
        [picker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
        [myview addSubview:btn];
        
        
        UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(187,225,190,40)];
        btn1.backgroundColor=[UIColor blackColor];
        [btn1 addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 setTitle: @"CANCEL" forState: UIControlStateNormal];
        [myview addSubview:btn1];
        
        [self.view addSubview:myview];
        
    }
    
    
    else if(screenBounds.size.height == 480 && screenBounds.size.width == 320)
    {
        myview = [[UIView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, self.view.bounds.size.height)];
        // [myview setBackgroundColor:[UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:1]];
        myview.backgroundColor = [UIColor lightGrayColor];
        
        picker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,10,self.view.bounds.size.width, self.view.bounds.size.height)];
        //[picker setBackgroundColor:[UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:1]];;
        picker.backgroundColor = [UIColor lightGrayColor];
        
        [myview addSubview:picker];
        
        //[picker setBackgroundColor:[UIColor clearColor]];
        [picker setBackgroundColor: [UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:1]];;
        
        picker.datePickerMode=UIDatePickerModeDate;
        //    picker.hidden=NO;
        picker.date=[NSDate date];
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(-7,225,187,42)];
        // btn.backgroundColor=[UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:1];
        btn.backgroundColor=[UIColor blackColor];
        [btn setTitle: @"OK" forState: UIControlStateNormal];
        [btn addTarget:self action:@selector(ok:) forControlEvents:UIControlEventTouchUpInside];
        [picker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
        [myview addSubview:btn];
        
        
        UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(150,225,188,42)];
        // btn1.backgroundColor=[UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:1];
        btn1.backgroundColor=[UIColor blackColor];
        [btn1 addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 setTitle: @"CANCEL" forState: UIControlStateNormal];
        [myview addSubview:btn1];
        
        [self.view addSubview:myview];
    }
    else
    {
        myview = [[UIView alloc] initWithFrame:CGRectMake(0, 450, self.view.bounds.size.width, self.view.bounds.size.height)];
        //[myview setBackgroundColor:[UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:1]];
        myview.backgroundColor = [UIColor lightGrayColor];
        
        
        picker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,10,self.view.bounds.size.width, self.view.bounds.size.height)];
        //[picker setBackgroundColor:[UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:1]];
        picker.backgroundColor = [UIColor lightGrayColor];
        [myview addSubview:picker];
        
        //[picker setBackgroundColor:[UIColor clearColor]];
        //  [picker setBackgroundColor: [UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:1]];
        
        picker.datePickerMode=UIDatePickerModeDate;
        //    picker.hidden=NO;
        picker.date=[NSDate date];
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(15,225,187,42)];
        //  btn.backgroundColor=[UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:1];
        btn.backgroundColor=[UIColor blackColor];
        [btn setTitle: @"OK" forState: UIControlStateNormal];
        [btn addTarget:self action:@selector(ok:) forControlEvents:UIControlEventTouchUpInside];
        [picker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
        [myview addSubview:btn];
        
        
        UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(210,225,188,42)];
        //btn1.backgroundColor=[UIColor colorWithRed:(58.0f/255.0f) green:(85.0f/255.0f) blue:(140.0f/255.0f) alpha:1];
        btn1.backgroundColor=[UIColor blackColor];
        [btn1 addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 setTitle: @"CANCEL" forState: UIControlStateNormal];
        [myview addSubview:btn1];
        
        [self.view addSubview:myview];
        
    }
    
}
-(void)ok:(id)sender
{
    scroll.scrollEnabled=YES;
    [myview removeFromSuperview];
    
    
    if (ok==1) {
        
        
        [self LabelTitle:sender];
        [picker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
        NSLog(@".....%@",strday);
        [self monthcheck];
        NSLog(@"date....%@",[NSString stringWithFormat:@"%@-%@-%@",stryear,strmon,strday]);
        
        dateEpclbl.text =[NSString stringWithFormat:@"%@-%@-%@",stryear,strmon,strday];
        
    }
    else  if (ok==2) {
        
        
        [self LabelTitle:sender];
        [picker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
        NSLog(@".....%@",strday);
        [self monthcheck];
        NSLog(@"date....%@",[NSString stringWithFormat:@"%@-%@-%@",strday,strmon,stryear]);
        
        gastestdata.text =[NSString stringWithFormat:@"%@-%@-%@",stryear,strmon,strday];
        CGRect screenBounds=[[UIScreen mainScreen] bounds];
        if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
        {
            [scroll setContentOffset:CGPointMake(0.0f, 280.0f) animated:YES];
            
        }
        else if(screenBounds.size.height == 667 && screenBounds.size.width == 375)
        {
            [scroll setContentOffset:CGPointMake(0.0f, 182.0f) animated:YES];
        }
        else
        {
            [scroll setContentOffset:CGPointMake(0.0f, 110.0f) animated:YES];
        }
        
    }
    else if (ok==3) {
        
        
        [self LabelTitle:sender];
        [picker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
        NSLog(@".....%@",strday);
        [self monthcheck];
        NSLog(@"date....%@",[NSString stringWithFormat:@"%@-%@-%@",stryear,strmon,strday]);
        
        electricSafedatelbl.text =[NSString stringWithFormat:@"%@-%@-%@",stryear,strmon,strday];
        CGRect screenBounds=[[UIScreen mainScreen] bounds];
        if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
        {
            [scroll setContentOffset:CGPointMake(0.0f, 280.0f) animated:YES];
            
        }
        else if(screenBounds.size.height == 667 && screenBounds.size.width == 375)
        {
            [scroll setContentOffset:CGPointMake(0.0f, 182.0f) animated:YES];
        }
        else
        {
            [scroll setContentOffset:CGPointMake(0.0f, 110.0f) animated:YES];
        }
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
    
    [myview removeFromSuperview];
    
    if ( ok==3 || ok ==2)
    {
        
        
        CGRect screenBounds=[[UIScreen mainScreen] bounds];
        if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
        {
            [scroll setContentOffset:CGPointMake(0.0f, 280.0f) animated:YES];
            
        }
        else if(screenBounds.size.height == 667 && screenBounds.size.width == 375)
        {
            [scroll setContentOffset:CGPointMake(0.0f, 182.0f) animated:YES];
        }
        else
        {
            [scroll setContentOffset:CGPointMake(0.0f, 110.0f) animated:YES];
        }
        
    }
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
    //[scroll setContentOffset:CGPointMake(0.0f, 400.0f) animated:YES];
    [textField resignFirstResponder];
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
    {
        [scroll setContentOffset:CGPointMake(0.0f, 280.0f) animated:YES];
        
    }
    else if(screenBounds.size.height == 667 && screenBounds.size.width == 375)
    {
        [scroll setContentOffset:CGPointMake(0.0f, 182.0f) animated:YES];
    }
    else
    {
        [scroll setContentOffset:CGPointMake(0.0f, 110.0f) animated:YES];
        return YES;
    }
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    
    
    
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
    return YES;
    
}


/*
 -(void)OpenDatePicker
 {
 myview = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - self.view.frame.size.height * .45, self.view.frame.size.width, self.view.frame.size.height * .45)];
 
 myview.backgroundColor = [UIColor lightGrayColor];
 
 UIButton *okbtn=[[UIButton alloc]initWithFrame:CGRectMake(0, myview.frame.size.height - 40, myview.frame.size.width/2, 40)];
 UIButton *cancelbtn=[[UIButton alloc]initWithFrame:CGRectMake(myview.frame.size.width/2, myview.frame.size.height - 40, myview.frame.size.width/2, 40)];
 cancelbtn.backgroundColor=[UIColor darkGrayColor];
 [cancelbtn setTitle:@"Cancel" forState:UIControlStateNormal];
 [cancelbtn setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1] forState:UIControlStateNormal];
 
 [myview addSubview:cancelbtn];
 [myview addSubview:okbtn];
 okbtn.backgroundColor=[UIColor darkGrayColor];
 [okbtn setTitle:@"Ok" forState:UIControlStateNormal];
 [okbtn setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1] forState:UIControlStateNormal];
 
 [okbtn addTarget:self action:@selector(okDateAction) forControlEvents:UIControlEventTouchUpInside];
 
 [cancelbtn addTarget:self action:@selector(cancelDateAction) forControlEvents:UIControlEventTouchUpInside];
 
 picker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, myview.frame.size.height - okbtn.frame.size.height)];
 //    [datepicker sizeToFit];
 [picker setDatePickerMode:UIDatePickerModeDate];
 [picker setMinimumDate:[NSDate date]];
 
 [myview addSubview:picker];
 [self.view addSubview:myview];
 }
 
 -(void)okDateAction
 {
 [myview removeFromSuperview];
 NSDateFormatter *dateFormator=[[NSDateFormatter alloc] init];
 [dateFormator setDateFormat:@"dd-MM-YYYY"];
 //    [dateFormator setDateFormat:@"YYYY-MM-dd"];
 NSString *datenew=[dateFormator stringFromDate:picker.date];
 // [self.datelbl setText:datenew];
 NSLog(@"date...%@",datenew);
 }
 
 -(void) cancelDateAction
 {
 [myview removeFromSuperview];
 }
 
 - (IBAction)dateAvailableTapped:(id)sender
 {
 NSLog(@"pickUpDateTapped");
 
 [myview removeFromSuperview];
 [picker removeFromSuperview];
 [self OpenDatePicker];
 }
 */


@end
