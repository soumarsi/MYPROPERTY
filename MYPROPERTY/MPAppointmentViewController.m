//
//  MPAppointmentViewController.m
//  MYPROPERTY
//
//  Created by Somenath on 05/08/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "MPAppointmentViewController.h"
#import "Footer.h"
#import "RightMenu.h"
#import "SubCatagoryView.h"
#import "SearchViewController.h"
#import "FavouriteViewController.h"
#import "MPNotificationViewController.h"
#import "RightMenu.h"
#import "QFProfileViewController.h"
#import "ChangePasswordViewController.h"
#import "AddadvertisementViewController.h"
#import "InviteFriendsViewController.h"
#import "PropertyViewController.h"
#import "MPOfferAlertsViewController.h"
#import "Listing3ViewController.h"
#import "UIImageView+WebCache.h"
#import "MPMakeAnOfferViewController.h"
#import "feedback.h"
#import "MPBookAgentViewController.h"
#import "PropertyDetails2ViewController.h"

@interface MPAppointmentViewController () <footerdelegate,rightDelegate,UIGestureRecognizerDelegate, SubCatagoryDelegate, UITableViewDataSource, UITableViewDelegate>
{
    BOOL viewslide,rightslide, tapcheck, experidate;
    UIView *slideview, *blackview;
    NSInteger check, actioncheck;
    NSArray *btnname;
    Footer *footerView;
    RightMenu *rightView;
    SubCatagoryView *subcat;
    NSUserDefaults *userinfo;
    NSString *userid;
    NSMutableDictionary *appointmentdic;
    NSMutableArray *request_rcvd, *request_sent;
    NSString *bedsnumber;
    NSString *bathsnumber;
    NSString *roomsnumber;
    NSString *price, *bookingid, *adv_idfinal, *chkingdata;
    UIButton *btn1, *btn2, *btn3;
    UIView *appointmentsubview;
    UITableView *alerttableview;
    UIButton *sent;
    UIButton *recived;
    UIView *polygonView;
    
}

@property (strong, nonatomic) IBOutlet UIView *mainview;
@property (strong, nonatomic) IBOutlet UIButton *subviewbtn;
@property (strong, nonatomic) IBOutlet UIImageView *headerimage;
@property (strong, nonatomic) IBOutlet UIView *subCatgoryView;
@property (strong, nonatomic) IBOutlet UILabel *nodatafoundlbl;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UIButton *reqRecvBtn;
@property (strong, nonatomic) IBOutlet UIButton *reqSentBtn;
@end

@implementation MPAppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    obj = [[FW_JsonClass alloc]init];
    userinfo=[[NSUserDefaults alloc]init];
    
    userid = [userinfo objectForKey:@"id"];
    NSLog(@"userid is : %@",userid);
    
    NSString *appointmenturl = [NSString stringWithFormat:@"%@json_output.php?mode=list_of_appointments_Sent_and_recvd&user_id=%@",App_Domain_Url,userid];
    
    
    
    viewslide = 0;
    rightslide = 0;
    tapcheck = 0;
    check = 1;
    actioncheck = 21;
    
    polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
    polygonView.backgroundColor=[UIColor blackColor];
    polygonView.alpha=0.3;
    [self.view addSubview:polygonView];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
    
    [polygonView addSubview:spinner];
    [spinner startAnimating];
    
    [obj GlobalDict:appointmenturl Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         appointmentdic=[result mutableCopy];
         
         request_rcvd = [appointmentdic valueForKey:@"request_rcvd"];
         request_sent = [appointmentdic valueForKey:@"request_sent"];
         
         [_reqRecvBtn setTitle:[NSString stringWithFormat:@"Request recieved(%ld)",(long)[request_rcvd count]] forState:UIControlStateNormal];
         [_reqSentBtn setTitle:[NSString stringWithFormat:@"Request sent(%ld)",(long)[request_sent count]] forState:UIControlStateNormal];
         
         if ([request_rcvd count] == 0)
         {
             [_nodatafoundlbl setHidden:NO];
         }
         else
         {
             [_tableview reloadData];
             [_nodatafoundlbl setHidden:YES];
         }
         
         [spinner stopAnimating];
         [spinner removeFromSuperview];
         [polygonView removeFromSuperview];
     }];
    
    
    blackview = [[UIView alloc]init];
    footerView=[[Footer alloc]init];
    
    [footerView setFrame:CGRectMake(0, self.view.frame.size.height - 60, self.view.frame.size.width, 60)];
    
    footerView.footerdelegate=self;
    [self.mainview addSubview:footerView];
    
    [footerView TapCheck:4];
    
    [_tableview setShowsVerticalScrollIndicator:NO];
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

- (IBAction)subcatagoryTapped:(id)sender
{
    
    if (viewslide == 0)
    {
        //_nodatafoundlbl.hidden = YES;
        [_subviewbtn setImage:[UIImage imageNamed:@"up_arrow"] forState:UIControlStateNormal];
        if (check == 1)
        {
            //            slideview = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width * .5, _headerimg.frame.size.height + self.subCatgoryView.frame.size.height + self.buttonScroll.frame.size.height + 8, self.view.frame.size.width * .49, 210)];
            //
            //            slideview.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1];
            
            subcat = [[SubCatagoryView alloc]init];
            
            [subcat setFrame:CGRectMake(self.view.frame.size.width * .55, _headerimage.frame.size.height + self.subCatgoryView.frame.size.height + 2, self.view.frame.size.width * .44, 210)];
            subcat.SubCatagoryDelegate = self;
            [subcat TapCheck:3];
            
            subcat.layer.borderWidth = 1.0f;
            subcat.layer.cornerRadius = 4.0f;
            subcat.layer.borderColor = [UIColor colorWithRed:200.0f/255 green:200.0f/255.0f blue:200.0f/255.0f alpha:1].CGColor;
            
            subcat.layer.shadowOffset = CGSizeMake(-1, 1);
            subcat.layer.shadowRadius = 6;
            subcat.layer.shadowOpacity = 0.5;
            
            [subcat.layer setMasksToBounds:YES];
            
            [self.view addSubview:subcat];
            
//            UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelSubViewByTap)];
//            tapGestureRecognize.delegate = self;
//            tapGestureRecognize.numberOfTapsRequired = 1;
//            [tapGestureRecognize requireGestureRecognizerToFail:tapGestureRecognize];
//            [self.mainview addGestureRecognizer:tapGestureRecognize];
            
            [self.view addSubview:slideview];
        }
        else if (check == 6)
        {
            
            [subcat setFrame:CGRectMake(self.view.frame.size.width * .7, _headerimage.frame.size.height + subcat.frame.size.height , self.view.frame.size.width * .29, 100)];
            
            subcat.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
            subcat.layer.borderWidth = 2.0f;
            subcat.layer.cornerRadius = 4.0f;
            subcat.layer.borderColor = [UIColor colorWithRed:74.0f/255 green:133.0f/255.0f blue:219.0f/255.0f alpha:1].CGColor;
            [self.view addSubview:slideview];
        }
        viewslide = 1;
    }
    else
    {
//        _nodatafoundlbl.hidden = YES;
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            // Fade the label
            
            [subcat setAlpha:0];
        }
                         completion:^(BOOL finished) {
                             [subcat removeFromSuperview];
                             [_subviewbtn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
                             viewslide = 0;
                             
                         }
         ];
        
        
        //        [_subviewbtn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
        //        [slideview removeFromSuperview];
        //        viewslide = 0;
    }
}

