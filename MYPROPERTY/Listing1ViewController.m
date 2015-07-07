//
//  Listing1ViewController.m
//  MyProperty
//
//  Created by soumyajit on 03/07/15.
//  Copyright (c) 2015 kausik jati. All rights reserved.
//

#import "Listing1ViewController.h"

@interface Listing1ViewController ()

@end

@implementation Listing1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    Arry2 = [[NSArray alloc]init];
    Arry1 = [[NSArray alloc]init];
    Arry1=@[@"1",@"2",@"3",@"4",@"5"];
    Arry2=@[@"A",@"B",@"C",@"D",@"E",@"F"];
    Arry1=[Arry1 sortedArrayUsingSelector:@selector(compare:)];
    Arry2=[Arry2 sortedArrayUsingSelector:@selector(compare:)];
    pview.hidden=YES;
    
   // picker.delegate=self;
  //  picker.dataSource= self;
//    picker = [[UIPickerView alloc]init];
//    picker.frame=CGRectMake(30, 500 ,300 , 100);
//    
//    [self.view addSubview:picker];
    picker.hidden=YES;
    
    
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

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component==_kARRY1)
    {
        return [Arry1 count];
    }
    
    
    else
    {
        return [Arry2 count];
        
    }
    
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component==_kARRY1)
        return Arry1[row];
    else
        return Arry2[row];
}
- (IBAction)btn1:(id)sender {
    
    picker.hidden=NO;
    pview.hidden=NO;

    
}

- (IBAction)btn2:(id)sender {
    
    picker.hidden=NO;
    pview.hidden=NO;
    //[self Pkrcanclebtn:sender];
    
    
}
- (IBAction)btn3:(id)sender {
    
    picker.hidden=NO;
    pview.hidden=NO;
    
    
}
- (IBAction)btn4:(id)sender {
    
    picker.hidden=NO;
    pview.hidden=NO;
    
    
}
- (IBAction)btn5:(id)sender {
    
    picker.hidden=NO;
    pview.hidden=NO;
    
    
}
- (IBAction)btn6:(id)sender {
    
    picker.hidden=NO;
    pview.hidden=NO;
    
    
}

- (IBAction)Pkrcanclebtn:(id)sender {
    picker.hidden=YES;
    pview.hidden=YES;


}


@end
