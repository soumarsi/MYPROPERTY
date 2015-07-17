//
//  MPDashBoardViewController.m
//  MYPROPERTY
//
//  Created by Somenath on 08/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "MPDashBoardViewController.h"
#import "Footer.h"
#import "SearchViewController.h"
#import "FavouriteViewController.h"
#import "MPNotificationViewController.h"
#import "RightMenu.h"
#import "PropertyViewController.h"
#import "MPEditProperty.h"
#import "RS_PCH.pch"
#import "QFProfileViewController.h"
#import "ChangePasswordViewController.h"
#import "AddadvertisementViewController.h"


@import UIKit;

@interface MPDashBoardViewController ()<footerdelegate,rightDelegate,UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate>
{
    BOOL viewslide,rightslide, tapcheck, experidate;
    UIView *slideview, *blackview;
    NSInteger check;
    NSArray *btnname;
    Footer *footerView;
    RightMenu *rightView;
    NSUserDefaults *userinfo;
    NSMutableArray *mypropertyarr, *myaddvertisementsarr;
    NSString *bedsnumber;
    NSString *bathsnumber;
    NSString *roomsnumber;
    NSString *price;
    UIButton *btn1, *btn2, *btn3;
}


@property (strong, nonatomic) IBOutlet UIButton *tableviewbtn;
@property (strong, nonatomic) IBOutlet UIButton *gridviewbtn;
@property (strong, nonatomic) IBOutlet UIView *blueline;
@property (strong, nonatomic) IBOutlet UILabel *subcatagorylbl;
@property (strong, nonatomic) IBOutlet UIView *mainview;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@end

@implementation MPDashBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    myaddvertisementsarr=[[NSMutableArray alloc]init];
    mypropertyarr=[[NSMutableArray alloc]init];
    _tableview.hidden = YES;
    _tableviewbtn.hidden = YES;
    _gridviewbtn.hidden = YES;
    
    obj = [[FW_JsonClass alloc]init];
    userinfo=[[NSUserDefaults alloc]init];
    
    NSString *userid = [userinfo objectForKey:@"id"];
    
    NSString *mypropertyul = [NSString stringWithFormat:@"%@json_output.php?mode=list_my_property&user_id=4",App_Domain_Url];
    NSString *myaddvertiseurl = [NSString stringWithFormat:@"%@json_output.php?mode=list_my_property_advertisements&user_id=4",App_Domain_Url];
    
    
    [_spinner setHidden:NO];
    [_spinner startAnimating];
    
    [obj GlobalDict:mypropertyul Globalstr:@"array" Withblock:^(id result, NSError *error) {
        mypropertyarr = [result mutableCopy];
        NSLog(@"mypropertyarr----->%@",mypropertyarr);
        NSLog(@"mypropertyarr count----->%ld",(long)mypropertyarr.count);
        
        [obj GlobalDict:myaddvertiseurl Globalstr:@"array" Withblock:^(id result, NSError *error)
         {
             myaddvertisementsarr=[result mutableCopy];
             
             NSLog(@"addverstisement%@",[[myaddvertisementsarr objectAtIndex:1] valueForKey:@"property_price"]);
             //             [_tableview reloadData];
             [_spinner stopAnimating];
             [_spinner setHidden:YES];
         }];
    }];
    
    NSLog(@"userid is : %@",userid);
    
    viewslide = 0;
    rightslide = 0;
    tapcheck = 0;
    check = 1;
    
    blackview = [[UIView alloc]init];
    footerView=[[Footer alloc]init];
    
    [footerView setFrame:CGRectMake(0, self.view.frame.size.height - 60, self.view.frame.size.width, 60)];
    
    footerView.footerdelegate=self;
    [self.mainview addSubview:footerView];
    
    [_buttonScroll setContentSize:CGSizeMake(480, _buttonScroll.frame.size.height)];
    //    _buttonScroll.pagingEnabled = YES;
    _buttonScroll.showsHorizontalScrollIndicator = NO;
    
}

// footer delegate method

