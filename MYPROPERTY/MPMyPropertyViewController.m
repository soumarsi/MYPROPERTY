//
//  MPMyPropertyViewController.m
//  MYPROPERTY
//
//  Created by Somenath on 23/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "MPMyPropertyViewController.h"
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

@interface MPMyPropertyViewController () <footerdelegate,rightDelegate,UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    BOOL viewslide,rightslide, tapcheck;
    UIView *slideview, *blackview;
    Footer *footerView;
    RightMenu *rightView;
    NSUserDefaults *userinfo;
    NSMutableArray *mypropertyarr,*imagearray,*imagearray2;
    NSMutableDictionary *favdic;
    NSString *userid,*coredtachk;
    AppDelegate *appDelegate;
     NSMutableArray *coredtaimagarray;
    BOOL coredatavalue;
    NSOperationQueue *myQueue;
    NSUserDefaults *chakingdata;
    UITapGestureRecognizer *tapGestureRecognize;
    UISwipeGestureRecognizer *recognizer;
    UISwipeGestureRecognizer *recognizer1;
    UIView *polygonView;
    NSTimer *myTimer;
}

@property (strong, nonatomic) IBOutlet UIView *mainview;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) IBOutlet UILabel *nodatalbl;
@end

@implementation MPMyPropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    chakingdata=[[NSUserDefaults alloc] init];
    coredtachk=[chakingdata objectForKey:@"data"];
    
    userinfo=[[NSUserDefaults alloc]init];
    obj = [[FW_JsonClass alloc]init];
    
   userid = [userinfo objectForKey:@"id"];
    NSLog(@"userid is : %@",userid);
    
    _processview.progress = 0.0f;
    //_processview.center = self.view.center;
    
    
    
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    if ([_datachangestring isEqualToString:@"data change"])
    {
        
        
        NSManagedObjectContext *context3=[appDelegate managedObjectContext];
        NSFetchRequest *request3=[[NSFetchRequest alloc] initWithEntityName:@"Mypropertydata"];
        NSMutableArray *fetchrequest3=[[context3 executeFetchRequest:request3 error:nil] mutableCopy];
        NSError *error;
        NSInteger CoreDatafinalCount=[fetchrequest3 count];
        NSLog(@"core data final count=%ld",(long)CoreDatafinalCount);
        for (NSManagedObject *obj3 in fetchrequest3)
        {
            
            [context3 deleteObject:obj3];
            
            
        }
        [context3 save:&error];
    
        NSManagedObjectContext *context4=[appDelegate managedObjectContext];
        NSFetchRequest *request4=[[NSFetchRequest alloc] initWithEntityName:@"Mypropertyimage"];
        NSMutableArray *fetchrequest4=[[context3 executeFetchRequest:request4 error:nil] mutableCopy];
        NSInteger CoreDatafinalCount2=[fetchrequest4 count];
        NSError *error1;
        NSLog(@"core data final count=%ld",(long)CoreDatafinalCount2);
        for (NSManagedObject *obj4 in fetchrequest4)
        {
            
            NSLog(@"data removed%@",obj4);
            [context4 deleteObject:obj4];
            
            
            
        }
    [context4 save:&error1];
        
        
        
        [self getdata];
        
        
        
    }
    else if ([coredtachk isEqualToString:@"data change"])
    {
        
        NSManagedObjectContext *context3=[appDelegate managedObjectContext];
        NSFetchRequest *request3=[[NSFetchRequest alloc] initWithEntityName:@"Mypropertydata"];
        NSMutableArray *fetchrequest3=[[context3 executeFetchRequest:request3 error:nil] mutableCopy];
        NSError *error;
        NSInteger CoreDatafinalCount=[fetchrequest3 count];
        NSLog(@"core data final count=%ld",(long)CoreDatafinalCount);
        for (NSManagedObject *obj3 in fetchrequest3)
        {
            
            [context3 deleteObject:obj3];
            
            
        }
        [context3 save:&error];
        
        
        
        NSString *mypropertyul = [NSString stringWithFormat:@"%@json_output.php?mode=list_my_property&user_id=%@",App_Domain_Url,userid];
        
        polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
        polygonView.backgroundColor=[UIColor blackColor];
        polygonView.alpha=0.3;
        [self.view addSubview:polygonView];
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
        [polygonView addSubview:_processview];
        [polygonView addSubview:spinner];
        
        
        
        [spinner startAnimating];
        
        
        
        [obj GlobalDict:mypropertyul Globalstr:@"array" Withblock:^(id result, NSError *error) {
            mypropertyarr = [result mutableCopy];
            
            if (mypropertyarr.count == 0)
            {
                _nodatalbl.hidden = NO;
                [spinner stopAnimating];
                [spinner removeFromSuperview];
                [polygonView removeFromSuperview];
            }
            else
            {
                
                //_nodatalbl.hidden = YES;
                //[_tableview reloadData];
                
                [self startCount];
                
                myQueue = [[NSOperationQueue alloc] init];
                [myQueue addOperationWithBlock:^{
                    
                    // Background work
                    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:mypropertyarr];
                    
                    NSManagedObjectContext *context=[appDelegate managedObjectContext];
                    NSManagedObject *newUser=[NSEntityDescription insertNewObjectForEntityForName:@"Mypropertydata" inManagedObjectContext:context];
                    
                    [newUser setValue:data forKey:@"data"];
                    [appDelegate saveContext];
                    
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        // Main thread work (UI usually)
                        
                        coredatavalue=true;
                        
                        mypropertyarr=[[NSMutableArray alloc] init];
                        NSManagedObjectContext *context = [appDelegate managedObjectContext];
                        NSEntityDescription *entityDesc =[NSEntityDescription entityForName:@"Mypropertydata"inManagedObjectContext:context];
                        NSFetchRequest *request = [[NSFetchRequest alloc] init];
                        [request setEntity:entityDesc];
                        NSError *error;
                        NSArray *objects = [context executeFetchRequest:request
                                                                  error:&error];
                        objects = [NSKeyedUnarchiver unarchiveObjectWithData:[[objects objectAtIndex:0]valueForKey:@"data"]];
                        mypropertyarr=[objects mutableCopy];
                        
                        //[jsonarray12 addObjectsFromArray:objects];
                        
                        NSLog(@"Core data recived12......%@",objects);
                        
                        
                        
                        coredtaimagarray=[[NSMutableArray alloc]init];
                        
                        
                        NSManagedObjectContext *context2=[appDelegate managedObjectContext];
                        NSFetchRequest *request1=[[NSFetchRequest alloc] initWithEntityName:@"Mypropertyimage"];
                        NSMutableArray *fetchrequest1=[[context2 executeFetchRequest:request1 error:nil] mutableCopy];
                        NSInteger CoreDatafinalCount=[fetchrequest1 count];
                        NSLog(@"core data final count=%ld",(long)CoreDatafinalCount);
                        for (NSManagedObject *obj1 in fetchrequest1)
                        {
                            NSData *dataBytes = [obj1 valueForKey:@"image"];
                            //[btnimg setBackgroundImage:[UIImage imageWithData:dataBytes] forState:UIControlStateNormal];
                            [coredtaimagarray addObject:[UIImage imageWithData:dataBytes]];
                            
                        }
                        [_tableview reloadData];
                        [spinner stopAnimating];
                        [spinner removeFromSuperview];
                        [polygonView removeFromSuperview];
                        [_processview removeFromSuperview];
                        
                        NSLog(@"coredataimagearray%lu",(unsigned long)coredtaimagarray.count);
                    }];
                }];
                
            }
        }];
        
        
        
        
        [chakingdata setValue:@"no change" forKey:@"data"];
        [chakingdata synchronize];
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
    NSFetchRequest *request1=[[NSFetchRequest alloc] initWithEntityName:@"Mypropertyimage"];
    NSMutableArray *fetchrequest1=[[context2 executeFetchRequest:request1 error:nil] mutableCopy];
    NSInteger CoreDatafinalCount=[fetchrequest1 count];
    NSLog(@"core data final count=%ld",(long)CoreDatafinalCount);
    
    if (CoreDatafinalCount==0)
    {
        NSString *mypropertyul = [NSString stringWithFormat:@"%@json_output.php?mode=list_my_property&user_id=%@",App_Domain_Url,userid];
        polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
        polygonView.backgroundColor=[UIColor blackColor];
        polygonView.alpha=0.3;
        [self.view addSubview:polygonView];
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
        
        [polygonView addSubview:spinner];
        
        
        [spinner startAnimating];
        
        [obj GlobalDict:mypropertyul Globalstr:@"array" Withblock:^(id result, NSError *error) {
            mypropertyarr = [result mutableCopy];
            
            if (mypropertyarr.count == 0)
            {
                _nodatalbl.hidden = NO;
                [spinner stopAnimating];
                [spinner removeFromSuperview];
                [polygonView removeFromSuperview];
                [_processview removeFromSuperview];
            }
            else
            {
                
                //_nodatalbl.hidden = YES;
                //[_tableview reloadData];
                
                [self startCount];

                
                myQueue = [[NSOperationQueue alloc] init];
                [myQueue addOperationWithBlock:^{
                    
                    // Background work
                    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:mypropertyarr];
                    
                    NSManagedObjectContext *context=[appDelegate managedObjectContext];
                    NSManagedObject *newUser=[NSEntityDescription insertNewObjectForEntityForName:@"Mypropertydata" inManagedObjectContext:context];
                    
                    [newUser setValue:data forKey:@"data"];
                    [appDelegate saveContext];
                    
                    
                    for ( NSDictionary *tempDict1 in  result)
                    {
                        NSManagedObjectContext *context22=[appDelegate managedObjectContext];
                        NSManagedObject *manageobject22=[NSEntityDescription insertNewObjectForEntityForName:@"Mypropertyimage" inManagedObjectContext:context22];
                        NSMutableArray *imagearray28=[[NSMutableArray alloc] init];
                        imagearray28=[tempDict1 valueForKey:@"media"];
                        
                        if (imagearray28.count>0)
                        {
                            
                            NSData *picturedata=[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[imagearray28 objectAtIndex:0]]]];
                            //NSLog(@"picdata%@",picturedata);
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
                        // Main thread work (UI usually)
                        
                        
                        coredatavalue=true;
                        
                        mypropertyarr=[[NSMutableArray alloc] init];
                        NSManagedObjectContext *context = [appDelegate managedObjectContext];
                        NSEntityDescription *entityDesc =[NSEntityDescription entityForName:@"Mypropertydata"inManagedObjectContext:context];
                        NSFetchRequest *request = [[NSFetchRequest alloc] init];
                        [request setEntity:entityDesc];
                        NSError *error;
                        NSArray *objects = [context executeFetchRequest:request
                                                                  error:&error];
                        objects = [NSKeyedUnarchiver unarchiveObjectWithData:[[objects objectAtIndex:0]valueForKey:@"data"]];
                        mypropertyarr=[objects mutableCopy];
                        
                        //[jsonarray12 addObjectsFromArray:objects];
                        
                        NSLog(@"Core data recived12......%@",objects);
                        
                        
                        
                        coredtaimagarray=[[NSMutableArray alloc]init];
                        
                        
                        NSManagedObjectContext *context2=[appDelegate managedObjectContext];
                        NSFetchRequest *request1=[[NSFetchRequest alloc] initWithEntityName:@"Mypropertyimage"];
                        NSMutableArray *fetchrequest1=[[context2 executeFetchRequest:request1 error:nil] mutableCopy];
                        NSInteger CoreDatafinalCount=[fetchrequest1 count];
                        NSLog(@"core data final count=%ld",(long)CoreDatafinalCount);
                        for (NSManagedObject *obj1 in fetchrequest1)
                        {
                            NSData *dataBytes = [obj1 valueForKey:@"image"];
                            
                            [coredtaimagarray addObject:[UIImage imageWithData:dataBytes]];
                            
                        }
                        [_tableview reloadData];
                        [spinner stopAnimating];
                        [spinner removeFromSuperview];
                        [polygonView removeFromSuperview];
                        [_processview removeFromSuperview];
                        
                        NSLog(@"coredataimagearray%lu",(unsigned long)coredtaimagarray.count);
                    }];
                }];
                
            }
        }];

    }
    else
    {
        
//        NSString *mypropertyul = [NSString stringWithFormat:@"%@json_output.php?mode=list_my_property&user_id=%@",App_Domain_Url,userid];
//        
//        UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//        backview.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.3];
//        [backview addSubview:_spinner];
//        [_mainview addSubview:backview];
//        [_spinner setHidden:NO];
//        [_spinner startAnimating];
//        [obj GlobalDict:mypropertyul Globalstr:@"array" Withblock:^(id result, NSError *error) {
//            mypropertyarr = [result mutableCopy];
//            [_spinner setHidden:YES];
//            [_spinner stopAnimating];
//            [backview removeFromSuperview];
//            if (mypropertyarr.count == 0)
//            {
//                _nodatalbl.hidden = NO;
//            }
//            else
//            {
//                
//                    //_nodatalbl.hidden = YES;
//                    //[_tableview reloadData];
//                
//                NSManagedObjectContext *context2=[appDelegate managedObjectContext];
//                NSFetchRequest *request1=[[NSFetchRequest alloc] initWithEntityName:@"Mypropertyimage"];
//                NSMutableArray *fetchrequest1=[[context2 executeFetchRequest:request1 error:nil] mutableCopy];
//                NSInteger CoreDatafinalCount=[fetchrequest1 count];
//                NSLog(@"core data final count=%ld",(long)CoreDatafinalCount);
//                
//                if (CoreDatafinalCount==mypropertyarr.count)
//                {
//                    [self holedata];
//                    coredatavalue=true;
//                }
//                else
//                {
//                    _nodatalbl.hidden = YES;
//                    [_tableview reloadData];
//                }
//                
//        
//            }
//        }];
        [self holedata];
        
        
    }
    
    
    
    
}


