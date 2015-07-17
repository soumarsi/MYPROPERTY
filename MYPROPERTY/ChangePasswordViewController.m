//
//  ChangePasswordViewController.m
//  MYPROPERTY
//
//  Created by soumyajit on 08/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController () <UITextFieldDelegate>

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    obj= [[FW_JsonClass alloc]init];
    _chngbtn.layer.cornerRadius=3;
    _confrmpwd.delegate=self;
    userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



- (IBAction)chngpwdbtn:(id)sender {
    
    if (![self TarminateWhiteSpace:_newpwd.text].length==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Faild"
                                                        message:@"Faild"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil,nil];
        [alert show];
        
        
    }
    
    
    else if (_newpwd.text.length<6)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Faild"
                                                        message:@"Enter min 6 digit password"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil,nil];
        [alert show];
        
        
    }
    
    
    else if ([self TarminateWhiteSpace:_newpwd.text].length==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Faild"
                                                        message:@"Faild"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil,nil];
        [alert show];
        
    }
    
    else if (!([self.newpwd.text isEqual:self.confrmpwd.text] ))
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Faild"
                                                        message:@"Password must Equal"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil,nil];
        [alert show];
        
        
        
    }
    
    else
    {
        
        
        NSString *url = [NSString stringWithFormat:@"%@json_output.php?mode=change_password&user_id=%@&user_password=%@",App_Domain_Url,userid,[_newpwd text]];
        
        [obj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error)
         {
             
             
             NSMutableArray *temp = [result mutableCopy];
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                             message:[temp valueForKey:@"message"]
                                                            delegate:self
                                                   cancelButtonTitle:@"Cancel"
                                                   otherButtonTitles:nil,nil];
             [alert show];
             
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


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
