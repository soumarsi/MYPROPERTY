//
//  Listing3ViewController.m
//  myProfile
//
//  Created by soumyajit on 02/07/15.
//  Copyright (c) 2015 kausik jati. All rights reserved.
//

#import "Listing3ViewController.h"
#import "RightMenu.h"
#import "Footer.h"
#import "FavouriteViewController.h"
#import "MPNotificationViewController.h"
#import "QFProfileViewController.h"
#import "PropertyViewController.h"
#import "PropertyDetails2ViewController.h"
#import "GridTableViewCell.h"
#import "LeftMenu.h"
#import "MPDashBoardViewController.h"
#import "ChangePasswordViewController.h"
#import "Listing0ViewController.h"
#import "SearchViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "MPRegisterPropertyViewController.h"
#import "MPBookAgentViewController.h"
#import "InviteFriendsViewController.h"
#import "MPMyPropertyViewController.h"
#import "MPMyAddvertisementViewController.h"
#import "UIImageView+WebCache.h"
#import "JPSThumbnailAnnotation.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"




@interface Listing3ViewController ()<footerdelegate,UIGestureRecognizerDelegate,rightDelegate,leftDelegate,UIAlertViewDelegate>
{
    RightMenu *rightView;
    BOOL rightslide;
    Footer *footerView;
    UIView *blackview;
    BOOL tablechk, leftslide, isFullScreen;
    LeftMenu *leftView;
    NSString *bedsnumber;
    NSString *bathsnumber;
    NSString *roomsnumber;
    NSString *price;
    NSString *advertise_id;
    NSMutableDictionary *bookingdic;
    NSUserDefaults *userinfo;
    NSString *userid;
    NSMutableDictionary *favdic;
    NSMutableArray *imagearray,*imagearray2;
    BOOL imagechkdata;
    NSMutableArray *imagechkarray ,*latlongArray ,*locArray,*indexarray,*nexttimesearchdata;
    //JPSThumbnail *point;
    BOOL zoom;
    NSString *url3;
    AppDelegate *app;
    CGRect prevFrame;
    
}
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@property (strong, nonatomic) IBOutlet UIView *mainview;
@property (strong, nonatomic) IBOutlet UIImageView *headerview;
@end

@implementation Listing3ViewController
@synthesize mymap,mview;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _srchdata=[[NSMutableArray alloc] init];
    _srchdata=[_tempsrchdata mutableCopy];
    app =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    // NSLog(@"next start value%@",_nextstartvalue);
    [_lodinglabel setFrame:CGRectMake((self.view.frame.size.width/2-(_lodinglabel.frame.size.width/2)), self.view.frame.size.height -50 , _lodinglabel.frame.size.width, _lodinglabel.frame.size.height)];
    
    [_spinner setHidden:YES];
    [_lodinglabel setHidden:YES];
    isFullScreen=false;
    zoom=TRUE;
    obj = [[FW_JsonClass alloc]init];
    // point=[[JPSThumbnail alloc]init];
    indexarray = [[NSMutableArray alloc]init];
    
    userinfo=[[NSUserDefaults alloc]init];
    userid = [userinfo objectForKey:@"id"];
    //    NSLog(@"userid is : %@",userid);
    //        NSLog(@"srch page data %@",_srchdata);
    //    NSLog(@"search text data ....%@",_srchdata);
    //    NSLog(@"data cout%lu",(unsigned long)_srchdata.count);
    NSInteger count=[_srchdata count];
    NSString *title = [NSString stringWithFormat:@"%ld Rentals Found at ''%@''",(long)count,_srchtext];
    // NSLog(@"text--------------%@",_srchtext);
    _searchtitle.text=title;
    tablechk=true;
    rightslide = 0;
    leftslide = 0;
    
    
    footerView = [[Footer alloc]init];
    blackview = [[UIView alloc]init];
    
    [footerView setFrame:CGRectMake(0, self.view.frame.size.height - 60, self.view.frame.size.width, 60)];
    
    footerView.footerdelegate=self;
    //    [footerView TapCheck:1];
    [self.mainview addSubview:footerView];
    
    //    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    //    [self.mainview addGestureRecognizer:panGestureRecognizer];
    
    
    _tableviewlisting3.delegate=self;
    _tableviewlisting3.dataSource=self;
    [_tableviewlisting3 setShowsHorizontalScrollIndicator:NO];
    [_tableviewlisting3 setShowsVerticalScrollIndicator:NO];
    
    imagechkarray=[[NSMutableArray alloc]init];
    locArray = [[NSMutableArray alloc]init ];
    mymap.delegate=self;
    mview.hidden=YES;
    mymap.hidden = YES;
    
    [mymap  addAnnotations:[self annotations]];
}