-(void)cancelSubViewByTap
{
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        // Fade the label
        
        [subcat setAlpha:0];
    }
                     completion:^(BOOL finished) {
                         [subcat removeFromSuperview];
                         [_subviewbtn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
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
//        [subcat TapCheck:3];
//        MPAppointmentViewController *appo = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"appointment"];
//        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
//            // Fade the label
//            
//            [subcat setAlpha:0];
//        }
//                         completion:^(BOOL finished) {
//                             [subcat removeFromSuperview];
//                             [_subviewbtn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
//                             viewslide = 0;
//                             
//                         }
//         ];
//        [self.navigationController pushViewController:appo animated:NO];
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
                             [subcat removeFromSuperview];
                             [_subviewbtn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
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

- (IBAction)backTapped:(id)sender
{
    //[self.navigationController popViewControllerAnimated:NO];
//    for (UIViewController *controller in self.navigationController.viewControllers)
//    {
//        if ([controller isKindOfClass:[Listing3ViewController class]])
//        {
//            [self.navigationController popToViewController:controller animated:YES];
//            
//            break;
//        }
//    }
    
    
    for (int i=self.navigationController.viewControllers.count-1; i>=0; i--)
    {
        UIViewController *vc = self.navigationController.viewControllers[i];
        if ([vc isKindOfClass:[Listing3ViewController class]])
        {
            [self.navigationController popToViewController:vc animated:YES];
            break;
        }
    }
    
    
    
    
}

- (IBAction)requestRecivedTapped:(id)sender
{
    
    [_reqRecvBtn setTitleColor:[UIColor colorWithRed:74.0f/255.0f green:133.0f/255.0f blue:219.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [_reqSentBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
     if([request_rcvd count] == 0)
     {
         [_nodatafoundlbl setHidden:NO];
         [_tableview setHidden:YES];
     }
     else
     {
         actioncheck = 21;
         [_tableview setHidden:NO];
         [_tableview reloadData];
         [_nodatafoundlbl setHidden:YES];
         
     }
}

- (IBAction)RequestSentTapped:(id)sender
{
    
    [_reqSentBtn setTitleColor:[UIColor colorWithRed:74.0f/255.0f green:133.0f/255.0f blue:219.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [_reqRecvBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    if ([request_sent count] == 0)
    {
        [_nodatafoundlbl setHidden:NO];
        [_tableview setHidden:YES];
    }
    else
    {
        actioncheck = 22;
         [_tableview setHidden:NO];
        [_tableview reloadData];
        [_nodatafoundlbl setHidden:YES];
       
    }
}

- (IBAction)listViewBtnTapped:(id)sender
{
    tapcheck = 0;
    [_tableview reloadData];
}


- (IBAction)gridViewBtnTapped:(id)sender
{
    tapcheck = 1;
    [_tableview reloadData];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"heightForRowAtIndexPath");
    if (tapcheck == 0)
    {
        return 130;
    }
    else
    {
        return 200.0f;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger someV =0;
    NSLog(@"numberOfRowsInSection");
    
    if (actioncheck == 21)
    {
        someV = [request_rcvd count];
    }
    else if (actioncheck == 22)
    {
        someV = [request_sent count];
    }
    return someV;
    
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForRowAtIndexPath");
    if (tapcheck == 0)
    {
        cell1 = (AppointmentListCell *)[tableView dequeueReusableCellWithIdentifier:@"appointlist"];
        
        if (actioncheck == 21)
        {
            cell1.appoint_status.text = [NSString stringWithFormat:@"Appointment Request from %@",[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"sent_by"]];
            cell1.timming.text = [[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"booking_time"];
            cell1.datetovisit.text = [[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"booking_date"];
            
            cell1.bookingstatus.text = [[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"booking_status"];
            [cell1.propertyimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[request_rcvd objectAtIndex:indexPath.row ]valueForKey:@"property_image"]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            if ([[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"booking_status"] isEqualToString:@"Priliminary"] || [[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"booking_status"] isEqualToString:@"Rejected"])
            {
                cell1.newtimebtn.hidden = NO;
                cell1.newtimebtn.tag = indexPath.row;
                [cell1.newtimebtn addTarget:self action:@selector(NewTimeTapped:) forControlEvents:UIControlEventTouchUpInside];
            }
            else if ([[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"booking_status"] isEqualToString:@"Confirmed"])
            {
                cell1.newtimebtn.hidden = YES;
                cell1.newtimebtn.tag = indexPath.row;
            }
            
            if ([[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_confirm"] isEqualToString:@"Y"] && [[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_reject"] isEqualToString:@"Y"])
            {
                
                cell1.slidearrow.hidden=NO;
            }
            else if ([[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_confirm"] isEqualToString:@"Y"] && [[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_reject"] isEqualToString:@"N"])
            {
                cell1.slidearrow.hidden=NO;
                
            }
            else if ([[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_confirm"] isEqualToString:@"N"] && [[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_reject"] isEqualToString:@"Y"])
            {
                cell1.slidearrow.hidden=NO;
            }
            else if ([[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_confirm"] isEqualToString:@"N"] && [[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_reject"] isEqualToString:@"N"])
            {
                //img.hidden=YES;
                cell1.slidearrow.hidden=YES;
            }
            
            [cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            return cell1;
        }
        else if (actioncheck == 22)
        {
            
            cell1.appoint_status.text = [NSString stringWithFormat:@"Appointment Request Sent To %@",[[request_sent objectAtIndex:indexPath.row] valueForKey:@"sent_to_user"]];
            cell1.timming.text = [[request_sent objectAtIndex:indexPath.row] valueForKey:@"booking_time"];
            cell1.datetovisit.text = [[request_sent objectAtIndex:indexPath.row] valueForKey:@"booking_date"];
            
            
            cell1.bookingstatus.text = [[request_sent objectAtIndex:indexPath.row] valueForKey:@"booking_status"];
            [cell1.propertyimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[request_sent objectAtIndex:indexPath.row ]valueForKey:@"property_image"]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            
            if ([[[request_sent objectAtIndex:indexPath.row] valueForKey:@"booking_status"] isEqualToString:@"Priliminary"] || [[[request_sent objectAtIndex:indexPath.row] valueForKey:@"booking_status"] isEqualToString:@"Rejected"])
            {
                cell1.newtimebtn.hidden = NO;
                cell1.newtimebtn.tag = indexPath.row;
                [cell1.newtimebtn addTarget:self action:@selector(NewTimeTapped:) forControlEvents:UIControlEventTouchUpInside];
            }
            else if ([[[request_sent objectAtIndex:indexPath.row] valueForKey:@"booking_status"] isEqualToString:@"Confirmed"])
            {
                cell1.newtimebtn.hidden = YES;
                cell1.newtimebtn.tag = indexPath.row;
            }
            
            [cell1.newtimebtn addTarget:self action:@selector(NewTimeTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            ////////////
            
            if ([[[request_sent objectAtIndex:indexPath.row] valueForKey:@"make_an_offer"] isEqualToString:@"N"] && [[[request_sent objectAtIndex:indexPath.row] valueForKey:@"give_feedback"] isEqualToString:@"N"])
            {
                cell1.slidearrow.hidden=YES;
            }
            
            else if ([[[request_sent objectAtIndex:indexPath.row] valueForKey:@"make_an_offer"] isEqualToString:@"Y"] && [[[request_sent objectAtIndex:indexPath.row] valueForKey:@"give_feedback"] isEqualToString:@"N"])
            {
                cell1.slidearrow.hidden=NO;
            }
            else if ([[[request_sent objectAtIndex:indexPath.row] valueForKey:@"make_an_offer"] isEqualToString:@"N"] && [[[request_sent objectAtIndex:indexPath.row] valueForKey:@"give_feedback"] isEqualToString:@"Y"])
            {
                cell1.slidearrow.hidden=NO;
            }
            
            else if ([[[request_sent objectAtIndex:indexPath.row] valueForKey:@"make_an_offer"] isEqualToString:@"Y"] && [[[request_sent objectAtIndex:indexPath.row] valueForKey:@"give_feedback"] isEqualToString:@"Y"])
            {
                cell1.slidearrow.hidden=NO;
            }
            
            
            [cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            
            ////////////
            
            return cell1;
        }
        
    }
    else if (tapcheck == 1)
    {
        cell2 = (AppointmentGridCell *)[tableView dequeueReusableCellWithIdentifier:@"appointgrid"];
        
        if (actioncheck == 21)
        {
            cell2.feedback.hidden=YES;
            cell2.makeoffer.hidden=YES;
            
            cell2.appoint_status.text = [NSString stringWithFormat:@"Appointment Request from %@",[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"sent_by"]];
            cell2.timming.text = [[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"booking_time"];
            cell2.datetovisit.text = [[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"booking_date"];
            cell2.bookingstatus.text = [[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"booking_status"];
            [cell2.propertyimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[request_rcvd objectAtIndex:indexPath.row ]valueForKey:@"property_image"]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            
            if ([[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"booking_status"] isEqualToString:@"Priliminary"] || [[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"booking_status"] isEqualToString:@"Rejected"])
            {
                cell2.newtimebtn.hidden = NO;
                cell2.newtimebtn.tag = indexPath.row;
                [cell2.newtimebtn addTarget:self action:@selector(NewTimeTapped:) forControlEvents:UIControlEventTouchUpInside];
            }
            else if ([[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"booking_status"] isEqualToString:@"Confirmed"])
            {
                cell2.newtimebtn.hidden = YES;
                cell2.newtimebtn.tag = indexPath.row;
            }
            
            if ([[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_confirm"] isEqualToString:@"N"] && [[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_reject"] isEqualToString:@"N"])
            {
                cell2.requestreciveconfirm.hidden=YES;
                cell2.requestrecivereject.hidden=YES;
            }
            else if ([[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_confirm"] isEqualToString:@"Y"] && [[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_reject"] isEqualToString:@"N"])
            {
                cell2.requestreciveconfirm.tag=indexPath.row;
                cell2.requestreciveconfirm.layer.cornerRadius=4;
                cell2.requestreciveconfirm.hidden=NO;
                
                
                cell2.requestrecivereject.hidden=YES;
            }
            else if ([[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_confirm"] isEqualToString:@"N"] && [[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_reject"] isEqualToString:@"Y"])
            {
                
                cell2.requestreciveconfirm.hidden=YES;
                
                cell2.requestrecivereject.tag=indexPath.row;
                cell2.requestrecivereject.layer.cornerRadius=4;
                cell2.requestrecivereject.hidden=NO;
            }
            else if ([[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_confirm"] isEqualToString:@"Y"] && [[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_reject"] isEqualToString:@"Y"])
            {
                cell2.requestreciveconfirm.tag=indexPath.row;
                cell2.requestreciveconfirm.layer.cornerRadius=4;
                cell2.requestreciveconfirm.hidden=NO;
                
                cell2.requestrecivereject.tag=indexPath.row;
                cell2.requestrecivereject.layer.cornerRadius=4;
                cell2.requestrecivereject.hidden=NO;
            }
            
            
            
            
            [cell2.requestreciveconfirm addTarget:self action:@selector(requestreciveconfirmTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell2.requestrecivereject addTarget:self action:@selector(requestreciverejectTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            
            [cell2 setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell2;
        }
        else if (actioncheck == 22)
        {
            
            cell2.requestreciveconfirm.hidden=YES;
            cell2.requestrecivereject.hidden=YES;
            
            cell2.appoint_status.text = [NSString stringWithFormat:@"Appointment Request Sent To %@",[[request_sent objectAtIndex:indexPath.row] valueForKey:@"sent_to_user"]];
            cell2.timming.text = [[request_sent objectAtIndex:indexPath.row] valueForKey:@"booking_time"];
            cell2.datetovisit.text = [[request_sent objectAtIndex:indexPath.row] valueForKey:@"booking_date"];
            cell2.bookingstatus.text = [[request_sent objectAtIndex:indexPath.row] valueForKey:@"booking_status"];
            [cell2.propertyimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[request_sent objectAtIndex:indexPath.row ]valueForKey:@"property_image"]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            
            if ([[[request_sent objectAtIndex:indexPath.row] valueForKey:@"booking_status"] isEqualToString:@"Priliminary"] || [[[request_sent objectAtIndex:indexPath.row] valueForKey:@"booking_status"] isEqualToString:@"Rejected"])
            {
                cell2.newtimebtn.hidden = NO;
                cell2.newtimebtn.tag = indexPath.row;
                [cell2.newtimebtn addTarget:self action:@selector(NewTimeTapped:) forControlEvents:UIControlEventTouchUpInside];
            }
            else if ([[[request_sent objectAtIndex:indexPath.row] valueForKey:@"booking_status"] isEqualToString:@"Confirmed"])
            {
                cell2.newtimebtn.hidden = YES;
                cell2.newtimebtn.tag = indexPath.row;
            }
            
            
            if ([[[request_sent objectAtIndex:indexPath.row] valueForKey:@"make_an_offer"] isEqualToString:@"N"] && [[[request_sent objectAtIndex:indexPath.row] valueForKey:@"give_feedback"] isEqualToString:@"N"])
            {
                cell2.feedback.hidden=YES;
                cell2.makeoffer.hidden=YES;
            }
            else if ([[[request_sent objectAtIndex:indexPath.row] valueForKey:@"make_an_offer"] isEqualToString:@"Y"] && [[[request_sent objectAtIndex:indexPath.row] valueForKey:@"give_feedback"] isEqualToString:@"N"])
            {
                cell2.feedback.hidden=YES;
                
                cell2.makeoffer.tag=indexPath.row;
                cell2.makeoffer.layer.cornerRadius=4;
                cell2.makeoffer.hidden=NO;
            }
            else if ([[[request_sent objectAtIndex:indexPath.row] valueForKey:@"make_an_offer"] isEqualToString:@"N"] && [[[request_sent objectAtIndex:indexPath.row] valueForKey:@"give_feedback"] isEqualToString:@"Y"])
            {
                cell2.feedback.tag=indexPath.row;
                cell2.feedback.layer.cornerRadius=4;
                cell2.feedback.hidden=NO;
                
                
                
                cell2.makeoffer.hidden=YES;
            }
            else if ([[[request_sent objectAtIndex:indexPath.row] valueForKey:@"make_an_offer"] isEqualToString:@"Y"] && [[[request_sent objectAtIndex:indexPath.row] valueForKey:@"give_feedback"] isEqualToString:@"Y"])
            {
                cell2.feedback.tag=indexPath.row;
                cell2.feedback.layer.cornerRadius=4;
                cell2.feedback.hidden=NO;
                
                
                cell2.makeoffer.tag=indexPath.row;
                cell2.makeoffer.layer.cornerRadius=4;
                cell2.makeoffer.hidden=NO;
            }
            
            
            [cell2.feedback addTarget:self action:@selector(feedbackbtnTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell2.makeoffer addTarget:self action:@selector(makeofferbtnTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            
            [cell2 setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell2;
        }
    }
    return nil;
}

-(void)requestreciveconfirmTapped:(UIButton *)sender
{
    NSLog(@"CONFIRM");
    NSLog(@"Action to perform with Confirm");
    
    polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
    polygonView.backgroundColor=[UIColor blackColor];
    polygonView.alpha=0.3;
    [self.view addSubview:polygonView];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
    
    [polygonView addSubview:spinner];
    [spinner startAnimating];
    
    NSString *confirm = [NSString stringWithFormat:@"%@json_output.php?mode=update_booking_status&booking_id=%@&booking_status=C",App_Domain_Url,[[request_rcvd objectAtIndex:sender.tag] valueForKey:@"booking_id"]];
    [obj GlobalDict:confirm Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         NSLog(@"%@",result);
         NSMutableDictionary *holdresult=[result mutableCopy];
         NSString *returnvalue=[holdresult valueForKey:@"message"];
         if ([returnvalue isEqualToString:@"Status Updated Successfully"])
         {
             
             appointmentdic=nil;
             request_rcvd=nil;
             request_sent=nil;
             NSString *appointmenturl = [NSString stringWithFormat:@"%@json_output.php?mode=list_of_appointments_Sent_and_recvd&user_id=%@",App_Domain_Url,userid];
             
             [obj GlobalDict:appointmenturl Globalstr:@"array" Withblock:^(id result, NSError *error)
              {
                  appointmentdic=[result mutableCopy];
                  
                  request_rcvd = [appointmentdic valueForKey:@"request_rcvd"];
                  request_sent = [appointmentdic valueForKey:@"request_sent"];
                  [_tableview reloadData];
                  [spinner stopAnimating];
                  [spinner removeFromSuperview];
                  [polygonView removeFromSuperview];
                  UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Status Updated" message: @"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
                  [alert show];
              }];
             
             
             
             
         }
         else
         {
             [spinner stopAnimating];
             [spinner removeFromSuperview];
             [polygonView removeFromSuperview];
             UIAlertView *alert = [[UIAlertView alloc]initWithTitle:returnvalue message: @"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
             [alert show];
             
         }
     }];
    
    
    
    
    
    
    
}





-(void)requestreciverejectTapped:(UIButton *)sender
{
    NSLog(@"Reject");
    
    NSLog(@"Action to perform with Reject");
    
    polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
    polygonView.backgroundColor=[UIColor blackColor];
    polygonView.alpha=0.3;
    [self.view addSubview:polygonView];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
    
    [polygonView addSubview:spinner];
    [spinner startAnimating];
    
    
    
    
    NSString *confirm = [NSString stringWithFormat:@"%@json_output.php?mode=update_booking_status&booking_id=%@&booking_status=R",App_Domain_Url,[[request_rcvd objectAtIndex:sender.tag] valueForKey:@"booking_id"]];
    [obj GlobalDict:confirm Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         NSLog(@"%@",result);
         NSMutableDictionary *holdresult=[result mutableCopy];
         NSString *returnvalue=[holdresult valueForKey:@"message"];
         if ([returnvalue isEqualToString:@"Status Updated Successfully"])
         {
             appointmentdic=nil;
             request_rcvd=nil;
             request_sent=nil;
             NSString *appointmenturl = [NSString stringWithFormat:@"%@json_output.php?mode=list_of_appointments_Sent_and_recvd&user_id=%@",App_Domain_Url,userid];
             
             [obj GlobalDict:appointmenturl Globalstr:@"array" Withblock:^(id result, NSError *error)
              {
                  appointmentdic=[result mutableCopy];
                  
                  request_rcvd = [appointmentdic valueForKey:@"request_rcvd"];
                  request_sent = [appointmentdic valueForKey:@"request_sent"];
                  [_tableview reloadData];
                  
                  [spinner stopAnimating];
                  [spinner removeFromSuperview];
                  [polygonView removeFromSuperview];
                  UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Status Updated" message: @"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
                  [alert show];
              }];
         }
         else
         {
             
             [spinner stopAnimating];
             [spinner removeFromSuperview];
             [polygonView removeFromSuperview];
             UIAlertView *alert = [[UIAlertView alloc]initWithTitle:returnvalue message: @"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
             [alert show];
         }
     }];
    
    
    
    
    
}





-(void)feedbackbtnTapped:(UIButton *)sender
{
    NSLog(@"feedback");
    NSLog(@"Action to perform with Button2!");
    NSLog(@"feedback button");
    feedback *feed = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"feed"];
    
    feed.data_dic = [[request_sent objectAtIndex:sender.tag] mutableCopy];
    
    [self.navigationController pushViewController:feed animated:YES];
    
    
    
    
}


-(void)makeofferbtnTapped:(UIButton *)sender
{
    NSLog(@"makeoffer");
    
    NSLog(@"Action to perform with Button 1");
    NSLog(@"Action to perform with make an offfer");
    MPMakeAnOfferViewController *make = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"makeanoffer"];
    
    make.data_dic = [[request_sent objectAtIndex:sender.tag] mutableCopy];
    
    [self.navigationController pushViewController:make animated:YES];
    
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tapcheck == 0 )
    {
        if (editingStyle == UITableViewCellEditingStyleDelete)
        {
            
            //add code here for when you hit delete
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tapcheck == 0)
    {
        if (indexPath.row >= 0)
        {
            if (actioncheck == 21)
            {
                if ([[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_confirm"] isEqualToString:@"Y"] && [[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_reject"] isEqualToString:@"Y"])
                {
                    return UITableViewCellEditingStyleInsert;
                }
                else if ([[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_confirm"] isEqualToString:@"Y"] && [[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_reject"] isEqualToString:@"N"])
                {
                    return UITableViewCellEditingStyleInsert;
                }
                else if ([[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_confirm"] isEqualToString:@"N"] && [[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_reject"] isEqualToString:@"Y"])
                {
                    return UITableViewCellEditingStyleInsert;
                }
                else
                    return nil;
            }
            else if (actioncheck == 22)
            {
                if ([[[request_sent objectAtIndex:indexPath.row] valueForKey:@"make_an_offer"] isEqualToString:@"Y"] && [[[request_sent objectAtIndex:indexPath.row] valueForKey:@"give_feedback"] isEqualToString:@"Y"])
                {
                    return UITableViewCellEditingStyleInsert;
                }
                else if ([[[request_sent objectAtIndex:indexPath.row] valueForKey:@"make_an_offer"] isEqualToString:@"Y"] && [[[request_sent objectAtIndex:indexPath.row] valueForKey:@"give_feedback"] isEqualToString:@"N"])
                {
                    return UITableViewCellEditingStyleInsert;
                }
                else if ([[[request_sent objectAtIndex:indexPath.row] valueForKey:@"make_an_offer"] isEqualToString:@"N"] && [[[request_sent objectAtIndex:indexPath.row] valueForKey:@"give_feedback"] isEqualToString:@"Y"])
                {
                    return UITableViewCellEditingStyleInsert;
                }
                else
                    return nil;
            }
        }
        return nil;
    }
    
    else
        return nil;
    
}

- (NSArray *)tableView:(UITableView *)tableView
editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tapcheck == 0)
    {
        
        if ( actioncheck == 21)
        {
            if (indexPath.row >= 0)
            {
                
                UITableViewRowAction *button, *button2;
                if ([[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_confirm"] isEqualToString:@"N"] && [[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_reject"] isEqualToString:@"N"])
                {
                    
                    return nil;
                    
                }
                
                else if ([[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_confirm"] isEqualToString:@"Y"] && [[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_reject"] isEqualToString:@"N"])
                {
                    button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Confirm" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                              {
                                  NSLog(@"Action to perform with Confirm");
                                  
                                  polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
                                  polygonView.backgroundColor=[UIColor blackColor];
                                  polygonView.alpha=0.3;
                                  [self.view addSubview:polygonView];
                                  UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
                                  spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
                                  
                                  [polygonView addSubview:spinner];
                                  [spinner startAnimating];
                                  
                                  NSString *confirm = [NSString stringWithFormat:@"%@json_output.php?mode=update_booking_status&booking_id=%@&booking_status=C",App_Domain_Url,[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"booking_id"]];
                                  [obj GlobalDict:confirm Globalstr:@"array" Withblock:^(id result, NSError *error)
                                   {
                                       NSLog(@"%@",result);
                                       NSMutableDictionary *holdresult=[result mutableCopy];
                                       NSString *returnvalue=[holdresult valueForKey:@"message"];
                                       if ([returnvalue isEqualToString:@"Status Updated Successfully"])
                                       {
                                           
                                           appointmentdic=nil;
                                           request_rcvd=nil;
                                           request_sent=nil;
                                           NSString *appointmenturl = [NSString stringWithFormat:@"%@json_output.php?mode=list_of_appointments_Sent_and_recvd&user_id=%@",App_Domain_Url,userid];
                                           
                                           [obj GlobalDict:appointmenturl Globalstr:@"array" Withblock:^(id result, NSError *error)
                                            {
                                                appointmentdic=[result mutableCopy];
                                                
                                                request_rcvd = [appointmentdic valueForKey:@"request_rcvd"];
                                                request_sent = [appointmentdic valueForKey:@"request_sent"];
                                                [_tableview reloadData];
                                                [spinner stopAnimating];
                                                [spinner removeFromSuperview];
                                                [polygonView removeFromSuperview];
                                                UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Status Updated" message: @"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
                                                [alert show];
                                            }];
                                           
                                           
                                           
                                           
                                       }
                                       else
                                       {
                                           [spinner stopAnimating];
                                           [spinner removeFromSuperview];
                                           [polygonView removeFromSuperview];
                                           UIAlertView *alert = [[UIAlertView alloc]initWithTitle:returnvalue message: @"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
                                           [alert show];
                                           
                                       }
                                   }];
                                  
                                  
                              }];
                    
                    button.backgroundColor = [UIColor colorWithRed:232/255.0f green:122/255.0f blue:86/255.0f alpha:1]; //arbitrary color
                    
                    
                    return @[button];
                    
                }
                else if ([[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_confirm"] isEqualToString:@"N"] && [[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_reject"] isEqualToString:@"Y"])
                {
                    
                    button2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Reject" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                               {
                                   NSLog(@"Action to perform with Reject");
                                   
                                   polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
                                   polygonView.backgroundColor=[UIColor blackColor];
                                   polygonView.alpha=0.3;
                                   [self.view addSubview:polygonView];
                                   UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
                                   spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
                                   
                                   [polygonView addSubview:spinner];
                                   [spinner startAnimating];
                                   
                                   
                                   
                                   
                                   NSString *confirm = [NSString stringWithFormat:@"%@json_output.php?mode=update_booking_status&booking_id=%@&booking_status=R",App_Domain_Url,[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"booking_id"]];
                                   [obj GlobalDict:confirm Globalstr:@"array" Withblock:^(id result, NSError *error)
                                    {
                                        NSLog(@"%@",result);
                                        NSMutableDictionary *holdresult=[result mutableCopy];
                                        NSString *returnvalue=[holdresult valueForKey:@"message"];
                                        if ([returnvalue isEqualToString:@"Status Updated Successfully"])
                                        {
                                            appointmentdic=nil;
                                            request_rcvd=nil;
                                            request_sent=nil;
                                            NSString *appointmenturl = [NSString stringWithFormat:@"%@json_output.php?mode=list_of_appointments_Sent_and_recvd&user_id=%@",App_Domain_Url,userid];
                                            
                                            [obj GlobalDict:appointmenturl Globalstr:@"array" Withblock:^(id result, NSError *error)
                                             {
                                                 appointmentdic=[result mutableCopy];
                                                 
                                                 request_rcvd = [appointmentdic valueForKey:@"request_rcvd"];
                                                 request_sent = [appointmentdic valueForKey:@"request_sent"];
                                                 [_tableview reloadData];
                                                 
                                                 [spinner stopAnimating];
                                                 [spinner removeFromSuperview];
                                                 [polygonView removeFromSuperview];
                                                 UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Status Updated" message: @"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
                                                 [alert show];
                                             }];
                                        }
                                        else
                                        {
                                            
                                            [spinner stopAnimating];
                                            [spinner removeFromSuperview];
                                            [polygonView removeFromSuperview];
                                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:returnvalue message: @"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
                                            [alert show];
                                        }
                                    }];
                                   
                               }];
                    
                    button2.backgroundColor = [UIColor colorWithRed:82.0f/255.0f green:173.0f/255.0f blue:33.0f/255.0f alpha:1]; //arbitrary color
                    return @[button2];
                    
                }
                
                else if ([[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_confirm"] isEqualToString:@"Y"] && [[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_reject"] isEqualToString:@"Y"])
                {
                    button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Confirm" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                              {
                                  NSLog(@"Action to perform with Confirm");
                                  
                                  polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
                                  polygonView.backgroundColor=[UIColor blackColor];
                                  polygonView.alpha=0.3;
                                  [self.view addSubview:polygonView];
                                  UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
                                  spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
                                  
                                  [polygonView addSubview:spinner];
                                  [spinner startAnimating];
                                  
                                  
                                  NSString *confirm = [NSString stringWithFormat:@"%@json_output.php?mode=update_booking_status&booking_id=%@&booking_status=C",App_Domain_Url,[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"booking_id"]];
                                  [obj GlobalDict:confirm Globalstr:@"array" Withblock:^(id result, NSError *error)
                                   {
                                       NSLog(@"%@",result);
                                       NSMutableDictionary *holdresult=[result mutableCopy];
                                       NSString *returnvalue=[holdresult valueForKey:@"message"];
                                       if ([returnvalue isEqualToString:@"Status Updated Successfully"])
                                       {
                                           appointmentdic=nil;
                                           request_rcvd=nil;
                                           request_sent=nil;
                                           NSString *appointmenturl = [NSString stringWithFormat:@"%@json_output.php?mode=list_of_appointments_Sent_and_recvd&user_id=%@",App_Domain_Url,userid];
                                           
                                           [obj GlobalDict:appointmenturl Globalstr:@"array" Withblock:^(id result, NSError *error)
                                            {
                                                appointmentdic=[result mutableCopy];
                                                
                                                request_rcvd = [appointmentdic valueForKey:@"request_rcvd"];
                                                request_sent = [appointmentdic valueForKey:@"request_sent"];
                                                [_tableview reloadData];
                                                [spinner stopAnimating];
                                                [spinner removeFromSuperview];
                                                [polygonView removeFromSuperview];
                                                UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Status Updated" message: @"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
                                                [alert show];
                                            }];
                                       }
                                       else
                                       {
                                           [spinner stopAnimating];
                                           [spinner removeFromSuperview];
                                           [polygonView removeFromSuperview];
                                           UIAlertView *alert = [[UIAlertView alloc]initWithTitle:returnvalue message: @"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
                                           [alert show];
                                       }
                                   }];
                                  
                              }];
                    
                    button.backgroundColor = [UIColor colorWithRed:232/255.0f green:122/255.0f blue:86/255.0f alpha:1]; //arbitrary color
                    
                    button2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Reject" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                               {
                                   NSLog(@"Action to perform with Reject");
                                   
                                   
                                   polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
                                   polygonView.backgroundColor=[UIColor blackColor];
                                   polygonView.alpha=0.3;
                                   [self.view addSubview:polygonView];
                                   UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
                                   spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
                                   
                                   [polygonView addSubview:spinner];
                                   [spinner startAnimating];
                                   
                                   
                                   NSString *confirm = [NSString stringWithFormat:@"%@json_output.php?mode=update_booking_status&booking_id=%@&booking_status=R",App_Domain_Url,[[request_rcvd objectAtIndex:indexPath.row] valueForKey:@"booking_id"]];
                                   [obj GlobalDict:confirm Globalstr:@"array" Withblock:^(id result, NSError *error)
                                    {
                                        NSLog(@"%@",result);
                                        NSMutableDictionary *holdresult=[result mutableCopy];
                                        NSString *returnvalue=[holdresult valueForKey:@"message"];
                                        if ([returnvalue isEqualToString:@"Status Updated Successfully"])
                                        {
                                            appointmentdic=nil;
                                            request_rcvd=nil;
                                            request_sent=nil;
                                            NSString *appointmenturl = [NSString stringWithFormat:@"%@json_output.php?mode=list_of_appointments_Sent_and_recvd&user_id=%@",App_Domain_Url,userid];
                                            
                                            [obj GlobalDict:appointmenturl Globalstr:@"array" Withblock:^(id result, NSError *error)
                                             {
                                                 appointmentdic=[result mutableCopy];
                                                 
                                                 request_rcvd = [appointmentdic valueForKey:@"request_rcvd"];
                                                 request_sent = [appointmentdic valueForKey:@"request_sent"];
                                                 [_tableview reloadData];
                                                 [spinner stopAnimating];
                                                 [spinner removeFromSuperview];
                                                 [polygonView removeFromSuperview];
                                                 UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Status Updated" message: @"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
                                                 [alert show];
                                             }];
                                        }
                                        else
                                        {
                                            [spinner stopAnimating];
                                            [spinner removeFromSuperview];
                                            [polygonView removeFromSuperview];
                                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:returnvalue message: @"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
                                            [alert show];
                                        }
                                    }];
                                   
                                   
                               }];
                    
                    button2.backgroundColor = [UIColor colorWithRed:82.0f/255.0f green:173.0f/255.0f blue:33.0f/255.0f alpha:1];
                    return @[button,button2];
                }
            }
            
        }
        else if ( actioncheck == 22)
        {
            if (indexPath.row >= 0)
            {
                
                UITableViewRowAction *button, *button2;
                if ([[[request_sent objectAtIndex:indexPath.row] valueForKey:@"make_an_offer"] isEqualToString:@"N"] && [[[request_sent objectAtIndex:indexPath.row] valueForKey:@"give_feedback"] isEqualToString:@"N"])
                {
                    
                    return nil;
                    
                }
                
                else if ([[[request_sent objectAtIndex:indexPath.row] valueForKey:@"make_an_offer"] isEqualToString:@"Y"] && [[[request_sent objectAtIndex:indexPath.row] valueForKey:@"give_feedback"] isEqualToString:@"N"])
                {
                    button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Make offer" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                              {
                                  NSLog(@"Action to perform with Button 1");
                                  NSLog(@"Action to perform with make an offfer");
                                  MPMakeAnOfferViewController *make = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"makeanoffer"];
                                  
                                  make.data_dic = [[request_sent objectAtIndex:indexPath.row] mutableCopy];
                                  
                                  [self.navigationController pushViewController:make animated:YES];
                              }];
                    
                    button.backgroundColor = [UIColor colorWithRed:232/255.0f green:122/255.0f blue:86/255.0f alpha:1]; //arbitrary color
                    
                    
                    return @[button];
                    
                }
                else if ([[[request_sent objectAtIndex:indexPath.row] valueForKey:@"make_an_offer"] isEqualToString:@"N"] && [[[request_sent objectAtIndex:indexPath.row] valueForKey:@"give_feedback"] isEqualToString:@"Y"])
                {
                    
                    button2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Feedback" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                               {
                                   NSLog(@"Action to perform with Button2!");
                                   feedback *feed = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"feed"];
                                   
                                   feed.data_dic = [[request_sent objectAtIndex:indexPath.row] mutableCopy];
                                   
                                   [self.navigationController pushViewController:feed animated:YES];
                               }];
                    
                    button2.backgroundColor = [UIColor colorWithRed:82.0f/255.0f green:173.0f/255.0f blue:33.0f/255.0f alpha:1]; //arbitrary color
                    return @[button2];
                    
                }
                
                else if ([[[request_sent objectAtIndex:indexPath.row] valueForKey:@"make_an_offer"] isEqualToString:@"Y"] && [[[request_sent objectAtIndex:indexPath.row] valueForKey:@"give_feedback"] isEqualToString:@"Y"])
                {
                    button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Make offer" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                              {
                                  NSLog(@"Action to perform with Button 1");
                                  NSLog(@"Action to perform with make an offer");
                                  MPMakeAnOfferViewController *make = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"makeanoffer"];
                                  
                                  make.data_dic = [[request_sent objectAtIndex:indexPath.row] mutableCopy];
                                  
                                  [self.navigationController pushViewController:make animated:YES];
                              }];
                    
                    button.backgroundColor = [UIColor colorWithRed:232/255.0f green:122/255.0f blue:86/255.0f alpha:1]; //arbitrary color
                    
                    button2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Feedback" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                               {
                                   NSLog(@"Action to perform with Button2!");
                                   
                                   feedback *feed = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"feed"];
                                   
                                   feed.data_dic = [[request_sent objectAtIndex:indexPath.row] mutableCopy];
                                   
                                   [self.navigationController pushViewController:feed animated:YES];
                                   
                               }];
                    
                    button2.backgroundColor = [UIColor colorWithRed:82.0f/255.0f green:173.0f/255.0f blue:33.0f/255.0f alpha:1];
                    return @[button,button2];
                }
            }
            
        }
        
        
    }
    return nil;
}

-(void)NewTimeTapped:(UIButton *)sender
{
    NSLog(@"tag is: %ld",(long)sender.tag);
    
    
    if (tapcheck == 0)
    {
        if (actioncheck == 21)
        {
            bookingid = [[request_rcvd objectAtIndex:sender.tag] valueForKey:@"booking_id"];
            adv_idfinal=[[request_rcvd objectAtIndex:sender.tag] valueForKey:@"advert_id"];
            
            NSString *dateString = [[request_rcvd objectAtIndex:sender.tag] valueForKey:@"booking_date"];
            NSArray* foo = [dateString componentsSeparatedByString: @"-"];
            NSString* year = [foo objectAtIndex: 0];
            NSString *month=[foo objectAtIndex:1];
            NSString *finaladdress=[[request_rcvd objectAtIndex:sender.tag] valueForKey:@"address1"];
            
            
            NSLog(@"bookingidfinal%@",bookingid);
            NSLog(@"advidfinal%@",adv_idfinal);
            NSLog(@"yearfinal%@",year);
            NSLog(@"monthfinal%@",month);
            chkingdata=@"i am from request";
            MPBookAgentViewController *book = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"bookagent"];
            book.book_id=bookingid;
            book.chkdata=chkingdata;
            book.finaladv_id=adv_idfinal;
            book.finalyear=year;
            book.finalmonth=month;
            book.address=finaladdress;
            [self.navigationController pushViewController:book animated:YES];
            
            
        }
        else if (actioncheck==22)
        {
            bookingid = [[request_sent objectAtIndex:sender.tag] valueForKey:@"booking_id"];
            adv_idfinal=[[request_sent objectAtIndex:sender.tag] valueForKey:@"advert_id"];
            
            
            NSString *dateString = [[request_sent objectAtIndex:sender.tag] valueForKey:@"booking_date"];
            NSArray* foo = [dateString componentsSeparatedByString: @"-"];
            NSString* year = [foo objectAtIndex: 0];
            NSString *month=[foo objectAtIndex:1];
            NSString *finaladdress=[[request_sent objectAtIndex:sender.tag] valueForKey:@"address1"];
            
            
            NSLog(@"bookingidfinal%@",bookingid);
            NSLog(@"advidfinal%@",adv_idfinal);
            NSLog(@"yearfinal%@",year);
            NSLog(@"monthfinal%@",month);
            chkingdata=@"i am from request";
            MPBookAgentViewController *book = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"bookagent"];
            book.book_id=bookingid;
            book.chkdata=chkingdata;
            book.finaladv_id=adv_idfinal;
            book.finalyear=year;
            book.finalmonth=month;
            book.address=finaladdress;
            [self.navigationController pushViewController:book animated:YES];
            
        }
    }
    else if (tapcheck==1)
    {
        
        if (actioncheck == 21)
        {
            bookingid = [[request_rcvd objectAtIndex:sender.tag] valueForKey:@"booking_id"];
            adv_idfinal = [[request_rcvd objectAtIndex:sender.tag] valueForKey:@"advert_id"];
            
            
            NSString *dateString = [[request_rcvd objectAtIndex:sender.tag] valueForKey:@"booking_date"];
            NSArray* foo = [dateString componentsSeparatedByString: @"-"];
            NSString* year = [foo objectAtIndex: 0];
            NSString *month=[foo objectAtIndex:1];
            NSString *finaladdress=[[request_rcvd objectAtIndex:sender.tag] valueForKey:@"address1"];
            
            NSLog(@"bookingidfinal%@",bookingid);
            NSLog(@"advidfinal%@",adv_idfinal);
            NSLog(@"yearfinal%@",year);
            NSLog(@"monthfinal%@",month);
            chkingdata=@"i am from request";
            MPBookAgentViewController *book = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"bookagent"];
            book.book_id=bookingid;
            book.chkdata=chkingdata;
            book.finaladv_id=adv_idfinal;
            book.finalyear=year;
            book.finalmonth=month;
            book.address=finaladdress;
            [self.navigationController pushViewController:book animated:YES];
            
            
        }
        else if (actioncheck==22)
        {
            bookingid = [[request_sent objectAtIndex:sender.tag] valueForKey:@"booking_id"];
            adv_idfinal = [[request_sent objectAtIndex:sender.tag] valueForKey:@"advert_id"];
            
            
            NSString *dateString = [[request_sent objectAtIndex:sender.tag] valueForKey:@"booking_date"];
            NSArray* foo = [dateString componentsSeparatedByString: @"-"];
            NSString* year = [foo objectAtIndex: 0];
            NSString *month=[foo objectAtIndex:1];
            NSString *finaladdress=[[request_sent objectAtIndex:sender.tag] valueForKey:@"address1"];
            
            NSLog(@"bookingidfinal%@",bookingid);
            NSLog(@"advidfinal%@",adv_idfinal);
            NSLog(@"yearfinal%@",year);
            NSLog(@"monthfinal%@",month);
            
            chkingdata=@"i am from request";
            MPBookAgentViewController *book = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"bookagent"];
            book.book_id=bookingid;
            book.chkdata=chkingdata;
            book.finaladv_id=adv_idfinal;
            book.finalyear=year;
            book.finalmonth=month;
            book.address=finaladdress;
            [self.navigationController pushViewController:book animated:YES];
            
        }
    }
    
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"didSelectRowAtIndexPath");
//    PropertyDetails2ViewController *prop2 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"propertydetail"];
//    prop2.checkstring = @"appoint";
//    if (actioncheck == 21)
//    {
//        prop2.data_dic = [[request_rcvd objectAtIndex:indexPath.row] mutableCopy];
//    }
//    else
//    {
//        prop2.data_dic = [[request_sent objectAtIndex:indexPath.row] mutableCopy];
//    }
//    
//    [self.navigationController pushViewController:prop2 animated:YES];
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