-(void)pushmethod:(UIButton *)sender
{
    NSLog(@"footer method called");
    long tagId = [sender tag];
    NSLog(@"%ld",(long)sender.tag);
    if ( tagId == 1 )
    {
        NSLog(@"tagid is: %ld",(long)tagId);
        SearchViewController *pro = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"searchView"];
        [self.navigationController pushViewController:pro animated:NO];
    }
    else if ( tagId == 2 )
    {
        NSLog(@"tagid is: %ld",(long)tagId);
        FavouriteViewController *fav = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"favourites"];
        [self.navigationController pushViewController:fav animated:NO];
    }
    else if (tagId == 3)
    {
        NSLog(@"tagid is: %ld",(long)tagId);
        PropertyViewController *prop = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"registerproperty"];
        [self.navigationController pushViewController:prop animated:NO];
    }
    else if (tagId == 4)
    {
        MPNotificationViewController *noti = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"notification"];
        [self.navigationController pushViewController:noti animated:NO];
    }
    else
    {
        //[footerView TapCheck:5];
        //        QFProfileViewController *pro = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"profile"];
        //        [self.navigationController pushViewController:pro animated:NO];
        if (rightslide == 0)
        {
            rightView = [[RightMenu alloc]init];
            rightView.rightDelegate = self;
            [rightView setFrame:CGRectMake(self.view.frame.size.width + 50, 0,self.view.frame.size.width*.55, self.mainview.frame.size.height)];
            
            [blackview setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            blackview.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.01];
            [_mainview setUserInteractionEnabled:YES];
            
            UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelRightMenuByTap)];
            tapGestureRecognize.delegate = self;
            tapGestureRecognize.numberOfTapsRequired = 1;
            [tapGestureRecognize requireGestureRecognizerToFail:tapGestureRecognize];
            [blackview addGestureRecognizer:tapGestureRecognize];
            
            UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(cancelRightMenu)];
            recognizer.direction = UISwipeGestureRecognizerDirectionRight;
            recognizer.delegate = self;
            
            UISwipeGestureRecognizer *recognizer1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(cancelRightMenu)];
            recognizer.direction = UISwipeGestureRecognizerDirectionRight;
            recognizer.delegate = self;
            
            [blackview addGestureRecognizer:recognizer];
            [rightView addGestureRecognizer:recognizer1];
            
            [_mainview addSubview:blackview];
            
            
            [UIView animateWithDuration:.5 animations:^{
                
                blackview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
                
                [rightView setFrame:CGRectMake(self.view.frame.size.width*.45, 0,self.view.frame.size.width*.55, self.mainview.frame.size.height)];
                
                //            [self.mainview setFrame:CGRectMake(self.mainview.frame.size.width*(-.55),0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height)];
                
                //            [footerView setFrame:CGRectMake(self.mainview.frame.size.width*(-.55),self.mainview.frame.size.height-60,[footerView bounds].size.width,[footerView bounds].size.height)];
            }];
            
            [self.view addSubview:rightView];
            rightslide = 1;
        }
        else
        {
            //        [rightView removeFromSuperview];
            
            [UIView animateWithDuration:.5 animations:^{
                
                blackview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.01];
                
                [rightView setFrame:CGRectMake(self.view.frame.size.width + 10, 0,self.view.frame.size.width*.55, self.mainview.frame.size.height)];
                
                //            [self.mainview setFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height)];
                
                
                //            [footerView setFrame:CGRectMake(0,self.mainview.frame.size.height-60,[footerView bounds].size.width,[footerView bounds].size.height)];
                
            }
                             completion:^(BOOL finished){
                                 
                                 [blackview removeFromSuperview];
                             }];
            
            rightslide = 0;
        }
        
    }
}

-(void)rightclk:(UIButton *)sender
{
    NSInteger tagId;
    tagId = sender.tag;
    NSLog(@"%ld",(long)tagId);
    if ( tagId == 2 )
    {
        NSLog(@"tagid is: %ld",(long)tagId);
        QFProfileViewController *pro = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"profile"];
        [self.navigationController pushViewController:pro animated:YES];
        [rightView removeFromSuperview];
        [blackview removeFromSuperview];
        rightslide = 0;
    }
    else if (tagId == 3)
    {
        NSLog(@"tagid is: %ld",(long)tagId);
        ChangePasswordViewController *pro = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"changepwd"];
        [self.navigationController pushViewController:pro animated:YES];
        [rightView removeFromSuperview];
        [blackview removeFromSuperview];
        rightslide = 0;
    }
    else if (tagId == 5)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SessionStateChangeNotification" object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
        NSLog(@"logout");
        //[self.navigationController popToRootViewControllerAnimated:NO];
        // NSArray *array = [self.navigationController viewControllers];
        //[self.navigationController popToViewController:[array objectAtIndex:0] animated:NO];
        ViewController *home=(ViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:Nil]instantiateViewControllerWithIdentifier:@"loginpage"];
        
        [FBSession.activeSession closeAndClearTokenInformation];
        [FBSession.activeSession close];
        [FBSession setActiveSession:nil];
        
        [self.navigationController pushViewController:home animated:NO];
        
    }
    
}






-(void)cancelRightMenuByTap
{
    [UIView animateWithDuration:.5 animations:^{
        
        blackview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.01];
        
        [rightView setFrame:CGRectMake(self.view.frame.size.width + 10, 0,self.view.frame.size.width*.55, self.mainview.frame.size.height)];
        
    }
                     completion:^(BOOL finished){
                         
                         [blackview removeFromSuperview];
                     }];
    
    rightslide = 0;
}

-(void)cancelRightMenu
{
    [UIView animateWithDuration:.5 animations:^{
        
        blackview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.01];
        
        [rightView setFrame:CGRectMake(self.view.frame.size.width + 10, 0,self.view.frame.size.width*.55, self.mainview.frame.size.height)];
        
    }
                     completion:^(BOOL finished){
                         
                         [blackview removeFromSuperview];
                     }];
    
    rightslide = 0;
}


- (IBAction)backTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)alertsTapped:(id)sender
{
    check = 1;
    _tableview.hidden = YES;
    _tableviewbtn.hidden = YES;
    _gridviewbtn.hidden = YES;
    
    self.subCatgoryView.hidden = NO;
    [self.blueline setFrame:CGRectMake(10, _buttonScroll.frame.size.height - 5, 141, 3)];
    [self.buttonScroll setContentOffset:CGPointMake(0, 0)];
}