-(void)pushmethod:(UIButton *)sender
{
    //NSLog(@"footer method called");
    long tagId = [sender tag];
    NSLog(@"%ld",(long)tagId);
    if ( tagId == 1 )
    {
        // NSLog(@"tagid is: %ld",(long)tagId);
        SearchViewController *pro = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"searchView"];
        [self applyMapViewMemoryHotFix];
        [self.navigationController pushViewController:pro animated:NO];
    }
    else if ( tagId == 2 )
    {
        FavouriteViewController *fav = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"favourites"];
        [self applyMapViewMemoryHotFix];
        [self.navigationController pushViewController:fav animated:NO];
    }
    else if (tagId == 3)
    {
        //NSLog(@"tagid is: %ld",(long)tagId);
        MPRegisterPropertyViewController *prop = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"registerproperty"];
        [self applyMapViewMemoryHotFix];
        
        [self.navigationController pushViewController:prop animated:NO];
    }
    else if (tagId == 4)
    {
        //NSLog(@"tagid is: %ld",(long)tagId);
        MPDashBoardViewController *fav = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"dashboard"];
        [self applyMapViewMemoryHotFix];
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


/*- (void)handlePan:(UIPanGestureRecognizer *)recognizer
 {
 static CGPoint originalCenter;
 rightView = [[RightMenu alloc]init];
 rightView.rightDelegate = self;
 [rightView setFrame:CGRectMake(self.view.frame.size.width + 50, 0,self.view.frame.size.width*.55, self.mainview.frame.size.height)];
 
 [blackview setFrame:CGRectMake(0, self.headerview.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
 blackview.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.01];
 [_mainview setUserInteractionEnabled:YES];
 
 
 if (recognizer.state == UIGestureRecognizerStateBegan)
 {
 originalCenter = recognizer.view.center;
 
 } else if (recognizer.state == UIGestureRecognizerStateChanged)
 {
 CGPoint translation = [recognizer translationInView:self.view];
 
 recognizer.view.center = CGPointMake(originalCenter.x + translation.x, originalCenter.y);
 }
 else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateFailed)
 {
 if (recognizer.view.frame.origin.x  <= 60) {
 [UIView animateWithDuration:0.25 animations:^{
 // recognizer.view.center = CGPointMake(384, 487.5);
 
 
 blackview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
 
 [rightView setFrame:CGRectMake(self.view.frame.size.width*.45, 0,self.view.frame.size.width*.55, self.mainview.frame.size.height)];
 
 
 
 }];
 } else {
 [UIView animateWithDuration:0.25 animations:^{
 // recognizer.view.center = CGPointMake(384 + 320, 487.5);
 blackview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.01];
 
 [rightView setFrame:CGRectMake(self.view.frame.size.width + 10, 0,self.view.frame.size.width*.55, self.mainview.frame.size.height)];
 
 }];
 
 }
 }
 }
 */



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
        [leftView setFrame:CGRectMake(-220, 0,self.view.frame.size.width*.6, self.mainview.frame.size.height)];
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
    // NSLog(@"%ld",(long)tagId);
    
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
        // NSLog(@"tagid is: %ld",(long)tagId);
        QFProfileViewController *pro = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"profile"];
        [self.navigationController pushViewController:pro animated:YES];
        [rightView removeFromSuperview];
        [blackview removeFromSuperview];
        rightslide = 0;
    }
    else if (tagId == 3)
    {
        //NSLog(@"tagid is: %ld",(long)tagId);
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
        // NSLog(@"logout");
        
        [self deletecoredata];
        [self purgeMapMemory];
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

-(void)deletecoredata
{
    
    
    
    [self deleteAllEntities:@"Mypropertydata"];
    [self deleteAllEntities:@"List0"];
    [self deleteAllEntities:@"Mypropertyimage"];
    [self deleteAllEntities:@"Mpregister"];
    
}

- (void)deleteAllEntities:(NSString *)nameEntity
{
    NSManagedObjectContext *theContext=[app managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:nameEntity];
    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError *error;
    NSArray *fetchedObjects = [theContext executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *object in fetchedObjects)
    {
        [theContext deleteObject:object];
    }
    
    error = nil;
    [theContext save:&error];
}

-(void)leftclk:(UIButton *)sender
{
    NSInteger tagId;
    tagId = sender.tag;
    //NSLog(@"%ld",(long)tagId);
    if ( tagId == 100 )
    {
        // NSLog(@"tagid is: %ld",(long)tagId);
        MPDashBoardViewController *fav = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"dashboard"];
        [self.mainview setFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height)];
        
        
        [leftView removeFromSuperview];
        leftslide = 0;
        [self applyMapViewMemoryHotFix];
        
        [self.navigationController pushViewController:fav animated:NO];
        
    }
    else if ( tagId == 101 )
    {
        MPMyPropertyViewController *fav = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"myproperty"];
        [self.mainview setFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height)];
        
        [leftView removeFromSuperview];
        leftslide = 0;
        [self applyMapViewMemoryHotFix];
        [self.navigationController pushViewController:fav animated:NO];
    }
    else if ( tagId == 102 )
    {
        MPMyAddvertisementViewController *fav = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"myaddvertise"];
        [self.mainview setFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height)];
        
        [leftView removeFromSuperview];
        leftslide = 0;
        [self applyMapViewMemoryHotFix];
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

