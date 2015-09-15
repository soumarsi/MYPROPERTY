//
//  FavouriteViewController.m
//  myProfile
//
//  Created by Shwetaa's iMac on 03/07/15.
//  Copyright (c) 2015 kausik jati. All rights reserved.
//

#import "FavouriteViewController.h"
#import "RightMenu.h"
#import "Footer.h"
#import "MPNotificationViewController.h"
#import "QFProfileViewController.h"
#import "PropertyDetails2ViewController.h"
#import "PropertyViewController.h"
#import "GridefavouriteTableViewCell.h"
#import "LeftMenu.h"
#import "MPDashBoardViewController.h"
#import "ChangePasswordViewController.h"
#import "Listing0ViewController.h"
#import "SearchViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "MPRegisterPropertyViewController.h"
#import "InviteFriendsViewController.h"
#import "MPMyPropertyViewController.h"
#import "MPMyAddvertisementViewController.h"
#import "UIImageView+WebCache.h"
#import "MPSendToFriendViewController.h"


@interface FavouriteViewController ()<footerdelegate,UIGestureRecognizerDelegate,rightDelegate,leftDelegate>
{
    RightMenu *rightView;
    BOOL rightslide;
    Footer *footerView;
    UIView *blackview;
    BOOL tablechk, leftslide, check, menudownbool;
    LeftMenu *leftView;
    FW_JsonClass *obj;
    NSUserDefaults *userinfo;
    NSMutableDictionary *favdic;
    NSMutableArray *sellarr, *rentarr, *imagearrayrentgrid, *imagearraysellgrid;
    NSMutableArray *send_arr_sell, *send_arr_rent, *image_arr,*image_arr2;
    UIView *menudownview;
    UIImageView *uparrow;
    NSArray *btnname;
    NSString *userid;
    NSMutableDictionary *selectPropertyDetail;
    UIView *polygonView;
    UIView *subview;
}

@property (strong, nonatomic) IBOutlet UIView *mainview;
@property (strong, nonatomic) IBOutlet UIButton *sellbtn;
@property (strong, nonatomic) IBOutlet UIButton *rentbtn;
@property (strong, nonatomic) IBOutlet UIButton *selectAllBtn;
@property (strong, nonatomic) IBOutlet UIButton *deSelectAllBtn;
@property (strong, nonatomic) IBOutlet UIButton *menu_down;
@property (strong, nonatomic) IBOutlet UIImageView *headerimg;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) IBOutlet UILabel *nodatafoundlbl;

@end

