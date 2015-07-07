//
//  MPRegisterPropertyViewController.m
//  MYPROPERTY
//
//  Created by Somenath on 03/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "MPRegisterPropertyViewController.h"

@interface MPRegisterPropertyViewController ()

@property (strong, nonatomic) IBOutlet UIScrollView *mainscroll;
@end

@implementation MPRegisterPropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_mainscroll setContentSize:CGSizeMake(self.view.frame.size.width, 800)];
    _mainscroll.showsVerticalScrollIndicator = YES;
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
