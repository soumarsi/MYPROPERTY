//
//  MPSendToFriendViewController.m
//  MYPROPERTY
//
//  Created by Somenath on 30/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "MPSendToFriendViewController.h"
#import "UIImageView+WebCache.h"
#import "RS_PCH.pch"
#import "FavouriteViewController.h"
#import "Listing3ViewController.h"
#import "MPMyAddvertisementViewController.h"

@interface MPSendToFriendViewController ()<UITextFieldDelegate,UIScrollViewDelegate>
{
    UIColor *color;
    NSMutableArray *property_detail,*propert_id;
    NSMutableDictionary *user_detail;
    NSUserDefaults *userinfo;
    NSString *userid;
    UIView *imageDetailView;
    UIButton *imageCloseBtn;
}

@property (strong, nonatomic) IBOutlet UIPageControl *pagecontrole;
@property (strong, nonatomic) IBOutlet UIScrollView *mainscroll;
@property (strong, nonatomic) IBOutlet UIScrollView *imgscroll;
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *friendsName;
@property (strong, nonatomic) IBOutlet UITextField *friendsEmail;
@property (strong, nonatomic) IBOutlet UITextView *comment;
@property (strong, nonatomic) IBOutlet UILabel *comment_lbl;
@end

@implementation MPSendToFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    obj = [[FW_JsonClass alloc]init];
    
    
    
    userinfo = [[NSUserDefaults alloc]init];
    userid = [userinfo objectForKey:@"id"];
    NSLog(@"userid is : %@",userid);
    
    [self.mainscroll setContentSize:CGSizeMake(self.view.frame.size.width, 520)];
    
    color = [UIColor colorWithRed:92.0f/255.0f green:92.0f/255.0f blue:92.0f/255.0f alpha:1];
    
    [_username setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    [_email setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    [_friendsName setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    [_friendsEmail setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    [property_detail removeAllObjects];
    [user_detail removeAllObjects];
    
    _username.autocorrectionType = UITextAutocorrectionTypeNo;
    _email.autocorrectionType = UITextAutocorrectionTypeNo;
    _friendsName.autocorrectionType=UITextAutocorrectionTypeNo;
    _friendsEmail.autocorrectionType=UITextAutocorrectionTypeNo;
    _comment.autocorrectionType=UITextAutocorrectionTypeNo;
    propert_id=[[NSMutableArray alloc]init ];
    
    if ([_chakdata isEqualToString:@"i am from detalispage"])
    {
        
        NSLog(@"%@",_finalchackdata);
        
        NSLog(@"from detalispage");
        NSLog(@"data_dic%@",_data_dic);
      
        _pagecontrole.numberOfPages = 1;
        
        NSString *email = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_email"];
       NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_nicename"];
        
        _username.text = name;
        _email.text = email;
        
        _idstring=[_data_dic valueForKey:@"property_id"];
        
        
        
        
        NSLog(@"propertyid%@",_idstring);
        
        int i = 0;
        NSInteger x = 0;
        for (i = 0; i<_data_dic.count; i++)
        {
            UIImageView *propimg = [[UIImageView alloc]initWithFrame:CGRectMake(x, 0, self.view.frame.size.width, self.imgscroll.frame.size.height)];
            //        propimg.contentMode = UIViewContentModeScaleAspectFit;
            propimg.userInteractionEnabled = YES;
            
            if ([_finalchackdata isEqualToString:@"listing3"] || [_finalchackdata isEqualToString:@"myadvertisement"])
            {
                [propimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[_data_dic valueForKey:@"media"] objectAtIndex:0]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            }
            else if ([_finalchackdata isEqualToString:@"fav"])
            {
                [propimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[_data_dic valueForKey:@"images"] objectAtIndex:0]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            }
            
            
            
            UIButton *imageclearbtn = [[UIButton alloc]initWithFrame:CGRectMake(x, 0, self.view.frame.size.width, self.imgscroll.frame.size.height)];
            
            imageclearbtn.tag = i;
            imageclearbtn.backgroundColor = [UIColor clearColor];
            imageclearbtn.userInteractionEnabled = YES;
            
            [imageclearbtn addTarget:self action:@selector(imageTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.imgscroll addSubview:propimg];
            [self.imgscroll addSubview:imageclearbtn];
            x = x+self.view.frame.size.width;
        }
        
        
    }
    else
    {
    
    
    property_detail = [_data_dic valueForKey:@"property_details"];
    user_detail = [_data_dic valueForKey:@"user_details"];
    
    _pagecontrole.numberOfPages = [property_detail count];
    
    NSInteger arrcount = [property_detail count];
    
        for (int p=0; p<property_detail.count; p++)
        {
            NSString *id=[[property_detail objectAtIndex:p ]valueForKey:@"property_id"];
            [propert_id addObject:id];
        }
        NSLog(@"propert id %@",propert_id);
        
        NSString *idjoinedstring = [propert_id componentsJoinedByString:@","];

        _idstring=idjoinedstring;
        
    [_imgscroll setContentSize:CGSizeMake(self.view.frame.size.width * arrcount, self.imgscroll.frame.size.height)];
    _imgscroll.delegate = self;
    _imgscroll.showsHorizontalScrollIndicator = NO;
    _imgscroll.pagingEnabled = YES;

    
    NSLog(@"height-----%ld",(long)self.imgscroll.frame.size.height);
    
    int i = 0;
    NSInteger x = 0;
    for (i = 0; i<arrcount; i++)
    {
        UIImageView *propimg = [[UIImageView alloc]initWithFrame:CGRectMake(x, 0, self.view.frame.size.width, self.imgscroll.frame.size.height)];
//        propimg.contentMode = UIViewContentModeScaleAspectFit;
        propimg.userInteractionEnabled = YES;
        [propimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[property_detail objectAtIndex:i] valueForKey:@"images"]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        
        UIButton *imageclearbtn = [[UIButton alloc]initWithFrame:CGRectMake(x, 0, self.view.frame.size.width, self.imgscroll.frame.size.height)];
        
        imageclearbtn.tag = i;
        imageclearbtn.backgroundColor = [UIColor clearColor];
        imageclearbtn.userInteractionEnabled = YES;
        
        [imageclearbtn addTarget:self action:@selector(imageTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.imgscroll addSubview:propimg];
        [self.imgscroll addSubview:imageclearbtn];
        x = x+self.view.frame.size.width;
    }
    
    _username.text = [user_detail valueForKey:@"user_name"];
    _email.text = [user_detail valueForKey:@"user_email"];
    }
}

-(void)imageTapped:(UIButton *)sender
{
    NSLog(@"gesture sender: %ld",(long)sender.tag);
    
    NSInteger tagId = sender.tag;
    
    imageDetailView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    imageDetailView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.9];
    
    imageCloseBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 100, 0, 100, 100)];
    imageCloseBtn.backgroundColor = [UIColor clearColor];
    [imageCloseBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [imageCloseBtn addTarget:self action:@selector(closeTapped) forControlEvents:UIControlEventTouchUpInside];
    
    UIScrollView *imgscroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height * .2, self.view.frame.size.width, self.view.frame.size.height * .6)];
    [imgscroll setContentSize:CGSizeMake(self.view.frame.size.width * [property_detail count], imgscroll.frame.size.height)];
    imgscroll.showsHorizontalScrollIndicator = NO;
    imgscroll.pagingEnabled = YES;
    [imgscroll setContentOffset:CGPointMake(tagId * self.view.frame.size.width, 0) animated:NO];
    
    int i;
    float x = 5;
    if ([_chakdata isEqualToString:@"i am from detalispage"])
    {
        UIScrollView *imgscroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height * .3, self.view.frame.size.width, self.view.frame.size.height * .4)];
        [imgscroll setContentSize:CGSizeMake(self.view.frame.size.width , imgscroll.frame.size.height)];
        imgscroll.showsHorizontalScrollIndicator = NO;
        imgscroll.pagingEnabled = YES;
        [imgscroll setContentOffset:CGPointMake(tagId * self.view.frame.size.width, 0) animated:NO];
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(x, 0, imgscroll.frame.size.width - 10, imgscroll.frame.size.height)];
        
        
        
        if ([_finalchackdata isEqualToString:@"listing3"] || [_finalchackdata isEqualToString:@"myadvertisement"])
        {
            [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[_data_dic valueForKey:@"media"] objectAtIndex:0]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        }
        else if ([_finalchackdata isEqualToString:@"fav"])
        {
            [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[_data_dic valueForKey:@"images"] objectAtIndex:0]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        }
        
        [imgscroll addSubview:img];
        [imageDetailView addSubview:imageCloseBtn];
        [imageDetailView addSubview:imgscroll];
        [self.view addSubview:imageDetailView];
    }
    else
    {
        for (i = 0; i<[property_detail count]; i++)
        {
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(x, 0, imgscroll.frame.size.width - 10, imgscroll.frame.size.height)];
            img.contentMode = UIViewContentModeScaleAspectFit;
        
        
            [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[property_detail objectAtIndex:i] valueForKey:@"images"]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        
            x = x + self.view.frame.size.width;
        
            [imgscroll addSubview:img];
        }
        [imageDetailView addSubview:imageCloseBtn];
        [imageDetailView addSubview:imgscroll];
        [self.view addSubview:imageDetailView];
    }

    
    
}