- (IBAction)myPropertyTapped:(id)sender
{
    check = 3;
    _tableview.hidden = NO;
    _tableviewbtn.hidden = NO;
    _gridviewbtn.hidden = NO;
    
    self.subCatgoryView.hidden = YES;
    [self.blueline setFrame:CGRectMake(183, _buttonScroll.frame.size.height - 5, 114, 3)];
    if (self.view.frame.size.width == 320)
    {
        [_buttonScroll setContentOffset:CGPointMake(75 , 0)];
    }
    else if (self.view.frame.size.width == 375)
    {
        [_buttonScroll setContentOffset:CGPointMake(50 , 0)];
    }
    else
    {
        [_buttonScroll setContentOffset:CGPointMake(30 , 0)];
    }
    
    [_tableview reloadData];
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        // Fade the label
        
        [slideview setAlpha:0];
    }
                     completion:^(BOOL finished) {
                         [slideview removeFromSuperview];
                         [_subviewbtn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
                         viewslide = 0;
                         
                     }
     ];
    
    
    //    [slideview removeFromSuperview];
    //    [_subviewbtn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
    //    viewslide = 0;
}

- (IBAction)myAdvertiseTapped:(id)sender
{
    check = 4;
    _tableview.hidden = NO;
    _tableviewbtn.hidden = NO;
    _gridviewbtn.hidden = NO;
    
    self.subCatgoryView.hidden = YES;
    [self.blueline setFrame:CGRectMake(325, _buttonScroll.frame.size.height - 5, 150, 3)];
    if (self.view.frame.size.width == 320)
    {
        [_buttonScroll setContentOffset:CGPointMake(160, 0)];
    }
    else if (self.view.frame.size.width == 375)
    {
        [_buttonScroll setContentOffset:CGPointMake(105, 0)];
    }
    else
    {
        [_buttonScroll setContentOffset:CGPointMake(70, 0)];
    }
    
    [_tableview reloadData];
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        // Fade the label
        
        [slideview setAlpha:0];
    }
                     completion:^(BOOL finished) {
                         [slideview removeFromSuperview];
                         [_subviewbtn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
                         viewslide = 0;
                         
                     }
     ];
    
    //    [slideview removeFromSuperview];
    //    [_subviewbtn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
    //    viewslide = 0;
}

- (IBAction)subcatviewbtn:(id)sender
{
    if (viewslide == 0)
    {
        [_subviewbtn setImage:[UIImage imageNamed:@"up_arrow"] forState:UIControlStateNormal];
        if (check == 1)
        {
            slideview = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width * .6, _headerimg.frame.size.height + self.subCatgoryView.frame.size.height + self.buttonScroll.frame.size.height + 2, self.view.frame.size.width * .39, 180)];
            
            slideview.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1];
            slideview.layer.borderWidth = 1.0f;
            slideview.layer.cornerRadius = 4.0f;
            slideview.layer.borderColor = [UIColor colorWithRed:200.0f/255 green:200.0f/255.0f blue:200.0f/255.0f alpha:1].CGColor;
            slideview.layer.shadowOffset = CGSizeMake(-3, 3);
            slideview.layer.shadowRadius = 6;
            slideview.layer.shadowOpacity = 0.5;
            
            
            
            UIImageView *backimg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, slideview.frame.size.width, slideview.frame.size.height)];
            backimg.image = [UIImage imageNamed:@"popup_near"];
            
            btnname = [NSArray arrayWithObjects:@"SEARCH ALERTS", @"PROPERTY STATUS", @"APPOINTMENTS", @"OFFER ALERTS", @"RENEW ALERTS", @"PROPERTY ISSUE", nil];
            NSInteger i = 0;
            for (int j = 0 ; j<6 ; j++)
            {
                UIButton *namebtn = [[UIButton alloc]initWithFrame:CGRectMake(0, i, slideview.frame.size.width, 30)];
                [namebtn setTitle:[NSString stringWithFormat:@"%@",[btnname objectAtIndex:j]] forState:UIControlStateNormal];
                [namebtn setTitleColor:[UIColor colorWithRed:39.0f/255 green:39.0f/255.0f blue:39.0f/255.0f alpha:1] forState:UIControlStateNormal];
                namebtn.titleLabel.font = [UIFont fontWithName:@"helvetica" size:12];
                
                
                NSString* functionNamePrefix = @"actionMethod_";
                NSString* functionName = [functionNamePrefix stringByAppendingString:[NSString stringWithFormat:@"%d",j]];
                SEL selectorFromString = NSSelectorFromString(functionName);
                [namebtn addTarget:self action:selectorFromString forControlEvents:UIControlEventTouchDown];
                //namebtn addTarget:self action:@selector([NSString stringWithFormat:@"" ]) forControlEvents:<#(UIControlEvents)#>
                
                UIImageView *divider = [[UIImageView alloc]initWithFrame:CGRectMake(0, i, slideview.frame.size.width, 1)];
                divider.image = [UIImage imageNamed:@"divider-line"];
                [slideview addSubview:divider];
                [slideview addSubview:namebtn];
                i = i + 30;
            }
            
            //            UIButton *namebtn = [[UIButton alloc]initWithFrame:CGRectMake(0, i, slideview.frame.size.width, 30)];
            
            //            [slideview addSubview:backimg];
            [self.view addSubview:slideview];
        }
        else if (check == 6)
        {
            slideview = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width * .7, _headerimg.frame.size.height + self.subCatgoryView.frame.size.height + self.buttonScroll.frame.size.height, self.view.frame.size.width * .29, 100)];
            
            slideview.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
            slideview.layer.borderWidth = 2.0f;
            slideview.layer.cornerRadius = 4.0f;
            slideview.layer.borderColor = [UIColor colorWithRed:74.0f/255 green:133.0f/255.0f blue:219.0f/255.0f alpha:1].CGColor;
            [self.view addSubview:slideview];
        }
        viewslide = 1;
    }
    else
    {
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            // Fade the label
            
            [slideview setAlpha:0];
        }
                         completion:^(BOOL finished) {
                             [slideview removeFromSuperview];
                             [_subviewbtn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
                             viewslide = 0;
                             
                         }
         ];
        
        
        //        [_subviewbtn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
        //        [slideview removeFromSuperview];
        //        viewslide = 0;
    }
}