- (IBAction)filterTapped:(id)sender
{
    //[self purgeMapMemory];
    
    [self.navigationController popViewControllerAnimated:NO];
    
}


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



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_srchdata count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tablechk==true) {
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
        Listing3TableViewCell *cell;
        cell=(Listing3TableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"listing3"];
        
        cell.titlelabel.text=[[_srchdata objectAtIndex:indexPath.row] valueForKey:@"property_type"];
        bedsnumber=[[_srchdata objectAtIndex:indexPath.row] valueForKey:@"no_of_beds"];
        bathsnumber=[[_srchdata objectAtIndex:indexPath.row] valueForKey:@"no_of_baths"];
        roomsnumber=[[_srchdata objectAtIndex:indexPath.row] valueForKey:@"no_of_rooms"];
        //        NSLog(@"%@",bathsnumber);
        NSString* strRR = [NSString stringWithFormat:@"%@ bedroom(s),%@ bathroom(s),%@ rooms(s)", bedsnumber, bathsnumber, roomsnumber];
        cell.bedroomslabel.text=strRR;
        
        price=[[_srchdata objectAtIndex:indexPath.row] valueForKey:@"property_price"];
        NSString* pp = [NSString stringWithFormat:@"£%@", price];
        cell.pricelabel.text=pp;
        
        //        UIButton *book = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 80, 55, 60, 25)];
        //        book.backgroundColor = [UIColor colorWithRed:61.0f/255.0f green:168.0f/255.0f blue:0.0f/255.0f alpha:1];
        //        [book setTitle:@"Book now" forState:UIControlStateNormal];
        //        [book setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //        [book setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //        [cell addSubview:book];
        
        NSString *online_check=[[_srchdata objectAtIndex:indexPath.row] valueForKey:@"added_by_status"];
        
        //        NSLog(@"online_check---- %@",online_check);
        
        if ([online_check isEqualToString:@"Y"])
        {
            [cell.booknow setHidden:YES];
            [cell.addToFavBtn setHidden:YES];
            [cell.addToFavImg setHidden:YES];
        }
        else
        {
            [cell.booknow setHidden:NO];
            [cell.addToFavBtn setHidden:NO];
            [cell.addToFavImg setHidden:NO];
            
            
            //                        if ([[imagechkarray containsObject:indexPath.row] isEqualToString:[[_srchdata objectAtIndex:indexPath.row]valueForKey:@"advert_id"]])
            
            if ([imagechkarray containsObject:[[_srchdata objectAtIndex:indexPath.row]objectForKey:@"advert_id"]])
            {
                if ([[[_srchdata objectAtIndex:indexPath.row] valueForKey:@"saved_prop"] isEqualToString:@"N"])
                {
                    cell.addToFavImg.image = [UIImage imageNamed:@"5"];
                }
                
                
            }
            else
            {
                
                if ([[[_srchdata objectAtIndex:indexPath.row] valueForKey:@"saved_prop"] isEqualToString:@"Y"]) {
                    cell.addToFavImg.image = [UIImage imageNamed:@"5"];
                }
                else if ([[[_srchdata objectAtIndex:indexPath.row] valueForKey:@"saved_prop"] isEqualToString:@"N"])
                {
                    cell.addToFavImg.image = [UIImage imageNamed:@"add_to_fav"];
                }
            }
        }
        
        cell.booknow.tag = indexPath.row;
        [cell.booknow addTarget:self action:@selector(bookNowTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.addToFavBtn.tag = indexPath.row;
        [cell.addToFavBtn addTarget:self action:@selector(addToFavTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        imagearray=[[_srchdata objectAtIndex:indexPath.row] valueForKey:@"media"];
        if (imagearray.count>0)
        {
            [cell.homepicture sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[imagearray objectAtIndex:0]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        }
        else
        {
            cell.homepicture.image=[UIImage imageNamed:@"placeholder1"];
        }
        
        
        
        if (indexPath.row==[_srchdata count]-1)
        {
            NSInteger datacount=[_nextstartvalue integerValue];
            if (datacount > 0)
            {
                
                [self Requstdata];
                // [mymap  addAnnotations:[self annotations]];
            }
            
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        
        return cell;
    }
    else if (tablechk==false)
    {
        GridTableViewCell *cell2;
        cell2=(GridTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"gridcell"];
        
        cell2.titlelabel.text=[[_srchdata objectAtIndex:indexPath.row] valueForKey:@"property_type"];
        bedsnumber=[[_srchdata objectAtIndex:indexPath.row] valueForKey:@"no_of_beds"];
        bathsnumber=[[_srchdata objectAtIndex:indexPath.row] valueForKey:@"no_of_baths"];
        roomsnumber=[[_srchdata objectAtIndex:indexPath.row] valueForKey:@"no_of_rooms"];
        // NSLog(@"%@",bathsnumber);
        NSString* strRR = [NSString stringWithFormat:@"%@ bedroom(s),%@ bathroom(s),%@ rooms(s)", bedsnumber, bathsnumber, roomsnumber];
        cell2.bedroomslabel.text=strRR;
        
        NSString *online_check=[[_srchdata objectAtIndex:indexPath.row] valueForKey:@"added_by_status"];
        
        // NSLog(@"online_check---- %@",online_check);
        
        if ([online_check isEqualToString:@"Y"])
        {
            [cell2.booknow setHidden:YES];
            [cell2.addToFavBtn setHidden:YES];
            [cell2.addToFavImg setHidden:YES];
            
        }
        else
        {
            [cell2.booknow setHidden:NO];
            [cell2.addToFavBtn setHidden:NO];
            [cell2.addToFavImg setHidden:NO];
            
            
            if ([imagechkarray containsObject:[[_srchdata objectAtIndex:indexPath.row]objectForKey:@"advert_id"]])
            {
                if ([[[_srchdata objectAtIndex:indexPath.row] valueForKey:@"saved_prop"] isEqualToString:@"N"])
                {
                    cell2.addToFavImg.image = [UIImage imageNamed:@"5"];
                }
                
                
            }
            else
            {
                
                if ([[[_srchdata objectAtIndex:indexPath.row] valueForKey:@"saved_prop"] isEqualToString:@"Y"]) {
                    cell2.addToFavImg.image = [UIImage imageNamed:@"5"];
                }
                else if ([[[_srchdata objectAtIndex:indexPath.row] valueForKey:@"saved_prop"] isEqualToString:@"N"])
                {
                    cell2.addToFavImg.image = [UIImage imageNamed:@"add_to_fav"];
                }
            }
            
            
            
            
        }
        
        cell2.booknow.tag = indexPath.row;
        [cell2.booknow addTarget:self action:@selector(bookNowTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        price=[[_srchdata objectAtIndex:indexPath.row] valueForKey:@"property_price"];
        NSString* pp = [NSString stringWithFormat:@"£%@", price];
        cell2.pricelabel.text=pp;
        
        cell2.addToFavBtn.tag = indexPath.row;
        [cell2.addToFavBtn addTarget:self action:@selector(addToFavTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        imagearray2=[[NSMutableArray alloc] init];
        imagearray2=[[_srchdata objectAtIndex:indexPath.row] valueForKey:@"media"];
        if (imagearray.count>0)
        {
            [cell2.homepicture sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[imagearray2 objectAtIndex:0]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        }
        else
        {
            cell2.homepicture.image=[UIImage imageNamed:@"placeholder1"];
        }
        
        
        
        if (indexPath.row==[_srchdata count]-1)
        {
            NSInteger datacount=[_nextstartvalue integerValue];
            if (datacount > 0)
            {
                [self Requstdata];
            }
            
        }
        
        
        [cell2 setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return cell2;
        
        
        
        
        
        
        
        
    }
    
    return nil;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PropertyDetails2ViewController *prop2 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"propertydetail"];
    prop2.checkstring = @"listing3";
    prop2.list3indexpath = indexPath.row;
    prop2.data_dic = [[_srchdata objectAtIndex:indexPath.row] mutableCopy];
    [self.navigationController pushViewController:prop2 animated:YES];
}

-(void)addToFavTapped:(UIButton *)sender
{
    // NSLog(@"indexpath is: %ld",(long)sender.tag);
    
    
    
    advertise_id = [[_srchdata objectAtIndex:sender.tag] valueForKey:@"advert_id"];
    NSLog(@"damn advert id: %@",advertise_id);
    
    NSString *addToFav = [NSString stringWithFormat:@"%@json_output.php?mode=save_property_wishlist&user_id=%@&advert_id=%@",App_Domain_Url,userid,advertise_id];
    
    [obj GlobalDict:addToFav Globalstr:@"array" Withblock:^(id result, NSError *error) {
        favdic = [result mutableCopy];
        
        if ([[favdic valueForKey:@"message"] isEqualToString:@"property saved"])
        {
            if ([imagechkarray containsObject:[[_srchdata objectAtIndex:sender.tag]objectForKey:@"advert_id"]])
            {
            }
            else
            {
                [imagechkarray addObject:[[_srchdata objectAtIndex:sender.tag] valueForKey:@"advert_id"]];
                // NSLog(@"imag array %@",imagechkarray);
                [_tableviewlisting3 reloadData];
            }
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Property Saved." message: @"Added to favourites" delegate: self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
            
            [alert show];
        }
        else if ([[favdic valueForKey:@"message"] isEqualToString:@"You have already saved this property"])
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Property already saved." message: @"Already Added to favourites" delegate: self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
            
            [alert show];
        }
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == [alertView cancelButtonIndex])
    {
        // NSLog(@"done");
        
    }
}


-(void)bookNowTapped:(UIButton *)sender
{
    
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    
    
    NSInteger week = [components month];
    NSInteger year = [components year];
    
    NSString *finalyear = [NSString stringWithFormat:@"%ld",(long)year];
    NSString *finalmonth=[NSString stringWithFormat:@"%ld",(long)week];
    
    
    //NSLog(@"tag is: %ld",(long)sender.tag);
    advertise_id = [[_srchdata objectAtIndex:sender.tag] valueForKey:@"advert_id"];
    
    // NSLog(@"advertise id is: %@",advertise_id);
    
    //    NSString *url =[NSString stringWithFormat:@"%@json_output.php?mode=show_available_appointment_timing&advert_id=%@",App_Domain_Url,advertise_id];
    
    
    NSString *url =[NSString stringWithFormat:@"%@json_output.php?mode=show_available_appointment_timing&advert_id=%@&year=%@&month=%@", App_Domain_Url, advertise_id, finalyear, finalmonth];
    
    [obj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
        bookingdic = [result mutableCopy];
        //        NSLog(@"bookingdic-----%@",bookingdic);
        
        MPBookAgentViewController *book = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"bookagent"];
        book.bookingDetailsDic = [bookingdic mutableCopy];
        book.address = [[_srchdata objectAtIndex:sender.tag] valueForKey:@"address1"];
        
        [self.navigationController pushViewController:book animated:YES];
    }];
    
    
    
}


- (void)resetDefaults {
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self applyMapViewMemoryHotFix];
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

- (IBAction)gridviewbutton:(id)sender
{
    tablechk=false;
    _tableviewlisting3.hidden=NO;
    [_tableviewlisting3 reloadData];
    [self applyMapViewMemoryHotFix];
    mview.hidden=YES;
    
    mymap.hidden=YES;
    
}

- (IBAction)listviewbutton:(id)sender
{
    tablechk=true;
    [_tableviewlisting3 reloadData];
    _tableviewlisting3.hidden=NO;
    [self applyMapViewMemoryHotFix];
    mview.hidden=YES;
    
    mymap.hidden=YES;
}
- (IBAction)mapbuttonTap:(id)sender


{
    
    //[self didReceiveMemoryWarning];
    //mymap = [[MKMapView alloc]init];
    [mview addSubview:mymap];
    [mymap removeAnnotations:mymap.annotations];
    [mymap  addAnnotations:[self annotations]];
    _tableviewlisting3.hidden=YES;
    
    mview.hidden=NO;
    mymap.hidden=NO;
    
    
    
    //   MapView *prop2 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"map"];
    //
    //
    //
    //    prop2.location = [latlongArray mutableCopy];
    //
    //
    //    [self.navigationController pushViewController:prop2 animated:YES];
    //
    
    
}



- (void)viewWillDisappear:(BOOL)animated
{
    // [self applyMapViewMemoryHotFix];
    //    locArray=Nil;
    //[self purgeMapMemory];
    //  NSLog(@"viewWillDisappear=================");
}

- (void)purgeMapMemory
{
    // Switching map types causes cache purging, so switch to a different map type
    
    // mymap.mapType = MKMapTypeStandard;
    mymap=Nil;
    mymap.delegate=Nil;
    
    [mymap.layer removeAllAnimations];
    [mymap removeAnnotations:mymap.annotations];
    mymap.showsUserLocation=Nil;
    [mymap removeFromSuperview];
    
}

/*-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
 {
 
 
 
 
 MKCoordinateRegion mapRegion;
 mapRegion.center = mapView.userLocation.coordinate;
 mapRegion.span.latitudeDelta = .1;
 mapRegion.span.longitudeDelta = .1;
 
 
 
 [mapView setRegion:mapRegion animated: YES];
 //  NSLog(@"Retain count is  From delegate %ld", CFGetRetainCount((__bridge CFTypeRef)mymap));
 
 
 
 
 
 
 }
 
 */
/*- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation
 {
 static NSString *annotationViewReuseIdentifier = @"annotationViewReuseIdentifier";
 
 MKAnnotationView *annotationView = (MKAnnotationView *)[mymap dequeueReusableAnnotationViewWithIdentifier:annotationViewReuseIdentifier];
 
 if (annotationView == nil)
 {
 annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewReuseIdentifier] ;
 }
 
 // here you can assign your friend's image
 annotationView.image = [UIImage imageNamed:@"locator"];
 annotationView.annotation = annotation;
 
 //       PicButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
 //        [PicButton addTarget:self action:@selector(showLocationPicture) forControlEvents:UIControlEventTouchUpInside];
 //
 //        annotationView.rightCalloutAccessoryView = PicButton;
 // add below line of code to enable selection on annotation view
 annotationView.canShowCallout = YES;
 
 return annotationView;
 }
 
 */
//-(void)showLocationPicture
//{
//
//
//}



/*-(MKPointAnnotation*)setAnnotation: (NSString*) title atLocation:(CLLocationCoordinate2D)Location withImage:(UIImage*) LocationImage{
 
 MKPointAnnotation *Pin = [[MKPointAnnotation alloc]init];
 
 Pin.title = title;
 
 [Pin setCoordinate:Location];
 
 [self mapView:mymap viewForAnnotation:Pin].annotation = Pin;
 return Pin;
 }
 
 */

/*
 -(MKAnnotationView*)mapView:(MKMapView*)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
 // If you are showing the users location on the map you don't want to change it
 MKAnnotationView *view = nil;
 
 // This is not the users location indicator (the blue dot)
 view = [mapView dequeueReusableAnnotationViewWithIdentifier:@"myAnnotationIdentifier"];
 if (!view) {
 // Could not reuse a view ...
 
 // Creating a new annotation view, in this case it still looks like a pin
 view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotationIdentifier"] ;
 
 view.image = [UIImage imageNamed:@"ping.png"];
 
 view.canShowCallout = YES; // So that the callout can appear
 //
 //            UIImageView *myImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ping.png"]];
 //            myImageView.frame = CGRectMake(0,0,60,60);
 //           // Change the size of the image to fit the callout
 
 // Change this to rightCallout... to move the image to the right side
 //view.leftCalloutAccessoryView = myImageView;
 //  myImageView = nil;
 
 }
 return view;
 }
 */

- (void)applyMapViewMemoryHotFix{
    
    switch (mymap.mapType) {
        case MKMapTypeHybrid:
        {
            mymap.mapType = MKMapTypeStandard;
            
            
            
        }
            
            break;
        case MKMapTypeStandard:
        {
            mymap.mapType = MKMapTypeHybrid;
            
        }
            
            break;
        default:
            break;
    }
    
    
    mymap.mapType = MKMapTypeStandard;
    
    
    
}



-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    
    [self applyMapViewMemoryHotFix];
    
    
    
    
    if (zoom==TRUE)
    {
        MKCoordinateRegion zoomRegion = MKCoordinateRegionForMapRect(MKMapRectWorld);
        MKCoordinateRegion adjustedRegion = [mymap regionThatFits:zoomRegion];
        [mymap setRegion:adjustedRegion animated:YES];
        zoom=FALSE;
    }
    
    
    
    // NSLog(@"new function");
    
    
    
    
    
}

- (NSArray *)annotations
{
    if (_srchdata.count>0) {
        
        
        if (locArray.count>0)
        {
            [locArray removeAllObjects];
        }
        
        for (int i= 0 ; i<_srchdata.count; i++)
        {
            
            
            float lat =[[[_srchdata objectAtIndex:i ] valueForKey:@"latitude" ]floatValue ];
            float lon = [[[_srchdata objectAtIndex:i]valueForKey:@"longitude" ]floatValue ];
            
            
            
            
            JPSThumbnail *point1 =[[JPSThumbnail alloc]init];
            point1.coordinate =CLLocationCoordinate2DMake(lat, lon);
            
            NSArray *media = [[_srchdata objectAtIndex:i]valueForKey:@"media"];
            //indexarray = [_srchdata objectAtIndex:i];
            if (media.count>0)
            {
                
                
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[media objectAtIndex:0]]];
                
                SDWebImageManager *manager = [SDWebImageManager sharedManager];
                
                [manager downloadImageWithURL:url options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize)
                 
                 {
                     
                     
                 } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                     
                     if(image){
                         NSString *localKey = [NSString stringWithFormat:@"Item-%d", i];
                         [[SDImageCache sharedImageCache] storeImage:image forKey:localKey];
                         
                         point1.image = image ;
                         NSLog(@"image=====%@",image);
                     }
                 }];
                
                
                
                
                
            }
            else
            {
                // NSLog(@"else");
                point1.image =[UIImage imageNamed:@"placeholder1"];
            }
            
            point1.title = [_srchdata[i]valueForKey:@"address1"];
            point1.subtitle = [_srchdata [i]valueForKey:@"county"];
            
            //            UITapGestureRecognizer *letterTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(highlightLetter:)];
            //            JPSThumbnailAnnotationView *objc= [[JPSThumbnailAnnotationView alloc]init];
            //
            //            letterTapRecognizer.numberOfTapsRequired = 1;
            //            [objc.maskView addGestureRecognizer:letterTapRecognizer];
            
            point1.disclosureBlock = ^{
                //  NSLog(@"index==%@",_srchdata[i]);
                
                PropertyDetails2ViewController *prop2 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"propertydetail"];
                prop2.checkstring = @"listing3";
                
                prop2.data_dic = [_srchdata[i]  mutableCopy];
                [self.navigationController pushViewController:prop2 animated:YES];
                
            };
            
            
            
            JPSThumbnailAnnotation *anotation= [JPSThumbnailAnnotation annotationWithThumbnail:point1];
            
            
            [locArray insertObject:anotation atIndex:i];
            
            
        }
        
        
        
    }
    
    
    
    NSLog(@"loca  array   ===%lu",(unsigned long)locArray.count);
    return locArray;
}





#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
        
        
        
        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didSelectAnnotationViewInMap:mymap];
        // NSLog(@"didselect");
        
        
        
        
        
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didDeselectAnnotationViewInMap:mymap];
        
        
        
        
        
        
        
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation conformsToProtocol:@protocol(JPSThumbnailAnnotationProtocol)]) {
        
        
        
        
        
        return [((NSObject<JPSThumbnailAnnotationProtocol> *)annotation) annotationViewInMap:mymap];
        
        
        
    }
    return nil;
}

