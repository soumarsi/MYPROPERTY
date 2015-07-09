//
//  PropertyDetails2ViewController.m
//  MyProperty
//
//  Created by soumyajit on 03/07/15.
//  Copyright (c) 2015 kausik jati. All rights reserved.
//

#import "PropertyDetails2ViewController.h"

@interface PropertyDetails2ViewController ()

@property (strong, nonatomic) IBOutlet UIScrollView *mainscroll;
@end

@implementation PropertyDetails2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_mainscroll setContentSize:CGSizeMake(self.view.frame.size.width, 798)];
}

- (IBAction)backTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
