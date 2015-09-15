//
//  ForgotPassword.m
//  MYPROPERTY
//
//  Created by soumyajit on 29/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "ForgotPassword.h"
#import "LoginViewController.h"

@interface ForgotPassword ()

@end

@implementation ForgotPassword

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    forgotText.autocorrectionType=UITextAutocorrectionTypeNo;
    obj = [[FW_JsonClass alloc]init];
    
    UIColor *color = [UIColor whiteColor];
    forgotText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Your Emaild" attributes:@{NSForegroundColorAttributeName: color}];
    
    submitbtn.layer.cornerRadius=3;
    
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

- (IBAction)SubmitTap:(id)sender
{
    if([self Emailtest:forgotText.text])
    {
        forgotText.text=@"";
        NSAttributedString *nn3=[[NSAttributedString alloc]initWithString:@"Please Enter proper Email-id" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        forgotText.attributedPlaceholder=nn3;
    }
    else
        
        
    {
        NSString *url = [NSString stringWithFormat:@"%@json_output.php?mode=forgot_password&user_email=%@",App_Domain_Url,[forgotText text]];
        NSString *encodeurl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
        [obj GlobalDict:encodeurl Globalstr:@"array" Withblock:^(id result, NSError *error) {
            
            if ([[result valueForKey:@"msg"] isEqualToString:@"A Password Recovery Email Is Sent To Your Mail Id, Please check email"])
            {
                UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                
                LoginViewController *login = [story instantiateViewControllerWithIdentifier:@"login"];
                
                [self.navigationController pushViewController:login animated:YES];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"   message:[result valueForKey:@"msg"] delegate:self  cancelButtonTitle:@"Cancel" otherButtonTitles:nil,nil];
                [alert show];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Faild"   message:[result valueForKey:@"msg"] delegate:self  cancelButtonTitle:@"Cancel" otherButtonTitles:nil,nil];
                [alert show];
            }
            
            
        }];
    }

    
    
}


- (IBAction)backTap:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}





-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
