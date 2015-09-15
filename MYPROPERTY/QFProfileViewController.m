//
//  QFProfileViewController.m
//  MYPROPERTY
//
//  Created by Somenath on 03/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "QFProfileViewController.h"
#import "Footer.h"

@interface QFProfileViewController ()<footerdelegate>
{
    IBOutlet UIButton *bkbtn;
    IBOutlet UILabel *toplbl;
    IBOutlet UIImageView *topbar;
    
}

@end

@implementation QFProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    countryArry = [[NSMutableArray alloc]init];
    picker.hidden=YES;
    pview.hidden = YES;
    [pview addSubview:picker];
    [self.view addSubview:pview];
    
    userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"country"]!=NULL)
    {
        countrylbl.text =[[NSUserDefaults standardUserDefaults] objectForKey:@"country"];
    }
    else
    {
        countrylbl.text =@"Country";
    }
    
    
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
        
    {
        pview.frame = CGRectMake(0, 390, 320, 200);
        toplbl.frame =CGRectMake(60, 23, 221, 35);
        scrollView.frame=CGRectMake(0, 60, 320,568);
        [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 790)];
        
    }
    
    
    
    
    else  if (screenBounds.size.height == 667  && screenBounds.size.width == 375)
    {
        
        
        topbar.frame=CGRectMake(0, 0, 375, 70);
        bkbtn.frame = CGRectMake(0, 0, 66, 70);
        toplbl.frame =CGRectMake(80, 30, 221, 25);
        scrollView.frame=CGRectMake(0, 70, 375,667);
        [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 800)];
        
        
    }
    else if (screenBounds.size.height ==736  && screenBounds.size.width == 414)
    {
        topbar.frame=CGRectMake(0, 0, 414, 78);
        bkbtn.frame = CGRectMake(0, 0, 66, 78);
        toplbl.frame =CGRectMake(80, 30, 221, 25);
        pview.frame = CGRectMake(0, 500, 414, 300);
        
        scrollView.frame=CGRectMake(0, 78, 414,736);
        [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 800)];
        
    }
    
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    
    // [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 710)];
    //}
    //    else if (screenBounds.size.height == 667   && screenBounds.size.width == 375)
    //    {
    //         [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 800)];
    //    }
    //    else
    //    {
    //        [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 900)];
    //    }
    
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
    updatebtn.layer.cornerRadius=3;
    _addresstextview.delegate = self;
    _addresstextview.autocorrectionType = UITextAutocorrectionTypeNo;
    scrollView.delegate=self;
    obj = [[FW_JsonClass alloc]init];
    Footer *footer=[[Footer alloc]init];
    //NSString *Value = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_nicename"];
    nameUpdate.text =[[NSUserDefaults standardUserDefaults] objectForKey:@"user_nicename"];
    emailUpdate.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_email"];
    //phonenoUpdate.text = [[NSUserDefaults standardUserDefaults]objectForKey:@""];
    userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
    namelbl.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_nicename"];
    phonenoUpdate.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    pincodetext.text =[[NSUserDefaults standardUserDefaults] objectForKey:@"post_code"];
    towntxt.text =[[NSUserDefaults standardUserDefaults] objectForKey:@"town"];
    
    
    
    _addresstextview.text =[[NSUserDefaults standardUserDefaults] objectForKey:@"address"];
    
    //    [footer setFrame:CGRectMake(0, self.view.frame.size.height - 60, self.view.frame.size.width, 60)];
    
    addresslbl.hidden=NO;
    
    if (_addresstextview.text.length>0)
    {
        addresslbl.hidden=YES;
    }
    
    footer.footerdelegate=self;
    [footer TapCheck:5];
    //    [self.view addSubview:footer];
    
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

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
    
    
    
    pview.hidden=YES;
    picker.hidden=YES;
    scrollView.scrollEnabled = YES;
    // textView.autocorrectionType = UITextAutocorrectionTypeNo;
    
    
    addresslbl.hidden=YES;
    
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    
    if (screenBounds.size.height == 736  && screenBounds.size.width == 414)
    {
        
        [scrollView setContentOffset:CGPointMake(0.0f, 100.0f) animated:YES];
        
        
    }
    
    else
    {
        
        [scrollView setContentOffset:CGPointMake(0.0f, 200.0f) animated:YES];
        
        
    }
    
    
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    pview.hidden=YES;
    picker.hidden=YES;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    
    
    if (textField ==phonenoUpdate)
    {
        
        if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
            
        {
            [scrollView setContentOffset:CGPointMake(0.0f, 90.0f) animated:YES];
            
        }
        
        else if(screenBounds.size.height == 667  && screenBounds.size.width == 375)
            
        {
            
            [scrollView setContentOffset:CGPointMake(0.0f, 90.0f) animated:YES];
            
            
        }
        else if (screenBounds.size.height == 736  && screenBounds.size.width == 414)
        {
            
            
            
            
        }
        
        
        
        
    }
    if (textField ==nameUpdate)
    {
        if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
            
        {
            [scrollView setContentOffset:CGPointMake(0.0f, 20.0f) animated:YES];
            
        }
        
        else if(screenBounds.size.height == 667  && screenBounds.size.width == 375)
            
        {
            [scrollView setContentOffset:CGPointMake(0.0f, 20.0f) animated:YES];
            
            
        }
        else if (screenBounds.size.height == 736  && screenBounds.size.width == 414)
        {
            
            
            
            
        }
        
        
        
        
        
    }
    
    
    if (textField ==emailUpdate)
    {
        if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
            
        {
            [scrollView setContentOffset:CGPointMake(0.0f, 70.0f) animated:YES];
            
        }
        
        else if(screenBounds.size.height == 667  && screenBounds.size.width == 375)
            
        {
            
            [scrollView setContentOffset:CGPointMake(0.0f, 70.0f) animated:YES];
            
        }
        else if (screenBounds.size.height == 736  && screenBounds.size.width == 414)
        {
            
            
            
            
        }
        
        
        
        
    }
    
    if (textField== pincodetext)
    {
        if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
            
        {
            [scrollView setContentOffset:CGPointMake(0.0f, 360.0f) animated:YES];
            
        }
        
        else if(screenBounds.size.height == 667  && screenBounds.size.width == 375)
            
        {
            
            [scrollView setContentOffset:CGPointMake(0.0f, 360.0f) animated:YES];
            
        }
        else if (screenBounds.size.height == 736  && screenBounds.size.width == 414)
        {
            
            
            [scrollView setContentOffset:CGPointMake(0.0f, 260.0f) animated:YES];
            
        }
        
        
        
    }
    
    if (textField == towntxt)
    {
        if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
            
        {
            [scrollView setContentOffset:CGPointMake(0.0f, 260.0f) animated:YES];
            
        }
        
        else if(screenBounds.size.height == 667  && screenBounds.size.width == 375)
            
        {
            
            [scrollView setContentOffset:CGPointMake(0.0f, 260.0f) animated:YES];
            
        }
        else if (screenBounds.size.height == 736  && screenBounds.size.width == 414)
        {
            
            
            [scrollView setContentOffset:CGPointMake(0.0f, 160.0f) animated:YES];
            
        }
        
        
    }
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"])
    {
        
        
        CGRect screenBounds=[[UIScreen mainScreen] bounds];
        if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
            
        {
            [scrollView setContentOffset:CGPointMake(0.0f, 225.0f) animated:YES];
            
        }
        
        else if(screenBounds.size.height == 667  && screenBounds.size.width == 375)
            
        {
            
            [scrollView setContentOffset:CGPointMake(0.0f, 150.0f) animated:YES];
            
        }
        else if (screenBounds.size.height == 736  && screenBounds.size.width == 414)
        {
            
            [scrollView setContentOffset:CGPointMake(0.0f, 78.0f) animated:YES];
            
            
        }
        
        if (textView.text.length==0)
        {
            addresslbl.hidden=NO;
            
            
        }
        
        
        
        
        
        [textView resignFirstResponder];
        return YES;
        
    }
    
    
    
    return YES;
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    if (_addresstextview.text.length==0)
    {
        addresslbl.hidden=NO;
        
        
    }
    
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    if (textField ==pincodetext)
    {
        
        if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
            
        {
            [scrollView setContentOffset:CGPointMake(0.0f, 225.0f) animated:YES];
            
        }
        
        else if(screenBounds.size.height == 667  && screenBounds.size.width == 375)
            
        {
            
            [scrollView setContentOffset:CGPointMake(0.0f, 150.0f) animated:YES];
            
        }
        else if (screenBounds.size.height == 736  && screenBounds.size.width == 414)
        {
            
            [scrollView setContentOffset:CGPointMake(0.0f, 78.0f) animated:YES];
            
            
        }
        
        
        
    }
    
    if (textField ==towntxt)
    {
        if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
            
        {
            [scrollView setContentOffset:CGPointMake(0.0f, 225.0f) animated:YES];
            
        }
        
        else if(screenBounds.size.height == 667  && screenBounds.size.width == 375)
            
        {
            
            [scrollView setContentOffset:CGPointMake(0.0f, 150.0f) animated:YES];
            
        }
        else if (screenBounds.size.height == 736  && screenBounds.size.width == 414)
        {
            
            [scrollView setContentOffset:CGPointMake(0.0f, 78.0f) animated:YES];
            
            
        }
    }
    
    [textField resignFirstResponder];
    scrollView.scrollEnabled = YES;
    
    return YES;
}

