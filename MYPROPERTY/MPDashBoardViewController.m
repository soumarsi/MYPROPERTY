//
//  MPDashBoardViewController.m
//  MYPROPERTY
//
//  Created by Shwetaa's iMac on 11/08/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "MPDashBoardViewController.h"
#import "Footer.h"
#import "SearchViewController.h"
#import "FavouriteViewController.h"
#import "PropertyViewController.h"
#import "RightMenu.h"
#import "InviteFriendsViewController.h"
#import "QFProfileViewController.h"
#import "ChangePasswordViewController.h"
#import "SubCatagoryView.h"
#import "MPAppointmentViewController.h"
#import "MPOfferAlertsViewController.h"


@import UIKit;

@interface MPDashBoardViewController ()<footerdelegate,rightDelegate,UIGestureRecognizerDelegate,SubCatagoryDelegate>
{
    Footer *footerView;
    BOOL rightslide,viewslide;
    RightMenu *rightView;
     UIView *slideview, *blackview;
    SubCatagoryView *subcat;
    UIView *subview1;
    
}

@end

@implementation MPDashBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    viewslide = 0;
    blackview = [[UIView alloc]init];
     rightslide = 0;
    footerView=[[Footer alloc]init];
    
    [footerView setFrame:CGRectMake(0, self.view.frame.size.height - 60, self.view.frame.size.width, 60)];
    
    footerView.footerdelegate=self;
    [self.mainview addSubview:footerView];
    
    [footerView TapCheck:4];
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
        PropertyViewController *prop = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"registerproperty"];
        [self.navigationController pushViewController:prop animated:NO];
    }
    else if (tagId == 4)
    {
        NSLog(@"tagid is: %ld",(long)tagId);
        
        //MPDashBoardViewController *fav = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"dashboard"];
        //[self.navigationController pushViewController:fav animated:NO];
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
            //[tapGestureRecognize requireGestureRecognizerToFail:tapGestureRecognize];
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
    //[self.view removeGestureRecognizer:tap];
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





-(void)rightclk:(UIButton *)sender
{
    NSInteger tagId;
    tagId = sender.tag;
    NSLog(@"%ld",(long)tagId);
    if (tagId == 1)
    {
        InviteFriendsViewController *pro = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"invite"];
        [self.navigationController pushViewController:pro animated:YES];
        [rightView removeFromSuperview];
        [blackview removeFromSuperview];
        rightslide = 0;
        
    }
    else if ( tagId == 2 )
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

















- (IBAction)backbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)subcatbtn:(id)sender
{
    if (viewslide==0) {
        subcat = [[SubCatagoryView alloc]init];
        
        [subcat setFrame:CGRectMake(self.view.frame.size.width * .55, _headerimg.frame.size.height + self.subCatgoryView.frame.size.height +2, self.view.frame.size.width * .44, 210)];
        subcat.SubCatagoryDelegate = self;
        [subcat TapCheck:1];
        
        subcat.layer.borderWidth = 1.0f;
        subcat.layer.cornerRadius = 4.0f;
        subcat.layer.borderColor = [UIColor colorWithRed:200.0f/255 green:200.0f/255.0f blue:200.0f/255.0f alpha:1].CGColor;
        
        subcat.layer.shadowOffset = CGSizeMake(-1, 1);
        subcat.layer.shadowRadius = 6;
        subcat.layer.shadowOpacity = 0.5;
        
        
        [subcat.layer setMasksToBounds:YES];
        
        
       subview1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [_mainview addSubview:subview1];
        
        
        
        UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelSubViewByTap)];
        tapGestureRecognize.delegate = self;
        tapGestureRecognize.numberOfTapsRequired = 1;
        //[tapGestureRecognize requireGestureRecognizerToFail:tapGestureRecognize];
        [subview1 addGestureRecognizer:tapGestureRecognize];
        viewslide = 1;
        
        [subview1 addSubview:subcat];
        
        
    }
    else
    {
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            // Fade the label
            
            [subcat setAlpha:0];
        }
                         completion:^(BOOL finished) {
                             [subview1 removeFromSuperview];
                             [subcat removeFromSuperview];
                            // [_subviewbtn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
                             viewslide = 0;
                             
                         }
         ];
    }
    
}


-(void)cancelSubViewByTap
{
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        // Fade the label
        
        [subcat setAlpha:0];
    }
                     completion:^(BOOL finished) {
                         [subview1 removeFromSuperview];
                         [subcat removeFromSuperview];
                         //[_subviewbtn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
                         viewslide = 0;
                         
                     }
     ];
    
}




-(void)subCatagoryClk:(UIButton *)sender
{
    if (sender.tag == 200)
    {
        NSLog(@"1");
        [subcat TapCheck:1];
    }
    else if (sender.tag == 201)
    {
        NSLog(@"2");
        [subcat TapCheck:2];
    }
    else if (sender.tag == 202)
    {
        NSLog(@"3");
        [subcat TapCheck:3];
        MPAppointmentViewController *appo = (MPAppointmentViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"appointment"];
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            // Fade the label
            
            [subcat setAlpha:0];
        }
                         completion:^(BOOL finished) {
                             [subview1 removeFromSuperview];
                             [subcat removeFromSuperview];
                            // [_subviewbtn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
                             viewslide = 0;
                             
                         }
         ];
        [self.navigationController pushViewController:appo animated:NO];
    }
    else if (sender.tag == 203)
    {
        NSLog(@"4");
        [subcat TapCheck:4];
        MPOfferAlertsViewController *offer = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"offeralerts"];
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            // Fade the label
            
            [subcat setAlpha:0];
        }
                         completion:^(BOOL finished) {
                             [subview1 removeFromSuperview];
                             [subcat removeFromSuperview];
                            // [_subviewbtn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
                             viewslide = 0;
                             
                         }
         ];
        [self.navigationController pushViewController:offer animated:NO];
        
    }
    else if (sender.tag == 204)
    {
        NSLog(@"5");
        [subcat TapCheck:5];
    }
    else if (sender.tag == 205)
    {
        NSLog(@"6");
        [subcat TapCheck:6];
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
