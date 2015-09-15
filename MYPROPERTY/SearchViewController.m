//
//  SearchViewController.m
//  MyProperty
//
//  Created by soumyajit on 03/07/15.
//  Copyright (c) 2015 kausik jati. All rights reserved.
//
#import "SearchViewController.h"
#import "Listing0ViewController.h"
#import "MPRegisterPropertyViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self labelCorrection];
    check =@"srch";
    
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

-(void)labelCorrection
{
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    if(screenBounds.size.height == 667 && screenBounds.size.width == 375)
    {
        
        lbl1.frame = CGRectMake(110, 270, 108, 18);
        lbl3.frame =CGRectMake(68, 290, 250, 18);
        lbl2.frame = CGRectMake(215, 270, 108, 18);
        
    }
    else if(screenBounds.size.height == 736 && screenBounds.size.width == 414)
    {
        
        lbl1.frame = CGRectMake(120  , 300, 108, 20);
        lbl3.frame =CGRectMake(78, 320, 270, 20);
        lbl2.frame = CGRectMake(230, 300, 109, 20);
        
        [lbl1 setFont: [UIFont fontWithName:@"Helvetica Bold" size:18.0]];
        
        [lbl2 setFont: [UIFont fontWithName:@"Helvetica" size:18.0]];
        
        [lbl3 setFont: [UIFont fontWithName:@"Helvetica" size:18.0]];
        
        
    }
    
    
    
    
}
- (IBAction)buyMeTapped:(id)sender
{
    Listing0ViewController *list = (Listing0ViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"list0"];
    list.srchtype=@"S";
    
    list.check=check;
    
    [self.navigationController pushViewController:list animated:YES];
}
- (IBAction)rentMeTpped:(id)sender
{
    Listing0ViewController *list = (Listing0ViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"list0"];
    list.srchtype=@"R";
    list.check=check;
    
    [self.navigationController pushViewController:list animated:YES];
}
- (IBAction)letMeTapped:(id)sender
{
    MPRegisterPropertyViewController *list = (MPRegisterPropertyViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"registerproperty"];
    [self.navigationController pushViewController:list animated:YES];
}

- (IBAction)saleTapped:(id)sender
{
    MPRegisterPropertyViewController *list = (MPRegisterPropertyViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"registerproperty"];
    [self.navigationController pushViewController:list animated:YES];
}

@end
