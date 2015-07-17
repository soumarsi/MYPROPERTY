//
//  MPEditMedia.m
//  MYPROPERTY
//
//  Created by Somenath on 14/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "MPEditMedia.h"

@interface MPEditMedia ()

@property (strong, nonatomic) IBOutlet UIScrollView *mainscroll;
@end

@implementation MPEditMedia

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"into edit media controller......");
    NSLog(@"Data dictionary is:------%@",self.data_dictionary);
    
    [self.mainscroll setContentSize:CGSizeMake(self.view.frame.size.width, 640)];
    
    self.dateOfEpcTaken.text = [self.data_dictionary valueForKey:@"date_epc_taken"];
    self.dateOfGasTestTaken.text = [self.data_dictionary valueForKey:@"gas_test_date"];
    self.dateOfElecSafeTestTaken.text = [self.data_dictionary valueForKey:@"elec_safe_test_date"];
    self.gasRegNo.text = [self.data_dictionary valueForKey:@"gas_reg_no"];
    self.certificateSerialNo.text = [self.data_dictionary valueForKey:@"certificate_serial_no"];
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