- (IBAction)okbtn:(id)sender {
    
    
    
    
    countrylbl.text= holedata;
    
    
    pview.hidden=YES;
    picker.hidden=YES;
    scrollView.scrollEnabled = YES;
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
        
    {
        CGRect rc=[scrollView bounds];
        rc=[scrollView convertRect:rc toView:scrollView];
        CGPoint pt;
        pt=rc.origin;
        pt.x=0;
        pt.y=200;
        
        [scrollView setContentOffset:pt animated:YES];
        
    }
    
    else if(screenBounds.size.height == 667  && screenBounds.size.width == 375)
        
    {
        
        
        CGRect rc=[scrollView bounds];
        rc=[scrollView convertRect:rc toView:scrollView];
        CGPoint pt;
        pt=rc.origin;
        pt.x=0;
        pt.y=100;
        
        [scrollView setContentOffset:pt animated:YES];
    }
    else if (screenBounds.size.height == 736  && screenBounds.size.width == 414)
    {
        
        CGRect rc=[scrollView bounds];
        rc=[scrollView convertRect:rc toView:scrollView];
        CGPoint pt;
        pt=rc.origin;
        pt.x=0;
        pt.y=78;
        
        [scrollView setContentOffset:pt animated:YES];
        
        
    }
    
}

- (IBAction)countryBtn:(id)sender
{
    pview.hidden=YES;
    picker.hidden=YES;
    
    countrybtn.hidden=YES;
    [phonenoUpdate resignFirstResponder];
    [nameUpdate resignFirstResponder];
    [towntxt resignFirstResponder];
    [pincodetext resignFirstResponder];
    [emailUpdate resignFirstResponder];
    [_addresstextview resignFirstResponder];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    self.view.frame=CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [UIView commitAnimations];
    
    
    
    NSString *curl = [NSString stringWithFormat:@"http://esolzdemos.com/lab1/countries-object-array.json"];
    countrylbl.text=@"Loading Countrys.....";
    
    [obj GlobalDict:curl Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         
         
         countryArry = [result valueForKey:@"name"];
         picker.delegate=self;
         picker.dataSource=self;
         
         
         if (countryArry.count!=0) {
             
             countrylbl.text = @"Choose Country";
             pview.hidden=NO;
             picker.hidden=NO;
             CGRect screenBounds=[[UIScreen mainScreen] bounds];
             if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
                 
             {
                 CGRect rc=[scrollView bounds];
                 rc=[scrollView convertRect:rc toView:scrollView];
                 CGPoint pt;
                 pt=rc.origin;
                 pt.x=0;
                 pt.y=270;
                 
                 [scrollView setContentOffset:pt animated:YES];
                 
             }
             
             else if(screenBounds.size.height == 667  && screenBounds.size.width == 375)
                 
             {
                 
                 
                 CGRect rc=[scrollView bounds];
                 rc=[scrollView convertRect:rc toView:scrollView];
                 CGPoint pt;
                 pt=rc.origin;
                 pt.x=0;
                 pt.y=210;
                 
                 [scrollView setContentOffset:pt animated:YES];
             }
             else if (screenBounds.size.height == 736  && screenBounds.size.width == 414)
             {
                 
                 CGRect rc=[scrollView bounds];
                 rc=[scrollView convertRect:rc toView:scrollView];
                 CGPoint pt;
                 pt=rc.origin;
                 pt.x=0;
                 pt.y=260;
                 
                 [scrollView setContentOffset:pt animated:YES];
                 
                 
             }
             else{
                 
                 CGRect rc=[scrollView bounds];
                 rc=[scrollView convertRect:rc toView:scrollView];
                 CGPoint pt;
                 pt=rc.origin;
                 pt.x=0;
                 pt.y=150;
                 
                 [scrollView setContentOffset:pt animated:YES];
                 
             }
             scrollView.scrollEnabled = NO;
             countrybtn.hidden=NO;
         }
         else
         {
             countrylbl.text =@"Select Country";
             countrybtn.hidden = NO;
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Faild"   message:@"Country Loading Faild"   delegate:self cancelButtonTitle:@"OK"  otherButtonTitles:nil];
             
             
             [alert show];
         }
     }];
    
    
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    
    // countrylbl.text=countryArry[0];
    holedata = [[NSString alloc] initWithFormat:
                @"%@", [countryArry objectAtIndex:row]];
    NSLog(@"%@", holedata);
}


