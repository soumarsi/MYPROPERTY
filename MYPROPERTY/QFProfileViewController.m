//
//  QFProfileViewController.m
//  MYPROPERTY
//
//  Created by Somenath on 03/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "QFProfileViewController.h"
#import "Footer.h"

@interface QFProfileViewController ()<footerdelegate>

@end

@implementation QFProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
    
    Footer *footer=[[Footer alloc]init];
    
//    [footer setFrame:CGRectMake(0, self.view.frame.size.height - 60, self.view.frame.size.width, 60)];
    
    footer.footerdelegate=self;
    [footer TapCheck:5];
//    [self.view addSubview:footer];

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
