//
//  MPDashBoardViewController.m
//  MYPROPERTY
//
//  Created by Somenath on 08/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "MPDashBoardViewController.h"

@interface MPDashBoardViewController ()
{
    BOOL viewslide;
    UIView *slideview;
    NSInteger check;
}


@property (strong, nonatomic) IBOutlet UIView *blueline;
@end

@implementation MPDashBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    viewslide = 0;
    check = 1;
    
    [_buttonScroll setContentSize:CGSizeMake(880, _buttonScroll.frame.size.height)];
    _buttonScroll.showsHorizontalScrollIndicator = NO;
    
}

- (IBAction)backTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)alertsTapped:(id)sender
{
    check = 1;
    self.subCatgoryView.hidden = NO;
    [self.blueline setFrame:CGRectMake(0, _subCatgoryView.frame.size.height - 5, 150, 3)];
}

- (IBAction)savedTapped:(id)sender
{
    check = 2;
    self.subCatgoryView.hidden = YES;
    [self.blueline setFrame:CGRectMake(155, _subCatgoryView.frame.size.height - 5, 150, 3)];
}

- (IBAction)myPropertyTapped:(id)sender
{
    check = 3;
    self.subCatgoryView.hidden = YES;
    [self.blueline setFrame:CGRectMake(300, _subCatgoryView.frame.size.height - 5, 150, 3)];
}

- (IBAction)myAdvertiseTapped:(id)sender
{
    check = 4;
    self.subCatgoryView.hidden = YES;
    [self.blueline setFrame:CGRectMake(450, _subCatgoryView.frame.size.height - 5, 150, 3)];
}

- (IBAction)registerTapped:(id)sender
{
    check = 5;
    self.subCatgoryView.hidden = YES;
    self.subCatgoryView.hidden = YES;
    [self.blueline setFrame:CGRectMake(620, _subCatgoryView.frame.size.height - 5, 150, 3)];
}

- (IBAction)myDetailTapped:(id)sender
{
    check = 6;
    self.subCatgoryView.hidden = NO;
    [self.blueline setFrame:CGRectMake(770, _subCatgoryView.frame.size.height - 5, 120, 3)];
}

- (IBAction)subcatviewbtn:(id)sender
{
    if (viewslide == 0)
    {
        [_subviewbtn setImage:[UIImage imageNamed:@"up_arrow"] forState:UIControlStateNormal];
        if (check == 1)
        {
            slideview = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width * .7, _headerimg.frame.size.height + self.subCatgoryView.frame.size.height + self.buttonScroll.frame.size.height, self.view.frame.size.width * .29, 200)];
            
            slideview.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
            slideview.layer.borderWidth = 2.0f;
            slideview.layer.cornerRadius = 4.0f;
            slideview.layer.borderColor = [UIColor colorWithRed:74.0f/255 green:133.0f/255.0f blue:219.0f/255.0f alpha:1].CGColor;
            
            
            [self.view addSubview:slideview];
        }
        else if (check == 6)
        {
            slideview = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width * .7, _headerimg.frame.size.height + self.subCatgoryView.frame.size.height + self.buttonScroll.frame.size.height, self.view.frame.size.width * .29, 100)];
            
            slideview.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
            slideview.layer.borderWidth = 2.0f;
            slideview.layer.cornerRadius = 4.0f;
            slideview.layer.borderColor = [UIColor colorWithRed:74.0f/255 green:133.0f/255.0f blue:219.0f/255.0f alpha:1].CGColor;
            [self.view addSubview:slideview];
        }
        viewslide = 1;
    }
    else
    {
        [_subviewbtn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
        [slideview removeFromSuperview];
        viewslide = 0;
    }
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