- (IBAction)cancelbtn:(id)sender {
    
    
    pview.hidden=YES;
    picker.hidden=YES;
    scrollView.scrollEnabled = YES;
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
        
    {
        CGRect rc=[scrollView bounds];
        rc=[scrollView convertRect:rc toView:scrollView];
        CGPoint pt;
        pt=rc.origin;
        pt.x=0;
        pt.y=200;
        
        [scrollView setContentOffset:pt animated:YES];
        
    }
    
    else if(screenBounds.size.height == 667  && screenBounds.size.width == 375)
        
    {
        
        
        CGRect rc=[scrollView bounds];
        rc=[scrollView convertRect:rc toView:scrollView];
        CGPoint pt;
        pt=rc.origin;
        pt.x=0;
        pt.y=100;
        
        [scrollView setContentOffset:pt animated:YES];
    }
    else if (screenBounds.size.height == 736  && screenBounds.size.width == 414)
    {
        
        CGRect rc=[scrollView bounds];
        rc=[scrollView convertRect:rc toView:scrollView];
        CGPoint pt;
        pt=rc.origin;
        pt.x=0;
        pt.y=78;
        
        [scrollView setContentOffset:pt animated:YES];
        
        
    }
    
    
    
}

-(IBAction)update:(id)sender
{
    NSLog(@"Tap");
    
    if ([self TarminateWhiteSpace:nameUpdate.text].length==0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Enter Name"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil,nil];
        [alert show];
    }
    else if ([self TarminateWhiteSpace:emailUpdate.text].length==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Enter Mailid"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil,nil];
        [alert show];
    }
    
    else{
        NSString *cnty = countrylbl.text;
        NSString *addrs = [_addresstextview text];
        
        NSString *url = [NSString stringWithFormat:@"%@json_output.php?mode=update_profile_details&user_id=%@&user_name=%@&address=%@&town=%@&post_code=%@&country=%@&phone=%@&address=%@&email=%@",App_Domain_Url,userid,[nameUpdate text],addrs,[towntxt text],[pincodetext text],cnty,[phonenoUpdate text],addrs,[emailUpdate text]];
        
        NSString* encodedUrl = [url stringByAddingPercentEscapesUsingEncoding:
                                NSUTF8StringEncoding];
        [obj GlobalDict:encodedUrl Globalstr:@"array" Withblock:^(id result, NSError *error)
         {
             
             NSLog(@"result....%@",result);
             NSMutableArray *arry;
             arry = [result mutableCopy];
             
             if ([[arry valueForKey:@"email_error"] isEqualToString:@"email id exists"])
             {
                 
                 
                 
                 
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[arry valueForKey:@"email_error"]
                                                                 message:@"Change mail id"
                                                                delegate:self
                                                       cancelButtonTitle:@"Cancel"
                                                       otherButtonTitles:nil,nil];
                 [alert show];
                 
                 NSString *url1 = [NSString stringWithFormat:@"%@json_output.php?mode=profile_details&user_id=%@",App_Domain_Url,userid];
                 
                 NSString* encodedUrl = [url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                 
                 [obj GlobalDict:encodedUrl Globalstr:@"array" Withblock:^(id result, NSError *error)
                  
                  {
                      
                      
                      
                      
                      
                      
                      
                      //chng somthing
                      
                      // NSMutableArray *temp =[[NSMutableArray alloc]init];
                      NSMutableArray *temp;
                      
                      temp= [result mutableCopy];
                      
                      [self resetDefaults];
                      userinfo=[[NSUserDefaults alloc]init];
                      
                      NSLog(@"userdetails%@",temp);
                      
                      
                      
                      [userinfo setValue:[temp valueForKey:@"id"] forKey:@"id"];
                      
                      [userinfo setValue:[temp valueForKey:@"user_email"] forKey:@"user_email"];
                      
                      [userinfo setValue:[temp valueForKey:@"user_nicename"] forKey:@"user_nicename"];
                      
                      [userinfo setValue:[temp valueForKey:@"user_registered"] forKey:@"user_registered"];
                      
                      [userinfo setValue:[temp valueForKey:@"address"] forKey:@"address"];
                      
                      [userinfo setValue:[temp valueForKey:@"country"] forKey:@"country"];
                      
                      [userinfo setValue:[temp valueForKey:@"town"] forKey:@"town"];
                      
                      [userinfo setValue:[temp valueForKey:@"post_code"] forKey:@"post_code"];
                      
                      [userinfo setValue:[temp valueForKey:@"phone"] forKey:@"phone"];
                      
                      [userinfo synchronize];
                      
                      
                      
                      NSString *Value = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_nicename"];
                      
                      NSLog(@"userinfo-%@",Value);
                      
                      namelbl.text = [arry valueForKey:@"user_name"];
                      nameUpdate.text = [arry valueForKey:@"user_name"];
                      _addresstextview.text = [arry valueForKey:@"address"];
                      emailUpdate.text = [arry valueForKey:@"user_email"];
                      towntxt.text = [arry valueForKey:@"town"];
                      phonenoUpdate.text = [arry valueForKey:@"phone"];
                      countrylbl.text = [arry valueForKey:@"country"];
                      pincodetext.text=[arry valueForKey:@"post_code"];
                      
                  }];
                 
                 
             }
             
             else
             {
                 
                 
                 
                 
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                 message:[arry valueForKey:@"msg"]
                                                                delegate:self
                                                       cancelButtonTitle:@"Cancel"
                                                       otherButtonTitles:nil,nil];
                 [alert show];
                 
                 
                 NSString *url1 = [NSString stringWithFormat:@"%@json_output.php?mode=profile_details&user_id=%@",App_Domain_Url,userid];
                 
                 NSString* encodedUrl = [url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                 
                 [obj GlobalDict:encodedUrl Globalstr:@"array" Withblock:^(id result, NSError *error)
                  
                  {
                      
                      
                      
                      
                      
                      
                      
                      //chng something
                      
                      // NSMutableArray *temp =[[NSMutableArray alloc]init];
                      
                      
                      NSMutableArray *temp;
                      temp= [result mutableCopy];
                      
                      [self resetDefaults];
                      userinfo=[[NSUserDefaults alloc]init];
                      
                      NSLog(@"userdetails%@",temp);
                      
                      
                      
                      [userinfo setValue:[temp valueForKey:@"id"] forKey:@"id"];
                      
                      [userinfo setValue:[temp valueForKey:@"user_email"] forKey:@"user_email"];
                      
                      [userinfo setValue:[temp valueForKey:@"user_nicename"] forKey:@"user_nicename"];
                      
                      [userinfo setValue:[temp valueForKey:@"user_registered"] forKey:@"user_registered"];
                      
                      [userinfo setValue:[temp valueForKey:@"address"] forKey:@"address"];
                      
                      [userinfo setValue:[temp valueForKey:@"country"] forKey:@"country"];
                      
                      [userinfo setValue:[temp valueForKey:@"town"] forKey:@"town"];
                      
                      [userinfo setValue:[temp valueForKey:@"post_code"] forKey:@"post_code"];
                      
                      [userinfo setValue:[temp valueForKey:@"phone"] forKey:@"phone"];
                      
                      [userinfo synchronize];
                      
                      
                      
                      NSString *Value = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_nicename"];
                      
                      NSLog(@"userinfo-%@",Value);
                      
                      namelbl.text = [arry valueForKey:@"user_name"];
                      nameUpdate.text = [arry valueForKey:@"user_name"];
                      _addresstextview.text = [arry valueForKey:@"address"];
                      emailUpdate.text = [arry valueForKey:@"user_email"];
                      towntxt.text = [arry valueForKey:@"town"];
                      phonenoUpdate.text = [arry valueForKey:@"phone"];
                      countrylbl.text = [arry valueForKey:@"country"];
                      pincodetext.text=[arry valueForKey:@"post_code"];
                      
                  }];
                 
                 
                 
                 
                 
             }
             
             
             
             
         }];
    }
    
}

- (void)resetDefaults {
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
}


-(NSString *)TarminateWhiteSpace:(NSString *)Str
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [Str stringByTrimmingCharactersInSet:whitespace];
    return trimmed;
}

//pickerview

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 1;
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return countryArry.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)
component
{
    
    return countryArry[row];
}


@end
