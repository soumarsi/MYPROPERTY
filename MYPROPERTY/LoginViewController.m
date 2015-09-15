//
//  LoginViewController.m
//  MYPROPERTY
//
//  Created by soumyajit on 06/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "LoginViewController.h"
#import "ViewController.h"
#import "ForgotPassword.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    userinfo=[[NSUserDefaults alloc]init];
    obj = [[FW_JsonClass alloc]init];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectCD:) name:@"no_internet" object:nil];
    spinnerview.hidden=YES;
    spinner.hidden=YES;
    check=YES;
    _emailtext.delegate=self;
    _passwordtext.delegate=self;
    _emailtext.autocorrectionType = UITextAutocorrectionTypeNo;
    _passwordtext.autocorrectionType = UITextAutocorrectionTypeNo;
    [_emailtext setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_passwordtext setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    if(screenBounds.size.height == 667 && screenBounds.size.width == 375)
    {
        NSLog(@"iphone 6");
        _label1.frame = CGRectMake(110, 225, 108, 18);
        [_label1 setFont: [UIFont fontWithName:@"Helvetica Bold" size:17.0]];
        _label2.frame = CGRectMake(214, 225, 108, 18);
        [_label2 setFont: [UIFont fontWithName:@"Helvetica" size:17.0]];
        _label3.frame =CGRectMake(68, 245, 265, 18);
        [_label3 setFont: [UIFont fontWithName:@"Helvetica" size:18.0]];
        
    }
    else if(screenBounds.size.height == 736 && screenBounds.size.width == 414)
    {
        NSLog(@"iphone 6+");
        _label1.frame = CGRectMake(120, 255, 108, 18);
        [_label1 setFont: [UIFont fontWithName:@"Helvetica Bold" size:18.0]];
        _label2.frame = CGRectMake(229, 255, 108, 18);
        [_label2 setFont: [UIFont fontWithName:@"Helvetica" size:18.0]];
        _label3.frame =CGRectMake(73, 274, 270, 21);
        [_label3 setFont: [UIFont fontWithName:@"Helvetica" size:19.0]];
        
    }
    
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)connectCD:(NSNotification *)note
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Faild"   message:@"Connection Faild!" delegate:self  cancelButtonTitle:@"Cancel" otherButtonTitles:nil,nil];
    [alert show];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)signupbackbutton:(id)sender
{
    //[self.navigationController popToRootViewControllerAnimated:YES];
    [UIView  beginAnimations: @"Showinfo"context: nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    [self.navigationController popViewControllerAnimated:YES];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
}
- (IBAction)clickLogin:(id)sender
{
    
    
    if ([self Emailtest:_emailtext.text])
    {
        _emailtext.text=@"";
        
        
        NSAttributedString *nn3=[[NSAttributedString alloc]initWithString:@"Please Enter email-id" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        _emailtext.attributedPlaceholder=nn3;
        
    }
    else if (_passwordtext.text.length<6)
    {
        _passwordtext.text=@"";
        NSAttributedString *nn3=[[NSAttributedString alloc]initWithString:@"Enter min 6 digit password" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        _passwordtext.attributedPlaceholder=nn3;
        
        
    }
    else if ([self TarminateWhiteSpace:_passwordtext.text].length==0)
    {
        
        _passwordtext.text=@"";
        NSAttributedString *nn3=[[NSAttributedString alloc]initWithString:@"Please Enter Password" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        _passwordtext.attributedPlaceholder=nn3;
        
    }
    else
    {
        
        
            spinner.hidden=NO;
            spinnerview.hidden=NO;
            [spinner startAnimating];
            
            NSString *url = [NSString stringWithFormat:@"%@json_output.php?mode=wp_check_email_password&user_login=%@&user_password=%@",App_Domain_Url,[_emailtext text], [_passwordtext text] ];
            
            
            
            NSString *login=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            [obj GlobalDict:login Globalstr:@"array" Withblock:^(id result, NSError *error)
             {
                 if ([[result valueForKey:@"message"]isEqualToString:@"successfully logged in"])
                 {
                     _Arry1 =[[NSMutableArray alloc]init];
                     _Arry1=[result mutableCopy];
                     
                     
                     
                     _userid=[_Arry1 valueForKey:@"user_id"];
                     
                     NSLog(@"userid%@",_userid);
                     
                     
                     SearchViewController *srch = (SearchViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"searchView"];
                     
                     
                     
                     [self.navigationController pushViewController:srch animated:YES];
                     
                     NSString *url1 = [NSString stringWithFormat:@"%@json_output.php?mode=profile_details&user_id=%@",App_Domain_Url,_userid];
                     
                     NSString* encodedUrl = [url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                     
                     
                     
                     
                     
                     
                     
                     [obj GlobalDict:encodedUrl Globalstr:@"array" Withblock:^(id result, NSError *error)
                      
                      {
                          
                          
                          
                          
                          
                          
                          
                          //chng something
                          
                         // NSMutableArray *temp =[[NSMutableArray alloc]init];
                          
                          
                          NSMutableArray *temp;
                          temp= [result mutableCopy];
                          
                          
                          
                          NSLog(@"userdetails%@",temp);
                          
                          
                          
                          [userinfo setValue:[temp valueForKey:@"id"] forKey:@"id"];
                          
                          [userinfo setValue:[temp valueForKey:@"user_email"] forKey:@"user_email"];
                          
                          [userinfo setValue:[temp valueForKey:@"user_nicename"] forKey:@"user_nicename"];
                          
                          [userinfo setValue:[temp valueForKey:@"user_registered"] forKey:@"user_registered"];
                          
                          [userinfo setValue:[temp valueForKey:@"address"] forKey:@"address"];
                          
                          [userinfo setValue:[temp valueForKey:@"country"] forKey:@"country"];
                          
                          [userinfo setValue:[temp valueForKey:@"town"] forKey:@"town"];
                          
                          [userinfo setValue:[temp valueForKey:@"post_code"] forKey:@"post_code"];
                          
                          
                          
                          [userinfo synchronize];
                          
                          
                          
                          NSString *Value = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_nicename"];
                          
                          NSLog(@"userinfo-%@",Value);
                          
                          
                          
                      }];
                     
                     
                     
                     
                 }
                 
                 else
                 {
                     
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Faild" message:[result valueForKey:@"message"] delegate:self  cancelButtonTitle:@"OK"  otherButtonTitles:nil,nil];
                     [alert show];
                     spinner.hidden=YES;
                     spinnerview.hidden=YES;
                     
                     
                 }
                 
             }];
        
        
        
    }
    
    
    
    
}

- (IBAction)forgotbtnTap:(id)sender
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ForgotPassword  *forgot = [story instantiateViewControllerWithIdentifier:@"forgot"];
    
    [self.navigationController pushViewController:forgot animated:YES];
    
    
}




-(NSString *)TarminateWhiteSpace:(NSString *)Str
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [Str stringByTrimmingCharactersInSet:whitespace];
    return trimmed;
}

-(BOOL)Emailtest:(NSString *)Email
{
    NSString *regex = @"[^@]+@[A-Za-z0-9.-]+\\.[A-Za-z]+";
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![emailPredicate evaluateWithObject:Email])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
@end