@implementation FavouriteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    send_arr_sell = [[NSMutableArray alloc]init];
    send_arr_rent = [[NSMutableArray alloc]init];
    
    _deSelectAllBtn.hidden = YES;
    
    obj = [[FW_JsonClass alloc]init];
    check = 0;
    menudownbool = 0;
    
    userinfo=[[NSUserDefaults alloc]init];
    userid = [userinfo objectForKey:@"id"];
    NSLog(@"userid is : %@",userid);
    
    tablechk=true;
    rightslide = 0;
    leftslide = 0;
    
    _tableviewfevourite.delegate=self;
    _tableviewfevourite.dataSource=self;
    
    footerView = [[Footer alloc]init];
    blackview = [[UIView alloc]init];
    
    [footerView setFrame:CGRectMake(0, self.view.frame.size.height - 60, self.view.frame.size.width, 60)];
    
    footerView.footerdelegate=self;
    [footerView TapCheck:2];
    [self.mainview addSubview:footerView];
    
    [_sellbtn setTitleColor:[UIColor colorWithRed:74.0f/255.0f green:133.0f/255.0f blue:219.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [_rentbtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    NSString *urlstr = [NSString stringWithFormat:@"%@json_output.php?mode=user_saved_property_list&user_id=%@",App_Domain_Url,userid];
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    backview.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.3];
    [backview addSubview:_spinner];
    [_mainview addSubview:backview];
    [_spinner setHidden:NO];
    [_spinner startAnimating];
    
    [obj GlobalDict:urlstr Globalstr:@"array" Withblock:^(id result, NSError *error) {
        favdic = [result mutableCopy];
        sellarr = [favdic valueForKey:@"sell"];
        rentarr = [favdic valueForKey:@"rent"];
        
        [_sellbtn setTitle:[NSString stringWithFormat:@"Sell (%ld)",(long)sellarr.count] forState:UIControlStateNormal];
        [_rentbtn setTitle:[NSString stringWithFormat:@"Rent (%ld)",(long)rentarr.count] forState:UIControlStateNormal];
        
        if (sellarr.count == 0)
        {
            _nodatafoundlbl.hidden = NO;
            [_tableviewfevourite reloadData];
        }
        else
        {
            _nodatafoundlbl.hidden = YES;
            [_tableviewfevourite reloadData];
        }
        
        [_spinner setHidden:YES];
        [_spinner stopAnimating];
        [backview removeFromSuperview];
        
        [_tableviewfevourite reloadData];
    }];
    
    
    // Do any additional setup after loading the view.
}

- (IBAction)menuDropTapped:(id)sender
{
    if (menudownbool == 0)
    {
        menudownview = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width *.7, self.headerimg.frame.size.height, self.view.frame.size.width *.29, 120)];
//        [_menu_down setImage:[UIImage imageNamed:@"menu_up"] forState:UIControlStateNormal];
        
        uparrow = [[UIImageView alloc]initWithFrame:CGRectMake(self.menu_down.frame.origin.x + (self.menu_down.frame.size.width/2) - 7, self.headerimg.frame.size.height - 5, 15, 10)];
        uparrow.image = [UIImage imageNamed:@"uparrow"];
        uparrow.contentMode = UIViewContentModeScaleAspectFit;
        [self.headerimg addSubview:uparrow];
        
        menudownview.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
        menudownview.layer.borderWidth = 1.0f;
        menudownview.layer.borderColor = [UIColor colorWithRed:230.0f/255.0f green:230.0f/255.0f blue:230.0f/255.0f alpha:1].CGColor;
        menudownview.layer.cornerRadius = 4.0f;
        
        menudownview.layer.shadowOffset = CGSizeMake(-1, 1);
        menudownview.layer.shadowRadius = 4;
        menudownview.layer.shadowOpacity = 0.5;
//        [menudownview.layer setMasksToBounds:YES];
        
        
        subview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        
        
        
        
        UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelSubViewByTap)];
        [tapGestureRecognize setCancelsTouchesInView:NO];
        tapGestureRecognize.delegate = self;
        tapGestureRecognize.numberOfTapsRequired = 1;
        //[tapGestureRecognize requireGestureRecognizerToFail:tapGestureRecognize];
        [subview addGestureRecognizer:tapGestureRecognize];
        
        [_mainview addSubview:subview];
        
        btnname = [NSArray arrayWithObjects:@"Select all", @"Deselect all", @"Invite friends", nil];
        NSInteger i = 0;
        for (int j = 0 ; j<3 ; j++)
        {
            UIButton *namebtn = [[UIButton alloc]initWithFrame:CGRectMake(0, i, menudownview.frame.size.width, 40)];
            [namebtn setTitle:[NSString stringWithFormat:@"%@",[btnname objectAtIndex:j]] forState:UIControlStateNormal];
            [namebtn setTitleColor:[UIColor colorWithRed:39.0f/255 green:39.0f/255.0f blue:39.0f/255.0f alpha:1] forState:UIControlStateNormal];
            namebtn.titleLabel.font = [UIFont fontWithName:@"helvetica" size:12];
            
            
            NSString* functionNamePrefix = @"actionMethod_";
            NSString* functionName = [functionNamePrefix stringByAppendingString:[NSString stringWithFormat:@"%d",j]];
            SEL selectorFromString = NSSelectorFromString(functionName);
            [namebtn addTarget:self action:selectorFromString forControlEvents:UIControlEventTouchDown];
            
            UIImageView *divider = [[UIImageView alloc]initWithFrame:CGRectMake(0, i, menudownview.frame.size.width, 1)];
            divider.image = [UIImage imageNamed:@"divider-line"];
            [menudownview addSubview:divider];
            [menudownview addSubview:namebtn];
            i = i + 40;
        }

        
        [subview addSubview:menudownview];
        menudownbool = 1;
    }
    else
    {
        [menudownview removeFromSuperview];
        [uparrow removeFromSuperview];
//        [_menu_down setImage:[UIImage imageNamed:@"menu_down"] forState:UIControlStateNormal];
        menudownbool = 0;
    }
}

-(void)cancelSubViewByTap
{
    [subview removeFromSuperview];
    [menudownview removeFromSuperview];
    [uparrow removeFromSuperview];
    menudownbool = 0;
}

-(void)actionMethod_0
{
    NSLog(@"action0");
    [subview removeFromSuperview];
    [menudownview removeFromSuperview];
    [uparrow removeFromSuperview];
    //        [_menu_down setImage:[UIImage imageNamed:@"menu_down"] forState:UIControlStateNormal];
    menudownbool = 0;
    if (check == 0)
    {
        for (int i=0; i<sellarr.count; i++)
        {
            if ([send_arr_sell containsObject:[[sellarr objectAtIndex:i]objectForKey:@"property_saved_id"]])
            {
                
            }
            else
            {
                
                [send_arr_sell addObject:[[sellarr objectAtIndex:i]objectForKey:@"property_saved_id"]];
            }
            
        }
        [_tableviewfevourite reloadData];
    }
    else if (check == 1)
    {
        for (int i=0; i<rentarr.count; i++)
        {
            if ([send_arr_rent containsObject:[[rentarr objectAtIndex:i]objectForKey:@"property_saved_id"]])
            {}
            else
            {
                
                [send_arr_rent addObject:[[rentarr objectAtIndex:i]objectForKey:@"property_saved_id"]];
            }
        }
        [_tableviewfevourite reloadData];
    }

    NSLog(@"send_arr_sell array====%@",send_arr_sell);
    NSLog(@"send_arr_rent array====%@",send_arr_rent);
}

-(void)actionMethod_1
{
    NSLog(@"action1");
    [subview removeFromSuperview];
    [menudownview removeFromSuperview];
    [uparrow removeFromSuperview];
    //        [_menu_down setImage:[UIImage imageNamed:@"menu_down"] forState:UIControlStateNormal];
    menudownbool = 0;
    if (check == 0)
    {
        [send_arr_sell removeAllObjects];
        NSLog(@"After deselect sell====%@",send_arr_sell);
        [_tableviewfevourite reloadData];
    }
    else
    {
        [send_arr_rent removeAllObjects];
        NSLog(@"After deselect rent====%@",send_arr_rent);
        [_tableviewfevourite reloadData];
    }

}

