//
//  SignupViewController.m
//  MYPROPERTY
//
//  Created by soumyajit on 06/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "SignupViewController.h"


@interface SignupViewController ()

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    obj = [[FW_JsonClass alloc]init];
    signupbtnview.hidden=YES;
    
    _titletextfield.delegate=self;
    _firstnametextfield.delegate=self;
    _lastnametextfield.delegate=self;
    _emailtextfield.delegate=self;
    _passwordtextfield.delegate=self;
    _confirmpasswordtextfield.delegate=self;
    _titletextfield.autocorrectionType=UITextAutocorrectionTypeNo;
    _firstnametextfield.autocorrectionType=UITextAutocorrectionTypeNo;
    _lastnametextfield.autocorrectionType=UITextAutocorrectionTypeNo;
    _emailtextfield.autocorrectionType=UITextAutocorrectionTypeNo;
    _passwordtextfield.autocorrectionType=UITextAutocorrectionTypeNo;
    _confirmpasswordtextfield.autocorrectionType=UITextAutocorrectionTypeNo;
    [_titletextfield setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_firstnametextfield setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_lastnametextfield setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_emailtextfield setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_passwordtextfield setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_confirmpasswordtextfield setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    _clickSignup.layer.cornerRadius=3;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    self.view.frame=CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [UIView commitAnimations];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField

{
    if ( [_passwordtextfield.text isEqualToString:@" "])
    {
        UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Sorry!"  message:@"Password Cannot content Space" delegate:self cancelButtonTitle:@"OK"   otherButtonTitles: nil];
        
        [alert show];
    }
    
    
    
}



- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        _passwordtextfield.text=@"";
        _confirmpasswordtextfield.text=@"";
    }
}

