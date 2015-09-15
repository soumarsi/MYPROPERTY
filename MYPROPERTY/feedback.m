//
//  feedback.m
//  MYPROPERTY
//
//  Created by soumyajit on 27/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "feedback.h"
#import "UIImageView+WebCache.h"
#import "MPDashBoardViewController.h"

@interface feedback ()
{
    NSMutableDictionary *detail_dic;
}

@end

@implementation feedback

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    obj=[[FW_JsonClass alloc]init];
    feedBacktextview.layer.cornerRadius=5;
    userid=[[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
    feedBacktextview.autocorrectionType = UITextAutocorrectionTypeNo;
    
    NSString *urlstr = [NSString stringWithFormat:@"%@json_output.php?mode=make_a_feedback&user_id=%@&booking_id=%@",App_Domain_Url,userid,[_data_dic valueForKey:@"booking_id"]];
    
    [obj GlobalDict:urlstr Globalstr:@"array" Withblock:^(id result, NSError *error) {
        detail_dic = [result mutableCopy];
        
        [propertyImageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[detail_dic valueForKey:@"property_media"]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        addresslbl.text = [detail_dic valueForKey:@"property_address_details"];
        roomeslbl.text = [detail_dic valueForKey:@"property_room_details"];
        
        
        appointmentDetaillbl.text = [NSString stringWithFormat:@"%@ \n %@",[detail_dic valueForKey:@"booking_date"],[detail_dic valueForKey:@"booking_time"]];
    }];
    
}



-(NSString *)TarminateWhiteSpace:(NSString *)Str
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [Str stringByTrimmingCharactersInSet:whitespace];
    return trimmed;
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
    paceholderlbl.hidden=YES;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    self.view.frame=CGRectMake(0, -170, self.view.bounds.size.width, self.view.bounds.size.height);
    [UIView commitAnimations];
    
    
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        self.view.frame=CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        [UIView commitAnimations];
        if (feedBacktextview.text.length==0)
        {
            paceholderlbl.hidden=NO;
        }
    }
    return YES;
}
- (IBAction)makeOfferTap:(id)sender
{
    NSString *url = [NSString stringWithFormat:@"%@json_output.php?mode=create_feedback&user_id=%@&booking_id=%@&feedback_details=%@",App_Domain_Url,userid,[detail_dic valueForKey:@"booking_id"],[feedBacktextview text]];
    NSString *encodeurl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    if ([self TarminateWhiteSpace:feedBacktextview.text].length==0)
    {
        paceholderlbl.hidden = NO;
        paceholderlbl.text = @"Please Enter some feedback";
    }
    else
    {
        [obj GlobalDict:encodeurl Globalstr:@"array" Withblock:^(id result, NSError *error) {
            
            NSMutableDictionary *feedbackdic=[result mutableCopy];
            NSString *result_str = [feedbackdic valueForKey:@"message"];
            
            if ([result_str isEqualToString:@"Feedback Added successfully"]) {
                //                UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Feedback Added successfully" message: @"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
                
                
                
                
                
                MPDashBoardViewController *object =[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"dashboard"];
                [self.navigationController pushViewController:object animated:YES];
                
                
                
                //[alert show];
            }
        }];
    }
}

- (IBAction)backTap:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
