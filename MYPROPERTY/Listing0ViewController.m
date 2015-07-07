//
//  Listing0ViewController.m
//  MyProperty
//
//  Created by soumyajit on 03/07/15.
//  Copyright (c) 2015 kausik jati. All rights reserved.
//

#import "Listing0ViewController.h"
#import "Listing3ViewController.h"

@interface Listing0ViewController ()

@end

@implementation Listing0ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    obj = [[FW_JsonClass alloc]init];
    
    NSString *url = [NSString stringWithFormat:@"%@json_output.php?mode=property_type",App_Domain_Url];
    [obj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         
         _Arry1 =[[NSMutableArray alloc]init];
         
         
         _Arry1 = [result valueForKey:@"type_name"];
         
         
         NSLog(@"Arry1%@",_Arry1);
         
         
     }];
    
    
    int buttonTagIndex = done.tag;
    
    pview.hidden=YES;
    picker.hidden=YES;
    
    
    
    
    [myView setBackgroundColor:[UIColor colorWithRed:31/255.0 green:55/255.0 blue:97/255.0 alpha:1]];
    [self viewCorrection];
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

-(void)viewCorrection
{
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    if(screenBounds.size.height == 667 && screenBounds.size.width == 375)
    {
        
        myView.frame = CGRectMake(0, 0, 375, 67);
        
        
    }
    else if(screenBounds.size.height == 736 && screenBounds.size.width == 414)
    {
        
        myView.frame = CGRectMake(0, 0, 414, 67);
        
        
    }
    
    
    
    
}
- (IBAction)btn1:(id)sender {
    
    picker.dataSource=self;
    picker.delegate=self;
    
    picker.hidden=NO;
    pview.hidden=NO;
    btntag=1;
    
    
}

- (IBAction)btn2:(id)sender {
    
    picker.dataSource=self;
    picker.delegate=self;
    picker.hidden=NO;
    pview.hidden=NO;
    btntag=2;
    
    //[self Pkrcanclebtn:sender];
    
    
}
- (IBAction)btn3:(id)sender {
    
    picker.dataSource=self;
    picker.delegate=self;
    picker.hidden=NO;
    pview.hidden=NO;
    btntag=3;
    
    
}
- (IBAction)btn4:(id)sender {
    
    picker.dataSource=self;
    picker.delegate=self;
    picker.hidden=NO;
    pview.hidden=NO;
    btntag=4;
    
}
- (IBAction)btn5:(id)sender {
    
    picker.dataSource=self;
    picker.delegate=self;
    picker.hidden=NO;
    pview.hidden=NO;
    btntag=5;
    
}


- (IBAction)Pkrcanclebtn:(id)sender {
    
    
    picker.dataSource=self;
    picker.delegate=self;
    picker.hidden=YES;
    pview.hidden=YES;
    
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 1;
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    
    return _Arry1.count;
    
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)
component
{
    NSLog(@"picker ...%@",_Arry1);
    
    return _Arry1[row];
    
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    
    holedata = [[NSString alloc] initWithFormat:
                @"%@", [_Arry1 objectAtIndex:row]];
    NSLog(@"%@", holedata);
    
    
}


- (IBAction)done:(id)sender
{
    if (btntag==1) {
        lbl1.text=holedata;
    }
    else if (btntag==2)
    {
        lbl2.text=holedata;
    }
    else if (btntag==3)
    {
        lbl3.text=holedata;
    }
    
    else if (btntag==4)
    {
        lbl4.text=holedata;
    }
    else if (btntag==5)
    {
        lbl5.text=holedata;
    }
    picker.hidden=YES;
    pview.hidden=YES;
    
}
- (IBAction)searchTapped:(id)sender
{
    Listing3ViewController *list = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"list3"];
    [self.navigationController pushViewController:list animated:YES];
}


@end