//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    if (textField ==_emailtextfield)
//    {
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:0.25];
//        self.view.frame=CGRectMake(0, -100, self.view.bounds.size.width, self.view.bounds.size.height);
//        [UIView commitAnimations];
//    }
//    else if (textField ==_passwordtextfield)
//    {
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:0.25];
//        self.view.frame=CGRectMake(0, -150, self.view.bounds.size.width, self.view.bounds.size.height);
//        [UIView commitAnimations];
//    }
//    else if (textField ==_confirmpasswordtextfield)
//    {
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:0.25];
//        self.view.frame=CGRectMake(0, -150, self.view.bounds.size.width, self.view.bounds.size.height);
//        [UIView commitAnimations];
//    }
//    return YES;
//}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)signupback:(id)sender
{
    NSLog(@"Tap");
    //    ViewController *home=(ViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:Nil]instantiateViewControllerWithIdentifier:@"mainviewcontroller"];
    //    [self.navigationController pushViewController:home animated:YES];
    
    [UIView  beginAnimations: @"Showinfo"context: nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    [self.navigationController popViewControllerAnimated:YES];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
}




- (IBAction)clickSignup:(id)sender {
    
    if([self TarminateWhiteSpace:_firstnametextfield.text].length==0)
    {
        _firstnametextfield.text=@"";
        NSAttributedString *nn3=[[NSAttributedString alloc]initWithString:@"Please Enter name" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        _firstnametextfield.attributedPlaceholder=nn3;
    }
    else if([self Emailtest:_emailtextfield.text])
    {
        _emailtextfield.text=@"";
        NSAttributedString *nn3=[[NSAttributedString alloc]initWithString:@"Please Enter proper Email-id" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        _emailtextfield.attributedPlaceholder=nn3;
    }
    else if (_passwordtextfield.text.length<6)
    {
        _passwordtextfield.text=@"";
        NSAttributedString *nn3=[[NSAttributedString alloc]initWithString:@"Enter min 6 digit password" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        _passwordtextfield.attributedPlaceholder=nn3;
        
        
    }
    else if ([self TarminateWhiteSpace:_passwordtextfield.text].length==0)
    {
        _passwordtextfield.text=@"";
        NSAttributedString *nn3=[[NSAttributedString alloc]initWithString:@"Please Enter password" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        _passwordtextfield.attributedPlaceholder=nn3;
        
    }
    else if ([self TarminateWhiteSpace:_confirmpasswordtextfield.text].length==0)
    {
        _confirmpasswordtextfield.text=@"";
        NSAttributedString *nn3=[[NSAttributedString alloc]initWithString:@"Please Enter confirm password" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        _confirmpasswordtextfield.attributedPlaceholder=nn3;
    }
    else if (![_passwordtextfield.text isEqualToString:_confirmpasswordtextfield.text])
    {
        _passwordtextfield.text=@"";
        _confirmpasswordtextfield.text=@"";
        NSAttributedString *nn3=[[NSAttributedString alloc]initWithString:@"password  mismatch" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        _passwordtextfield.attributedPlaceholder=nn3;
        _confirmpasswordtextfield.attributedPlaceholder=nn3;
    }
    
    else if(![self isPasswordValid:_passwordtextfield.text] )
    {
        
        _passwordtextfield.text=@"";
        _confirmpasswordtextfield.text= @"";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Faild" message:@"Minimum 6 characters and at least 1 Alphabet, 1 Number and 1 Special Character " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        
    }
    
    else
    {
        signupbtnview.hidden=NO;
        
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
        
        NSInteger day = [components day];
        NSInteger week = [components month];
        NSInteger year = [components year];
        
        NSString *string = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)year, (long)week, (long)day];
        NSLog(@"st%@",string);
        NSString *space=@"abc";
        NSString *url = [NSString stringWithFormat:@"%@json_output.php?mode=sign_up_via_email&user_name=%@&user_email=%@&user_password=%@&user_registered=%@&display_name=%@",App_Domain_Url,[_firstnametextfield text], [_emailtextfield text],[_passwordtextfield text],string,space];
        
        NSString* encodedUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [obj GlobalDict:encodedUrl Globalstr:@"array" Withblock:^(id result, NSError *error)
         {
             
             _Arry1 =[[NSMutableArray alloc]init];
             
             
             _Arry1=[result mutableCopy];
             
             if ([[_Arry1 valueForKey:@"message"]isEqualToString:@"successfully logged in"]) {
                 
                 LoginViewController *srch = ( LoginViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"login"];
                 
                 [self.navigationController pushViewController:srch animated:YES];
                 
                 
                 
                 
             }
             else
             {
                 signupbtnview.hidden=YES;
                 
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Faild"
                                                                 message:[_Arry1 valueForKey:@"message"]
                                                                delegate:self
                                                       cancelButtonTitle:@"Cancel"
                                                       otherButtonTitles:nil,nil];
                 [alert show];
             }
             
             
             NSLog(@"Arry1%@",_Arry1);
             
             
         }];
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==_passwordtextfield || textField==_confirmpasswordtextfield  )
    {
        
        
        if ( [string isEqualToString:@" "])
        {
            UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Sorry!"  message:@"Password Cannot content Space" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            
            [alert show];
        }
        
        
    }
    
    
    if (textField==_emailtextfield) {
        
        if ( [string isEqualToString:@" "])
        {
            UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Sorry!"  message:@"Emailid Cannot content Space" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            
            [alert show];
            
        }
    }
    return YES;
}


- (IBAction)loginbuttonpushfromsignup:(id)sender
{
    LoginViewController *srch = ( LoginViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"login"];
    [self.navigationController pushViewController:srch animated:YES];
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



//-(BOOL)passwordcheck:(NSString *)check
//{
//    NSCharacterSet *s = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890__$@$!%*?&"];
//
//   // NSString *myRegex = @"[A-Z0-9a-z_$@$!%*?&]*";
//
//
//    NSPredicate *password = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", s];
//    NSLog(@"check......%@",check);
//    if (![password evaluateWithObject:check])
//
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
//
//}

-(BOOL) isPasswordValid:(NSString *)pwd
{
    if ( [pwd length]<6 || [pwd length]>32 )
        
        return NO;
    
    NSRange rang; rang = [pwd rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]];
    
    if ( !rang.length )
    {
        return NO;
    }
    rang = [pwd rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]];
    
    if ( !rang.length )
    {
        return NO;
    }
    
    return YES;
}



@end
