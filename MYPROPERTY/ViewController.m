//
//  ViewController.m
//  myProfile
//
//  Created by soumyajit on 02/07/15.
//  Copyright (c) 2015 kausik jati. All rights reserved.
//

#import "ViewController.h"
#import "SearchViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    if(screenBounds.size.height == 667 && screenBounds.size.width == 375)
    {
        NSLog(@"iphone 6");
        _label1.frame = CGRectMake(110, 245, 108, 18);
        [_label1 setFont: [UIFont fontWithName:@"Helvetica Bold" size:17.0]];
        _label2.frame = CGRectMake(214, 245, 108, 18);
         [_label2 setFont: [UIFont fontWithName:@"Helvetica" size:17.0]];
        _label3.frame =CGRectMake(68, 265, 265, 18);
        [_label3 setFont: [UIFont fontWithName:@"Helvetica" size:18.0]];
        _labellogin.frame=CGRectMake(101, 550, 170, 18);
        [_labellogin setFont: [UIFont fontWithName:@"Helvetica Bold" size:13.0]];
    }
    else if(screenBounds.size.height == 736 && screenBounds.size.width == 414)
    {
        NSLog(@"iphone 6+");
        _label1.frame = CGRectMake(120, 270, 108, 18);
        [_label1 setFont: [UIFont fontWithName:@"Helvetica Bold" size:18.0]];
        _label2.frame = CGRectMake(229, 270, 108, 18);
        [_label2 setFont: [UIFont fontWithName:@"Helvetica" size:18.0]];
        _label3.frame =CGRectMake(73, 290, 270, 21);
        [_label3 setFont: [UIFont fontWithName:@"Helvetica" size:19.0]];
        _labellogin.frame=CGRectMake(114, 610, 180, 18);
        [_labellogin setFont: [UIFont fontWithName:@"Helvetica Bold" size:14.0]];
        
    }
}

- (IBAction)loginTapped:(id)sender {
    
    SearchViewController *search = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"searchView"];
    [self.navigationController pushViewController:search animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
