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


@interface MPNotificationViewController () <UITableViewDataSource,UITabBarDelegate,footerdelegate>

@end

@implementation MPNotificationViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Footer *footer=[[Footer alloc]init];
    
    [footer setFrame:CGRectMake(0, self.view.frame.size.height - 60, self.view.frame.size.width, 60)];
    
    footer.footerdelegate=self;
    [footer TapCheck:4];
    [self.view addSubview:footer];
    
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

@end