-(void)Requstdata
{
    //    NSLog(@"next time url");
    //    NSLog(@"location %@",_location);
    //    NSLog(@"radius %@",_radius);
    //    NSLog(@"minprice %@",_minprice);
    //    NSLog(@"%@",_lativalue);
    //    NSLog(@"%@",_longvalue);
    
    nexttimesearchdata=[[NSMutableArray alloc]init];
    [_spinner setHidden:NO];
    [_spinner startAnimating];
    [_lodinglabel setHidden:NO];
    _lodinglabel.layer.cornerRadius=6;
    _lodinglabel.clipsToBounds=YES;
    
    [UIView animateWithDuration:0.9f
                          delay:0.6f
                        options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse |UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         [_lodinglabel setFrame:CGRectMake((self.view.frame.size.width/2-(_lodinglabel.frame.size.width/2)), self.view.frame.size.height-100, _lodinglabel.frame.size.width, _lodinglabel.frame.size.height)];
                     }
                     completion:nil
     
     
     ];
    
    
    
    
    
    
    
    
    
    
    if ([_resulttype isEqualToString:@"S"])
    {
        url3 =[NSString stringWithFormat:@"%@json_output.php?mode=search_property&location=%@&radius=%@&min_price=%@&max_price=%@&min_bed=%@&max_bed=%@&property_type=%@&added_time=%@&sold_status=%@&buy_or_rent=S&latitude_val=%@&longitude_val=%@&start=%@&user_id=%@",App_Domain_Url,_location,_radius,_minprice,_maxprice,_minbed,_maxbed,_propertytype,_addedtime,_soldstatus,_lativalue,_longvalue,_nextstartvalue,userid];
    }
    else if([_resulttype isEqualToString:@"R"])
    {
        url3 =[NSString stringWithFormat:@"%@json_output.php?mode=search_property&location=%@&radius=%@&min_price=%@&max_price=%@&min_bed=%@&max_bed=%@&property_type=%@&added_time=%@&sold_status=%@&buy_or_rent=R&latitude_val=%@&longitude_val=%@&start=%@&user_id=%@",App_Domain_Url,_location,_radius,_minprice,_maxprice,_minbed,_maxbed,_propertytype,_addedtime,_soldstatus,_lativalue,_longvalue,_nextstartvalue,userid];
    }
    
    
    
    NSString* encodedUrl = [url3 stringByAddingPercentEscapesUsingEncoding:
                            
                            NSUTF8StringEncoding];
    [obj GlobalDict:encodedUrl Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         
         NSInteger pos=[_srchdata count];
         nexttimesearchdata=[[result valueForKey:@"all_property"] mutableCopy];
         _nextstartvalue=[result valueForKey:@"next_start"];
         // NSLog(@"next time data%lu",(unsigned long)nexttimesearchdata.count);
         [_srchdata addObjectsFromArray:nexttimesearchdata];
         [locArray removeAllObjects];
         [mymap removeAnnotations:mymap.annotations];
         [mymap addAnnotations:[self annotations]];
         //[_srchdata addObject:nexttimesearchdata];
         
         // NSLog(@"hole data %lu",(unsigned long)_srchdata.count);
         //[_tableviewlisting3 reloadData];
         
         
         NSInteger count=[_srchdata count];
         NSString *title = [NSString stringWithFormat:@"%ld Rentals Found at ''%@''",(long)count,_location];
         // NSLog(@"text--------------%@",_location);
         _searchtitle.text=title;
         
         
         [_tableviewlisting3 beginUpdates];
         
         
         for(int k=0; k<nexttimesearchdata.count; k++)
             
         {
             
             
             NSArray *insert0 = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:pos inSection:0]];
             
             [_tableviewlisting3 insertRowsAtIndexPaths:insert0 withRowAnimation:UITableViewRowAnimationBottom];
             
             
             pos++;
             
             
             
             
         }
         
         [_tableviewlisting3  endUpdates];
         [_spinner setHidden:YES];
         [_spinner stopAnimating];
         
         [_lodinglabel setHidden:YES];
         
     }];
    
    
    
    
    
}


@end
