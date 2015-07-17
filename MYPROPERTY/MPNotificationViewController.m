//
//  MPNotificationViewController.m
//  MYPROPERTY
//
//  Created by Somenath on 03/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "MPNotificationViewController.h"
#import "Footer.h"
#import "FavouriteViewController.h"
#import "QFProfileViewController.h"
#import "PropertyDetails2ViewController.h"
#import "PropertyViewController.h"
#import "LeftMenu.h"
#import "MPDashBoardViewController.h"
#import "ChangePasswordViewController.h"
#import "RightMenu.h"
#import "Listing0ViewController.h"
#import "SearchViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "MPRegisterPropertyViewController.h"


@interface MPNotificationViewController () <UITableViewDataSource,UITabBarDelegate,footerdelegate,leftDelegate,rightDelegate,UIGestureRecognizerDelegate,UISearchBarDelegate>
{
    BOOL leftslide,rightslide;
    LeftMenu *leftView;
    RightMenu *rightView;
    UIView *blackview;
    Footer *footerView;
}

@property (strong, nonatomic) IBOutlet UIView *mainview;
@property (strong, nonatomic) IBOutlet UIView *headerview;
@end

@implementation MPNotificationViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    footerView=[[Footer alloc]init];
    blackview = [[UIView alloc]init];
    
    [footerView setFrame:CGRectMake(0, self.view.frame.size.height - 60, self.view.frame.size.width, 60)];
    
    footerView.footerdelegate=self;
    [footerView TapCheck:4];
    [self.mainview addSubview:footerView];
    
    _searchalert.hidden = YES;
    _bookingalert.hidden = YES;
    _renewalert.hidden = YES;
    _offeralert.hidden = YES;
    _propertyalert.hidden = YES;
    
    [_msgtableview reloadData];
}

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
        MPRegisterPropertyViewController *prop = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"registerproperty"];
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
            
            [blackview setFrame:CGRectMake(0, self.headerview.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
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

- (IBAction)leftMenuTapped:(id)sender
{
    if (leftslide == 0)
    {
        leftView = [[LeftMenu alloc]init];
        [leftView setFrame:CGRectMake(-220, 0,self.view.frame.size.width*.6, self.mainview.frame.size.height)];
        leftView.leftDelegate = self;
        [self.view addSubview:leftView];
        
        
        [UIView animateWithDuration:.5 animations:^{
            
            [self.mainview setFrame:CGRectMake(self.mainview.frame.size.width*.6,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height)];
            
            [leftView setFrame:CGRectMake(0, 0,self.view.frame.size.width*.6, self.mainview.frame.size.height)];
            
            
            //            [self.view addSubview:leftView];
            
        }];
        
        leftslide = 1;
    }
    else
    {
        [UIView animateWithDuration:.5 animations:^{
            
            [self.mainview setFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height)];
            
            [leftView setFrame:CGRectMake(-leftView.frame.size.width, 0,self.view.frame.size.width*.6, self.mainview.frame.size.height)];
            
        }
         
         
         
         
         
         
         
         
         
         
         ];
        
        leftslide = 0;
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

-(void)leftclk:(UIButton *)sender
{
    NSInteger tagId;
    tagId = sender.tag;
    NSLog(@"%ld",(long)tagId);
    if ( tagId == 100 )
    {
        NSLog(@"tagid is: %ld",(long)tagId);
        MPDashBoardViewController *fav = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"dashboard"];
        [self.mainview setFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height)];
        
        [leftView removeFromSuperview];
        leftslide = 0;
        
        [self.navigationController pushViewController:fav animated:NO];
    }
//    else if ( tagId == 101 )
//    {
//        Listing0ViewController *fav = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"list0"];
//        [self.navigationController pushViewController:fav animated:NO];
//    }
}


- (IBAction)settingsTapped:(id)sender
{
    [_settingbtn setTitleColor:[UIColor colorWithRed:(224.0f/255.0f) green:(63.0f/255.0f) blue:(87.0f/255.0f) alpha:1] forState:UIControlStateNormal];
    _messagebtn.titleLabel.textColor = [UIColor colorWithRed:(145.0f/255.0f) green:(145.0f/255.0f) blue:(145.0f/255.0f) alpha:1];
    
    _msgtableview.hidden = YES;
    
    _searchalert.hidden = NO;
    _bookingalert.hidden = NO;
    _renewalert.hidden = NO;
    _offeralert.hidden = NO;
    _propertyalert.hidden = NO;
    
   
    
}

- (IBAction)messageTapped:(id)sender
{
    _messagebtn.titleLabel.textColor = [UIColor colorWithRed:(224.0f/255.0f) green:(63.0f/255.0f) blue:(87.0f/255.0f) alpha:1];
    _settingbtn.titleLabel.textColor = [UIColor colorWithRed:(145.0f/255.0f) green:(145.0f/255.0f) blue:(145.0f/255.0f) alpha:1];

    _msgtableview.hidden = NO;
    
    _searchalert.hidden = YES;
    _bookingalert.hidden = YES;
    _renewalert.hidden = YES;
    _offeralert.hidden = YES;
    _propertyalert.hidden = YES;
    
    
    
}


// Message table view delegate and data source methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return [jsonarray count];
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = (NotificationCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    //    cell = [[MyMessageCell alloc]init];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PropertyDetails2ViewController *prop2 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"propertydetail"];
    [self.navigationController pushViewController:prop2 animated:YES];
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

- (IBAction)gridViewbtn:(id)sender {
}

- (IBAction)listViewbtn:(id)sender {
}
@end
