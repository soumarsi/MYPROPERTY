//

//  MPRegisterPropertyViewController.m

//  MYPROPERTY

//

//  Created by Somenath on 03/07/15.

//  Copyright (c) 2015 Esolz. All rights reserved.

//



#import "MPRegisterPropertyViewController.h"
#import "Footer.h"



@interface MPRegisterPropertyViewController ()



@property (strong, nonatomic) IBOutlet UIScrollView *mainscroll;

@end



@implementation MPRegisterPropertyViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];
    obj = [[FW_JsonClass alloc]init];
    _pincodeArray = [[NSMutableArray alloc]init];
    arry = [[NSMutableArray alloc]init];
    Footer *footerView = [[Footer alloc]init];
    [footerView TapCheck:3];
    pickarry = [[NSArray alloc]init];
    
    dict = [[NSMutableDictionary alloc]init];
    
    
    _mainscroll.showsHorizontalScrollIndicator=NO;
    _mainscroll.showsVerticalScrollIndicator = NO;
    
    // Do any additional setup after loading the view.
    
    [_mainscroll setContentSize:CGSizeMake(self.view.frame.size.width, 922)];
    
    _mainscroll.showsVerticalScrollIndicator = YES;
    
    [pview setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:1]];
    _picCodesrch.delegate=self;
    
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
    
    
    [parking addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
    
    [gardenflg addTarget:self action:@selector(changeSwitch1:) forControlEvents:UIControlEventValueChanged];
    parkingflg=@"N";
    gardenflag=@"N";
    
    
    
    
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
    
    UIColor *color = [UIColor colorWithRed:36.0f/255.0f green:36.0f/255.0f blue:36.0f/255.0f alpha:1.0f];
    
    _picCodesrch.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter post code" attributes:@{NSForegroundColorAttributeName: color}];
    
    
}

- (void)changeSwitch:(id)sender{
    
    
    if([sender isOn]){
        parkingflg=@"Y";
        
    }
    else
    {
        parkingflg= @"N";
    }
}
- (void)changeSwitch1:(id)sender{
    
    if([sender isOn]){
        gardenflag=@"Y";
    } else{
        gardenflag = @"N";
    }
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
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    btn1.hidden=NO;
    btn2.hidden=NO;
    btn3.hidden=NO;
    btn4.hidden=NO;
    btn5.hidden=NO;
    btn6.hidden=NO;
    
    //    CGRect rc=[_mainscroll bounds];
    //    CGPoint pt;
    //    rc=[_mainscroll convertRect:rc toView:_mainscroll];
    
    //    pt=rc.origin;
    //    pt.x=0;
    //    pt.y=0;
    //    [_mainscroll setContentOffset:pt animated:YES];
    [textField resignFirstResponder];
    _mainscroll.scrollEnabled=YES;
    return YES;
}


