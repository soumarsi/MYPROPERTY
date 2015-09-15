//
//  MPOfferAlertsViewController.m
//  MYPROPERTY
//
//  Created by Somenath on 05/08/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "MPOfferAlertsViewController.h"
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
#import "MPAppointmentViewController.h"
#import "Listing3ViewController.h"
#import "UIImageView+WebCache.h"
#import "PropertyDetails2ViewController.h"


@interface MPOfferAlertsViewController () <footerdelegate,rightDelegate,UIGestureRecognizerDelegate, SubCatagoryDelegate>
{
    BOOL viewslide,rightslide, tapcheck, experidate;
    NSUserDefaults *userinfo;
    UIView *slideview, *blackview, *polygonView;
    NSInteger check, actioncheck;
    NSArray *btnname;
    Footer *footerView;
    RightMenu *rightView;
    SubCatagoryView *subcat;
    NSString *userid;
    NSMutableArray *offer_rcvd, *offer_sent;
    NSMutableDictionary *appointmentdic, *offerdic;
}

@property (strong, nonatomic) IBOutlet UIView *mainview;
@property (strong, nonatomic) IBOutlet UIView *subCatgoryView;
@property (strong, nonatomic) IBOutlet UIButton *subviewbtn;
@property (strong, nonatomic) IBOutlet UIImageView *headerimage;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) IBOutlet UIButton *offerRecvBtn;
@property (strong, nonatomic) IBOutlet UIButton *offerSentBtn;
@property (strong, nonatomic) IBOutlet UILabel *nodatafoundlbl;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@end

@implementation MPOfferAlertsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    obj = [[FW_JsonClass alloc]init];
    userinfo=[[NSUserDefaults alloc]init];
    
    userid = [userinfo objectForKey:@"id"];
    NSLog(@"userid is : %@",userid);
    
    viewslide = 0;
    rightslide = 0;
    tapcheck = 0;
    check = 1;
    actioncheck = 31;
    
    blackview = [[UIView alloc]init];
    footerView=[[Footer alloc]init];
    
    NSString *offersurl = [NSString stringWithFormat:@"%@json_output.php?mode=list_of_sent_and_received_offers&user_id=%@",App_Domain_Url,userid];
    
    polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
    polygonView.backgroundColor=[UIColor blackColor];
    polygonView.alpha=0.3;
    [self.view addSubview:polygonView];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
    
    [polygonView addSubview:spinner];
    [spinner startAnimating];
    [obj GlobalDict:offersurl Globalstr:@"array" Withblock:^(id result, NSError *error)
    {
        offerdic = [result mutableCopy];
              
        offer_rcvd = [offerdic valueForKey:@"offer_rcvd"];
        offer_sent = [offerdic valueForKey:@"offer_sent"];
        
        [_offerRecvBtn setTitle:[NSString stringWithFormat:@"Offer recieved(%ld)",(long)[offer_rcvd count]] forState:UIControlStateNormal];
        [_offerSentBtn setTitle:[NSString stringWithFormat:@"Offer sent(%ld)",(long)[offer_sent count]] forState:UIControlStateNormal];
        
        if ([offer_rcvd count] == 0)
        {
            [_nodatafoundlbl setHidden:NO];
        }
        else
        {
            [_tableview reloadData];
            [_nodatafoundlbl setHidden:YES];
        }
        
        NSLog(@"offer_r----%@",offer_rcvd);
        NSLog(@"offer_s----%@",offer_sent);
              
        [spinner stopAnimating];
        [spinner removeFromSuperview];
        [polygonView removeFromSuperview];
    }];
         
    

    
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

- (IBAction)listViewTapped:(id)sender
{
    tapcheck = 0;
    
    [_tableview reloadData];
}

