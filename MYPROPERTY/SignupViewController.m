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
    signup.layer.cornerRadius = 3;
    
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField ==_emailtextfield)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        self.view.frame=CGRectMake(0, -100, self.view.bounds.size.width, self.view.bounds.size.height);
        [UIView commitAnimations];
    }
    else if (textField ==_passwordtextfield)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        self.view.frame=CGRectMake(0, -150, self.view.bounds.size.width, self.view.bounds.size.height);
        [UIView commitAnimations];
    }
    else if (textField ==_confirmpasswordtextfield)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        self.view.frame=CGRectMake(0, -150, self.view.bounds.size.width, self.view.bounds.size.height);
        [UIView commitAnimations];
    }
    return YES;
}



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
    [self.navigationController popToRootViewControllerAnimated:YES];
    //    ViewController *home=(ViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:Nil]instantiateViewControllerWithIdentifier:@"mainviewcontroller"];
    //    [self.navigationController pushViewController:home animated:YES];
//    
//    [UIView  beginAnimations: @"Showinfo"context: nil];
//    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationDuration:0.75];
//    [self.navigationController popToRootViewControllerAnimated:YES];
//    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
//    [UIView commitAnimations];
}




- (IBAction)clickSignup:(id)sender {
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    
    NSInteger day = [components day];
    NSInteger week = [components month];
    NSInteger year = [components year];
    
    NSString *string = [NSString stringWithFormat:@"%ld.%ld.%ld",(long)year, (long)week, (long)day];
    NSLog(@"st%@",string);
    
    NSString *url = [NSString stringWithFormat:@"%@json_output.php?mode=sign_up_via_email&user_name=%@&user_email=%@&user_password=%@&user_registered=%@&display_name=%@",App_Domain_Url,[_firstnametextfield text], [_emailtextfield text],[_passwordtextfield text],string,[_titletextfield text]];
    
    [obj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         
         _Arry1 =[[NSMutableArray alloc]init];
         
         
         _Arry1=[result mutableCopy];
         
         if ([[_Arry1 valueForKey:@"message"]isEqualToString:@"successfully logged in"]) {
             
             LoginViewController *srch = ( LoginViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"login"];
             
             [self.navigationController pushViewController:srch animated:YES];
             
             
         }
         else
         {
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
@end