- (IBAction)pincodeDonebtn:(id)sender
{
    [self.view addSubview:pview];
    [pview addSubview:myPickerView];
    
    if (_picCodesrch.text.length==6)
    {
        
        UIView *polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
        polygonView.backgroundColor=[UIColor blackColor];
        polygonView.alpha=0.3;
        [self.view addSubview:polygonView];
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
        
        [polygonView addSubview:spinner];
        
        
        NSString *data = [NSString stringWithFormat:@"%@",[_picCodesrch text]];
        NSLog(@"data%@",data);
        NSString *pinurl = [NSString stringWithFormat:@"https://api.getaddress.io/v2/uk/%@?api-key=H3JfLc3p4EyGk_vZ1gNJjg1041",data];
        [spinner startAnimating];
        [obj GlobalDict:pinurl Globalstr:@"array" Withblock:^(id result, NSError *error)
         {
             [_picCodesrch resignFirstResponder];
             
             if ([[result valueForKey:@"Message"] isEqualToString:@"Bad Request"]) {
                 
                 
                 
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                 message:@"Pincode Not found"
                                                                delegate:self
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil];
                 [alert show];
                 
                 
             }
             
             else
             {
                 
                 [dict setObject:[result valueForKey:@"Latitude"] forKey:@"Latitude"];
                 [dict setObject:[result valueForKey:@"Longitude"] forKey:@"Longitude"];
                 
                 _pincodeArray = [result valueForKey:@"Addresses"];
                 // NSLog(@"Pincode%@",_pincodeArray);
                 for (int i=0; i<_pincodeArray.count; i++) {
                     
                     
                     
                     //             if ([_pincodeArray[i] containsString:@","]) {
                     NSString *check = [NSString stringWithFormat:@", , , , , "];
                     
                     NSString *temp  = [NSString stringWithFormat:@"%@",_pincodeArray[i]];
                     
                     //  NSString *addrs = [NSString stringWithFormat:@"1 Quaves Road, , , , , Slough, Berkshire"];
                     newAddress=[temp stringByReplacingOccurrencesOfString:check withString:@","];
                     
                     
                     // NSLog(@"working..............%@",newAddress);
                     
                     [arry insertObject:newAddress atIndex:i];
                     
                     //
                     //                 [_pincodeArray[i] addObject:newAddress];
                     //                 NSLog(@"pin%@",_pincodeArray);
                     
                     
                     
                 }
                 
                 NSLog(@"arry ....%@",arry);
                 
                 myPickerView.tag=10;
                 btntag=10;
                 myPickerView.hidden=NO;
                 pview.hidden=NO;
                 myPickerView.dataSource = self;
                 myPickerView.delegate = self;
                 pincodelbl.text =_picCodesrch.text;
                 
             }
             // }
             [spinner stopAnimating];
             [spinner removeFromSuperview];
             [polygonView removeFromSuperview];
         }];
        
        
        
        
        
        
        
    }
    
    
    
    
    else
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Pincode Not found"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    
}

- (IBAction)btn1:(id)sender {
    holedata=[[NSString alloc]init];
    holedata=[Array_1 objectAtIndex:0];
    myPickerView.tag=1;
    myPickerView.hidden=NO;
    pview.hidden=NO;
    myPickerView.dataSource = self;
    myPickerView.delegate = self;
    _mainscroll.scrollEnabled=NO;
    btntag=1;
    
    btn1.hidden=YES;
    btn2.hidden=NO;
    btn3.hidden=NO;
    btn4.hidden=NO;
    btn5.hidden=NO;
    btn6.hidden=NO;
    [myPickerView selectRow:0 inComponent:0 animated:YES];
    
    
    [_picCodesrch resignFirstResponder];
    [propertyfulldescription resignFirstResponder ];
    [propertysummary resignFirstResponder];
}

