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
      _Arry1 =[[NSMutableArray alloc]init];
      _Arry2 =[[NSMutableArray alloc]init];
      _Arry3 =[[NSMutableArray alloc]init];
    _Arry4 =[[NSMutableArray alloc]init];
    _Arry5 =[[NSMutableArray alloc]init];
    
    
    picker.tag=1;
    
    NSString *url = [NSString stringWithFormat:@"%@json_output.php?mode=search_values",App_Domain_Url];
    [obj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         
         NSLog(@"result....%@",result);
         NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
         temp = [result mutableCopy];
         _Arry1 = [temp valueForKey:@"type"];
         _Arry1 = [_Arry1 valueForKey:@"type_name"];
         
         _Arry2 = [temp valueForKey:@"radius"];
         _Arry2 = [_Arry2 valueForKey:@"radius_value"];
         
         _Arry3 = [temp valueForKey:@"room"];
         _Arry3 = [_Arry3 valueForKey:@"number_of_rooms"];
         
         _Arry4 = [temp valueForKey:@"price"];
         _Arry4 = [_Arry4 valueForKey:@"price_amount"];
         
         _Arry5 = [temp valueForKey:@"addedtime"];
         _Arry5 = [_Arry5 valueForKey:@"added_value"];
         
         
         NSLog(@"Arry1%@",_Arry1);
         NSLog(@"Array2...%@",_Arry2);
         NSLog(@"Array2...%@",_Arry3);

         
         
         
     }];
    
    
    //int buttonTagIndex = done.tag;
    
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
- (IBAction)backBtn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)btn1:(id)sender {
    holedata = [[NSString alloc]init];
    picker.tag=1;
    picker.dataSource=self;
    picker.delegate=self;
    
    picker.hidden=NO;
    pview.hidden=NO;
    btntag=1;
    
    
}

- (IBAction)btn2:(id)sender {
    holedata = [[NSString alloc]init];
    picker.tag=2;
    picker.dataSource=self;
    picker.delegate=self;
    picker.hidden=NO;
    pview.hidden=NO;
    btntag=2;
    
    //[self Pkrcanclebtn:sender];
    
    
}
- (IBAction)btn3:(id)sender {
    holedata = [[NSString alloc]init];
    picker.tag=3;
    picker.dataSource=self;
    picker.delegate=self;
    picker.hidden=NO;
    pview.hidden=NO;
    btntag=3;
    
    
}
- (IBAction)btn4:(id)sender {
    
    holedata = [[NSString alloc]init];
    picker.tag=4;
    picker.dataSource=self;
    picker.delegate=self;
    picker.hidden=NO;
    pview.hidden=NO;
    btntag=4;
    
}
- (IBAction)btn5:(id)sender {
    
    holedata = [[NSString alloc]init];
    picker.tag=5;
    picker.dataSource=self;
    picker.delegate=self;
    picker.hidden=NO;
    pview.hidden=NO;
    btntag=5;
    
}


- (IBAction)Pkrcanclebtn:(id)sender {
    
    holedata = [[NSString alloc]init];
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
    
    if (picker.tag==1) {
        
        return _Arry1.count;
    }
    
    else if (picker.tag==2)
    {
        return _Arry2.count;
    }
    
    else if (picker.tag==3)
    {
        return _Arry3.count;
    }
    
    else if (picker.tag==4)
    {
        return _Arry4.count;
    }
    
    else if (picker.tag==5)
    {
        return _Arry5.count;
    }
    
    else
        return 0;
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)
component
{
   
    if (picker.tag==1) {
        
         return _Arry1[row];
    }
    else if (picker.tag==2)
    {
        return _Arry2[row];
        
    }

    
    else if (picker.tag==3)
    {
        return _Arry3[row];
        
    }
   else if (picker.tag==4)
   {
       return _Arry4[row];
       
   }
   else if (picker.tag==5)
   {
       return _Arry5[row];
       
   }
 
    
    else
    {
        return 0;
    }
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    if (picker.tag==1) {
        
        holedata = [[NSString alloc] initWithFormat:
                    @"%@", [_Arry1 objectAtIndex:row]];
        NSLog(@"%@", holedata);
    }
    else if (picker.tag==2)
        
    {
        holedata = [[NSString alloc] initWithFormat:
                    @"%@", [_Arry2 objectAtIndex:row]];
        NSLog(@"%@", holedata);
    }

    
    else if (picker.tag==3)
        
    {
        holedata = [[NSString alloc] initWithFormat:
                    @"%@", [_Arry3 objectAtIndex:row]];
        NSLog(@"%@", holedata);
    }
    
   else if (picker.tag==4)
       
   {
       holedata = [[NSString alloc] initWithFormat:
                   @"%@", [_Arry4 objectAtIndex:row]];
       NSLog(@"%@", holedata);
   }
   else if (picker.tag==5)
       
   {
       holedata = [[NSString alloc] initWithFormat:
                   @"%@", [_Arry5 objectAtIndex:row]];
       NSLog(@"%@", holedata);
   }
 
    
    else
    {
        holedata = [[NSString alloc] initWithFormat:
                    @"%@", [_Arry1 objectAtIndex:row]];
        NSLog(@"%@", holedata);
    }
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end