-(void)actionMethod_0
{
    _subcatagorylbl.text = [btnname objectAtIndex:0];
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        // Fade the label
        
        [slideview setAlpha:0];
    }
                     completion:^(BOOL finished) {
                         [slideview removeFromSuperview];
                         [_subviewbtn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
                         viewslide = 0;
                         
                     }
     ];
    
    //    [slideview removeFromSuperview];
    //    [_subviewbtn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
    //    viewslide = 0;
}

-(void)actionMethod_1
{
    _subcatagorylbl.text = [btnname objectAtIndex:1];
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        // Fade the label
        
        [slideview setAlpha:0];
    }
                     completion:^(BOOL finished) {
                         [slideview removeFromSuperview];
                         [_subviewbtn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
                         viewslide = 0;
                         
                     }
     ];
    
    //    [slideview removeFromSuperview];
    //    [_subviewbtn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
    //    viewslide = 0;
}

-(void)actionMethod_2
{
    _subcatagorylbl.text = [btnname objectAtIndex:2];
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        // Fade the label
        
        [slideview setAlpha:0];
    }
                     completion:^(BOOL finished) {
                         [slideview removeFromSuperview];
                         [_subviewbtn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
                         viewslide = 0;
                         
                     }
     ];
    
    //    [slideview removeFromSuperview];
    //    [_subviewbtn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
    //    viewslide = 0;
}

-(void)actionMethod_3
{
    _subcatagorylbl.text = [btnname objectAtIndex:3];
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        // Fade the label
        
        [slideview setAlpha:0];
    }
                     completion:^(BOOL finished) {
                         [slideview removeFromSuperview];
                         [_subviewbtn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
                         viewslide = 0;
                         
                     }
     ];
    
    //    [slideview removeFromSuperview];
    //    [_subviewbtn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
    //    viewslide = 0;
}

-(void)actionMethod_4
{
    _subcatagorylbl.text = [btnname objectAtIndex:4];
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        // Fade the label
        
        [slideview setAlpha:0];
    }
                     completion:^(BOOL finished) {
                         [slideview removeFromSuperview];
                         [_subviewbtn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
                         viewslide = 0;
                         
                     }
     ];
    
    //    [slideview removeFromSuperview];
    //    [_subviewbtn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
    //    viewslide = 0;
}

-(void)actionMethod_5
{
    _subcatagorylbl.text = [btnname objectAtIndex:5];
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        // Fade the label
        
        [slideview setAlpha:0];
    }
                     completion:^(BOOL finished) {
                         [slideview removeFromSuperview];
                         [_subviewbtn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
                         viewslide = 0;
                         
                     }
     ];
    
    //    [slideview removeFromSuperview];
    //    [_subviewbtn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
    //    viewslide = 0;
}

- (IBAction)listViewBtnTapped:(id)sender
{
    tapcheck = 0;
    [_tableview reloadData];
}

- (IBAction)GridViewBtnTapped:(id)sender
{
    tapcheck = 1;
    [_tableview reloadData];
}