-(void)closeTapped
{
    [imageDetailView removeFromSuperview];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Load the pages that are now on screen
    [self loadVisiblePages];
}

- (void)loadVisiblePages
{
    CGFloat pageWidth = self.view.frame.size.width;
    NSInteger page = (NSInteger)floor((self.imgscroll.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    self.pagecontrole.currentPage = page;
    //    NSInteger firstPage = page - 1;
    //    NSInteger lastPage = page + 1;
}


- (IBAction)backTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    //    [self.scrollview setContentOffset:CGPointMake(0.0f,0.0f) animated:YES];
    [_mainscroll setContentSize:CGSizeMake(self.view.frame.size.width, 520)];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _username)
    {
        if (self.view.frame.size.width == 320)
        {
            [self.mainscroll setContentOffset:CGPointMake(0, 7)];
            [self.mainscroll setContentSize:CGSizeMake(0, 722)];
        }
        else if (self.view.frame.size.width == 375)
        {
            [self.mainscroll setContentSize:CGSizeMake(0, 727)];
        }
        else
        {
            [self.mainscroll setContentSize:CGSizeMake(0, 740)];
        }
    }
    else if (textField == _email)
    {
        if (self.view.frame.size.width == 320)
        {
            [self.mainscroll setContentOffset:CGPointMake(0, 59)];
            [self.mainscroll setContentSize:CGSizeMake(0, 722)];
        }
        else if (self.view.frame.size.width == 375)
        {
            [self.mainscroll setContentSize:CGSizeMake(0, 727)];
        }
        else
        {
            [self.mainscroll setContentSize:CGSizeMake(0, 740)];
        }
        
    }
    else if (textField == _friendsName)
    {
        if (self.view.frame.size.width == 320)
        {
            [self.mainscroll setContentOffset:CGPointMake(0, 111)];
            [self.mainscroll setContentSize:CGSizeMake(0, 722)];
        }
        else if (self.view.frame.size.width == 375)
        {
            [self.mainscroll setContentOffset:CGPointMake(0, 17)];
            [self.mainscroll setContentSize:CGSizeMake(0, 727)];
        }
        else
        {
            [self.mainscroll setContentSize:CGSizeMake(0, 740)];
        }
        
    }
    else if (textField == _friendsEmail)
    {
        if (self.view.frame.size.width == 320)
        {
            [self.mainscroll setContentOffset:CGPointMake(0, 163)];
            [self.mainscroll setContentSize:CGSizeMake(0, 722)];
        }
        else if (self.view.frame.size.width == 375)
        {
            [self.mainscroll setContentOffset:CGPointMake(0, 69)];
            [self.mainscroll setContentSize:CGSizeMake(0, 727)];
        }
        else
        {
            [self.mainscroll setContentOffset:CGPointMake(0, 13)];
            [self.mainscroll setContentSize:CGSizeMake(0, 740)];
        }
        
    }
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if (self.view.frame.size.width == 320)
    {
        [self.mainscroll setContentOffset:CGPointMake(0.0f, 265.0f) animated:YES];
        self.comment_lbl.hidden=YES;
        [self.mainscroll setContentSize:CGSizeMake(0, 722)];
    }
    else if (self.view.frame.size.width == 375)
    {
        [self.mainscroll setContentOffset:CGPointMake(0.0f, 171.0f) animated:YES];
        self.comment_lbl.hidden=YES;
        [self.mainscroll setContentSize:CGSizeMake(0, 727)];
    }
    else
    {
        [self.mainscroll setContentOffset:CGPointMake(0.0f, 115.0f) animated:YES];
        self.comment_lbl.hidden=YES;
        [self.mainscroll setContentSize:CGSizeMake(0, 740)];
    }
    
    //    [self.mainscroll setContentOffset:CGPointMake(0.0f, 271.0f) animated:YES];
    //    self.comment_lbl.hidden=YES;
    //    [self.mainscroll setContentSize:CGSizeMake(0, 779)];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        //        [self.mainscroll setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];
        [self.mainscroll setContentSize:CGSizeMake(0, 520)];
        //
        if (textView.text.length==0)
        {
            self.comment_lbl.hidden=NO;
            //            [self.mainscroll setContentSize:CGSizeMake(0, 779)];
        }
    }
    return YES;
}

