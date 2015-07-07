//
//  SignupViewController.m
//  MYPROPERTY
//
//  Created by soumyajit on 06/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "SignupViewController.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)signupback:(id)sender
{
    NSLog(@"Tap");
//    ViewController *home=(ViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:Nil]instantiateViewControllerWithIdentifier:@"mainviewcontroller"];
//    [self.navigationController pushViewController:home animated:YES];

    [self.navigationController popToRootViewControllerAnimated:YES];
}



@end