-(void)actionMethod_2
{
    NSLog(@"action2");
    [subview removeFromSuperview];
    [menudownview removeFromSuperview];
    [uparrow removeFromSuperview];
    //        [_menu_down setImage:[UIImage imageNamed:@"menu_down"] forState:UIControlStateNormal];
    menudownbool = 0;
    
    if (check == 0)
    {
        if (send_arr_sell.count == 0)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Please select atleast one property" message: @"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
            [alert show];
        }
        else
        {
            NSString *idjoinedstring = [send_arr_sell componentsJoinedByString:@","];
            NSString *urlstr = [NSString stringWithFormat:@"%@json_output.php?mode=send_to_friend_saved_property&logged_in_user_id=%@&saved_ids=%@",App_Domain_Url,userid,idjoinedstring];
            [obj GlobalDict:urlstr Globalstr:@"array" Withblock:^(id result, NSError *error) {
                selectPropertyDetail = [result mutableCopy];
                
                MPSendToFriendViewController *send = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"sendtofriend"];
                [send.data_dic removeAllObjects];
                //send.idstring = idjoinedstring;
                
                send.data_dic = [selectPropertyDetail mutableCopy];
                [self.navigationController pushViewController:send animated:YES];
            }];
        }
        
//        NSString *idjoinedstring = [send_arr_sell componentsJoinedByString:@","];
//        NSString *urlstr = [NSString stringWithFormat:@"%@json_output.php?mode=send_to_friend_saved_property&logged_in_user_id=%@&saved_ids=%@",App_Domain_Url,userid,idjoinedstring];
//        [obj GlobalDict:urlstr Globalstr:@"array" Withblock:^(id result, NSError *error) {
//            selectPropertyDetail = [result mutableCopy];
//            
//            MPSendToFriendViewController *send = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"sendtofriend"];
//            [send.data_dic removeAllObjects];
//            send.idstring = idjoinedstring;
//            send.data_dic = [selectPropertyDetail mutableCopy];
//            [self.navigationController pushViewController:send animated:YES];
//        }];
    }
    else if (check == 1)
    {
        
        if (send_arr_rent.count == 0)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Please select atleast one property" message: @"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
            [alert show];
        }
        else
        {
            NSString *idjoinedstring = [send_arr_rent componentsJoinedByString:@","];
            NSString *urlstr = [NSString stringWithFormat:@"%@json_output.php?mode=send_to_friend_saved_property&logged_in_user_id=%@&saved_ids=%@",App_Domain_Url,userid,idjoinedstring];
            [obj GlobalDict:urlstr Globalstr:@"array" Withblock:^(id result, NSError *error) {
                selectPropertyDetail = [result mutableCopy];
                
                MPSendToFriendViewController *send = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"sendtofriend"];
                [send.data_dic removeAllObjects];
                send.idstring = idjoinedstring;
                send.data_dic = [selectPropertyDetail mutableCopy];
                [self.navigationController pushViewController:send animated:YES];
            }];
        }
        
//        NSString *idjoinedstring = [send_arr_rent componentsJoinedByString:@","];
//        NSString *urlstr = [NSString stringWithFormat:@"%@json_output.php?mode=send_to_friend_saved_property&logged_in_user_id=%@&saved_ids=%@",App_Domain_Url,userid,idjoinedstring];
//        [obj GlobalDict:urlstr Globalstr:@"array" Withblock:^(id result, NSError *error) {
//            selectPropertyDetail = [result mutableCopy];
//            
//            MPSendToFriendViewController *send = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"sendtofriend"];
//            [send.data_dic removeAllObjects];
//            send.idstring = idjoinedstring;
//            send.data_dic = [selectPropertyDetail mutableCopy];
//            [self.navigationController pushViewController:send animated:YES];
//        }];
    }
}




//footer delegate method

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
    }
    else if (tagId == 3)
    {
        NSLog(@"tagid is: %ld",(long)tagId);
        MPRegisterPropertyViewController *prop = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"registerproperty"];
        [self.navigationController pushViewController:prop animated:NO];
    }
    else if (tagId == 4)
    {
        MPDashBoardViewController *fav = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"dashboard"];
        [self.navigationController pushViewController:fav animated:NO];
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
            
            [blackview setFrame:CGRectMake(0, self.headerimg.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
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
        [leftView setFrame:CGRectMake(-leftView.frame.size.width-12, 0,self.view.frame.size.width*.6, self.mainview.frame.size.height)];
        leftView.leftDelegate = self;
        [self.view addSubview:leftView];
        
        
        [UIView animateWithDuration:.4 animations:^{
            
            [self.mainview setFrame:CGRectMake(self.mainview.frame.size.width*.6,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height)];
            
            [leftView setFrame:CGRectMake(0, 0,self.view.frame.size.width*.6, self.mainview.frame.size.height)];
            
            
            //            [self.view addSubview:leftView];
            
        }];
        
        leftslide = 1;
    }
    else
    {
        [UIView animateWithDuration:.4 animations:^{
            
            [self.mainview setFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height)];
            
            [leftView setFrame:CGRectMake(-leftView.frame.size.width, 0,self.view.frame.size.width*.6, self.mainview.frame.size.height)];
            
        }
                         completion:^(BOOL finished) {
                             [leftView removeFromSuperview];
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
        [self resetDefaults];
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
    else if ( tagId == 101 )
    {
        MPMyPropertyViewController *fav = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"myproperty"];
        [self.mainview setFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height)];
        
        [leftView removeFromSuperview];
        leftslide = 0;
        [self.navigationController pushViewController:fav animated:NO];
    }
    else if ( tagId == 102 )
    {
        MPMyAddvertisementViewController *fav = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"myaddvertise"];
        [self.mainview setFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height)];
        
        [leftView removeFromSuperview];
        leftslide = 0;
        [self.navigationController pushViewController:fav animated:NO];
    }
}


