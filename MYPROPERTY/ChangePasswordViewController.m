//
//  ChangePasswordViewController.m
//  MYPROPERTY
//
//  Created by soumyajit on 08/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "SearchViewController.h"

@interface ChangePasswordViewController () <UITextFieldDelegate>

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    obj= [[FW_JsonClass alloc]init];
    _newpwd.autocorrectionType=UITextAutocorrectionTypeNo;
    _confrmpwd.autocorrectionType=UITextAutocorrectionTypeNo;
    _chngbtn.layer.cornerRadius=3;
    _confrmpwd.delegate=self;
    userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
    
    [_newpwd setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_confrmpwd setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ( [string isEqualToString:@" "])
    {
        UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Sorry!"  message:@"Password Cannot content Space" delegate:self cancelButtonTitle:@"OK"   otherButtonTitles: nil];
        
        [alert show];
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField

{
    if ( [_newpwd.text isEqualToString:@" "])
    {
        UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Sorry!"  message:@"Password Cannot content Space" delegate:self cancelButtonTitle:@"OK"   otherButtonTitles: nil];
        
        [alert show];
    }
    
    
    
}




- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        _newpwd.text=@"";
        _confrmpwd.text=@"";
    }
}




- (IBAction)chngpwdbtn:(id)sender {
    
    
    
    
    
    
    if ([self TarminateWhiteSpace:_newpwd.text].length==0)
    {
        _newpwd.text=@"";
        NSAttributedString *nn3=[[NSAttributedString alloc]initWithString:@"Please Enter password" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        _newpwd.attributedPlaceholder=nn3;
        
    }
    else if ([self TarminateWhiteSpace:_confrmpwd.text].length==0)
    {
        _confrmpwd.text=@"";
        NSAttributedString *nn3=[[NSAttributedString alloc]initWithString:@"Please Enter confirm password" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        _confrmpwd.attributedPlaceholder=nn3;
    }
    else if (![_newpwd.text isEqualToString:_confrmpwd.text])
    {
        _newpwd.text=@"";
        _confrmpwd.text=@"";
        NSAttributedString *nn3=[[NSAttributedString alloc]initWithString:@"password  mismatch" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        _newpwd.attributedPlaceholder=nn3;
        _confrmpwd.attributedPlaceholder=nn3;
    }
    
    else if (_newpwd.text.length<6)
    {
        _newpwd.text=@"";
        _confrmpwd.text= @"";
        NSAttributedString *nn3=[[NSAttributedString alloc]initWithString:@"Enter min 6 digit password" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        _newpwd.attributedPlaceholder=nn3;
        _confrmpwd.attributedPlaceholder =nn3;
        
        
    }
    
    
    
    else if(![self isPasswordValid:_newpwd.text])
    {
        
        _newpwd.text=@"";
        _confrmpwd.text= @"";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Faild" message:@"Minimum 6 characters and at least 1 Alphabet, 1 Number and 1 Special Character " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        
    }
    else
        
    {
        
        
        NSString *url = [NSString stringWithFormat:@"%@json_output.php?mode=change_password&user_id=%@&user_password=%@",App_Domain_Url,userid,[_newpwd text]];
        
        [obj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error)
         {
             
             
             NSMutableArray *temp = [result mutableCopy];
             
             if ([[temp valueForKey:@"message" ]isEqualToString:@"Successfully Changed Password"])
             {
                 
                 SearchViewController *srch = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"searchView"];
                 
                 [self.navigationController pushViewController:srch animated:YES];
                 
                 
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[temp valueForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                 [alert show];
                 
             }
             else
             {
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Faild" message:[temp valueForKey:@"message"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil,nil];
                 [alert show];
                 
             }
         }];
        
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

-(NSString *)TarminateWhiteSpace:(NSString *)Str
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [Str stringByTrimmingCharactersInSet:whitespace];
    return trimmed;
}



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
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