- (IBAction)btn2:(id)sender {
    
    [_picCodesrch resignFirstResponder];
    [propertyfulldescription resignFirstResponder ];
    [propertysummary resignFirstResponder];
    holedata=[[NSString alloc]init];
    holedata=[Array_2 objectAtIndex:0];
    myPickerView.tag=2;
    myPickerView.hidden=NO;
    pview.hidden=NO;
    myPickerView.dataSource = self;
    myPickerView.delegate = self;
    
    
    btn1.hidden=NO;
    btn2.hidden=YES;
    btn3.hidden=NO;
    btn4.hidden=NO;
    btn5.hidden=NO;
    btn6.hidden=NO;
    [myPickerView selectRow:0 inComponent:0 animated:YES];
    
    [_picCodesrch resignFirstResponder];
    
    _mainscroll.scrollEnabled=NO;
    
    
    btntag=2;
    
}
- (IBAction)btn3:(id)sender {
    
    [_picCodesrch resignFirstResponder];
    [propertyfulldescription resignFirstResponder ];
    [propertysummary resignFirstResponder];
    holedata=[[NSString alloc]init];
    holedata=[Array_3 objectAtIndex:0];
    myPickerView.tag=3;
    myPickerView.hidden=NO;
    pview.hidden=NO;
    myPickerView.dataSource = self;
    myPickerView.delegate = self;
    
    [myPickerView selectRow:0 inComponent:0 animated:YES];
    
    
    
    btn1.hidden=NO;
    btn2.hidden=NO;
    btn3.hidden=YES;
    btn4.hidden=NO;
    btn5.hidden=NO;
    btn6.hidden=NO;
    
    _mainscroll.scrollEnabled=NO;
    btntag=3;
    [_picCodesrch resignFirstResponder];
    
}
- (IBAction)btn4:(id)sender {
    [_picCodesrch resignFirstResponder];
    [propertyfulldescription resignFirstResponder ];
    [propertysummary resignFirstResponder];
    holedata=[[NSString alloc]init];
    holedata=[Array_4 objectAtIndex:0];
    myPickerView.tag=4;
    myPickerView.hidden=NO;
    pview.hidden=NO;
    myPickerView.dataSource = self;
    myPickerView.delegate = self;
    [_picCodesrch resignFirstResponder];
    _mainscroll.scrollEnabled=NO;
    btntag=4;
    
    btn1.hidden=NO;
    btn2.hidden=NO;
    btn3.hidden=NO;
    btn4.hidden=YES;
    btn5.hidden=NO;
    btn6.hidden=NO;
    [myPickerView selectRow:0 inComponent:0 animated:YES];
    
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    if(screenBounds.size.height == 667  && screenBounds.size.width == 375)
        
    {
        CGRect rc=[_mainscroll bounds];
        CGPoint pt;
        rc=[_mainscroll convertRect:rc toView:_mainscroll];
        
        pt=rc.origin;
        pt.x=0;
        pt.y=100;
        [_mainscroll setContentOffset:pt animated:YES];
        
        
    }
    else
    {
        CGRect rc=[_mainscroll bounds];
        CGPoint pt;
        rc=[_mainscroll convertRect:rc toView:_mainscroll];
        
        pt=rc.origin;
        pt.x=0;
        pt.y=200;
        [_mainscroll setContentOffset:pt animated:YES];
        
    }
    [self.view addSubview:pview];
    [pview addSubview:myPickerView];
}
- (IBAction)btn5:(id)sender {
    _mainscroll.scrollEnabled=YES;
    [_picCodesrch resignFirstResponder];
    [propertyfulldescription resignFirstResponder ];
    [propertysummary resignFirstResponder];
    holedata=[[NSString alloc]init];
    holedata=[Array_4 objectAtIndex:0];
    myPickerView.tag=5;
    myPickerView.hidden=NO;
    pview.hidden=NO;
    myPickerView.dataSource = self;
    myPickerView.delegate = self;
    [myPickerView selectRow:0 inComponent:0 animated:YES ];
    
    btntag=5;
    
    
    btn1.hidden=NO;
    btn2.hidden=NO;
    btn3.hidden=NO;
    btn4.hidden=NO;
    btn5.hidden=YES;
    btn6.hidden=NO;
    
    
    //    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    //    if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
    //
    //    {
    //        CGRect rc=[_mainscroll bounds];
    //        CGPoint pt;
    //        rc=[_mainscroll convertRect:rc toView:_mainscroll];
    //
    //        pt=rc.origin;
    //        pt.x=0;
    //        pt.y+=200;
    //        [_mainscroll setContentOffset:pt animated:YES];
    //
    //    }
    //    else
    //    {
    //        CGRect rc=[_mainscroll bounds];
    //        CGPoint pt;
    //        rc=[_mainscroll convertRect:rc toView:_mainscroll];
    //
    //        pt=rc.origin;
    //        pt.x=0;
    //        pt.y+=100;
    //        [_mainscroll setContentOffset:pt animated:YES];
    //
    //
    //    }
    
    [self.view addSubview:pview];
    [pview addSubview:myPickerView];
    
    
    
}
- (IBAction)btn6:(id)sender {
    
    [_picCodesrch resignFirstResponder];
    [propertyfulldescription resignFirstResponder ];
    [propertysummary resignFirstResponder];
    holedata=[[NSString alloc]init];
    holedata=[Array_4 objectAtIndex:0];
    myPickerView.tag=6;
    myPickerView.hidden=NO;
    pview.hidden=NO;
    myPickerView.dataSource = self;
    myPickerView.delegate = self;
    [_picCodesrch resignFirstResponder];
    _mainscroll.scrollEnabled=YES;
    btntag=6;
    
    btn1.hidden=NO;
    btn2.hidden=NO;
    btn3.hidden=NO;
    btn4.hidden=NO;
    btn5.hidden=NO;
    btn6.hidden=YES;
    
    [myPickerView selectRow:0 inComponent:0 animated:YES];
    
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 667  && screenBounds.size.width == 375) {
        CGPoint pt1;
        
        CGRect rc1=[_mainscroll bounds];
        rc1=[_mainscroll convertRect:rc1 toView:_mainscroll];
        
        pt1=rc1.origin;
        pt1.x=0;
        pt1.y=100;
        [_mainscroll setContentOffset:pt1 animated:YES];
    }
    else  if (screenBounds.size.height == 568  && screenBounds.size.width == 320) {
        CGPoint pt1;
        
        CGRect rc1=[_mainscroll bounds];
        rc1=[_mainscroll convertRect:rc1 toView:_mainscroll];
        
        pt1=rc1.origin;
        pt1.x=0;
        pt1.y=270;
        [_mainscroll setContentOffset:pt1 animated:YES];
    }
    
    [self.view addSubview:pview];
    [pview addSubview:myPickerView];
    
}

