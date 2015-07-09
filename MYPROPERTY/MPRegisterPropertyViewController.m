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
    
    [_mainscroll setContentSize:CGSizeMake(self.view.frame.size.width, 950)];
    
    _mainscroll.showsVerticalScrollIndicator = YES;
    
    [pview setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:1]];
    
    
    //    myPickerView = [[UIPickerView alloc] init];
    
    //    myPickerView.frame = CGRectMake(0, 638, 162,320);
    
    //myPickerView.tag = i;
    
    //    myPickerView.delegate = self;
    
    //    myPickerView.showsSelectionIndicator = YES;
    
    Array_1 = [[NSMutableArray alloc] init];
    
    
    
    // Add some data for demo purposes.
    
    [Array_1 addObject:@"Manager"];
    
    [Array_1 addObject:@"Owner"];
    
    [Array_1 addObject:@"Tenant"];
    
    
    
    Array_2 = [[NSMutableArray alloc] init];
    
    
    
    // Add some data for demo purposes.
    
    [Array_2 addObject:@"Bungalows"];
    
    [Array_2 addObject:@"Commercial Property"];
    
    [Array_2 addObject:@"Flat/Amartment"];
    
    [Array_2 addObject:@"Houses"];
    
    [Array_2 addObject:@"Land"];
    
    
    Array_3 = [[NSMutableArray alloc] init];
    
    [Array_3 addObject:@"Availbe"];
    
    [Array_3 addObject:@"Rented"];
    
    Array_4 = [[NSMutableArray alloc] init];
    
    [Array_4 addObject:@"1"];
    
    [Array_4 addObject:@"2"];
    
    [Array_4 addObject:@"3"];
    
    [Array_4 addObject:@"4"];
    
    [Array_4 addObject:@"5"];
    
    
    
    myPickerView.tag=1;
    
    myPickerView.hidden=YES;
    pview.hidden=YES;
    CGRect scr= pview.frame;
    
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
        
    {
        scr.origin.y=self.view.bounds.size.height-scr.size.height;
        pview.frame=scr;
    }
    else if (screenBounds.size.height == 667  && screenBounds.size.width == 375)
    {
        scr.origin.y=self.view.bounds.size.height-scr.size.height;
        pview.frame=scr;
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



- (IBAction)btn1:(id)sender {
    holedata=[[NSString alloc]init];
    myPickerView.tag=1;
    myPickerView.hidden=NO;
    pview.hidden=NO;
    myPickerView.dataSource = self;
    myPickerView.delegate = self;
    _mainscroll.scrollEnabled=NO;
    btntag=1;
    
    
    
}

- (IBAction)btn2:(id)sender {
    holedata=[[NSString alloc]init];
    myPickerView.tag=2;
    myPickerView.hidden=NO;
    pview.hidden=NO;
    myPickerView.dataSource = self;
    myPickerView.delegate = self;
    
    _mainscroll.scrollEnabled=NO;
    btntag=2;
    
}
- (IBAction)btn3:(id)sender {
    holedata=[[NSString alloc]init];
    myPickerView.tag=3;
    myPickerView.hidden=NO;
    pview.hidden=NO;
    myPickerView.dataSource = self;
    myPickerView.delegate = self;
    
    _mainscroll.scrollEnabled=NO;
    btntag=3;
    
}
- (IBAction)btn4:(id)sender {
    holedata=[[NSString alloc]init];
    myPickerView.tag=4;
    myPickerView.hidden=NO;
    pview.hidden=NO;
    myPickerView.dataSource = self;
    myPickerView.delegate = self;
    
    _mainscroll.scrollEnabled=NO;
    btntag=4;
    
}
- (IBAction)btn5:(id)sender {
    holedata=[[NSString alloc]init];
    myPickerView.tag=5;
    myPickerView.hidden=NO;
    pview.hidden=NO;
    myPickerView.dataSource = self;
    myPickerView.delegate = self;
    
    _mainscroll.scrollEnabled=NO;
    btntag=5;
    
}
- (IBAction)btn6:(id)sender {
    holedata=[[NSString alloc]init];
    myPickerView.tag=6;
    myPickerView.hidden=NO;
    pview.hidden=NO;
    myPickerView.dataSource = self;
    myPickerView.delegate = self;
    
    _mainscroll.scrollEnabled=NO;
    btntag=6;
    CGPoint pt;
    
    CGRect rc=[_mainscroll bounds];
    rc=[_mainscroll convertRect:rc toView:_mainscroll];
    
    pt=rc.origin;
    pt.x=0;
    pt.y+=230;
    [_mainscroll setContentOffset:pt animated:YES];
    
    [self.view addSubview:pview];
    [pview addSubview:myPickerView];
    
}









//picker View delegate and data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    
    
    return 1;
    
    
    
}



- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component {
    
    
    
    
    
    if ( myPickerView.tag==1) // this is otherPickerview
        
    {
        
        return [Array_1 count];
        
        
        
        
        
    }
    
    else if(myPickerView.tag==2)
        
    {
        
        return [Array_2 count];
        
    }
    
    else if (myPickerView.tag==3)
    {
        return [Array_3 count];
    }
    else if (pickerView.tag==4 || pickerView.tag==5 || pickerView.tag==6)
        
    {
        return Array_4.count;
    }
    
    else
        return 0;
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)

component

{
    
    if (pickerView.tag==1) {
        
        
        return Array_1[row];
        
    }
    
    else if (pickerView.tag==2)
        
    {
        
        return Array_2[row];
        
    }
    
    
    else if (pickerView.tag==3)
        
    {
        
        return Array_3[row];
        
    }
    
    else if (pickerView.tag==4 || pickerView.tag==5 || pickerView.tag==6)
        
    {
        
        return Array_4[row];
        
    }
    
    else
        return 0;
    
    
    
    
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    if (pickerView.tag==1) {
        
        
        holedata = [[NSString alloc] initWithFormat:
                    @"%@", [Array_1 objectAtIndex:row]];
        NSLog(@"%@", holedata);
    }
    
    else if (pickerView.tag==2)
        
    {
        
        holedata = [[NSString alloc] initWithFormat:
                    @"%@", [Array_2 objectAtIndex:row]];
        NSLog(@"%@", holedata);
    }
    
    
    else if (pickerView.tag==3)
        
    {
        
        holedata = [[NSString alloc] initWithFormat:
                    @"%@", [Array_3 objectAtIndex:row]];
        NSLog(@"%@", holedata);
        
    }
    
    else if (pickerView.tag==4 || pickerView.tag==5 || pickerView.tag==6)
        
    {
        
        holedata = [[NSString alloc] initWithFormat:
                    @"%@", [Array_4 objectAtIndex:row]];
        NSLog(@"%@", holedata);
        
    }
    
    
    
}


- (IBAction)done:(id)sender
{
    if (btntag==1) {
        relationProperty.text=holedata;
    }
    else if (btntag==2)
    {
        propertytypelbl.text=holedata;
    }
    else if (btntag==3)
    {
        currentstatus.text=holedata;
    }
    
    else if (btntag==4)
    {
        noofbed.text=holedata;
    }
    else if (btntag==5)
    {
        noofroom.text=holedata;
    }
    else if (btntag==6)
    {
        noofbath.text=holedata;
        
    }
    myPickerView.hidden=YES;
    pview.hidden=YES;
    _mainscroll.scrollEnabled=YES;
    
}


-(IBAction)cancel:(id)sender
{
    pview.hidden=YES;
    _mainscroll.scrollEnabled=YES;
    
}



@end

