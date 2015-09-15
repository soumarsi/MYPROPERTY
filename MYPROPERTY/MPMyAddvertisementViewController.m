//
//  MPMyAddvertisementViewController.m
//  MYPROPERTY
//
//  Created by Somenath on 23/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "MPMyAddvertisementViewController.h"
#import "RS_PCH.pch"
#import "Footer.h"
#import "SearchViewController.h"
#import "FavouriteViewController.h"
#import "MPNotificationViewController.h"
#import "RightMenu.h"
#import "PropertyViewController.h"
#import "MPEditProperty.h"
#import "QFProfileViewController.h"
#import "ChangePasswordViewController.h"
#import "AddadvertisementViewController.h"
#import "InviteFriendsViewController.h"
#import "MPDashBoardViewController.h"
#import "UIImageView+WebCache.h"
#import "PropertyDetails2ViewController.h"
#import "AppDelegate.h"

@interface MPMyAddvertisementViewController () <footerdelegate,rightDelegate,UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    BOOL viewslide,rightslide, tapcheck, experidate;
    UIView *slideview, *blackview;
    Footer *footerView;
    RightMenu *rightView;
    NSUserDefaults *userinfo;
    NSMutableArray *myaddvertisementsarr,*imagearray,*imagearray2,*coredtaimagarray;
    NSString *bedsnumber;
    NSString *bathsnumber;
    NSString *roomsnumber;
    NSString *price;
    NSString *userid;
     AppDelegate *appDelegate;
    UIView *polygonView;
   
}

@property (strong, nonatomic) IBOutlet UIView *mainview;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UILabel *nodatalbl;
@end

@implementation MPMyAddvertisementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    userinfo=[[NSUserDefaults alloc]init];
    obj = [[FW_JsonClass alloc]init];
    myaddvertisementsarr = [[NSMutableArray alloc]init];
    
    userid = [userinfo objectForKey:@"id"];
    NSLog(@"userid is : %@",userid);
    coredtaimagarray=[[NSMutableArray alloc] init];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //   NSString *myaddvertiseurl = [NSString stringWithFormat:@"%@json_output.php?mode=list_my_property_advertisements&user_id=%@",App_Domain_Url,userid];
    
    
    if ([_datachagechaking isEqualToString:@"data edited"])
    {
        NSManagedObjectContext *context3=[appDelegate managedObjectContext];
        NSFetchRequest *request3=[[NSFetchRequest alloc] initWithEntityName:@"Myaddvertisementdata"];
        NSMutableArray *fetchrequest3=[[context3 executeFetchRequest:request3 error:nil] mutableCopy];
        NSError *error;
        NSInteger CoreDatafinalCount=[fetchrequest3 count];
        NSLog(@"core data final count=%ld",(long)CoreDatafinalCount);
        for (NSManagedObject *obj3 in fetchrequest3)
        {
            
            [context3 deleteObject:obj3];
            
            
        }
        [context3 save:&error];
        
        
        polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
        polygonView.backgroundColor=[UIColor blackColor];
        polygonView.alpha=0.3;
        [self.view addSubview:polygonView];
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
        [polygonView addSubview:spinner];
        [spinner startAnimating];
        
        NSString *myaddvertiseurl = [NSString stringWithFormat:@"%@json_output.php?mode=list_my_property_advertisements&user_id=%@",App_Domain_Url,userid];
        
        [obj GlobalDict:myaddvertiseurl Globalstr:@"array" Withblock:^(id result, NSError *error) {
            myaddvertisementsarr = [result mutableCopy];
            
            NSLog(@"count:---%ld",(unsigned long)myaddvertisementsarr.count);
            if (myaddvertisementsarr.count == 0)
            {
                [_nodatalbl setHidden:NO];
                [spinner stopAnimating];
                [spinner removeFromSuperview];
                [polygonView removeFromSuperview];
            }
            else
            {
                //[_nodatalbl setHidden:YES];
                //[_tableview reloadData];
                
                
                NSOperationQueue *myQueue = [[NSOperationQueue alloc] init];
                [myQueue addOperationWithBlock:^{
                    
                    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myaddvertisementsarr];
                    
                    NSManagedObjectContext *context=[appDelegate managedObjectContext];
                    NSManagedObject *newUser=[NSEntityDescription insertNewObjectForEntityForName:@"Myaddvertisementdata" inManagedObjectContext:context];
                    
                    [newUser setValue:data forKey:@"data"];
                    [appDelegate saveContext];
                    
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        myaddvertisementsarr=[[NSMutableArray alloc] init];
                        NSManagedObjectContext *context = [appDelegate managedObjectContext];
                        NSEntityDescription *entityDesc =[NSEntityDescription entityForName:@"Myaddvertisementdata"inManagedObjectContext:context];
                        NSFetchRequest *request = [[NSFetchRequest alloc] init];
                        [request setEntity:entityDesc];
                        NSError *error;
                        NSArray *objects = [context executeFetchRequest:request
                                                                  error:&error];
                        objects = [NSKeyedUnarchiver unarchiveObjectWithData:[[objects objectAtIndex:0]valueForKey:@"data"]];
                        myaddvertisementsarr=[objects mutableCopy];
                        
                        //[jsonarray12 addObjectsFromArray:objects];
                        
                        NSLog(@"Core data recived12......%@",objects);
                        
                        NSManagedObjectContext *context2=[appDelegate managedObjectContext];
                        NSFetchRequest *request1=[[NSFetchRequest alloc] initWithEntityName:@"Myaddvertisementimage"];
                        NSMutableArray *fetchrequest1=[[context2 executeFetchRequest:request1 error:nil] mutableCopy];
                        NSInteger CoreDatafinalCount=[fetchrequest1 count];
                        NSLog(@"core data final count=%ld",(long)CoreDatafinalCount);
                        for (NSManagedObject *obj1 in fetchrequest1)
                        {
                            NSData *dataBytes = [obj1 valueForKey:@"image"];
                            [coredtaimagarray addObject:[UIImage imageWithData:dataBytes]];
                            
                        }
                        [_tableview reloadData];
                        NSLog(@"coredataimagearray%lu",(unsigned long)coredtaimagarray.count);
                        
                        
                        
                        [_nodatalbl setHidden:YES];
                        //[_tableview reloadData];
                        [spinner stopAnimating];
                        [spinner removeFromSuperview];
                        [polygonView removeFromSuperview];
                        
                        
                    }];
                }];
                
                
            }
            
        }];
        
        
        
        
        
        
        
        
        
        
        
    }
    else
    {
      [self getdata];
    }
    
    
    
    viewslide = 0;
    rightslide = 0;
    tapcheck = 0;
    
    blackview = [[UIView alloc]init];
    footerView=[[Footer alloc]init];
    
    [footerView setFrame:CGRectMake(0, self.view.frame.size.height - 60, self.view.frame.size.width, 60)];
    
    footerView.footerdelegate=self;
    [self.mainview addSubview:footerView];
    
    [_tableview setShowsVerticalScrollIndicator:NO];
    
}