//tableview delegate and data source method

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tapcheck == 0)
    {
        return 100;
    }
    else
    {
        return 200.0f;
    }
    return 0;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger someV =0;
    
    if (check == 3)
    {
        someV = mypropertyarr.count;
    }
    else if (check == 4)
    {
        someV = myaddvertisementsarr.count;
    }
    
    
    return someV;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (check == 3)
    {
        if (tapcheck == 0)
        {
            cell1 = (DashboardListCell *)[tableView dequeueReusableCellWithIdentifier:@"listing3-1"];
            
            //            cell1.scrollview.userInteractionEnabled = YES;
            //            [cell1.scrollview setContentSize:CGSizeMake(self.view.frame.size.width + 300, 100)];
            //            cell1.scrollview.showsHorizontalScrollIndicator = NO;
            //            cell1.scrollview.pagingEnabled = YES;
            
            
            if([(NSNull *)[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"property_type"] == [NSNull null])
            {
                cell1.titlelabel.text = @"No data found";
            }
            else
            {
                cell1.titlelabel.text = [[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"property_type"];
            }
            
            
            
            cell1.bedroomslabel.text = [NSString stringWithFormat:@"%@ Beds, %@ Bathrooms, %@ Rooms",[[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"no_of_beds"],[[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"no_of_baths"],[[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"no_of_rooms"]];
            cell1.pricelabel.text = @"No Price found";
            cell1.cellview.tag = indexPath.row;
            
            //            btn1 = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width, 0, (cell1.scrollview.frame.size.width)/3, 100)];
            //            btn2 = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width + (cell1.scrollview.frame.size.width)/3, 0, (cell1.scrollview.frame.size.width)/3, 100)];
            
            //            btn1 = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width, 0, 100, 100)];
            //            btn2 = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width + 100, 0, 100, 100)];
            //            btn3 = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width + 200, 0, 100, 100)];
            //
            //            btn1.backgroundColor = [UIColor lightGrayColor];
            //            [btn1 setTitle:@"btn1" forState:UIControlStateNormal];
            //            btn2.backgroundColor = [UIColor redColor];
            //            [btn2 setTitle:@"btn2" forState:UIControlStateNormal];
            //            btn3.backgroundColor = [UIColor blueColor];
            //            [btn3 setTitle:@"btn3" forState:UIControlStateNormal];
            //            //tap for view
            //
            //            UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTapped:)];
            //            tapGestureRecognize.delegate = self;
            //            tapGestureRecognize.numberOfTapsRequired = 1;
            //            [tapGestureRecognize requireGestureRecognizerToFail:tapGestureRecognize];
            //            [cell1.cellview addGestureRecognizer:tapGestureRecognize];
            //
            //            //
            //            [cell1.scrollview addSubview:btn1];
            //            [cell1.scrollview addSubview:btn2];
            //            [cell1.scrollview addSubview:btn3];
            return cell1;
        }
        else
        {
            cell2 = (DashboardGridCell *)[tableView dequeueReusableCellWithIdentifier:@"gridfavourite-1"];
            
            if([(NSNull *)[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"property_type"] == [NSNull null])
            {
                cell2.titlelabel.text = @"No data found";
            }
            else
            {
                cell2.titlelabel.text = [[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"property_type"];
            }
            
            cell2.bedroomslabel.text = [NSString stringWithFormat:@"%@ Beds, %@ Bathrooms, %@ Rooms",[[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"no_of_beds"],[[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"no_of_baths"],[[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"no_of_rooms"]];
            cell2.pricelabel.text = @"No Price found";
            
            return cell2;
        }
        
    }
    else if (check == 4)
    {
        if (tapcheck == 0)
        {
            
            cell1 = (DashboardListCell *)[tableView dequeueReusableCellWithIdentifier:@"listing3-1"];
            //            cell1.scrollview.userInteractionEnabled = YES;
            //            [cell1.scrollview setContentSize:CGSizeMake(cell1.contentView.frame.size.width + 300, 100)];
            //            cell1.scrollview.showsHorizontalScrollIndicator = NO;
            //            cell1.scrollview.pagingEnabled = YES;
            
            cell1.titlelabel.text=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"property_type"];
            NSString *type=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"advert_added_for"];
            if ([type isEqualToString:@"R"])
            {
                price=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"property_price"];
                NSString* pp = [NSString stringWithFormat:@"£%@ For Rent", price];
                cell1.pricelabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell1.pricelabel.text=pp;
            }
            else if ([type isEqualToString:@"S"])
            {
                price=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"property_price"];
                NSString* pp = [NSString stringWithFormat:@"£%@ For Sell", price];
                cell1.pricelabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell1.pricelabel.text=pp;
                
            }
            
            bedsnumber=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"no_of_beds"];
            bathsnumber=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"no_of_baths"];
            roomsnumber=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"no_of_rooms"];
            NSLog(@"%@",bathsnumber);
            NSString* strRR = [NSString stringWithFormat:@"%@ bedroom(s),%@ bathroom(s),%@ rooms(s)", bedsnumber, bathsnumber, roomsnumber];
            cell1.bedroomslabel.text=strRR;
            
            return cell1;
        }
        else
        {
            cell2 = (DashboardGridCell *)[tableView dequeueReusableCellWithIdentifier:@"gridfavourite-1"];
            
            cell2.titlelabel.text=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"property_type"];
            NSString *type=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"advert_added_for"];
            if ([type isEqualToString:@"R"])
            {
                price=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"property_price"];
                NSString* pp = [NSString stringWithFormat:@"£%@ For Rent", price];
                cell2.pricelabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell2.pricelabel.text=pp;
            }
            else if ([type isEqualToString:@"S"])
            {
                price=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"property_price"];
                NSString* pp = [NSString stringWithFormat:@"£%@ For Sell", price];
                cell2.pricelabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell2.pricelabel.text=pp;
                
            }
            
            bedsnumber=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"no_of_beds"];
            bathsnumber=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"no_of_baths"];
            roomsnumber=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"no_of_rooms"];
            NSLog(@"%@",bathsnumber);
            NSString* strRR = [NSString stringWithFormat:@"%@ bedroom(s),%@ bathroom(s),%@ rooms(s)", bedsnumber, bathsnumber, roomsnumber];
            cell2.bedroomslabel.text=strRR;
            
            return cell2;
        }
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexpath: %ld",(long)indexPath.row);
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    if (editingStyle == UITableViewCellEditingStyleDelete) {
    //
    //        //add code here for when you hit delete
    //    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellEditingStyleInsert;
    
}

