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

@end

@implementation QFProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    countryArry = [[NSMutableArray alloc]init];
    picker.hidden=YES;
    pview.hidden = YES;
    [pview addSubview:picker];
    [self.view addSubview:pview];
    
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
        
    {
        pview.frame = CGRectMake(0, 390, 320, 200);
        
    }
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 710)];
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
    scrollView.delegate=self;
    obj = [[FW_JsonClass alloc]init];
    Footer *footer=[[Footer alloc]init];
    //NSString *Value = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_nicename"];
    nameUpdate.text =[[NSUserDefaults standardUserDefaults] objectForKey:@"user_nicename"];
    emailUpdate.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_email"];
    //phonenoUpdate.text = [[NSUserDefaults standardUserDefaults]objectForKey:@""];
    userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
    namelbl.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_nicename"];
    pincodetext.text =[[NSUserDefaults standardUserDefaults] objectForKey:@"post_code"];
    towntxt.text =[[NSUserDefaults standardUserDefaults] objectForKey:@"town"];
    countrylbl.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"country"];
    _addresstextview.text =[[NSUserDefaults standardUserDefaults] objectForKey:@"address"];
    
    //    [footer setFrame:CGRectMake(0, self.view.frame.size.height - 60, self.view.frame.size.width, 60)];
    
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

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    pview.hidden=YES;
    picker.hidden=YES;
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    
    if (textView==_addresstextview) {
        
        addresslbl.hidden=YES;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        self.view.frame=CGRectMake(0, -170, self.view.bounds.size.width, self.view.bounds.size.height);
        [UIView commitAnimations];
        
    }
    return  YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    pview.hidden=YES;
    picker.hidden=YES;
    
    if (textField ==phonenoUpdate)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        self.view.frame=CGRectMake(0, -90, self.view.bounds.size.width, self.view.bounds.size.height);
        [UIView commitAnimations];
        return YES;
    }
    else if (textField ==nameUpdate)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        self.view.frame=CGRectMake(0, -20, self.view.bounds.size.width, self.view.bounds.size.height);
        [UIView commitAnimations];
        return YES;
    }
    
    
    else if (textField ==emailUpdate)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        self.view.frame=CGRectMake(0,-60, self.view.bounds.size.width, self.view.bounds.size.height);
        [UIView commitAnimations];
        return YES;
    }
    
    else if (textField== pincodetext)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        self.view.frame=CGRectMake(0,-200, self.view.bounds.size.width, self.view.bounds.size.height);
        [UIView commitAnimations];
        return YES;
    }
    
    else if (textField == towntxt)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        self.view.frame=CGRectMake(0,-180, self.view.bounds.size.width, self.view.bounds.size.height);
        [UIView commitAnimations];
        return YES;
    }
    else
    {
        return YES;
    }
    return nil;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"])
    {
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        self.view.frame=CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        [UIView commitAnimations];
        
        [textView resignFirstResponder];
        return YES;
        
    }
    
    
    return YES;
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    if (textField ==phonenoUpdate)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        self.view.frame=CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        [UIView commitAnimations];
    }
    else
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        self.view.frame=CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        [UIView commitAnimations];
    }
    [textField resignFirstResponder];
    
    
    return YES;
}

- (IBAction)okbtn:(id)sender {
    
    
    
    
    countrylbl.text= holedata;
    
    pview.hidden=YES;
    picker.hidden=YES;
    scrollView.scrollEnabled = YES;
    CGRect rc=[scrollView bounds];
    rc=[scrollView convertRect:rc toView:scrollView];
    CGPoint pt;
    pt=rc.origin;
    pt.x=0;
    pt.y=0;
    
    [scrollView setContentOffset:pt animated:YES];
    
}

- (IBAction)countryBtn:(id)sender
{
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
    
    
    [obj GlobalDict:curl Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         
         
         countryArry = [result valueForKey:@"name"];
         picker.delegate=self;
         picker.dataSource=self;
         
         
         if (countryArry.count!=0) {
             
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
                 pt.y=175;
                 
                 [scrollView setContentOffset:pt animated:YES];
             }
             else if (screenBounds.size.height == 736  && screenBounds.size.width == 414)
             {
                 
                 CGRect rc=[scrollView bounds];
                 rc=[scrollView convertRect:rc toView:scrollView];
                 CGPoint pt;
                 pt=rc.origin;
                 pt.x=0;
                 pt.y=200;
                 
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
         }
     }];
    
    
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    
    holedata = [[NSString alloc] initWithFormat:
                @"%@", [countryArry objectAtIndex:row]];
    NSLog(@"%@", holedata);
}


- (IBAction)cancelbtn:(id)sender {
    
    
    pview.hidden=YES;
    picker.hidden=YES;
    scrollView.scrollEnabled = YES;
    CGRect rc=[scrollView bounds];
    rc=[scrollView convertRect:rc toView:scrollView];
    CGPoint pt;
    pt=rc.origin;
    pt.x=0;
    pt.y=0;
    
    [scrollView setContentOffset:pt animated:YES];
    
    
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
             }
             
             else
             {
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                 message:[arry valueForKey:@"msg"]
                                                                delegate:self
                                                       cancelButtonTitle:@"Cancel"
                                                       otherButtonTitles:nil,nil];
                 [alert show];
             }
             
             
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
