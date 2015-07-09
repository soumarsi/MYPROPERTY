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
    
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
    updatebtn.layer.cornerRadius=3;
    
    obj = [[FW_JsonClass alloc]init];
    Footer *footer=[[Footer alloc]init];
    //NSString *Value = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_nicename"];
     nameUpdate.text =[[NSUserDefaults standardUserDefaults] objectForKey:@"user_nicename"];
    emailUpdate.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_email"];
    //phonenoUpdate.text = [[NSUserDefaults standardUserDefaults]objectForKey:@""];
     userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
    
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


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    
    if (textField ==phonenoUpdate)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        self.view.frame=CGRectMake(0, -80, self.view.bounds.size.width, self.view.bounds.size.height);
        [UIView commitAnimations];
        return YES;
    }
    else if (textField==emailUpdate)
    {
        return NO;
    }
    else if (textField==nameUpdate)
    {
        return YES;
    }
    
    return nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (textField ==phonenoUpdate)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        self.view.frame=CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        [UIView commitAnimations];
    }
    [textField resignFirstResponder];
    
    
    return YES;
}

-(IBAction)update:(id)sender
{
    NSLog(@"Tap");
    
    if ([self TarminateWhiteSpace:nameUpdate.text].length==0) {
        
        nameUpdate.text=@"";
        NSAttributedString *nn3=[[NSAttributedString alloc]initWithString:@"Name" attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
        nameUpdate.attributedPlaceholder=nn3;
    }
    else if ([self TarminateWhiteSpace:phonenoUpdate.text].length==0)
    {
        phonenoUpdate.text= @"";
        NSAttributedString *nn3=[[NSAttributedString alloc]initWithString:@"Phone No" attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
        phonenoUpdate.attributedPlaceholder=nn3;

    }
    
    else{
    
    NSString *url = [NSString stringWithFormat:@"%@json_output.php?mode=update_profile_details&user_id=%@&user_name=%@&address=kol&town=test&post_code=70&country=india&phone=%@&address=kol",App_Domain_Url,userid,[nameUpdate text],[phonenoUpdate text]];
    [obj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         
         NSLog(@"result....%@",result);
         NSMutableArray *arry = [[NSMutableArray alloc]init];
         arry = [result mutableCopy];
         
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                         message:[arry valueForKey:@"msg"]
                                                        delegate:self
                                               cancelButtonTitle:@"Cancel"
                                               otherButtonTitles:nil,nil];

         [alert show];
         
         
     }];
    }
    
}
-(NSString *)TarminateWhiteSpace:(NSString *)Str
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [Str stringByTrimmingCharactersInSet:whitespace];
    return trimmed;
}



@end