//- (IBAction)rightMenuBtnTapped:(id)sender
//{
//    if (rightslide == 0)
//    {
//        rightView = [[RightMenu alloc]init];
//        
//        [rightView setFrame:CGRectMake(self.view.frame.size.width + 50, 0,self.view.frame.size.width*.55, self.mainview.frame.size.height)];
//        
//        [blackview setFrame:CGRectMake(0, self.headerview.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
//        blackview.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.01];
//        [_mainview setUserInteractionEnabled:YES];
//        
//        /* UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelRightMenu)];
//         tapGestureRecognize.delegate = self;
//         tapGestureRecognize.numberOfTapsRequired = 1;
//         [tapGestureRecognize requireGestureRecognizerToFail:tapGestureRecognize];
//         [blackview addGestureRecognizer:tapGestureRecognize]; */
//        
//        UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(cancelRightMenu)];
//        recognizer.direction = UISwipeGestureRecognizerDirectionRight;
//        recognizer.delegate = self;
//        
//        UISwipeGestureRecognizer *recognizer1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(cancelRightMenu)];
//        recognizer.direction = UISwipeGestureRecognizerDirectionRight;
//        recognizer.delegate = self;
//        
//        [blackview addGestureRecognizer:recognizer];
//        [rightView addGestureRecognizer:recognizer1];
//        
//        [_mainview addSubview:blackview];
//        
//        
//        [UIView animateWithDuration:.7 animations:^{
//            
//            blackview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
//            
//            [rightView setFrame:CGRectMake(self.view.frame.size.width*.45, 0,self.view.frame.size.width*.55, self.mainview.frame.size.height)];
//            
//            //            [self.mainview setFrame:CGRectMake(self.mainview.frame.size.width*(-.55),0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height)];
//            
//            //            [footerView setFrame:CGRectMake(self.mainview.frame.size.width*(-.55),self.mainview.frame.size.height-60,[footerView bounds].size.width,[footerView bounds].size.height)];
//        }];
//        
//        [self.view addSubview:rightView];
//        rightslide = 1;
//    }
//    else
//    {
//        //        [rightView removeFromSuperview];
//        
//        [UIView animateWithDuration:.7 animations:^{
//            
//            blackview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.01];
//            
//            [rightView setFrame:CGRectMake(self.view.frame.size.width + 10, 0,self.view.frame.size.width*.55, self.mainview.frame.size.height)];
//            
//            //            [self.mainview setFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height)];
//            
//            
//            //            [footerView setFrame:CGRectMake(0,self.mainview.frame.size.height-60,[footerView bounds].size.width,[footerView bounds].size.height)];
//            
//        }
//                         completion:^(BOOL finished){
//                             
//                             [blackview removeFromSuperview];
//                         }];
//        
//        rightslide = 0;
//    }
//}

-(void)cancelRightMenu
{
    [UIView animateWithDuration:.7 animations:^{
        
        blackview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.01];
        
        [rightView setFrame:CGRectMake(self.view.frame.size.width + 10, 0,self.view.frame.size.width*.55, self.mainview.frame.size.height)];
        
    }
                     completion:^(BOOL finished){
                         
                         [blackview removeFromSuperview];
                     }];
    
    rightslide = 0;
}

