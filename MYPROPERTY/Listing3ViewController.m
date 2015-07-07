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

@interface Listing3ViewController ()<footerdelegate,UIGestureRecognizerDelegate>
{
    RightMenu *rightView;
    BOOL rightslide;
    Footer *footerView;
    UIView *blackview;
}

@property (strong, nonatomic) IBOutlet UIView *mainview;
@property (strong, nonatomic) IBOutlet UIImageView *headerview;
@end

@implementation Listing3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    rightslide = 0;
    
    footerView = [[Footer alloc]init];
    blackview = [[UIView alloc]init];
    
    [footerView setFrame:CGRectMake(0, self.view.frame.size.height - 60, self.view.frame.size.width, 60)];
    
    footerView.footerdelegate=self;
//    [footerView TapCheck:1];
    [self.view addSubview:footerView];
    
    _tableviewlisting3.delegate=self;
    _tableviewlisting3.dataSource=self;
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
        QFProfileViewController *pro = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"profile"];
        [self.navigationController pushViewController:pro animated:NO];
    }
}


- (IBAction)rightMenuBtnTapped:(id)sender
{
    if (rightslide == 0)
    {
        rightView = [[RightMenu alloc]init];
        
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
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Listing3TableViewCell *cell=(Listing3TableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"listing3"];
        
    return cell;
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

@end
