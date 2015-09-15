//
//  MPMakeAnOfferViewController.m
//  MYPROPERTY
//
//  Created by Somenath on 25/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "MPMakeAnOfferViewController.h"
#import "UIImageView+WebCache.h"

@interface MPMakeAnOfferViewController ()<UIScrollViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    BOOL checkbool;
    NSUserDefaults *userinfo;
    NSString *userid;
    NSMutableDictionary *detail_dic;
    UIColor *color;
    NSString *terms;
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;
@property (strong, nonatomic) IBOutlet UIView *headerview;
@property (strong, nonatomic) IBOutlet UITextField *username_txt;
@property (strong, nonatomic) IBOutlet UITextField *address_txt;
@property (strong, nonatomic) IBOutlet UITextField *country_txt;
@property (strong, nonatomic) IBOutlet UITextField *town_txt;
@property (strong, nonatomic) IBOutlet UITextField *postcode;
@property (strong, nonatomic) IBOutlet UITextField *phone_txt;
@property (strong, nonatomic) IBOutlet UITextField *offer_txt;
@property (strong, nonatomic) IBOutlet UIButton *check_btn;
@property (strong, nonatomic) IBOutlet UILabel *roomdetail_txt;
@property (strong, nonatomic) IBOutlet UILabel *address_prop_txt;
@property (strong, nonatomic) IBOutlet UIImageView *property_pic;
@end