- (IBAction)sellTapped:(id)sender
{
    check = 0;
    [_sellbtn setTitleColor:[UIColor colorWithRed:74.0f/255.0f green:133.0f/255.0f blue:219.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [_rentbtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    if (sellarr.count == 0)
    {
        _nodatafoundlbl.hidden = NO;
        [_tableviewfevourite reloadData];
    }
    else
    {
        _nodatafoundlbl.hidden = YES;
        [_tableviewfevourite reloadData];
    }
    
//    [_tableviewfevourite reloadData];
}

- (IBAction)rentTapped:(id)sender
{
    check = 1;
    [_rentbtn setTitleColor:[UIColor colorWithRed:74.0f/255.0f green:133.0f/255.0f blue:219.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [_sellbtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    
    if (rentarr.count == 0)
    {
        [_nodatafoundlbl setHidden:NO];
        [_tableviewfevourite reloadData];
    }
    else
    {
        _nodatafoundlbl.hidden = YES;
        [_tableviewfevourite reloadData];
    }
    
//    [_tableviewfevourite reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger value;
    if (check== 0)
    {
        value = [sellarr count];
    }
    else
    {
        value = [rentarr count];
    }
    return value;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tablechk==true)
    {
        return 100;
    }
    else
    {
        return 199;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tablechk==true)
    {
    
//        cell = [tableView dequeueReusableCellWithIdentifier:@"fevourite"];
//        cell = [[FavouriteTableViewCell alloc]init];
        
        cell1=(FavouriteTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"fevourite"];
        
        if (check == 0)
        {
            cell1.pricelabel.text = [NSString stringWithFormat:@"£%@",[[sellarr objectAtIndex:indexPath.row] valueForKey:@"property_price"]];
            cell1.subtitle.text = [NSString stringWithFormat:@"%@ Beds, %@ baths, %@ rooms",[[sellarr objectAtIndex:indexPath.row] valueForKey:@"no_of_beds"],[[sellarr objectAtIndex:indexPath.row] valueForKey:@"no_of_baths"],[[sellarr objectAtIndex:indexPath.row] valueForKey:@"no_of_rooms"]];
            cell1.addresslbl.text = [[sellarr objectAtIndex:indexPath.row] valueForKey:@"address1"];
            
            image_arr = [[sellarr objectAtIndex:indexPath.row]valueForKey:@"images"];
            
            [cell1.homepicture sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[image_arr objectAtIndex:0]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            
            cell1.checkUncheckBtn.tag = indexPath.row;
//            [cell.checkUncheckBtn addTarget:self action:@selector(checkUncheckTapped:) forControlEvents:UIControlEventTouchUpInside];
            ////
            
            if ([send_arr_sell containsObject:[[sellarr objectAtIndex:indexPath.row]objectForKey:@"property_saved_id"]])
            {
                [cell1.checkUncheckBtn addTarget:self action:@selector(UncheckTapped:) forControlEvents:UIControlEventTouchUpInside];
            }
            else
            {
                [cell1.checkUncheckBtn addTarget:self action:@selector(checkTapped:) forControlEvents:UIControlEventTouchUpInside];
            }
            ////
            
            if ([send_arr_sell containsObject:[[sellarr objectAtIndex:indexPath.row]objectForKey:@"property_saved_id"]])
            {
                [cell1.checkUncheckBtn setImage:[UIImage imageNamed:@"check_small"] forState:UIControlStateNormal];
            }
            else
            {
                [cell1.checkUncheckBtn setImage:[UIImage imageNamed:@"uncheck_small"] forState:UIControlStateNormal];
            }
        }
        else
        {
            cell1.pricelabel.text = [NSString stringWithFormat:@"£%@",[[rentarr objectAtIndex:indexPath.row] valueForKey:@"property_price"]];;
            cell1.subtitle.text = [NSString stringWithFormat:@"%@ Beds, %@ baths, %@ rooms",[[rentarr objectAtIndex:indexPath.row] valueForKey:@"no_of_beds"],[[rentarr objectAtIndex:indexPath.row] valueForKey:@"no_of_baths"],[[rentarr objectAtIndex:indexPath.row] valueForKey:@"no_of_rooms"]];
            cell1.addresslbl.text = [[rentarr objectAtIndex:indexPath.row] valueForKey:@"address1"];
            
            cell1.checkUncheckBtn.tag = indexPath.row;
            
            
            image_arr2 = [[rentarr objectAtIndex:indexPath.row]valueForKey:@"images"];
            
            [cell1.homepicture sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[image_arr2 objectAtIndex:0]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            
            
            if ([send_arr_rent containsObject:[[rentarr objectAtIndex:indexPath.row]objectForKey:@"property_saved_id"]])
            {
                [cell1.checkUncheckBtn addTarget:self action:@selector(UncheckTapped:) forControlEvents:UIControlEventTouchUpInside];
            }
            else
            {
                [cell1.checkUncheckBtn addTarget:self action:@selector(checkTapped:) forControlEvents:UIControlEventTouchUpInside];
            }
            if ([send_arr_rent containsObject:[[rentarr objectAtIndex:indexPath.row]objectForKey:@"property_saved_id"]])
            {
                [cell1.checkUncheckBtn setImage:[UIImage imageNamed:@"check_small"] forState:UIControlStateNormal];
            }
            else
            {
                [cell1.checkUncheckBtn setImage:[UIImage imageNamed:@"uncheck_small"] forState:UIControlStateNormal];
            }
        }
        [cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell1;
    }
    else if (tablechk==false)
    {
        
        
//        cell = [tableView dequeueReusableCellWithIdentifier:@"gridfavourite"];
//        cell = [[GridefavouriteTableViewCell alloc]init];
        
        cell2 = (GridefavouriteTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"gridfavourite"];
        
        if (check == 0)
        {
            cell2.roomslbl.text = [NSString stringWithFormat:@"%@ Beds, %@ baths, %@ rooms",[[sellarr objectAtIndex:indexPath.row] valueForKey:@"no_of_beds"],[[sellarr objectAtIndex:indexPath.row] valueForKey:@"no_of_baths"],[[sellarr objectAtIndex:indexPath.row] valueForKey:@"no_of_rooms"]];
            cell2.address.text = [[sellarr objectAtIndex:indexPath.row] valueForKey:@"address1"];
            cell2.pricelbl.text = [NSString stringWithFormat:@"£%@",[[sellarr objectAtIndex:indexPath.row] valueForKey:@"property_price"]];
            cell2.removebutton.tag=indexPath.row;
            
            imagearraysellgrid=[[sellarr objectAtIndex:indexPath.row] valueForKey:@"images"];
            
            [cell2.homepicture sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[imagearraysellgrid objectAtIndex:0]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            
            
            
        }
        else
        {
            cell2.roomslbl.text = [NSString stringWithFormat:@"%@ Beds, %@ baths, %@ rooms",[[rentarr objectAtIndex:indexPath.row] valueForKey:@"no_of_beds"],[[rentarr objectAtIndex:indexPath.row] valueForKey:@"no_of_baths"],[[rentarr objectAtIndex:indexPath.row] valueForKey:@"no_of_rooms"]];
            cell2.address.text = [[rentarr objectAtIndex:indexPath.row] valueForKey:@"address1"];
            cell2.pricelbl.text = [NSString stringWithFormat:@"£%@",[[rentarr objectAtIndex:indexPath.row] valueForKey:@"property_price"]];
            cell2.removebutton.tag=indexPath.row;
            
            imagearrayrentgrid=[[rentarr objectAtIndex:indexPath.row] valueForKey:@"images"];
            
            [cell2.homepicture sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[imagearrayrentgrid objectAtIndex:0]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            
        }
        [cell2.removebutton addTarget:self action:@selector(removeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [cell2 setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell2;
    }
    return nil;
}

-(void)UncheckTapped:(UIButton *)sender
{
    if (check == 0)
    {
        [send_arr_sell removeObject:[[sellarr objectAtIndex:sender.tag]objectForKey:@"property_saved_id"]];
        
        NSLog(@"data_arr====%@",send_arr_sell);
        [_tableviewfevourite reloadData];
    }
    else
    {
        [send_arr_rent removeObject:[[rentarr objectAtIndex:sender.tag]objectForKey:@"property_saved_id"]];
        
        NSLog(@"data_arr====%@",send_arr_rent);
        [_tableviewfevourite reloadData];
    }
    
}

-(void)checkTapped:(UIButton *)sender
{
    if (check == 0)
    {
        [send_arr_sell addObject:[[sellarr objectAtIndex:sender.tag]objectForKey:@"property_saved_id"]];
        
        NSLog(@"send_arr====%@",send_arr_sell);
        [_tableviewfevourite reloadData];
    }
    else
    {
        [send_arr_rent addObject:[[rentarr objectAtIndex:sender.tag]objectForKey:@"property_saved_id"]];
        
        NSLog(@"send_arr====%@",send_arr_rent);
        [_tableviewfevourite reloadData];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath");
    PropertyDetails2ViewController *prop2 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"propertydetail"];
    prop2.checkstring = @"fav";
    if (check == 0)
    {
        prop2.data_dic = [[sellarr objectAtIndex:indexPath.row] mutableCopy];
    }
    else
    {
        prop2.data_dic = [[rentarr objectAtIndex:indexPath.row] mutableCopy];
    }
    
    [self.navigationController pushViewController:prop2 animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        
    }
}


-(void)removeButtonTapped:(UIButton *)sender
{
    NSLog(@"tag is-----%ld",(long)sender.tag);
    if (check==0)
    {
        NSLog(@"i am here sell%@",[[sellarr objectAtIndex:sender.tag] valueForKey:@"advertisement_id"]);
        polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
        polygonView.backgroundColor=[UIColor blackColor];
        polygonView.alpha=0.3;
        [self.view addSubview:polygonView];
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
        
        [polygonView addSubview:spinner];
        [spinner startAnimating];
        
        
        
        NSString *urlstr = [NSString stringWithFormat:@"%@json_output.php?mode=remove_favourite_property&user_id=%@&advertisement_id=%@",App_Domain_Url,userid,[[sellarr objectAtIndex:sender.tag] valueForKey:@"advertisement_id"]];
        
        
        [obj GlobalDict:urlstr Globalstr:@"array" Withblock:^(id result, NSError *error) {
            NSLog(@"%@",result);
            NSMutableDictionary *resultdata=[result mutableCopy];
            NSString *response=[resultdata valueForKey:@"response"];
            if ([response isEqualToString:@"success"])
            {
                NSString *urlstr1 = [NSString stringWithFormat:@"%@json_output.php?mode=user_saved_property_list&user_id=%@",App_Domain_Url,userid];
                favdic=nil;
                sellarr=nil;
                rentarr=nil;
                [obj GlobalDict:urlstr1 Globalstr:@"array" Withblock:^(id result, NSError *error) {
                    favdic = [result mutableCopy];
                    sellarr = [favdic valueForKey:@"sell"];
                    rentarr = [favdic valueForKey:@"rent"];
                    [_sellbtn setTitle:[NSString stringWithFormat:@"Sell (%ld)",(long)sellarr.count] forState:UIControlStateNormal];
                    [_rentbtn setTitle:[NSString stringWithFormat:@"Rent (%ld)",(long)rentarr.count] forState:UIControlStateNormal];
                    [_tableviewfevourite reloadData];
                    
                    [spinner stopAnimating];
                    [spinner removeFromSuperview];
                    [polygonView removeFromSuperview];
                    
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"successfully Removed" message: @"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
                    [alert show];
                    
                    
                }];
            }
            else
            {
                [spinner stopAnimating];
                [spinner removeFromSuperview];
                [polygonView removeFromSuperview];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Failed to Remove" message: @"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
                [alert show];
            }
            
        }];
        
        
        
        
        
    }
    else
    {
        NSLog(@"i am here sell%@",[[rentarr objectAtIndex:sender.tag] valueForKey:@"advertisement_id"]);
        polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
        polygonView.backgroundColor=[UIColor blackColor];
        polygonView.alpha=0.3;
        [self.view addSubview:polygonView];
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
        
        [polygonView addSubview:spinner];
        [spinner startAnimating];
        
        
        NSString *urlstr = [NSString stringWithFormat:@"%@json_output.php?mode=remove_favourite_property&user_id=%@&advertisement_id=%@",App_Domain_Url,userid,[[rentarr objectAtIndex:sender.tag] valueForKey:@"advertisement_id"]];
        
        
        [obj GlobalDict:urlstr Globalstr:@"array" Withblock:^(id result, NSError *error) {
            NSLog(@"%@",result);
            NSMutableDictionary *resultdata=[result mutableCopy];
            NSString *response=[resultdata valueForKey:@"response"];
            if ([response isEqualToString:@"success"])
            {
                NSString *urlstr1 = [NSString stringWithFormat:@"%@json_output.php?mode=user_saved_property_list&user_id=%@",App_Domain_Url,userid];
                
                
                favdic=nil;
                sellarr=nil;
                rentarr=nil;
                [obj GlobalDict:urlstr1 Globalstr:@"array" Withblock:^(id result, NSError *error) {
                    favdic = [result mutableCopy];
                    sellarr = [favdic valueForKey:@"sell"];
                    rentarr = [favdic valueForKey:@"rent"];
                    [_sellbtn setTitle:[NSString stringWithFormat:@"Sell (%ld)",(long)sellarr.count] forState:UIControlStateNormal];
                    [_rentbtn setTitle:[NSString stringWithFormat:@"Rent (%ld)",(long)rentarr.count] forState:UIControlStateNormal];
                    [_tableviewfevourite reloadData];
                    
                    [spinner stopAnimating];
                    [spinner removeFromSuperview];
                    [polygonView removeFromSuperview];
                    
                    
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"successfully Updated" message: @"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
                    [alert show];
                    
                    
                }];
            }
            else
            {
                [spinner stopAnimating];
                [spinner removeFromSuperview];
                [polygonView removeFromSuperview];
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Failed to Remove" message: @"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
                [alert show];
            }
            
        }];
        
    }
    
}

- (void)resetDefaults {
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
}

//- (IBAction)selectAllTapped:(id)sender
/*{
    _selectAllBtn.hidden = YES;
    _deSelectAllBtn.hidden = NO;
    
    if (check == 0)
    {
        for (int i=0; i<sellarr.count; i++)
        {
            if ([send_arr_sell containsObject:[[sellarr objectAtIndex:i]objectForKey:@"property_saved_id"]])
            {
                
            }
            else
            {
                
                [send_arr_sell addObject:[[sellarr objectAtIndex:i]objectForKey:@"property_saved_id"]];
            }
            
        }
        [_tableviewfevourite reloadData];
    }
    else if (check == 1)
    {
        for (int i=0; i<rentarr.count; i++)
        {
            if ([send_arr_rent containsObject:[[rentarr objectAtIndex:i]objectForKey:@"property_saved_id"]])
            {}
            else
            {
                
                [send_arr_rent addObject:[[rentarr objectAtIndex:i]objectForKey:@"property_saved_id"]];
            }
        }
        [_tableviewfevourite reloadData];
    }
    
    NSLog(@"send_arr_sell array====%@",send_arr_sell);
    NSLog(@"send_arr_rent array====%@",send_arr_rent);
}*/

//- (IBAction)deSelectAllTapped:(id)sender
/*{
    _selectAllBtn.hidden = NO;
    _deSelectAllBtn.hidden = YES;
    
    
    if (check == 0)
    {
        [send_arr_sell removeAllObjects];
        NSLog(@"After deselect sell====%@",send_arr_sell);
        [_tableviewfevourite reloadData];
    }
    else
    {
        [send_arr_rent removeAllObjects];
        NSLog(@"After deselect rent====%@",send_arr_rent);
        [_tableviewfevourite reloadData];
    }

//    [send_arr removeAllObjects];
//    NSLog(@"After deselect====%@",send_arr_sell);
//    NSLog(@"After deselect====%@",send_arr_rent);
//    [_tableview reloadData];
}*/

///////subho

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Remove" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                    {
                                        NSLog(@"Action to perform with Button 1");
                                        if (check==0) {
                                            NSLog(@"i am here sell%@",[[sellarr objectAtIndex:indexPath.row] valueForKey:@"advertisement_id"]);
                                            
                                            
                                            polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
                                            polygonView.backgroundColor=[UIColor blackColor];
                                            polygonView.alpha=0.3;
                                            [self.view addSubview:polygonView];
                                            UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
                                            spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
                                            
                                            [polygonView addSubview:spinner];
                                            [spinner startAnimating];
                                            
                                            
                                            
                                            NSString *urlstr = [NSString stringWithFormat:@"%@json_output.php?mode=remove_favourite_property&user_id=%@&advertisement_id=%@",App_Domain_Url,userid,[[sellarr objectAtIndex:indexPath.row] valueForKey:@"advertisement_id"]];
                                            
                                            
                                            [obj GlobalDict:urlstr Globalstr:@"array" Withblock:^(id result, NSError *error) {
                                                NSLog(@"%@",result);
                                                NSMutableDictionary *resultdata=[result mutableCopy];
                                                NSString *response=[resultdata valueForKey:@"response"];
                                                if ([response isEqualToString:@"success"])
                                                {
                                                    NSString *urlstr1 = [NSString stringWithFormat:@"%@json_output.php?mode=user_saved_property_list&user_id=%@",App_Domain_Url,userid];
                                                    favdic=nil;
                                                    sellarr=nil;
                                                    rentarr=nil;
                                                    [obj GlobalDict:urlstr1 Globalstr:@"array" Withblock:^(id result, NSError *error) {
                                                        favdic = [result mutableCopy];
                                                        sellarr = [favdic valueForKey:@"sell"];
                                                        rentarr = [favdic valueForKey:@"rent"];
                                                        [_sellbtn setTitle:[NSString stringWithFormat:@"Sell (%ld)",(long)sellarr.count] forState:UIControlStateNormal];
                                                        [_rentbtn setTitle:[NSString stringWithFormat:@"Rent (%ld)",(long)rentarr.count] forState:UIControlStateNormal];
                                                        [_tableviewfevourite reloadData];
                                                        
                                                        [spinner stopAnimating];
                                                        [spinner removeFromSuperview];
                                                        [polygonView removeFromSuperview];
                                                        
                                                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"successfully Updated" message: @"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
                                                        [alert show];
                                                        
                                                        
                                                    }];
                                                }
                                                else
                                                {
                                                    [spinner stopAnimating];
                                                    [spinner removeFromSuperview];
                                                    [polygonView removeFromSuperview];
                                                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Failed to Remove" message: @"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
                                                    [alert show];
                                                }
                                                
                                            }];
                                            
                                            
                                            
                                        }
                                        else
                                        {
                                            NSLog(@"i am here rent%@",[[rentarr objectAtIndex:indexPath.row] valueForKey:@"advertisement_id"]);
                                            
                                            
                                            polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
                                            polygonView.backgroundColor=[UIColor blackColor];
                                            polygonView.alpha=0.3;
                                            [self.view addSubview:polygonView];
                                            UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
                                            spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
                                            
                                            [polygonView addSubview:spinner];
                                            [spinner startAnimating];
                                            
                                            
                                            NSString *urlstr = [NSString stringWithFormat:@"%@json_output.php?mode=remove_favourite_property&user_id=%@&advertisement_id=%@",App_Domain_Url,userid,[[rentarr objectAtIndex:indexPath.row] valueForKey:@"advertisement_id"]];
                                            
                                            
                                            [obj GlobalDict:urlstr Globalstr:@"array" Withblock:^(id result, NSError *error) {
                                                NSLog(@"%@",result);
                                                NSMutableDictionary *resultdata=[result mutableCopy];
                                                NSString *response=[resultdata valueForKey:@"response"];
                                                if ([response isEqualToString:@"success"])
                                                {
                                                    NSString *urlstr1 = [NSString stringWithFormat:@"%@json_output.php?mode=user_saved_property_list&user_id=%@",App_Domain_Url,userid];
                                                    
                                                    
                                                    favdic=nil;
                                                    sellarr=nil;
                                                    rentarr=nil;
                                                    [obj GlobalDict:urlstr1 Globalstr:@"array" Withblock:^(id result, NSError *error) {
                                                        favdic = [result mutableCopy];
                                                        sellarr = [favdic valueForKey:@"sell"];
                                                        rentarr = [favdic valueForKey:@"rent"];
                                                        [_sellbtn setTitle:[NSString stringWithFormat:@"Sell (%ld)",(long)sellarr.count] forState:UIControlStateNormal];
                                                        [_rentbtn setTitle:[NSString stringWithFormat:@"Rent (%ld)",(long)rentarr.count] forState:UIControlStateNormal];
                                                        [_tableviewfevourite reloadData];
                                                        
                                                        [spinner stopAnimating];
                                                        [spinner removeFromSuperview];
                                                        [polygonView removeFromSuperview];
                                                        
                                                        
                                                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"successfully Updated" message: @"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
                                                        [alert show];
                                                        
                                                        
                                                    }];
                                                }
                                                else
                                                {
                                                    [spinner stopAnimating];
                                                    [spinner removeFromSuperview];
                                                    [polygonView removeFromSuperview];
                                                    
                                                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Failed to Remove" message: @"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
                                                    [alert show];
                                                }
                                                
                                                
                                                
                                                
                                                
                                            }];
                                            
                                        }
                                        
                                        
                                        
                                        
                                    }];
    button.backgroundColor = [UIColor colorWithRed:232/255.0f green:122/255.0f blue:86/255.0f alpha:1];
    //arbitrary color
    
    return @[button];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tablechk==true)
    {
        return YES;
    }
    return NO;
}





///////



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (void)willTransitionToState:(UITableViewCellStateMask)state
//{
//    [super willTransitionToState:state];
//    if ((state & UITableViewCellStateShowingDeleteConfirmationMask) == UITableViewCellStateShowingDeleteConfirmationMask)
//    {
//        for (UIView *subview in self.subviews)
//        {
//            if ([NSStringFromClass([subview class]) isEqualToString:@"UITableViewCellDeleteConfirmationControl"])
//            {
//                UIImageView *deleteBtn = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 64, 33)];
//                [deleteBtn setImage:[UIImage imageNamed:@"cross"]];
//                [[subview.subviews objectAtIndex:0] addSubview:deleteBtn];
//            }
//        }
//    }
//}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



- (IBAction)listviewbutton:(id)sender
{
    tablechk=true;
    [_tableviewfevourite reloadData];
    
}
- (IBAction)grideviewbutton:(id)sender
{
    tablechk=false;
    [_tableviewfevourite reloadData];
}


@end