- (IBAction)submitTapped:(id)sender
{
    if ([self TarminateWhiteSpace:_username.text].length==0)
    {
        _username.text = @"";
        NSAttributedString *placeholder=[[NSAttributedString alloc]initWithString:@"Please Enter username" attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
        _username.attributedPlaceholder=placeholder;
    }
    else if ([self Emailtest:_email.text])
    {
        _email.text = @"";
        NSAttributedString *placeholder=[[NSAttributedString alloc]initWithString:@"Please Enter proper email" attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
        _email.attributedPlaceholder=placeholder;
    }
    if ([self TarminateWhiteSpace:_friendsName.text].length==0)
    {
        _friendsName.text = @"";
        NSAttributedString *placeholder=[[NSAttributedString alloc]initWithString:@"Please Enter username" attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
        _friendsName.attributedPlaceholder=placeholder;
    }
    else if ([self Emailtest:_friendsEmail.text])
    {
        _friendsEmail.text = @"";
        NSAttributedString *placeholder=[[NSAttributedString alloc]initWithString:@"Please Enter proper email" attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
        _friendsEmail.attributedPlaceholder=placeholder;
    }
    else
    {
        NSString *urlstr = [NSString stringWithFormat:@"%@json_output.php?mode=sending_property_to_friend&logged_in_user=%@&receiver_name=%@&receiver_email=%@&property_ids=%@&comment=%@", App_Domain_Url, userid, [_friendsName.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], _friendsEmail.text, _idstring, [_comment.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        [obj GlobalDict:urlstr Globalstr:@"array" Withblock:^(id result, NSError *error) {
            NSMutableDictionary *dic = [result mutableCopy];
            NSString *msg = [dic valueForKey:@"response"];
            if ([msg isEqualToString:@"success"])
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Message sent" message: @"success" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
                
                [alert show];
            }
        }];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == [alertView cancelButtonIndex])
    {
        NSLog(@"done");
        
//        if ([_finalchackdata isEqualToString:@"listing3"])
//        {
////            Listing3ViewController *list = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"list3"];
////            [self.navigationController pushViewController:list animated:YES];
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//        else if ([_finalchackdata isEqualToString:@"myadvertisement"])
//        {
////            MPMyAddvertisementViewController *add = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"myaddvertise"];
////            [self.navigationController pushViewController:add animated:YES];
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//        else if ([_finalchackdata isEqualToString:@"fav"])
//        {
//            
//        }
//        else
//        {
//        FavouriteViewController *fav = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"favourites"];
//        [self.navigationController pushViewController:fav animated:YES];
//        }
        
        
        [self.navigationController popViewControllerAnimated:YES];
    }
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

@end