- (NSArray *)tableView:(UITableView *)tableView
editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (check == 3)
    {
        if (indexPath.row >= 0) {
            
            UITableViewRowAction *button, *button2, *button3;
            if ([[[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"added_for_sell"] isEqualToString:@"N"] && [[[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"added_for_rent"] isEqualToString:@"N"])
            {
                button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"EDIT" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                          {
                              NSLog(@"Action to perform with Button 1");
                              MPEditProperty *editprop = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"editproperty1"];
                              editprop.regisdetail = [[mypropertyarr objectAtIndex:indexPath.row]mutableCopy];
                              [self.navigationController pushViewController:editprop animated:YES];
                              //                          NSLog(@"dic is:----%@",[mypropertyarr objectAtIndex:indexPath.row]);
                          }];
                
                button.backgroundColor = [UIColor colorWithRed:232/255.0f green:122/255.0f blue:86/255.0f alpha:1]; //arbitrary color
                
                button2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"SELL ME" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                           {
                               NSLog(@"Action to perform with Button2!");
                               
                               AddadvertisementViewController *add = (AddadvertisementViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"addadvertise"];
                               add.chkdata=@"S";
                               [self.navigationController pushViewController:add animated:YES];
                               
                           }];
                
                button2.backgroundColor = [UIColor colorWithRed:82.0f/255.0f green:173.0f/255.0f blue:33.0f/255.0f alpha:1]; //arbitrary color
                
                button3 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"LET ME" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                           {
                               
                               NSLog(@"Action to perform with Button3!");
                               
                               AddadvertisementViewController *add = (AddadvertisementViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"addadvertise"];
                               add.chkdata=@"R";
                               [self.navigationController pushViewController:add animated:YES];
                               
                               
                               
                               
                           }];
                
                button3.backgroundColor = [UIColor colorWithRed:32.0f/255.0f green:57.0f/255.0f blue:97.0f/255.0f alpha:1];
                return @[button, button2, button3];
                
            }
            
            else if ([[[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"added_for_rent"] isEqualToString:@"N"] && [[[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"added_for_sell"] isEqualToString:@"Y"])
            {
                button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"EDIT" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                          {
                              NSLog(@"Action to perform with Button 1");
                          }];
                
                button.backgroundColor = [UIColor colorWithRed:232/255.0f green:122/255.0f blue:86/255.0f alpha:1]; //arbitrary color
                button3 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"LET ME" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                           {
                               
                               NSLog(@"Action to perform with Button3!");
                               AddadvertisementViewController *add = (AddadvertisementViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"addadvertise"];
                               add.chkdata=@"R";
                               [self.navigationController pushViewController:add animated:YES];
                               
                           }];
                
                button3.backgroundColor = [UIColor colorWithRed:32.0f/255.0f green:57.0f/255.0f blue:97.0f/255.0f alpha:1]; //arbitrary color
                
                return @[button, button3];
                
            }
            else if ([[[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"added_for_rent"] isEqualToString:@"Y"] && [[[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"added_for_sell"] isEqualToString:@"N"])
            {
                button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"EDIT" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                          {
                              NSLog(@"Action to perform with Button 1");
                          }];
                
                button.backgroundColor = [UIColor colorWithRed:232/255.0f green:122/255.0f blue:86/255.0f alpha:1]; //arbitrary color
                button2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"SELL ME" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                           {
                               NSLog(@"Action to perform with Button2!");
                               
                               AddadvertisementViewController *add = (AddadvertisementViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"addadvertise"];
                               add.chkdata=@"S";
                               [self.navigationController pushViewController:add animated:YES];
                           }];
                
                button2.backgroundColor = [UIColor colorWithRed:82.0f/255.0f green:173.0f/255.0f blue:33.0f/255.0f alpha:1]; //arbitrary color
                return @[button, button2];
                
            }
            
            else if ([[[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"added_for_sell"] isEqualToString:@"Y"] && [[[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"added_for_rent"] isEqualToString:@"Y"])
            {
                button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"EDIT" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                          {
                              NSLog(@"Action to perform with Button 1");
                          }];
                
                button.backgroundColor = [UIColor colorWithRed:232/255.0f green:122/255.0f blue:86/255.0f alpha:1]; //arbitrary color
                return @[button];
            }
            
            
            
            return @[button, button2,button3];
        }
    }
    else if (check == 4)
        
    {
        
        NSLog(@"updated index path%ld",(long)indexPath.row);
        
        if (indexPath.row>=0) {
            
            
            
            NSLog(@"index %ld",(long)indexPath.row);
            
            
            
            NSString *dd = [[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"expiry_date"];
            
            NSLog(@"dd%@",dd);
            
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            
            [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
            
            [dateFormat setDateFormat:@"yyyy-MM-dd"];
            
            //[dateFormat setDateFormat:@"dd/MM/YYYY"];
            
            NSDate *date1 = [dateFormat dateFromString:dd];
            
            NSLog(@"Date1: %@", date1);
            
            NSDate *date2=[NSDate date];
            
            //NSLog(@"system date %@",date2);
            
            if ([date1 compare:date2] == NSOrderedDescending) {
                
                NSLog(@"date1 is later than date2");
                
                experidate=false;
                
            } else if ([date1 compare:date2] == NSOrderedAscending) {
                
                NSLog(@"date1 is earlier than date2");
                
                experidate=true;
                
            } else {
                
                NSLog(@"dates are the same");
                
                experidate=false;
                
            }
            
            if ([[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"publish_stat"] isEqualToString:@"Y"] && experidate==true)
                
            {
                
                UITableViewRowAction *button;
                
                UITableViewRowAction *button2;
                
                UITableViewRowAction *button3;
                
                
                
                button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"REMOVE" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                          
                          
                          
                          {
                              
                              
                              
                              NSLog(@"Action to perform with REMOVE");
                              
                              
                              
                          }];
                
                
                
                
                
                
                
                button.backgroundColor = [UIColor colorWithRed:232/255.0f green:122/255.0f blue:86/255.0f alpha:1];; //arbitrary color
                
                
                
                
                
                
                
                
                
                NSString *type=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"advert_added_for"];
                
                if ([type isEqualToString:@"R"])
                    
                {
                    
                    button2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"EDIT" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                               
                               
                               
                               {
                                   
                                   
                                   
                                   NSLog(@"Action to perform with EDIT for rent");
                                   
                                   //NSLog(@"%@",[myaddvertisementsarr objectAtIndex:indexPath.row]);
                                   
                                   AddadvertisementViewController *add = (AddadvertisementViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"addadvertise"];
                                   add.chkdata=@"R";
                                   add.prevprice= [[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"property_price"];
                                   [self.navigationController pushViewController:add animated:YES];
                                   
                               }];
                    
                    
                    
                }
                
                else if ([type isEqualToString:@"S"])
                    
                {
                    
                    button2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"EDIT" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                               
                               
                               
                               {
                                   
                                   
                                   
                                   NSLog(@"Action to perform with EDIT for sale");
                                   
                                   // NSLog(@"%@",[myaddvertisementsarr objectAtIndex:indexPath.row]);
                                   AddadvertisementViewController *add = (AddadvertisementViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"addadvertise"];
                                   add.chkdata=@"S";
                                   add.prevprice= [[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"property_price"];
                                   [self.navigationController pushViewController:add animated:YES];
                                   
                                   
                               }];
                    
                }
                
                
                
                button2.backgroundColor = [UIColor colorWithRed:82.0f/255.0f green:173.0f/255.0f blue:33.0f/255.0f alpha:1]; //arbitrary color
                
                
                
                
                
                
                
                button3 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"RENEW" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                           
                           
                           
                           {
                               
                               
                               
                               
                               
                               NSLog(@"Action to perform with RENEW");
                               
                               
                               
                               NSString *renew = [NSString stringWithFormat:@"%@json_output.php?mode=renew_advert&advert_id=%@",App_Domain_Url,[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"advert_id"]];
                               
                               
                               
                               [obj GlobalDict:renew Globalstr:@"array" Withblock:^(id result, NSError *error)
                                
                                {
                                    
                                    NSLog(@"renew api%@",result);
                                    
                                    
                                    
                                    /////
                                    
                                    NSString *myaddvertiseurl = [NSString stringWithFormat:@"%@json_output.php?mode=list_my_property_advertisements&user_id=4",App_Domain_Url];
                                    
                                    myaddvertisementsarr=[[NSMutableArray alloc]init];
                                    
                                    [obj GlobalDict:myaddvertiseurl Globalstr:@"array" Withblock:^(id result, NSError *error)
                                     
                                     {
                                         
                                         myaddvertisementsarr=[result mutableCopy];
                                         
                                         [_tableview reloadData];
                                         
                                     }];
                                    
                                    
                                    
                                }];
                               
                               //tableView.editing=false;
                               
                               
                               
                               
                               
                               
                               
                               
                               
                           }];
                
                
                
                
                
                
                
                button3.backgroundColor = [UIColor colorWithRed:32.0f/255.0f green:57.0f/255.0f blue:97.0f/255.0f alpha:1];;
                
                
                
                return @[button, button2,button3];
                
            }
            
            
            
            else if ([[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"publish_stat"] isEqualToString:@"N"] && experidate==true)
                
            {
                
                UITableViewRowAction *button2;
                
                UITableViewRowAction *button3;
                
                
                
                NSString *type=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"advert_added_for"];
                
                if ([type isEqualToString:@"R"])
                    
                {
                    
                    button2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"EDIT" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                               
                               
                               
                               {
                                   
                                   
                                   
                                   NSLog(@"Action to perform with EDIT for rent");
                                   
                                   //NSLog(@"%@",[myaddvertisementsarr objectAtIndex:indexPath.row]);
                                   AddadvertisementViewController *add = (AddadvertisementViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"addadvertise"];
                                   add.chkdata=@"R";
                                   add.prevprice= [[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"property_price"];
                                   [self.navigationController pushViewController:add animated:YES];
                                   
                                   
                               }];
                    
                    
                    
                }
                
                else if ([type isEqualToString:@"S"])
                    
                {
                    
                    button2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"EDIT" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                               
                               
                               
                               {
                                   
                                   
                                   
                                   NSLog(@"Action to perform with EDIT for sale");
                                   
                                   //NSLog(@"%@",[myaddvertisementsarr objectAtIndex:indexPath.row]);
                                   AddadvertisementViewController *add = (AddadvertisementViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"addadvertise"];
                                   add.chkdata=@"S";
                                   add.prevprice= [[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"property_price"];
                                   [self.navigationController pushViewController:add animated:YES];
                                   
                                   
                               }];
                    
                }
                
                
                
                
                
                button2.backgroundColor = [UIColor colorWithRed:82.0f/255.0f green:173.0f/255.0f blue:33.0f/255.0f alpha:1]; //arbitrary color
                
                
                
                
                
                
                
                button3 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"RENEW" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                           
                           
                           
                           {
                               
                               
                               
                               
                               
                               
                               
                               NSLog(@"Action to perform with RENEW!");
                               
                               
                               
                               NSString *renew = [NSString stringWithFormat:@"%@json_output.php?mode=renew_advert&advert_id=%@",App_Domain_Url,[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"advert_id"]];
                               
                               
                               
                               [obj GlobalDict:renew Globalstr:@"array" Withblock:^(id result, NSError *error)
                                
                                {
                                    
                                    NSLog(@"%@",result);
                                    
                                    NSString *myaddvertiseurl = [NSString stringWithFormat:@"%@json_output.php?mode=list_my_property_advertisements&user_id=4",App_Domain_Url];
                                    
                                    myaddvertisementsarr=[[NSMutableArray alloc]init];
                                    
                                    [obj GlobalDict:myaddvertiseurl Globalstr:@"array" Withblock:^(id result, NSError *error)
                                     
                                     {
                                         
                                         myaddvertisementsarr=[result mutableCopy];
                                         
                                         [_tableview reloadData];
                                         
                                     }];
                                    
                                    
                                    
                                    
                                    
                                }];
                               
                               
                               
                               
                               
                               
                           }];
                
                
                
                
                
                
                
                button3.backgroundColor = [UIColor colorWithRed:32.0f/255.0f green:57.0f/255.0f blue:97.0f/255.0f alpha:1];;
                
                
                
                
                
                
                
                return @[button2,button3];
                
            }
            
            else if ([[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"publish_stat"] isEqualToString:@"Y"] || experidate==false)
                
            {
                
                UITableViewRowAction *button;
                
                UITableViewRowAction *button2;
                
                
                
                
                
                
                
                button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"REMOVE" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                          
                          
                          
                          {
                              
                              
                              
                              NSLog(@"Action to perform with REMOVE");
                              
                              
                              
                              
                              
                          }];
                
                
                
                
                
                
                
                button.backgroundColor = [UIColor colorWithRed:232/255.0f green:122/255.0f blue:86/255.0f alpha:1];; //arbitrary color
                
                
                
                
                
                
                
                NSString *type=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"advert_added_for"];
                
                if ([type isEqualToString:@"R"])
                    
                {
                    
                    button2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"EDIT" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                               
                               
                               
                               {
                                   
                                   
                                   
                                   NSLog(@"Action to perform with EDIT for rent");
                                   
                                   //NSLog(@"%@",[myaddvertisementsarr objectAtIndex:indexPath.row]);
                                   
                                   
                                   AddadvertisementViewController *add = (AddadvertisementViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"addadvertise"];
                                   add.chkdata=@"R";
                                   add.prevprice= [[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"property_price"];
                                   [self.navigationController pushViewController:add animated:YES];
                               }];
                    
                    
                    
                }
                
                else if ([type isEqualToString:@"S"])
                    
                {
                    
                    button2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"EDIT" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                               
                               
                               
                               {
                                   
                                   
                                   
                                   NSLog(@"Action to perform with EDIT for sale");
                                   
                                   //NSLog(@"%@",[myaddvertisementsarr objectAtIndex:indexPath.row]);
                                   AddadvertisementViewController *add = (AddadvertisementViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"addadvertise"];
                                   add.chkdata=@"S";
                                   add.prevprice= [[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"property_price"];
                                   [self.navigationController pushViewController:add animated:YES];
                                   
                               }];
                    
                }
                
                
                
                
                
                
                
                button2.backgroundColor = [UIColor colorWithRed:82.0f/255.0f green:173.0f/255.0f blue:33.0f/255.0f alpha:1]; //arbitrary color
                
                
                
                
                
                
                
                
                
                return @[button, button2];
                
            }
            
            else if ([[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"publish_stat"] isEqualToString:@"N"] || experidate==false)
                
            {
                
                UITableViewRowAction *button2;
                
                NSString *type=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"advert_added_for"];
                
                if ([type isEqualToString:@"R"])
                    
                {
                    
                    button2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"EDIT" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                               
                               
                               
                               {
                                   
                                   
                                   
                                   NSLog(@"Action to perform with EDIT for rent");
                                   
                                   //NSLog(@"%@",[myaddvertisementsarr objectAtIndex:indexPath.row]);
                                   
                                   AddadvertisementViewController *add = (AddadvertisementViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"addadvertise"];
                                   add.chkdata=@"R";
                                   add.prevprice= [[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"property_price"];
                                   [self.navigationController pushViewController:add animated:YES];
                                   
                               }];
                    
                    
                    
                }
                
                else if ([type isEqualToString:@"S"])
                    
                {
                    
                    button2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"EDIT" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                               
                               
                               
                               {
                                   
                                   
                                   
                                   NSLog(@"Action to perform with EDIT for sale");
                                   
                                   //NSLog(@"%@",[myaddvertisementsarr objectAtIndex:indexPath.row]);
                                   AddadvertisementViewController *add = (AddadvertisementViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"addadvertise"];
                                   add.chkdata=@"S";
                                   add.prevprice= [[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"property_price"];
                                   [self.navigationController pushViewController:add animated:YES];
                                   
                                   
                               }];
                    
                }
                
                
                
                
                
                
                
                
                
                button2.backgroundColor = [UIColor colorWithRed:82.0f/255.0f green:173.0f/255.0f blue:33.0f/255.0f alpha:1]; //arbitrary color
                
                
                
                return @[ button2];
                
            }
        }
        
    }
    return nil;
}

//-(void)scrollViewTapped:(UITapGestureRecognizer *)sender
//{
//    NSLog(@"tag:---- %ld",(long)sender.view.tag);
//}




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