-(void)holedata
{
    
    [_processview setHidden:YES];
    coredatavalue=true;
    
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc =[NSEntityDescription entityForName:@"Mypropertydata"inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    objects = [NSKeyedUnarchiver unarchiveObjectWithData:[[objects objectAtIndex:0]valueForKey:@"data"]];
    mypropertyarr=[objects mutableCopy];
    
    //[jsonarray12 addObjectsFromArray:objects];
    
    NSLog(@"Core data recived12......%@",objects);
    
    
   
    coredtaimagarray=[[NSMutableArray alloc]init];
    
    
    NSManagedObjectContext *context2=[appDelegate managedObjectContext];
    NSFetchRequest *request1=[[NSFetchRequest alloc] initWithEntityName:@"Mypropertyimage"];
    NSMutableArray *fetchrequest1=[[context2 executeFetchRequest:request1 error:nil] mutableCopy];
    NSInteger CoreDatafinalCount=[fetchrequest1 count];
    NSLog(@"core data final count=%ld",(long)CoreDatafinalCount);
    for (NSManagedObject *obj1 in fetchrequest1)
    {
        NSData *dataBytes = [obj1 valueForKey:@"image"];
        //[btnimg setBackgroundImage:[UIImage imageWithData:dataBytes] forState:UIControlStateNormal];
        [coredtaimagarray addObject:[UIImage imageWithData:dataBytes]];
        
    }
    [_tableview reloadData];
    NSLog(@"coredataimagearray%lu",(unsigned long)coredtaimagarray.count);
    
    
    
    
   
    
}



- (void)startCount
{
    [_processview setHidden:NO];
    myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateUI:) userInfo:nil repeats:YES];
}