@implementation MPMakeAnOfferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    obj = [[FW_JsonClass alloc]init];
    
    checkbool = 0;
    terms = @"N";
    
    userinfo=[[NSUserDefaults alloc]init];
    userid = [userinfo objectForKey:@"id"];
    NSLog(@"userid is : %@",userid);

    
    NSLog(@"frame %ld, %ld, %f, %f",(long)_headerview.frame.origin.x,(long)_headerview.frame.origin.y, _headerview.frame.size.width, _headerview.frame.size.height);
          
    _scrollview.delegate = self;
    [_scrollview setContentSize:CGSizeMake(self.view.frame.size.width, 731)];
    _scrollview.showsVerticalScrollIndicator = NO;
    
    color = [UIColor colorWithRed:92.0f/255.0f green:92.0f/255.0f blue:92.0f/255.0f alpha:1];
    
    [_username_txt setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    [_address_txt setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    [_country_txt setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    [_town_txt setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    [_postcode setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    [_phone_txt setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    [_offer_txt setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    

    NSLog(@"Data_dic----%@",_data_dic);
    
//    _username_txt.text = [userinfo objectForKey:@"user_nicename"];
//    _address_txt.text = [userinfo objectForKey:@"address"];
//    _country_txt.text = [userinfo objectForKey:@"country"];
//    _town_txt.text = [userinfo objectForKey:@"town"];
//    _postcode.text = [userinfo objectForKey:@"post_code"];
//    _phone_txt.text = [userinfo objectForKey:@"phone"];
//    _offer_txt.text = [_data_dic objectForKey:@"advert_price"];
    
    NSString *urlstr = [NSString stringWithFormat:@"%@json_output.php?mode=make_an_offer&user_id=%@&booking_id=%@",App_Domain_Url,userid,[_data_dic valueForKey:@"booking_id"]];
    
    [obj GlobalDict:urlstr Globalstr:@"array" Withblock:^(id result, NSError *error) {
        detail_dic = [result mutableCopy];
        _username_txt.text = [detail_dic objectForKey:@"user_nicename"];
        _address_txt.text = [detail_dic objectForKey:@"address"];
        _country_txt.text = [detail_dic objectForKey:@"country"];
        _town_txt.text = [detail_dic objectForKey:@"town"];
        _postcode.text = [detail_dic objectForKey:@"post_code"];
        _phone_txt.text = [detail_dic objectForKey:@"phone"];
        _offer_txt.text = [detail_dic objectForKey:@"advert_price"];
        _roomdetail_txt.text = [detail_dic objectForKey:@"property_room_details"];
        _address_prop_txt.text = [detail_dic objectForKey:@"property_address_details"];
        [_property_pic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[detail_dic valueForKey:@"property_media"]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
    }];
}

- (IBAction)backTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
//    [self.scrollview setContentOffset:CGPointMake(0.0f,0.0f) animated:YES];
    [_scrollview setContentSize:CGSizeMake(self.view.frame.size.width, 731)];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _username_txt)
    {
        if (self.view.frame.size.width == 320)
        {
            [self.scrollview setContentOffset:CGPointMake(0, 29)];
            [self.scrollview setContentSize:CGSizeMake(0, 985)];
        }
        else if (self.view.frame.size.width == 375)
        {
//            [self.scrollview setContentOffset:CGPointMake(0, 29)];
            [self.scrollview setContentSize:CGSizeMake(0, 990)];
        }
        
    }
    else if (textField == _address_txt)
    {
        if (self.view.frame.size.width == 320)
        {
            [self.scrollview setContentOffset:CGPointMake(0, 81)];
            [self.scrollview setContentSize:CGSizeMake(0, 985)];
        }
        else if (self.view.frame.size.width == 375)
        {
            [self.scrollview setContentSize:CGSizeMake(0, 990)];
        }
    }
    else if (textField == _country_txt)
    {
        if (self.view.frame.size.width == 320)
        {
            [self.scrollview setContentOffset:CGPointMake(0, 133)];
            [self.scrollview setContentSize:CGSizeMake(0, 985)];
        }
        else if (self.view.frame.size.width == 375)
        {
            [self.scrollview setContentOffset:CGPointMake(0, 39)];
            [self.scrollview setContentSize:CGSizeMake(0, 990)];
        }
    }
    else if (textField==_town_txt)
    {
        if (self.view.frame.size.width == 320)
        {
            [self.scrollview setContentOffset:CGPointMake(0, 185)];
            [self.scrollview setContentSize:CGSizeMake(0, 985)];
        }
        else if (self.view.frame.size.width == 375)
        {
            [self.scrollview setContentOffset:CGPointMake(0, 91)];
            [self.scrollview setContentSize:CGSizeMake(0, 990)];
        }
        else
        {
            [self.scrollview setContentOffset:CGPointMake(0, 35)];
            [self.scrollview setContentSize:CGSizeMake(0, 1003)];
        }
    }
    else if (textField==_postcode)
    {
        if (self.view.frame.size.width == 320)
        {
            [self.scrollview setContentOffset:CGPointMake(0, 245)];
            UIToolbar *toolbar=[[UIToolbar alloc] init];
            [toolbar sizeToFit];
            UIBarButtonItem *barbtn=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(DoneClick)];
            [toolbar setItems:@[barbtn]];
            [self.postcode setInputAccessoryView:toolbar];
            [self.scrollview setContentSize:CGSizeMake(0, 993)];
        }
        else if (self.view.frame.size.width == 375)
        {
            [self.scrollview setContentOffset:CGPointMake(0, 146)];
            UIToolbar *toolbar=[[UIToolbar alloc] init];
            [toolbar sizeToFit];
            UIBarButtonItem *barbtn=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(DoneClick)];
            [toolbar setItems:@[barbtn]];
            [self.postcode setInputAccessoryView:toolbar];
            [self.scrollview setContentSize:CGSizeMake(0, 993)];
        }
        else
        {
            [self.scrollview setContentOffset:CGPointMake(0, 86)];
            UIToolbar *toolbar=[[UIToolbar alloc] init];
            [toolbar sizeToFit];
            UIBarButtonItem *barbtn=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(DoneClick)];
            [toolbar setItems:@[barbtn]];
            [self.postcode setInputAccessoryView:toolbar];
            [self.scrollview setContentSize:CGSizeMake(0, 1003)];
        }
    }
    else if (textField==_phone_txt)
    {
        if (self.view.frame.size.width == 320)
        {
            [self.scrollview setContentOffset:CGPointMake(0, 297)];
            UIToolbar *toolbar=[[UIToolbar alloc] init];
            [toolbar sizeToFit];
            UIBarButtonItem *barbtn=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(DoneClick)];
            [toolbar setItems:@[barbtn]];
            [self.phone_txt setInputAccessoryView:toolbar];
            [self.scrollview setContentSize:CGSizeMake(0, 993)];
        }
        else if (self.view.frame.size.width == 375)
        {
            [self.scrollview setContentOffset:CGPointMake(0, 198)];
            UIToolbar *toolbar=[[UIToolbar alloc] init];
            [toolbar sizeToFit];
            UIBarButtonItem *barbtn=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(DoneClick)];
            [toolbar setItems:@[barbtn]];
            [self.phone_txt setInputAccessoryView:toolbar];
            [self.scrollview setContentSize:CGSizeMake(0, 993)];
        }
        else
        {
            [self.scrollview setContentOffset:CGPointMake(0, 138)];
            UIToolbar *toolbar=[[UIToolbar alloc] init];
            [toolbar sizeToFit];
            UIBarButtonItem *barbtn=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(DoneClick)];
            [toolbar setItems:@[barbtn]];
            [self.phone_txt setInputAccessoryView:toolbar];
            [self.scrollview setContentSize:CGSizeMake(0, 1003)];
        }
    }
    else if (textField==_offer_txt)
    {
        if (self.view.frame.size.width == 320)
        {
            [self.scrollview setContentOffset:CGPointMake(0, 386)];
            UIToolbar *toolbar=[[UIToolbar alloc] init];
            [toolbar sizeToFit];
            UIBarButtonItem *barbtn=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(DoneClick)];
            [toolbar setItems:@[barbtn]];
            [self.offer_txt setInputAccessoryView:toolbar];
            [self.scrollview setContentSize:CGSizeMake(0, 1030)];
        }
        else if (self.view.frame.size.width == 375)
        {
            [self.scrollview setContentOffset:CGPointMake(0, 292)];
            UIToolbar *toolbar=[[UIToolbar alloc] init];
            [toolbar sizeToFit];
            UIBarButtonItem *barbtn=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(DoneClick)];
            [toolbar setItems:@[barbtn]];
            [self.offer_txt setInputAccessoryView:toolbar];
            [self.scrollview setContentSize:CGSizeMake(0, 1035)];
        }
        else
        {
            [self.scrollview setContentOffset:CGPointMake(0, 235)];
            UIToolbar *toolbar=[[UIToolbar alloc] init];
            [toolbar sizeToFit];
            UIBarButtonItem *barbtn=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(DoneClick)];
            [toolbar setItems:@[barbtn]];
            [self.offer_txt setInputAccessoryView:toolbar];
            [self.scrollview setContentSize:CGSizeMake(0, 1045
                                                       )];
        }
    }

}