-(void)getdata
{
    
    NSManagedObjectContext *context2=[appDelegate managedObjectContext];
    NSFetchRequest *request1=[[NSFetchRequest alloc] initWithEntityName:@"Myaddvertisementimage"];
    NSMutableArray *fetchrequest1=[[context2 executeFetchRequest:request1 error:nil] mutableCopy];
    NSInteger CoreDatafinalCount=[fetchrequest1 count];
    NSLog(@"core data final count=%ld",(long)CoreDatafinalCount);
    
    if (CoreDatafinalCount==0)
    {
        
        polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
        polygonView.backgroundColor=[UIColor blackColor];
        polygonView.alpha=0.3;
        [self.view addSubview:polygonView];
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
        [polygonView addSubview:spinner];
        [spinner startAnimating];
        
        NSString *myaddvertiseurl = [NSString stringWithFormat:@"%@json_output.php?mode=list_my_property_advertisements&user_id=%@",App_Domain_Url,userid];
        
        [obj GlobalDict:myaddvertiseurl Globalstr:@"array" Withblock:^(id result, NSError *error) {
            myaddvertisementsarr = [result mutableCopy];
            
            NSLog(@"count:---%ld",(unsigned long)myaddvertisementsarr.count);
            if (myaddvertisementsarr.count == 0)
            {
                [_nodatalbl setHidden:NO];
                [spinner stopAnimating];
                [spinner removeFromSuperview];
                [polygonView removeFromSuperview];
                
            }
            else
            {
                //[_nodatalbl setHidden:YES];
                //[_tableview reloadData];
                
                
                NSOperationQueue *myQueue = [[NSOperationQueue alloc] init];
                [myQueue addOperationWithBlock:^{
                    
                    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myaddvertisementsarr];
                    
                    NSManagedObjectContext *context=[appDelegate managedObjectContext];
                    NSManagedObject *newUser=[NSEntityDescription insertNewObjectForEntityForName:@"Myaddvertisementdata" inManagedObjectContext:context];
                    
                    [newUser setValue:data forKey:@"data"];
                    [appDelegate saveContext];
                    for ( NSDictionary *tempDict1 in  result)
                    {
                        NSManagedObjectContext *context22=[appDelegate managedObjectContext];
                        NSManagedObject *manageobject22=[NSEntityDescription insertNewObjectForEntityForName:@"Myaddvertisementimage" inManagedObjectContext:context22];
                        NSMutableArray *imagearray28=[[NSMutableArray alloc] init];
                        imagearray28=[tempDict1 valueForKey:@"media"];
                        
                        if (imagearray28.count>0)
                        {
                            
                            NSData *picturedata=[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[imagearray28 objectAtIndex:0]]]];
                            NSLog(@"picdata%@",picturedata);
                            if (picturedata!=NULL)
                            {
                                
                                [manageobject22 setValue:picturedata forKey:@"image"];
                            }
                            else
                            {
                                UIImage *placeholder=[UIImage imageNamed:@"placeholder1"];
                                NSData* pictureData = UIImagePNGRepresentation(placeholder);
                                [manageobject22 setValue:pictureData forKey:@"image"];
                            }
                            
                        }
                        else
                        {
                            UIImage *placeholder=[UIImage imageNamed:@"placeholder1"];
                            NSData* pictureData = UIImagePNGRepresentation(placeholder);
                            [manageobject22 setValue:pictureData forKey:@"image"];
                        }
                        
                        
                        
                        [appDelegate saveContext];
                        
                        
                    }
                    
                    
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        myaddvertisementsarr=[[NSMutableArray alloc] init];
                        NSManagedObjectContext *context = [appDelegate managedObjectContext];
                        NSEntityDescription *entityDesc =[NSEntityDescription entityForName:@"Myaddvertisementdata"inManagedObjectContext:context];
                        NSFetchRequest *request = [[NSFetchRequest alloc] init];
                        [request setEntity:entityDesc];
                        NSError *error;
                        NSArray *objects = [context executeFetchRequest:request
                                                                  error:&error];
                        objects = [NSKeyedUnarchiver unarchiveObjectWithData:[[objects objectAtIndex:0]valueForKey:@"data"]];
                        myaddvertisementsarr=[objects mutableCopy];
                        
                        //[jsonarray12 addObjectsFromArray:objects];
                        
                        NSLog(@"Core data recived12......%@",objects);
                        
                        NSManagedObjectContext *context2=[appDelegate managedObjectContext];
                        NSFetchRequest *request1=[[NSFetchRequest alloc] initWithEntityName:@"Myaddvertisementimage"];
                        NSMutableArray *fetchrequest1=[[context2 executeFetchRequest:request1 error:nil] mutableCopy];
                        NSInteger CoreDatafinalCount=[fetchrequest1 count];
                        NSLog(@"core data final count=%ld",(long)CoreDatafinalCount);
                        for (NSManagedObject *obj1 in fetchrequest1)
                        {
                            NSData *dataBytes = [obj1 valueForKey:@"image"];
                            [coredtaimagarray addObject:[UIImage imageWithData:dataBytes]];
                            
                        }
                        [_tableview reloadData];
                        NSLog(@"coredataimagearray%lu",(unsigned long)coredtaimagarray.count);
                        
                        
                        
                        [_nodatalbl setHidden:YES];
                        
                        [spinner stopAnimating];
                        [spinner removeFromSuperview];
                        [polygonView removeFromSuperview];
                        
                        
                    }];
                }];
                
                
            }
            
        }];
    }
    else
    {
        [self holedata];
    }
    
    
}