- (IBAction)gridViewTapped:(id)sender
{
    tapcheck = 1;
    
    [_tableview reloadData];
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
            [subcat TapCheck:4];
            
            subcat.layer.borderWidth = 1.0f;
            subcat.layer.cornerRadius = 4.0f;
            subcat.layer.borderColor = [UIColor colorWithRed:200.0f/255 green:200.0f/255.0f blue:200.0f/255.0f alpha:1].CGColor;
            
            subcat.layer.shadowOffset = CGSizeMake(0, 1);
            subcat.layer.shadowRadius = 6;
            subcat.layer.shadowOpacity = 0.5;
            
//            CALayer *layer = [CALayer layer];
//            
//            [layer setShadowOpacity:0.4f];
//            [layer setCornerRadius:8.0f];
//            [layer setBorderWidth:1.0f];
//            
//            [[subcat layer] addSublayer:layer];
//            
//            [[subcat layer] setShadowOpacity:0.4f];
//            [[subcat layer] setShadowRadius:15.0f];
//            [[subcat layer] setCornerRadius:8.0f];
//            [[subcat layer] setBorderWidth:1.0f];
            
            ;
            
//            [subcat.layer setShadowOffset:CGSizeMake(0, 3)];
//            [subcat.layer setShadowOpacity:0.4];
//            [subcat.layer setShadowRadius:3.0f];
//            [subcat.layer setShouldRasterize:YES];
//            
//            [subcat.layer setCornerRadius:12.0f];
//            [subcat.layer setShadowPath:[[UIBezierPath bezierPathWithRoundedRect:[self bounds]cornerRadius:12.0f] CGPath]];
            
//            [subcat.layer setMasksToBounds:YES];
            
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
                [subcat TapCheck:3];
                MPAppointmentViewController *appo = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"appointment"];
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
                [self.navigationController pushViewController:appo animated:NO];
    }
    else if (sender.tag == 203)
    {
        NSLog(@"4");
        [subcat TapCheck:4];
   /*     MPOfferAlertsViewController *offer = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"offeralerts"];
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
        [self.navigationController pushViewController:offer animated:NO];   */
        
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

- (IBAction)offerRecvTapped:(id)sender
{
   
    [_offerRecvBtn setTitleColor:[UIColor colorWithRed:74.0f/255.0f green:133.0f/255.0f blue:219.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [_offerSentBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    if([offer_rcvd count] == 0)
    {
        [_nodatafoundlbl setHidden:NO];
        [_tableview setHidden:YES];
    }
    else
    {
         actioncheck = 31;
        [_tableview setHidden:NO];
        [_tableview reloadData];
        [_nodatafoundlbl setHidden:YES];
    }
}



- (IBAction)offerSentTapped:(id)sender
{
    
    [_offerRecvBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_offerSentBtn setTitleColor:[UIColor colorWithRed:74.0f/255.0f green:133.0f/255.0f blue:219.0f/255.0f alpha:1] forState:UIControlStateNormal];
    
    if ([offer_sent count] == 0)
    {
        [_nodatafoundlbl setHidden:NO];
        [_tableview setHidden:YES];
    }
    else
    {
        actioncheck = 32;
        [_tableview setHidden:NO];
        [_tableview reloadData];
        [_nodatafoundlbl setHidden:YES];
    }
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
    NSLog(@"numberOfRowsInSection");
    NSInteger someV =0;
    
    if (actioncheck == 31)
    {
        someV = [offer_rcvd count];
    }
    else if (actioncheck == 32)
    {
        someV = [offer_sent count];
    }
    //    NSLog(@"row number-----%ld",(long)someV);
    return someV;
    
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"numberOfRowsInSection");
    if (tapcheck == 0)
    {
        cell1 = (OfferListCell *)[tableView dequeueReusableCellWithIdentifier:@"offerlist"];
        
        if (actioncheck == 31)
        {
            cell1.appoint_status.text = [NSString stringWithFormat:@"Offer received from %@ for %@",[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"sent_from_user"],[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"offer_price"]];
            cell1.timming.text = [[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"booking_time"];
            cell1.datetovisit.text = [[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"booking_date"];

            cell1.bookingstatus.text = [[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"offer_status"];
            
            [cell1.propertyimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[offer_rcvd objectAtIndex:indexPath.row ]valueForKey:@"property_image"]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            
            if ([[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_confirm"] isEqualToString:@"Y"] && [[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_reject"] isEqualToString:@"N"])
            {
                cell1.slidearrow.hidden=NO;
            }
            else if ([[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_confirm"] isEqualToString:@"N"] && [[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_reject"] isEqualToString:@"Y"])
            {
                cell1.slidearrow.hidden=NO;
            }
            
            else if ([[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_confirm"] isEqualToString:@"Y"] && [[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_reject"] isEqualToString:@"Y"])
            {
                cell1.slidearrow.hidden=NO;
            }
            
            [cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell1;
        }
        else if (actioncheck == 32)
        {
            cell1.appoint_status.text = [NSString stringWithFormat:@"Offer received from %@ for %@",[[offer_sent objectAtIndex:indexPath.row] valueForKey:@"sent_to_user"],[[offer_sent objectAtIndex:indexPath.row] valueForKey:@"offer_price"]];
            cell1.timming.text = [[offer_sent objectAtIndex:indexPath.row] valueForKey:@"booking_time"];
            cell1.datetovisit.text = [[offer_sent objectAtIndex:indexPath.row] valueForKey:@"booking_date"];
            cell1.bookingstatus.text = [[offer_sent objectAtIndex:indexPath.row] valueForKey:@"offer_status"];
            
            [cell1.propertyimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[offer_sent objectAtIndex:indexPath.row ]valueForKey:@"property_image"]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            [cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];

            return cell1;
        }
    }
    else if (tapcheck == 1)
    {
        cell2 = (OfferGridCell *)[tableView dequeueReusableCellWithIdentifier:@"offergrid"];
        
        if (actioncheck == 31)
        {
            cell2.appoint_status.text = [NSString stringWithFormat:@"Offer received from %@",[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"sent_from_user"]];
            cell2.pricelbl.text = [[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"offer_price"];
            cell2.timming.text = [[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"booking_time"];
            cell2.datetovisit.text = [[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"booking_date"];
            cell2.bookingstatus.text = [[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"offer_status"];
            
            [cell2.propertyimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[offer_rcvd objectAtIndex:indexPath.row ]valueForKey:@"property_image"]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            
            
            
            
            if ([[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_confirm"] isEqualToString:@"N"] && [[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_reject"] isEqualToString:@"N"])
            {
                cell2.confirmoffer.hidden=YES;
                cell2.rejectoffer.hidden=YES;
            }
            else if ([[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_confirm"] isEqualToString:@"Y"] && [[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_reject"] isEqualToString:@"N"])
            {
                cell2.confirmoffer.tag=indexPath.row;
                cell2.confirmoffer.layer.cornerRadius=4;
                cell2.confirmoffer.hidden=NO;
                
                
                cell2.rejectoffer.hidden=YES;
            }
            else if ([[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_confirm"] isEqualToString:@"N"] && [[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_reject"] isEqualToString:@"Y"])
            {
                
                cell2.confirmoffer.hidden=YES;
                
                cell2.rejectoffer.tag=indexPath.row;
                cell2.rejectoffer.layer.cornerRadius=4;
                cell2.rejectoffer.hidden=NO;
            }
            else if ([[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_confirm"] isEqualToString:@"Y"] && [[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_reject"] isEqualToString:@"Y"])
            {
                cell2.confirmoffer.tag=indexPath.row;
                cell2.confirmoffer.layer.cornerRadius=4;
                cell2.confirmoffer.hidden=NO;
                
                cell2.rejectoffer.tag=indexPath.row;
                cell2.rejectoffer.layer.cornerRadius=4;
                cell2.rejectoffer.hidden=NO;
            }
            
            
            
            [cell2.confirmoffer addTarget:self action:@selector(confirmofferbtnTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell2.rejectoffer addTarget:self action:@selector(rejectofferbtnTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell2 setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell2;
        }
        else if (actioncheck == 32)
        {
            cell2.confirmoffer.hidden=YES;
            cell2.rejectoffer.hidden=YES;
            
            
            
            cell2.appoint_status.text = [NSString stringWithFormat:@"Offer received from %@",[[offer_sent objectAtIndex:indexPath.row] valueForKey:@"sent_to_user"]];
            cell2.pricelbl.text = [[offer_sent objectAtIndex:indexPath.row] valueForKey:@"offer_price"];
            cell2.timming.text = [[offer_sent objectAtIndex:indexPath.row] valueForKey:@"booking_time"];
            cell2.datetovisit.text = [[offer_sent objectAtIndex:indexPath.row] valueForKey:@"booking_date"];

            cell2.bookingstatus.text = [[offer_sent objectAtIndex:indexPath.row] valueForKey:@"offer_status"];
            
            [cell2.propertyimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[offer_sent objectAtIndex:indexPath.row ]valueForKey:@"property_image"]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
    
            
            [cell2 setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell2;
        }
    }
    return nil;
}

-(void)confirmofferbtnTapped:(UIButton *)sender
{
    NSLog(@"offer confirm");
    NSLog(@"Action to perform with Confirm");
    
    polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
    polygonView.backgroundColor=[UIColor blackColor];
    polygonView.alpha=0.3;
    [self.view addSubview:polygonView];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
    
    [polygonView addSubview:spinner];
    [spinner startAnimating];
    
    NSString *confirm = [NSString stringWithFormat:@"%@json_output.php?mode=update_offer_status&user_id=%@&offer_id=%@&offer_status=C",App_Domain_Url,userid,[[offer_rcvd objectAtIndex:sender.tag] valueForKey:@"offer_id"]];
    [obj GlobalDict:confirm Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         NSLog(@"%@",result);
         NSMutableDictionary *holdresult=[result mutableCopy];
         NSString *returnvalue=[holdresult valueForKey:@"message"];
         if ([returnvalue isEqualToString:@"Status Updated Successfully"])
         {
             
             offerdic=nil;
             offer_rcvd=nil;
             offer_sent=nil;
             NSString *appointmenturl = [NSString stringWithFormat:@"%@json_output.php?mode=list_of_sent_and_received_offers&user_id=%@",App_Domain_Url,userid];
             
             [obj GlobalDict:appointmenturl Globalstr:@"array" Withblock:^(id result, NSError *error)
              {
                  offerdic=[result mutableCopy];
                  
                  offer_rcvd = [appointmentdic valueForKey:@"offer_rcvd"];
                  offer_sent = [appointmentdic valueForKey:@"offer_sent"];
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

-(void)rejectofferbtnTapped:(UIButton *)sender
{
    NSLog(@"offer reject");
    
    NSLog(@"Action to perform with Reject");
    
    polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
    polygonView.backgroundColor=[UIColor blackColor];
    polygonView.alpha=0.3;
    [self.view addSubview:polygonView];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
    
    [polygonView addSubview:spinner];
    [spinner startAnimating];
    
    
    
    
    NSString *confirm = [NSString stringWithFormat:@"%@son_output.php?mode=update_offer_status&user_id=%@&offer_id=%@&offer_status=R",App_Domain_Url,userid,[[offer_rcvd objectAtIndex:sender.tag] valueForKey:@"offer_id"]];
    [obj GlobalDict:confirm Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         NSLog(@"%@",result);
         NSMutableDictionary *holdresult=[result mutableCopy];
         NSString *returnvalue=[holdresult valueForKey:@"message"];
         if ([returnvalue isEqualToString:@"Status Updated Successfully"])
         {
             offerdic=nil;
             offer_rcvd=nil;
             offer_sent=nil;
             NSString *appointmenturl = [NSString stringWithFormat:@"%@json_output.php?mode=list_of_sent_and_received_offers&user_id=%@",App_Domain_Url,userid];
             
             [obj GlobalDict:appointmenturl Globalstr:@"array" Withblock:^(id result, NSError *error)
              {
                  offerdic=[result mutableCopy];
                  
                  offer_rcvd = [appointmentdic valueForKey:@"offer_rcvd"];
                  offer_sent = [appointmentdic valueForKey:@"offer_sent"];
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



//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"indexpath: %ld",(long)indexPath.row);
//    NSLog(@"didSelectRowAtIndexPath");
//    PropertyDetails2ViewController *prop2 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"propertydetail"];
//    prop2.checkstring = @"offer";
//    if (actioncheck == 31)
//    {
//        prop2.data_dic = [[offer_rcvd objectAtIndex:indexPath.row] mutableCopy];
//    }
//    else
//    {
//        prop2.data_dic = [[offer_sent objectAtIndex:indexPath.row] mutableCopy];
//    }
//    
//    [self.navigationController pushViewController:prop2 animated:YES];
//}

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
            if (actioncheck == 31)
            {
                if ([[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_confirm"] isEqualToString:@"Y"] && [[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_reject"] isEqualToString:@"N"])
                {
                    return UITableViewCellEditingStyleInsert;
                }
                else if ([[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_confirm"] isEqualToString:@"N"] && [[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_reject"] isEqualToString:@"Y"])
                {
                    return UITableViewCellEditingStyleInsert;
                }
                
                else if ([[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_confirm"] isEqualToString:@"Y"] && [[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_reject"] isEqualToString:@"Y"])
                {
                    return UITableViewCellEditingStyleInsert;
                }
                else
                {
                    return nil;
                }
            }
            else if (actioncheck == 32)
            {
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
        
        if (actioncheck == 31)
        {
            if (indexPath.row >= 0)
            {
                
                UITableViewRowAction *button, *button2;
                if ([[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_confirm"] isEqualToString:@"N"] && [[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_reject"] isEqualToString:@"N"])
                {
                    
                    return nil;
                    
                }
                
                else if ([[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_confirm"] isEqualToString:@"Y"] && [[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_reject"] isEqualToString:@"N"])
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
                                  
                                  NSString *confirm = [NSString stringWithFormat:@"%@json_output.php?mode=update_offer_status&user_id=%@&offer_id=%@&offer_status=C",App_Domain_Url,userid,[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"offer_id"]];
                                  [obj GlobalDict:confirm Globalstr:@"array" Withblock:^(id result, NSError *error)
                                   {
                                       NSLog(@"%@",result);
                                       NSMutableDictionary *holdresult=[result mutableCopy];
                                       NSString *returnvalue=[holdresult valueForKey:@"message"];
                                       if ([returnvalue isEqualToString:@"Status Updated Successfully"])
                                       {
                                           
                                           offerdic=nil;
                                           offer_rcvd=nil;
                                           offer_sent=nil;
                                           NSString *appointmenturl = [NSString stringWithFormat:@"%@json_output.php?mode=list_of_sent_and_received_offers&user_id=%@",App_Domain_Url,userid];
                                           
                                           [obj GlobalDict:appointmenturl Globalstr:@"array" Withblock:^(id result, NSError *error)
                                            {
                                                offerdic=[result mutableCopy];
                                                
                                                offer_rcvd = [appointmentdic valueForKey:@"offer_rcvd"];
                                                offer_sent = [appointmentdic valueForKey:@"offer_sent"];
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
                else if ([[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_confirm"] isEqualToString:@"N"] && [[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_reject"] isEqualToString:@"Y"])
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
                                   
                                   
                                   
                                   
                                   NSString *confirm = [NSString stringWithFormat:@"%@son_output.php?mode=update_offer_status&user_id=%@&offer_id=%@&offer_status=R",App_Domain_Url,userid,[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"offer_id"]];
                                   [obj GlobalDict:confirm Globalstr:@"array" Withblock:^(id result, NSError *error)
                                    {
                                        NSLog(@"%@",result);
                                        NSMutableDictionary *holdresult=[result mutableCopy];
                                        NSString *returnvalue=[holdresult valueForKey:@"message"];
                                        if ([returnvalue isEqualToString:@"Status Updated Successfully"])
                                        {
                                            offerdic=nil;
                                            offer_rcvd=nil;
                                            offer_sent=nil;
                                            NSString *appointmenturl = [NSString stringWithFormat:@"%@json_output.php?mode=list_of_sent_and_received_offers&user_id=%@",App_Domain_Url,userid];
                                            
                                            [obj GlobalDict:appointmenturl Globalstr:@"array" Withblock:^(id result, NSError *error)
                                             {
                                                 offerdic=[result mutableCopy];
                                                 
                                                 offer_rcvd = [appointmentdic valueForKey:@"offer_rcvd"];
                                                 offer_sent = [appointmentdic valueForKey:@"offer_sent"];
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
                
                else if ([[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_confirm"] isEqualToString:@"Y"] && [[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"make_reject"] isEqualToString:@"Y"])
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
                                  
                                  
                                  NSString *confirm = [NSString stringWithFormat:@"%@json_output.php?mode=update_offer_status&user_id=%@&offer_id=%@&offer_status=C",App_Domain_Url,userid,[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"offer_id"]];
                                  [obj GlobalDict:confirm Globalstr:@"array" Withblock:^(id result, NSError *error)
                                   {
                                       NSLog(@"%@",result);
                                       NSMutableDictionary *holdresult=[result mutableCopy];
                                       NSString *returnvalue=[holdresult valueForKey:@"message"];
                                       if ([returnvalue isEqualToString:@"Status Updated Successfully"])
                                       {
                                           offerdic=nil;
                                           offer_rcvd=nil;
                                           offer_sent=nil;
                                           NSString *appointmenturl = [NSString stringWithFormat:@"%@json_output.php?mode=list_of_sent_and_received_offers&user_id=%@",App_Domain_Url,userid];
                                           
                                           [obj GlobalDict:appointmenturl Globalstr:@"array" Withblock:^(id result, NSError *error)
                                            {
                                                offerdic=[result mutableCopy];
                                                
                                                offer_rcvd = [appointmentdic valueForKey:@"offer_rcvd"];
                                                offer_sent = [appointmentdic valueForKey:@"offer_sent"];
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
                                   
                                   
                                   NSString *confirm = [NSString stringWithFormat:@"%@json_output.php?mode=update_offer_status&user_id=%@&offer_id=%@&offer_status=R",userid,App_Domain_Url,[[offer_rcvd objectAtIndex:indexPath.row] valueForKey:@"offer_id"]];
                                   [obj GlobalDict:confirm Globalstr:@"array" Withblock:^(id result, NSError *error)
                                    {
                                        NSLog(@"%@",result);
                                        NSMutableDictionary *holdresult=[result mutableCopy];
                                        NSString *returnvalue=[holdresult valueForKey:@"message"];
                                        if ([returnvalue isEqualToString:@"Status Updated Successfully"])
                                        {
                                            offerdic=nil;
                                            offer_rcvd=nil;
                                            offer_sent=nil;
                                            NSString *appointmenturl = [NSString stringWithFormat:@"%@json_output.php?mode=list_of_sent_and_received_offers&user_id=%@",App_Domain_Url,userid];
                                            
                                            [obj GlobalDict:appointmenturl Globalstr:@"array" Withblock:^(id result, NSError *error)
                                             {
                                                 offerdic=[result mutableCopy];
                                                 
                                                 offer_rcvd = [appointmentdic valueForKey:@"offer_rcvd"];
                                                 offer_sent = [appointmentdic valueForKey:@"offer_sent"];
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
        
    }
    return nil;
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