-(void)DoneClick
{
    [self.postcode resignFirstResponder];
    [self.phone_txt resignFirstResponder];
    [self.offer_txt resignFirstResponder];
//    [self.scrollview setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];
    [_scrollview setContentSize:CGSizeMake(self.view.frame.size.width, 731)];
}

- (IBAction)submitTapped:(id)sender
{
    if ([self TarminateWhiteSpace:_username_txt.text].length==0)
    {
        NSAttributedString *placeholder=[[NSAttributedString alloc]initWithString:@"Please Enter username" attributes:@{NSForegroundColorAttributeName:color}];
        _username_txt.attributedPlaceholder=placeholder;
    }
    else if ([self TarminateWhiteSpace:_address_txt.text].length==0)
    {
        _address_txt.text=@"";
        NSAttributedString *placeholder=[[NSAttributedString alloc]initWithString:@"Please enter address" attributes:@{NSForegroundColorAttributeName:color}];
        _address_txt.attributedPlaceholder=placeholder;
    }
    else if ([self TarminateWhiteSpace:_country_txt.text].length==0)
    {
        _country_txt.text=@"";
        NSAttributedString *placeholder=[[NSAttributedString alloc]initWithString:@"Please enter Country" attributes:@{NSForegroundColorAttributeName:color}];
        _country_txt.attributedPlaceholder=placeholder;
    }
    else if ([self TarminateWhiteSpace:_town_txt.text].length==0)
    {
        _town_txt.text=@"";
        NSAttributedString *placeholder=[[NSAttributedString alloc]initWithString:@"Please enter town" attributes:@{NSForegroundColorAttributeName:color}];
        _town_txt.attributedPlaceholder=placeholder;
    }
    else if ([self TarminateWhiteSpace:_postcode.text].length==0)
    {
        _postcode.text=@"";
        NSAttributedString *placeholder=[[NSAttributedString alloc]initWithString:@"Please enter postcode" attributes:@{NSForegroundColorAttributeName:color}];
        _postcode.attributedPlaceholder=placeholder;
    }
    else if ([self TarminateWhiteSpace:_phone_txt.text].length==0)
    {
        _phone_txt.text=@"";
        NSAttributedString *placeholder=[[NSAttributedString alloc]initWithString:@"Please enter phone" attributes:@{NSForegroundColorAttributeName:color}];
        _phone_txt.attributedPlaceholder=placeholder;
    }
    else if ([self TarminateWhiteSpace:_offer_txt.text].length==0)
    {
        _offer_txt.text=@"";
        NSAttributedString *placeholder=[[NSAttributedString alloc]initWithString:@"Please enter offer price" attributes:@{NSForegroundColorAttributeName:color}];
        _offer_txt.attributedPlaceholder=placeholder;
    }
    else if ([terms isEqualToString:@"N"])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Please select the terms and condition" message: @"Selection of terms and conditions is mandatory" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil,nil];
        
        [alert show];
    }
    else
    {
        NSString *submiturl = [NSString stringWithFormat:@"%@json_output.php?mode=create_make_an_offer&user_id=%@&booking_id=%@&user_name=%@&address=%@&town=%@&postcode=%@&user_country=%@&phone=%@&price_val=%@",App_Domain_Url,userid,[_data_dic valueForKey:@"booking_id"],_username_txt.text,[_address_txt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],_town_txt.text,_postcode.text,_country_txt.text,_phone_txt.text,_offer_txt.text];
        
        [obj GlobalDict:submiturl Globalstr:@"array" Withblock:^(id result, NSError *error) {
            
            NSMutableDictionary *tempdic=[result mutableCopy];
            NSString *returnstr = [tempdic valueForKey:@"message"];
            if ([returnstr isEqualToString:@"Offer request sent successfully"])
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Offer request sent successfully" message: @"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
                
                [alert show];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"You have already made an offer for this addvertisements" message: @"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
                
                [alert show];
            }
        }];
    }
}

-(NSString *)TarminateWhiteSpace:(NSString *)Str
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [Str stringByTrimmingCharactersInSet:whitespace];
    return trimmed;
}

- (IBAction)checkBtnTapped:(id)sender
{
    if (checkbool == 0)
    {
        [_check_btn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
        terms = @"Y";
        checkbool = 1;
    }
    else
    {
        [_check_btn setImage:[UIImage imageNamed:@"check_unselect"] forState:UIControlStateNormal];
        terms = @"N";
        checkbool = 0;
    }
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

@end