-(void)holedata
{
    myaddvertisementsarr=[[NSMutableArray alloc] init];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc =[NSEntityDescription entityForName:@"Myaddvertisementdata"inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    objects = [NSKeyedUnarchiver unarchiveObjectWithData:[[objects objectAtIndex:0]valueForKey:@"data"]];
    myaddvertisementsarr=[objects mutableCopy];
    
    //[jsonarray12 addObjectsFromArray:objects];
    
    NSLog(@"Core data recived12......%@",objects);
    
    
    
    NSManagedObjectContext *context2=[appDelegate managedObjectContext];
    NSFetchRequest *request1=[[NSFetchRequest alloc] initWithEntityName:@"Myaddvertisementimage"];
    NSMutableArray *fetchrequest1=[[context2 executeFetchRequest:request1 error:nil] mutableCopy];
    NSInteger CoreDatafinalCount=[fetchrequest1 count];
    NSLog(@"core data final count=%ld",(long)CoreDatafinalCount);
    for (NSManagedObject *obj1 in fetchrequest1)
    {
        NSData *dataBytes = [obj1 valueForKey:@"image"];
        [coredtaimagarray addObject:[UIImage imageWithData:dataBytes]];
        
    }
    [_tableview reloadData];
    NSLog(@"coredataimagearray%lu",(unsigned long)coredtaimagarray.count);
 
    
    
    
}



- (IBAction)backTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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

//right menu delegate method

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

-(void)cancelRightMenuByTap
{
    [UIView animateWithDuration:.5 animations:^{
        
        blackview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.01];
        
        [rightView setFrame:CGRectMake(self.view.frame.size.width + 10, 0,self.view.frame.size.width*.55, self.mainview.frame.size.height)];
        
    }
                     completion:^(BOOL finished){
                         
                         [blackview removeFromSuperview];
                         [rightView removeFromSuperview];
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

- (IBAction)listviewTapped:(id)sender
{
    tapcheck = 0;
    [_tableview reloadData];
}

- (IBAction)gridviewTapped:(id)sender
{
    tapcheck = 1;
    [_tableview reloadData];
}

//tableview delegate and datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tapcheck == 0)
    {
        return 100.0f;
    }
    else if (tapcheck == 1)
    {
        return 200.0f;
    }
    return 0;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return myaddvertisementsarr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tapcheck == 0)
        
    {
        
        
        
        cell1 = (DashboardListCell *)[tableView dequeueReusableCellWithIdentifier:@"listing3-1"];
        if([(NSNull *)[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"property_type"] == [NSNull null])
        {
            cell1.titlelabel.text=@"no data";
        }
        else
        {
            cell1.titlelabel.text=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"property_type"];
        }
        if([(NSNull *)[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"advert_added_for"] == [NSNull null])
        {
            cell1.pricelabel.text=@"no data";
        }
        else
        {
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
        }
        if([(NSNull *)[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"no_of_beds"] == [NSNull null])
        {
            cell1.bedroomslabel.text=@"no data";
        }
        else
        {
            bedsnumber=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"no_of_beds"];
            bathsnumber=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"no_of_baths"];
            roomsnumber=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"no_of_rooms"];
            NSLog(@"%@",bathsnumber);
            NSString* strRR = [NSString stringWithFormat:@"%@ bedroom(s),%@ bathroom(s),%@ rooms(s)", bedsnumber, bathsnumber, roomsnumber];
            cell1.bedroomslabel.text=strRR;
        }
        
//        imagearray=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"media"];
//        if (imagearray.count>0)
//        {
//            [cell1.propertyimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[imagearray objectAtIndex:0]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
//        }
//        else
//        {
//            cell1.propertyimage.image=[UIImage imageNamed:@"placeholder1"];
//        }
        
        cell1.propertyimage.image=[coredtaimagarray objectAtIndex:indexPath.row];
        
        
        [cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell1;
    }
    else
    {
        cell2 = (DashboardGridCell *)[tableView dequeueReusableCellWithIdentifier:@"gridfavourite-1"];
        if([(NSNull *)[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"property_type"] == [NSNull null])
        {
            cell2.titlelabel.text=@"no data";
        }
        else
        {
            cell2.titlelabel.text=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"property_type"];
        }
        if([(NSNull *)[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"advert_added_for"] == [NSNull null])
        {
            cell2.pricelabel.text=@"no data";
        }
        else
        {
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
            
        }
        
        if([(NSNull *)[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"no_of_beds"] == [NSNull null])
            
        {
            cell2.bedroomslabel.text=@"no data";
        }
        else
        {
            bedsnumber=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"no_of_beds"];
            bathsnumber=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"no_of_baths"];
            roomsnumber=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"no_of_rooms"];
            NSLog(@"%@",bathsnumber);
            NSString* strRR = [NSString stringWithFormat:@"%@ bedroom(s),%@ bathroom(s),%@ rooms(s)", bedsnumber, bathsnumber, roomsnumber];
            cell2.bedroomslabel.text=strRR;
        }
        
        
//        imagearray2=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"media"];
//        if (imagearray2.count>0)
//        {
//            [cell2.propertyimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[imagearray2 objectAtIndex:0]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
//        }
//        else
//        {
//            cell2.propertyimage.image=[UIImage imageNamed:@"placeholder1"];
//        }
        cell2.propertyimage.image=[coredtaimagarray objectAtIndex:indexPath.row];
        
        
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
        if ([date1 compare:date2] == NSOrderedDescending)
        {
            NSLog(@"date1 is later than date2");
            experidate=false;
        } else if ([date1 compare:date2] == NSOrderedAscending)
        {
            NSLog(@"date1 is earlier than date2");
            experidate=true;
        }
        else
        {
            NSLog(@"dates are the same");
            experidate=false;
        }
        
        
        
        if ([[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"publish_stat"] isEqualToString:@"Y"] && experidate==true)
        {
            
            cell2.renewadd.hidden=NO;
            cell2.renewadd.tag=indexPath.row;
            cell2.renewadd.layer.cornerRadius=4;
            
            
            cell2.editadd.hidden=NO;
            cell2.editadd.tag=indexPath.row;
            cell2.editadd.layer.cornerRadius=4;
            
            
            cell2.removeadd.hidden=NO;
            cell2.removeadd.tag=indexPath.row;
            cell2.removeadd.layer.cornerRadius=4;
            
            
        }
        else if ([[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"publish_stat"] isEqualToString:@"N"] && experidate==true)
        {
            
            cell2.renewadd.hidden=NO;
            cell2.renewadd.tag=indexPath.row;
            cell2.renewadd.layer.cornerRadius=4;
            
            
            cell2.editadd.hidden=NO;
            cell2.editadd.tag=indexPath.row;
            cell2.editadd.layer.cornerRadius=4;
            
            
            cell2.removeadd.hidden=YES;
            
        }
        else if ([[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"publish_stat"] isEqualToString:@"Y"] && experidate==false)
        {
            cell2.renewadd.hidden=YES;
            
            
            
            cell2.editadd.hidden=NO;
            cell2.editadd.tag=indexPath.row;
            cell2.editadd.layer.cornerRadius=4;
            
            
            cell2.removeadd.hidden=NO;
            cell2.removeadd.tag=indexPath.row;
            cell2.removeadd.layer.cornerRadius=4;
            
        }
        else if ([[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"publish_stat"] isEqualToString:@"N"] && experidate==false)
        {
            cell2.renewadd.hidden=YES;
            
            
            
            cell2.editadd.hidden=NO;
            cell2.editadd.tag=indexPath.row;
            cell2.editadd.layer.cornerRadius=4;
            
            
            cell2.removeadd.hidden=YES;
            
            
        }
        
        
        [cell2.renewadd addTarget:self action:@selector(renewaddbtntap:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell2.editadd addTarget:self action:@selector(editaddbtntap:) forControlEvents:UIControlEventTouchUpInside];
        [cell2.removeadd addTarget:self action:@selector(removeaddbtntap:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        [cell2 setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        
        return cell2;
    }
}

-(void)renewaddbtntap:(UIButton *)sender
{
    NSLog(@"renew btn");
    
    NSLog(@"Action to perform with RENEW");
    NSString *renew = [NSString stringWithFormat:@"%@json_output.php?mode=renew_advert&advert_id=%@",App_Domain_Url,[[myaddvertisementsarr objectAtIndex:sender.tag] valueForKey:@"advert_id"]];
    [obj GlobalDict:renew Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         NSLog(@"renew api%@",result);
         /////
         NSString *myaddvertiseurl = [NSString stringWithFormat:@"%@json_output.php?mode=list_my_property_advertisements&user_id=%@",App_Domain_Url,userid];
         
         myaddvertisementsarr=[[NSMutableArray alloc]init];
         [obj GlobalDict:myaddvertiseurl Globalstr:@"array" Withblock:^(id result, NSError *error)
          
          {
              
              myaddvertisementsarr=[result mutableCopy];
              [_tableview reloadData];
              
          }];
         
     }];
    
    
    
    
}



-(void)removeaddbtntap:(UIButton *)sender
{
    NSLog(@"remove btn");
    
    NSLog(@"Action to perform with REMOVE");
    
    
}

-(void)editaddbtntap:(UIButton *)sender
{
    NSLog(@"edit btn");
    
    NSString *type=[[myaddvertisementsarr objectAtIndex:sender.tag] valueForKey:@"advert_added_for"];
    if ([type isEqualToString:@"R"])
    {
        
        NSLog(@"Action to perform with EDIT for rent");
        //NSLog(@"%@",[myaddvertisementsarr objectAtIndex:indexPath.row]);
        
        AddadvertisementViewController *add = (AddadvertisementViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"addadvertise"];
        add.chkdata=@"R";
        add.editforRent = @"editforrentbtn";
        add.prevprice= [[myaddvertisementsarr objectAtIndex:sender.tag] valueForKey:@"property_price"];
        NSString *pro_id=[[myaddvertisementsarr objectAtIndex:sender.tag] valueForKey:@"property_id"];
        add.property_id=pro_id;
        NSString *add_id=[[myaddvertisementsarr objectAtIndex:sender.tag] valueForKey:@"advert_id"];
        add.advert_id=add_id;
        [self.navigationController pushViewController:add animated:YES];
        
        
    }
    else if ([type isEqualToString:@"S"])
    {
        
        NSLog(@"Action to perform with EDIT for sale");
        // NSLog(@"%@",[myaddvertisementsarr objectAtIndex:indexPath.row]);
        AddadvertisementViewController *add = (AddadvertisementViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"addadvertise"];
        add.chkdata=@"S";
        add.editforSell = @"editforsellbtn";
        add.prevprice= [[myaddvertisementsarr objectAtIndex:sender.tag] valueForKey:@"property_price"];
        NSString *pro_id=[[myaddvertisementsarr objectAtIndex:sender.tag] valueForKey:@"property_id"];
        add.property_id=pro_id;
        NSString *add_id=[[myaddvertisementsarr objectAtIndex:sender.tag] valueForKey:@"advert_id"];
        add.advert_id=add_id;
        [self.navigationController pushViewController:add animated:YES];
        
    }
    
    
    
    
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath");
    PropertyDetails2ViewController *prop2 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"propertydetail"];
    prop2.checkstring = @"myadvertisement";
    prop2.data_dic = [[myaddvertisementsarr objectAtIndex:indexPath.row] mutableCopy];
    [self.navigationController pushViewController:prop2 animated:YES];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableview)
    {
        if (tapcheck == 0)
        {
            if (indexPath.row>=0)
            {
                if (editingStyle == UITableViewCellEditingStyleDelete)
                {
                    
                    //add code here for when you hit delete
                }
            }
            
        }
        
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tapcheck == 0)
    {
        if (indexPath.row >= 0)
        {
            return UITableViewCellEditingStyleInsert;
        }
        return UITableViewCellEditingStyleInsert;
    }
    
    else
        return nil;
    
}



- (NSArray *)tableView:(UITableView *)tableView
editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewRowAction *button;
    UITableViewRowAction *button2;
    UITableViewRowAction *button3;
    if (indexPath.row>=0)
    {
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
        if ([date1 compare:date2] == NSOrderedDescending)
        {
            NSLog(@"date1 is later than date2");
            experidate=false;
        }
        else if ([date1 compare:date2] == NSOrderedAscending)
        {
            NSLog(@"date1 is earlier than date2");
            experidate=true;
        }
        else
        {
            NSLog(@"dates are the same");
            experidate=false;
        }
        if ([[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"publish_stat"] isEqualToString:@"Y"] && experidate==true)
        {
            
            button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"REMOVE" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                      {
                          NSLog(@"Action to perform with REMOVE");
                      }];
            button.backgroundColor = [UIColor colorWithRed:232/255.0f green:122/255.0f blue:86/255.0f alpha:1];; //arbitrary color
            NSString *type=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"advert_added_for"];
            
                button2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"EDIT" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                           {
                               if ([type isEqualToString:@"R"])
                               {
                               NSLog(@"Action to perform with EDIT for rent");
                               //NSLog(@"%@",[myaddvertisementsarr objectAtIndex:indexPath.row]);
                               
                               AddadvertisementViewController *add = (AddadvertisementViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"addadvertise"];
                               add.chkdata=@"R";
                               add.editforRent = @"editforrentbtn";
                               add.prevprice= [[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"property_price"];
                               NSString *pro_id=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"property_id"];
                               add.property_id=pro_id;
                               NSString *add_id=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"advert_id"];
                               add.advert_id=add_id;
                               [self.navigationController pushViewController:add animated:YES];
                               }
                               else if ([type isEqualToString:@"S"])
                               {
                                   NSLog(@"Action to perform with EDIT for sale");
                                   // NSLog(@"%@",[myaddvertisementsarr objectAtIndex:indexPath.row]);
                                   AddadvertisementViewController *add = (AddadvertisementViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"addadvertise"];
                                   add.chkdata=@"S";
                                   add.editforSell = @"editforsellbtn";
                                   add.prevprice= [[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"property_price"];
                                   NSString *pro_id=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"property_id"];
                                   add.property_id=pro_id;
                                   NSString *add_id=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"advert_id"];
                                   add.advert_id=add_id;
                                   [self.navigationController pushViewController:add animated:YES];
                               }
                               
                           }];
            
            
            button2.backgroundColor = [UIColor colorWithRed:82.0f/255.0f green:173.0f/255.0f blue:33.0f/255.0f alpha:1]; //arbitrary color
            button3 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"RENEW" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                       {
                           NSLog(@"Action to perform with RENEW");
                           NSString *renew = [NSString stringWithFormat:@"%@json_output.php?mode=renew_advert&advert_id=%@",App_Domain_Url,[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"advert_id"]];
                           [obj GlobalDict:renew Globalstr:@"array" Withblock:^(id result, NSError *error)
                            {
                                NSLog(@"renew api%@",result);
                                /////
                                NSString *myaddvertiseurl = [NSString stringWithFormat:@"%@json_output.php?mode=list_my_property_advertisements&user_id=%@",App_Domain_Url,userid];
                                
                                myaddvertisementsarr=[[NSMutableArray alloc]init];
                                [obj GlobalDict:myaddvertiseurl Globalstr:@"array" Withblock:^(id result, NSError *error)
                                 
                                 {
                                     
                                     myaddvertisementsarr=[result mutableCopy];
                                     [_tableview reloadData];
                                     
                                 }];
                                
                            }];
                           
                           //tableView.editing=false;
                           
                       }];
            
            button3.backgroundColor = [UIColor colorWithRed:32.0f/255.0f green:57.0f/255.0f blue:97.0f/255.0f alpha:1];
            return @[button,button2,button3];
            
        }
        else if ([[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"publish_stat"] isEqualToString:@"N"] && experidate==true)
            
        {
            
            
            
            NSString *type=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"advert_added_for"];
            
            
                
                button2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"EDIT" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                           
                           
                           
                           {
                               if ([type isEqualToString:@"R"])
                                   
                               {
                                   NSLog(@"Action to perform with EDIT for rent");
                               
                               //NSLog(@"%@",[myaddvertisementsarr objectAtIndex:indexPath.row]);
                               AddadvertisementViewController *add = (AddadvertisementViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"addadvertise"];
                               add.chkdata=@"R";
                               add.editforRent = @"editforrentbtn";
                               add.prevprice= [[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"property_price"];
                               NSString *pro_id=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"property_id"];
                               add.property_id=pro_id;
                               NSString *add_id=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"advert_id"];
                               add.advert_id=add_id;
                               [self.navigationController pushViewController:add animated:YES];
                                }
                               else if ([type isEqualToString:@"S"])
                               {
                                   NSLog(@"Action to perform with EDIT for sale");
                                   
                                   //NSLog(@"%@",[myaddvertisementsarr objectAtIndex:indexPath.row]);
                                   AddadvertisementViewController *add = (AddadvertisementViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"addadvertise"];
                                   add.chkdata=@"S";
                                   add.editforSell = @"editforsellbtn";
                                   add.prevprice= [[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"property_price"];
                                   NSString *pro_id=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"property_id"];
                                   add.property_id=pro_id;
                                   NSString *add_id=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"advert_id"];
                                   add.advert_id=add_id;
                                   [self.navigationController pushViewController:add animated:YES];
                               }
                               
                               
                               
                           }];
                
                
                
            
            
            button2.backgroundColor = [UIColor colorWithRed:82.0f/255.0f green:173.0f/255.0f blue:33.0f/255.0f alpha:1]; //arbitrary color
            
            button3 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"RENEW" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                       
                       {
                           
                           NSLog(@"Action to perform with RENEW!");
                           
                           NSString *renew = [NSString stringWithFormat:@"%@json_output.php?mode=renew_advert&advert_id=%@",App_Domain_Url,[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"advert_id"]];
                           
                           [obj GlobalDict:renew Globalstr:@"array" Withblock:^(id result, NSError *error)
                            
                            {
                                
                                NSLog(@"%@",result);
                                
                                NSString *myaddvertiseurl = [NSString stringWithFormat:@"%@json_output.php?mode=list_my_property_advertisements&user_id=%@",App_Domain_Url,userid];
                                
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
        
        else if ([[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"publish_stat"] isEqualToString:@"Y"] && experidate==false)
            
        {
            
            
            
            button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"REMOVE" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                      
                      {
                          
                          NSLog(@"Action to perform with REMOVE");
                          
                      }];
            
            button.backgroundColor = [UIColor colorWithRed:232/255.0f green:122/255.0f blue:86/255.0f alpha:1];; //arbitrary color
            
            NSString *type=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"advert_added_for"];
            
            
                button2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"EDIT" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                           
                           {
                               if ([type isEqualToString:@"R"])
                                   
                               {

                               NSLog(@"Action to perform with EDIT for rent");
                               
                               //NSLog(@"%@",[myaddvertisementsarr objectAtIndex:indexPath.row]);
                               
                               
                               AddadvertisementViewController *add = (AddadvertisementViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"addadvertise"];
                               add.chkdata=@"R";
                               add.editforRent = @"editforrentbtn";
                               add.prevprice= [[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"property_price"];
                               NSString *pro_id=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"property_id"];
                               add.property_id=pro_id;
                               NSString *add_id=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"advert_id"];
                               add.advert_id=add_id;
                               [self.navigationController pushViewController:add animated:YES];
                                    }
                               else if ([type isEqualToString:@"S"])
                               {
                                   NSLog(@"Action to perform with EDIT for sale");
                                   
                                   //NSLog(@"%@",[myaddvertisementsarr objectAtIndex:indexPath.row]);
                                   AddadvertisementViewController *add = (AddadvertisementViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"addadvertise"];
                                   add.chkdata=@"S";
                                   add.editforSell = @"editforsellbtn";
                                   add.prevprice= [[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"property_price"];
                                   NSString *pro_id=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"property_id"];
                                   add.property_id=pro_id;
                                   NSString *add_id=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"advert_id"];
                                   add.advert_id=add_id;
                                   [self.navigationController pushViewController:add animated:YES];
                               }
                               
                           }];
                
           
            
            button2.backgroundColor = [UIColor colorWithRed:82.0f/255.0f green:173.0f/255.0f blue:33.0f/255.0f alpha:1]; //arbitrary color
            
            return @[button, button2];
            
        }
        
        else if ([[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"publish_stat"] isEqualToString:@"N"] && experidate==false)
            
        {
            
            
            
            NSString *type=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"advert_added_for"];
            
            
                
                button2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"EDIT" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                           
                           {
                               
                               if ([type isEqualToString:@"R"])
                                   
                               {
                               NSLog(@"Action to perform with EDIT for rent");
                               
                               //NSLog(@"%@",[myaddvertisementsarr objectAtIndex:indexPath.row]);
                               
                               AddadvertisementViewController *add = (AddadvertisementViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"addadvertise"];
                               add.chkdata=@"R";
                               add.editforRent = @"editforrentbtn";
                               add.prevprice= [[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"property_price"];
                               NSString *pro_id=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"property_id"];
                               add.property_id=pro_id;
                               NSString *add_id=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"advert_id"];
                               add.advert_id=add_id;
                               [self.navigationController pushViewController:add animated:YES];
                                   }
                                else if ([type isEqualToString:@"S"])
                                {
                                    NSLog(@"Action to perform with EDIT for sale");
                                    
                                    //NSLog(@"%@",[myaddvertisementsarr objectAtIndex:indexPath.row]);
                                    AddadvertisementViewController *add = (AddadvertisementViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"addadvertise"];
                                    add.chkdata=@"S";
                                    add.editforSell = @"editforsellbtn";
                                    add.prevprice= [[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"property_price"];
                                    NSString *pro_id=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"property_id"];
                                    add.property_id=pro_id;
                                    NSString *add_id=[[myaddvertisementsarr objectAtIndex:indexPath.row] valueForKey:@"advert_id"];
                                    add.advert_id=add_id;
                                    [self.navigationController pushViewController:add animated:YES];
                                }
                               
                               
                           }];
                
                
                
            
            
                        button2.backgroundColor = [UIColor colorWithRed:82.0f/255.0f green:173.0f/255.0f blue:33.0f/255.0f alpha:1]; //arbitrary color
            
            return @[ button2];
            
        }
    }
    
    return nil;
}

- (void)resetDefaults
{
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
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