- (void)updateUI:(NSTimer *)timer
{
    static int count =0; count++;
    NSInteger pos=[mypropertyarr count];
    
    if (count <=pos)
    {
        //        self.progressView.text = [NSString stringWithFormat:@"%d %%",count*10];
        
            
            self.processview.progress = (float)count/60.0f;
        
        
        
    } else
    {
        [myTimer invalidate];
        myTimer = nil;
    }
}



- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"working");
    [super viewWillDisappear:animated];
    //[myQueue cancelAllOperations];
    //myQueue=Nil;
    //[myQueue waitUntilAllOperationsAreFinished];
    //[myQueue setSuspended:YES];
}



- (IBAction)backTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
            
           tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelRightMenuByTap)];
            tapGestureRecognize.delegate = self;
            tapGestureRecognize.numberOfTapsRequired = 1;
            //[tapGestureRecognize requireGestureRecognizerToFail:tapGestureRecognize];
            [blackview addGestureRecognizer:tapGestureRecognize];
            
           recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(cancelRightMenu)];
            recognizer.direction = UISwipeGestureRecognizerDirectionRight;
            recognizer.delegate = self;
            
            recognizer1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(cancelRightMenu)];
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
    
    [blackview removeGestureRecognizer:tapGestureRecognize];
    [blackview removeGestureRecognizer:recognizer];
    
    
    
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
    return mypropertyarr.count;

}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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
        

        if (coredatavalue==true)
        {
            cell1.propertyimage.image=[coredtaimagarray objectAtIndex:indexPath.row];
        }
        else
        {
                    imagearray=[[mypropertyarr objectAtIndex:indexPath.row]valueForKey:@"media"];
                    if (imagearray.count>0) {
                        [cell1.propertyimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[imagearray objectAtIndex:0]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
                    }
                    else
                    {
                        cell1.propertyimage.image=[UIImage imageNamed:@"placeholder1"];
                    }
        }
        
        
        
        cell1.bedroomslabel.text = [NSString stringWithFormat:@"%@ Beds, %@ Bathrooms, %@ Rooms",[[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"no_of_beds"],[[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"no_of_baths"],[[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"no_of_rooms"]];
        if([(NSNull *)[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"status_val"] == [NSNull null])
        {
            cell1.pricelabel.text = @"No Status Available";
        }
        else
        {
            cell1.pricelabel.text = [[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"status_val"];
        }
        
        
        cell1.cellview.tag = indexPath.row;
        
        [cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
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
        
        
        
        
        if (coredatavalue==true)
        {
            cell2.propertyimage.image=[coredtaimagarray objectAtIndex:indexPath.row];
        }
        else
        {
            imagearray2=[[mypropertyarr objectAtIndex:indexPath.row]valueForKey:@"media"];
            if (imagearray2.count>0)
            {
                [cell2.propertyimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[imagearray2 objectAtIndex:0]]] placeholderImage:[UIImage imageNamed:@"placeholder1"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            }
            else
            {
                cell2.propertyimage.image=[UIImage imageNamed:@"placeholder1"];
            }
            
        }
        
        
        
        
        
        
       
        cell2.bedroomslabel.text = [NSString stringWithFormat:@"%@ Beds, %@ Bathrooms, %@ Rooms",[[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"no_of_beds"],[[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"no_of_baths"],[[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"no_of_rooms"]];
       
        if([(NSNull *)[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"status_val"] == [NSNull null])
        {
            cell2.pricelabel.text = @"No Status Found";
        }
        else
        {
            cell2.pricelabel.text = [[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"status_val"];
        }
        cell2.letme.hidden=NO;
        cell2.sellme.hidden=NO;
        cell2.edit.hidden=NO;
        
        
        if ([[[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"added_for_sell"] isEqualToString:@"N"] && [[[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"added_for_rent"] isEqualToString:@"N"])
        {
            cell2.letme.hidden=NO;
            cell2.sellme.hidden=NO;
            cell2.edit.hidden=NO;
            
            cell2.letme.tag=indexPath.row;
            cell2.letme.layer.cornerRadius=4;
            cell2.letme.frame=CGRectMake(cell2.edit.frame.origin.x, cell2.sellme.frame.origin.y-26,cell2.edit.frame.size.width, 21);
            
            
            
            cell2.sellme.tag=indexPath.row;
            cell2.sellme.layer.cornerRadius=4;
            
            
            
            
            cell2.edit.tag=indexPath.row;
            cell2.edit.layer.cornerRadius=4;
            
            
            
            NSLog(@"1stcondition%ld",(long)indexPath.row);
            
            
        }
        else if ([[[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"added_for_rent"] isEqualToString:@"N"] && [[[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"added_for_sell"] isEqualToString:@"Y"])
        {
            cell2.letme.hidden=NO;
            cell2.sellme.hidden=YES;
            cell2.edit.hidden=NO;

            
            cell2.letme.tag=indexPath.row;
            cell2.letme.layer.cornerRadius=4;
            cell2.letme.frame=CGRectMake(cell2.edit.frame.origin.x, cell2.sellme.frame.origin.y,cell2.edit.frame.size.width, 21);
            
            
            
            cell2.edit.tag=indexPath.row;
            cell2.edit.layer.cornerRadius=4;
            
            NSLog(@"2ndcondition%ld",(long)indexPath.row);
            
        }
        
        else if ([[[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"added_for_rent"] isEqualToString:@"Y"] && [[[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"added_for_sell"] isEqualToString:@"N"])
        {
            
            cell2.letme.hidden=YES;
             cell2.sellme.hidden=NO;
            cell2.edit.hidden=NO;
            
            
            
            cell2.sellme.tag=indexPath.row;
            cell2.sellme.layer.cornerRadius=4;
           
            
            
            
            cell2.edit.tag=indexPath.row;
            cell2.edit.layer.cornerRadius=4;
            
            NSLog(@"3rdcondition%ld",(long)indexPath.row);
        }
        else if ([[[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"added_for_sell"] isEqualToString:@"Y"] && [[[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"added_for_rent"] isEqualToString:@"Y"])
        {
            cell2.letme.hidden=YES;
            
            
            
            cell2.sellme.hidden=YES;
            cell2.edit.hidden=NO;
            
            
            cell2.edit.tag=indexPath.row;
            cell2.edit.layer.cornerRadius=4;
            
            NSLog(@"4thcondition%ld",(long)indexPath.row);
            
        }
        
        
        
        
        
        [cell2.letme addTarget:self action:@selector(letmebtntap:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell2.sellme addTarget:self action:@selector(sellmebtntap:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell2.edit addTarget:self action:@selector(editbtntap:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        [cell2 setSelectionStyle:UITableViewCellSelectionStyleNone];
        
      
        return cell2;
    }
}

-(void)letmebtntap:(UIButton *)sender
{
    NSLog(@"letme");
    NSLog(@"indexpath is: %ld",(long)sender.tag);
    AddadvertisementViewController *add = (AddadvertisementViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"addadvertise"];
    add.chkdata=@"R";
    add.mypropertyRent = @"mypropertyrentbtn";
    NSString *pro_id=[[mypropertyarr objectAtIndex:sender.tag] valueForKey:@"id"] ;
    NSLog(@"profileid %@",pro_id);
    add.property_id=[pro_id mutableCopy];
    [self.navigationController pushViewController:add animated:YES];
    
    
    
}

-(void)sellmebtntap:(UIButton *)sender
{
    NSLog(@"sellme");
    NSLog(@"indexpath is: %ld",(long)sender.tag);
    
    
    NSLog(@"Action to perform with Button2!");
    
    AddadvertisementViewController *add = (AddadvertisementViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"addadvertise"];
    add.chkdata=@"S";
    add.mypropertySell = @"mypropertysellbtn";
    NSString *pro_id=[[mypropertyarr objectAtIndex:sender.tag] valueForKey:@"id"];
    add.property_id=[pro_id mutableCopy];
    [self.navigationController pushViewController:add animated:YES];
    
    
    
}


-(void)editbtntap:(UIButton *)sender
{
    NSLog(@"edit");
    NSLog(@"indexpath is: %ld",(long)sender.tag);
    MPEditProperty *editprop = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"editproperty1"];
    editprop.regisdetail = [[mypropertyarr objectAtIndex:sender.tag]mutableCopy];
    [self.navigationController pushViewController:editprop animated:YES];
    
    
}




//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    PropertyDetails2ViewController *prop2 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"propertydetail"];
//    prop2.checkstring = @"myproperty";
//    prop2.data_dic = [[mypropertyarr objectAtIndex:indexPath.row] mutableCopy];
//    [self.navigationController pushViewController:prop2 animated:YES];
//}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableview)
    {
        if (tapcheck == 0)
        {
            if (indexPath.row >=0)
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
    NSLog(@"indexpath %ld",(long)indexPath.row);
    if (indexPath.row >= 0)
    {
        
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
                           add.mypropertySell = @"mypropertysellbtn";
                           NSString *pro_id=[[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"id"];
                           add.property_id=[pro_id mutableCopy];
                           [self.navigationController pushViewController:add animated:YES];
                           
                       }];
            
            button2.backgroundColor = [UIColor colorWithRed:82.0f/255.0f green:173.0f/255.0f blue:33.0f/255.0f alpha:1]; //arbitrary color
            
            button3 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"LET ME" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                       {
                           
                           NSLog(@"Action to perform with Button3!");
                           
                           AddadvertisementViewController *add = (AddadvertisementViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"addadvertise"];
                           add.chkdata=@"R";
                           add.mypropertyRent = @"mypropertyrentbtn";
                           NSString *pro_id=[[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"id"] ;
                           NSLog(@"profileid %@",pro_id);
                           add.property_id=[pro_id mutableCopy];
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
                          MPEditProperty *editprop = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"editproperty1"];
                          editprop.regisdetail = [[mypropertyarr objectAtIndex:indexPath.row]mutableCopy];
                          [self.navigationController pushViewController:editprop animated:YES];
                      }];
            
            button.backgroundColor = [UIColor colorWithRed:232/255.0f green:122/255.0f blue:86/255.0f alpha:1]; //arbitrary color
            button3 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"LET ME" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                       {
                           
                           NSLog(@"Action to perform with Button3!");
                           AddadvertisementViewController *add = (AddadvertisementViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"addadvertise"];
                           add.chkdata=@"R";
                           add.mypropertyRent = @"mypropertyrentbtn";
                           NSString *pro_id=[[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"id"];
                           add.property_id=[pro_id mutableCopy];
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
                          MPEditProperty *editprop = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"editproperty1"];
                          editprop.regisdetail = [[mypropertyarr objectAtIndex:indexPath.row]mutableCopy];
                          [self.navigationController pushViewController:editprop animated:YES];
                      }];
            
            button.backgroundColor = [UIColor colorWithRed:232/255.0f green:122/255.0f blue:86/255.0f alpha:1]; //arbitrary color
            button2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"SELL ME" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                       {
                           NSLog(@"Action to perform with Button2!");
                           
                           AddadvertisementViewController *add = (AddadvertisementViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"addadvertise"];
                           add.chkdata=@"S";
                           add.mypropertySell = @"mypropertysellbtn";
                           NSString *pro_id=[[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"id"];
                           add.property_id=[pro_id mutableCopy];
                           [self.navigationController pushViewController:add animated:YES];                           }];
            
            button2.backgroundColor = [UIColor colorWithRed:82.0f/255.0f green:173.0f/255.0f blue:33.0f/255.0f alpha:1]; //arbitrary color
            return @[button, button2];
            
        }
        
        else if ([[[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"added_for_sell"] isEqualToString:@"Y"] && [[[mypropertyarr objectAtIndex:indexPath.row] valueForKey:@"added_for_rent"] isEqualToString:@"Y"])
        {
            button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"EDIT" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                      {
                          NSLog(@"Action to perform with Button 1");
                          MPEditProperty *editprop = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"editproperty1"];
                          editprop.regisdetail = [[mypropertyarr objectAtIndex:indexPath.row]mutableCopy];
                          [self.navigationController pushViewController:editprop animated:YES];
                      }];
            
            button.backgroundColor = [UIColor colorWithRed:232/255.0f green:122/255.0f blue:86/255.0f alpha:1]; //arbitrary color
            return @[button];
        }
        
//        return @[button, button2,button3];
    }
    return nil;
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