- (IBAction)next:(id)sender
{
    if (relationProperty.text.length==0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Relationship to property" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
    else if (propertytypelbl.text.length==0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Property Type" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
    else if (currentstatus.text.length==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Current Status" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
    //    else if ([addresslbl.text isEqualToString:@"ADDRESS LINE"])
    //    {
    //
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Address Line " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //
    //        [alert show];
    //    }
    else if (noofbed.text.length==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Number of Bedrooms" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
    else if (noofbath.text.length==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Number of Bathrooms" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
    else if (noofroom.text.length==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Number of Bathrooms" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
    else if (propertysummary.text.length==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Property Summary Description" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
    else if (propertyfulldescription.text.length==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Property Full Description" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
    
    
    else
    {
        
        [dict setObject:relationProperty.text forKey:@"rel_to_property"];
        [dict setObject:propertytypelbl.text forKey:@"property_type"];
        [dict setObject:currentstatus.text forKey:@"current_status"];
        [dict setObject:addresslbl.text forKey:@"address1"];
        [dict setObject:townlbl.text forKey:@"town"];
        [dict setObject:countylbl.text forKey:@"county"];
        [dict setObject:pincodelbl.text forKey:@"postcode"];
        [dict setObject:addresslbl.text forKey:@"display_addr"];
        [dict setObject:noofbed.text forKey:@"no_of_beds"];
        [dict setObject:noofbath.text forKey:@"no_of_baths"];
        [dict setObject:noofroom.text forKey:@"no_of_rooms"];
        [dict setObject:propertysummary.text forKey:@"property_description"];
        [dict setObject:propertyfulldescription.text forKey:@"property_full_description"];
        [dict setObject:parkingflg forKey:@"off_strt_parkng_flag"];
        [dict setObject:gardenflag forKey:@"garden_flag"];
        
        UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        PropertyMediaViewController *media =(PropertyMediaViewController  *)[story instantiateViewControllerWithIdentifier:@"propertymedia"];
        
        
        
        
        
        
        
        
        
        
        
        
        
        media.self.firstdic=[dict mutableCopy];
        
        
        
        
        [self.navigationController pushViewController:media animated:YES];
    }
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
        //[myPickerView reloadAllComponents];
        return [Array_3 count];
    }
    else if (pickerView.tag==4 || pickerView.tag==5 || pickerView.tag==6)
        
    {
        return Array_4.count;
    }
    
    else
        return arry.count;
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
        // [myPickerView reloadAllComponents];
        return Array_3[row];
        
    }
    
    else if (pickerView.tag==4 || pickerView.tag==5 || pickerView.tag==6)
        
    {
        //[myPickerView reloadAllComponents];
        return Array_4[row];
        
    }
    
    else if (pickerView.tag==10)
    {
        //[myPickerView reloadAllComponents];
        return arry[row];
        
        
    }
    
    return nil;
    
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
    else  if(pickerView.tag == 10)
    {
        //        data1= [[NSString alloc] initWithFormat:
        //                    @"%@", [arry objectAtIndex:row]];
        //        data2=data1;
        //        data3=data2;
        //        NSLog(@"data1.......%@",data1);
        //        NSLog(@"data2.......%@",data2);
        //        NSLog(@"data3.......%@",data3);
        
        holddata = [arry objectAtIndex:row];
        
        
        NSLog(@"pickerarry...%@",holddata);
        
        
    }
    
    
    
}

/*- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
 
 
 
 
 
 
 
 
 
 if (btntag==10  && pickerView.tag==10)
 {
 UILabel* tView = (UILabel*)view;
 
 if (!tView){
 tView = [[UILabel alloc] init];
 // Setup label properties - frame, font, colors etc
 
 [tView setFont:[UIFont fontWithName:@"Open Sans" size:20]];
 tView.textAlignment = NSTextAlignmentCenter;
 tView.backgroundColor = [UIColor clearColor];
 }
 
 
 
 tView.text = [arry objectAtIndex:row];
 
 
 
 return tView;
 }
 
 else
 {
 if (btntag==1 && pickerView.tag==1) {
 UILabel* tView = (UILabel*)view;
 if (!tView){
 tView = [[UILabel alloc] init];
 
 tView.backgroundColor = [UIColor clearColor];
 [tView setFont:[UIFont fontWithName:@"Open Sans" size:24]];
 tView.textAlignment = NSTextAlignmentCenter;
 }
 
 
 
 tView.text = [Array_1 objectAtIndex:row];
 
 
 
 return tView;
 
 }
 
 else if (btntag==2 && pickerView.tag==2)
 {
 UILabel* tView = (UILabel*)view;
 if (!tView){
 tView = [[UILabel alloc] init];
 // Setup label properties - frame, font, colors etc
 
 [tView setFont:[UIFont fontWithName:@"Open Sans" size:24]];
 tView.textAlignment = NSTextAlignmentCenter;
 tView.backgroundColor = [UIColor clearColor];
 }
 
 
 
 tView.text = [Array_2 objectAtIndex:row];
 
 
 
 return tView;
 }
 else if (btntag==3  && pickerView.tag==3)
 {
 UILabel* tView = (UILabel*)view;
 
 if (!tView){
 tView = [[UILabel alloc] init];
 // Setup label properties - frame, font, colors etc
 
 [tView setFont:[UIFont fontWithName:@"Open Sans" size:24]];
 tView.textAlignment = NSTextAlignmentCenter;
 tView.backgroundColor = [UIColor clearColor];
 }
 
 
 
 tView.text = [Array_3 objectAtIndex:row];
 
 
 
 return tView;
 }
 
 else if (pickerView.tag==4 || pickerView.tag==5 || pickerView.tag==6)
 {
 UILabel* tView = (UILabel*)view;
 
 if (!tView){
 tView = [[UILabel alloc] init];
 // Setup label properties - frame, font, colors etc
 
 [tView setFont:[UIFont fontWithName:@"Open Sans" size:24]];
 tView.textAlignment = NSTextAlignmentCenter;
 tView.backgroundColor = [UIColor clearColor];
 }
 
 
 
 tView.text = [Array_4 objectAtIndex:row];
 
 
 
 return tView;
 }
 
 
 
 }
 
 
 return nil;
 }
 */

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
    else if (btntag==10)
    {
        
        pickarry= [holddata componentsSeparatedByString:@","] ;
        
        addresslbl.text = [pickarry objectAtIndex:0];
        
        
        
        townlbl.text=[pickarry objectAtIndex:1];
        
        countylbl.text= [pickarry objectAtIndex:2];
        
        
        
        // arry = [[NSMutableArray alloc]init];
        
        
    }
    myPickerView.hidden=YES;
    pview.hidden=YES;
    _mainscroll.scrollEnabled=YES;
    
    
    btn1.hidden=NO;
    btn2.hidden=NO;
    btn3.hidden=NO;
    btn4.hidden=NO;
    btn5.hidden=NO;
    btn6.hidden=NO;
    
    
    //    CGPoint pt;
    //
    //    CGRect rc=[_mainscroll bounds];
    //    rc=[_mainscroll convertRect:rc toView:_mainscroll];
    //
    //    pt=rc.origin;
    //    pt.x=0;
    //    pt.y=0;
    //    [_mainscroll setContentOffset:pt animated:YES];
    
    [self.view addSubview:pview];
    [pview addSubview:myPickerView];
}


-(IBAction)cancel:(id)sender
{
    pview.hidden=YES;
    _mainscroll.scrollEnabled=YES;
    [myPickerView selectRow:0 inComponent:0 animated:YES];
    
    btn1.hidden=NO;
    btn2.hidden=NO;
    btn3.hidden=NO;
    btn4.hidden=NO;
    btn5.hidden=NO;
    btn6.hidden=NO;
    
    //    CGPoint pt;
    //
    //    CGRect rc=[_mainscroll bounds];
    //    rc=[_mainscroll convertRect:rc toView:_mainscroll];
    //
    //    pt=rc.origin;
    //    pt.x=0;
    //    pt.y=0;
    //    [_mainscroll setContentOffset:pt animated:YES];
    
    [self.view addSubview:pview];
    [pview addSubview:myPickerView];
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField

{
    btn1.hidden=NO;
    btn2.hidden=NO;
    btn3.hidden=NO;
    btn4.hidden=NO;
    btn5.hidden=NO;
    btn6.hidden=NO;
    
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    pview.hidden=YES;
    myPickerView.hidden=YES;
    return YES;
}



-(void)textViewDidBeginEditing:(UITextView *)textView
{
    pview.hidden=YES;
    myPickerView.hidden=YES;
    btn1.hidden=NO;
    btn2.hidden=NO;
    btn3.hidden=NO;
    btn4.hidden=NO;
    btn5.hidden=NO;
    btn6.hidden=NO;
    
    if (textView==propertysummary)
    {
        propertysumrylbl.hidden=YES;
    }
    if (textView==propertyfulldescription)
    {
        propertydescriptionlbl.hidden=YES;
        
        CGRect rc=[_mainscroll bounds];
        CGPoint pt;
        rc=[_mainscroll convertRect:rc toView:_mainscroll];
        
        pt=rc.origin;
        pt.x=0;
        pt.y=600;
        [_mainscroll setContentOffset:pt animated:YES];
    }
    
    
    
    //  [self.mainscroll setContentSize:CGSizeMake(320, 1075)];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        // [self.mainscroll setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];
        if (textView.text.length==0)
        {
            propertysumrylbl.hidden=NO;
            propertydescriptionlbl.hidden = NO;
        }
        
        if ([propertyfulldescription.text isEqualToString:@"\n"]) {
            
            CGPoint pt;
            
            CGRect rc=[_mainscroll bounds];
            rc=[_mainscroll convertRect:rc toView:_mainscroll];
            
            pt=rc.origin;
            pt.x=0;
            pt.y=922;
            [_mainscroll setContentOffset:pt animated:YES];
            
        }
    }
    
    return YES;
}




@end

