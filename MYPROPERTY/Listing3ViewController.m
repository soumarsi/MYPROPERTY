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

@interface Listing3ViewController ()<footerdelegate,UIGestureRecognizerDelegate,rightDelegate,leftDelegate>
{
    RightMenu *rightView;
    BOOL rightslide;
    Footer *footerView;
    UIView *blackview;
    BOOL tablechk, leftslide;
    LeftMenu *leftView;
}

@property (strong, nonatomic) IBOutlet UIView *mainview;
@property (strong, nonatomic) IBOutlet UIImageView *headerview;
@end

@implementation Listing3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tablechk=true;
    rightslide = 0;
    leftslide = 0;
    
    footerView = [[Footer alloc]init];
    blackview = [[UIView alloc]init];
    
    [footerView setFrame:CGRectMake(0, self.view.frame.size.height - 60, self.view.frame.size.width, 60)];
    
    footerView.footerdelegate=self;
    //    [footerView TapCheck:1];
    [self.view addSubview:footerView];
    
    _tableviewlisting3.delegate=self;
    _tableviewlisting3.dataSource=self;
    [_tableviewlisting3 setShowsHorizontalScrollIndicator:NO];
    [_tableviewlisting3 setShowsVerticalScrollIndicator:NO];
    
    
}

-(void)pushmethod:(UIButton *)sender
{
    NSLog(@"footer method called");
    long tagId = [sender tag];
    NSLog(@"%ld",(long)tagId);
    if ( tagId == 1 )
    {
        NSLog(@"tagid is: %ld",(long)tagId);
    }
    else if ( tagId == 2 )
    {
        FavouriteViewController *fav = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"favourites"];
        [self.navigationController pushViewController:fav animated:NO];
    }
    else if (tagId == 3)
    {
        NSLog(@"tagid is: %ld",(long)tagId);
        PropertyViewController *prop = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"property"];
        [self.navigationController pushViewController:prop animated:NO];
    }
    else if (tagId == 4)
    {
        MPNotificationViewController *noti = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"notification"];
        [self.navigationController pushViewController:noti animated:NO];
    }
    else
    {
        [footerView TapCheck:5];
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
            
            /* UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelRightMenu)];
             tapGestureRecognize.delegate = self;
             tapGestureRecognize.numberOfTapsRequired = 1;
             [tapGestureRecognize requireGestureRecognizerToFail:tapGestureRecognize];
             [blackview addGestureRecognizer:tapGestureRecognize]; */
            
            UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(cancelRightMenu)];
            recognizer.direction = UISwipeGestureRecognizerDirectionRight;
            recognizer.delegate = self;
            
            UISwipeGestureRecognizer *recognizer1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(cancelRightMenu)];
            recognizer.direction = UISwipeGestureRecognizerDirectionRight;
            recognizer.delegate = self;
            
            [blackview addGestureRecognizer:recognizer];
            [rightView addGestureRecognizer:recognizer1];
            
            [_mainview addSubview:blackview];
            
            
            [UIView animateWithDuration:.7 animations:^{
                
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
            
            [UIView animateWithDuration:.7 animations:^{
                
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
- (IBAction)leftMenuTapped:(id)sender
{
    if (leftslide == 0)
    {
        leftView = [[LeftMenu alloc]init];
        [leftView setFrame:CGRectMake(-220, 0,self.view.frame.size.width*.6, self.mainview.frame.size.height)];
        leftView.leftDelegate = self;
        [self.view addSubview:leftView];
        
        
        [UIView animateWithDuration:.7 animations:^{
            
            [self.mainview setFrame:CGRectMake(self.mainview.frame.size.width*.6,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height)];
            
            [leftView setFrame:CGRectMake(0, 0,self.view.frame.size.width*.6, self.mainview.frame.size.height)];
            
            
            //            [self.view addSubview:leftView];
            
        }];
        
        leftslide = 1;
    }
    else
    {
        [UIView animateWithDuration:.7 animations:^{
            
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
    if ( tagId == 2 )
    {
        NSLog(@"tagid is: %ld",(long)tagId);
        QFProfileViewController *pro = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"profile"];
        [self.navigationController pushViewController:pro animated:YES];
    }
    else if (tagId == 3)
    {
        NSLog(@"tagid is: %ld",(long)tagId);
        ChangePasswordViewController *pro = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"changepwd"];
        [self.navigationController pushViewController:pro animated:YES];
    }
    else if (tagId == 4)
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
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
        return cell;
    }
    else if (tablechk==false)
    {
        GridTableViewCell *cell;
        cell=(GridTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"gridcell"];
        return cell;
    }
    
    return nil;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PropertyDetails2ViewController *prop2 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"propertydetail"];
    [self.navigationController pushViewController:prop2 animated:YES];
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
    [_tableviewlisting3 reloadData];
    
}

- (IBAction)listviewbutton:(id)sender
{
    tablechk=true;
    [_tableviewlisting3 reloadData];
}
@end
