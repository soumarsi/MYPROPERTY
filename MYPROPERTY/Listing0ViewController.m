//
//  Listing0ViewController.m
//  MyProperty
//
//  Created by soumyajit on 03/07/15.
//  Copyright (c) 2015 kausik jati. All rights reserved.
//

#import "Listing0ViewController.h"


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
    
    _Arraytable= [[NSMutableArray alloc]init];
    
    searchArray = [[NSMutableArray alloc]init];
    
    
    
    mytable.hidden=YES;
    
    mytable.delegate=self;
    mytable.dataSource=self;
    [mytable setShowsHorizontalScrollIndicator:NO];
    [mytable setShowsVerticalScrollIndicator:NO];
    
    
    UIView *polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
    polygonView.backgroundColor=[UIColor blackColor];
    polygonView.alpha=0.3;
    [self.view addSubview:polygonView];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
    
    [polygonView addSubview:spinner];
    
    
    
    picker.tag=1;
    
    [parking addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
    
    status =@"N";
    
    NSString *url = [NSString stringWithFormat:@"%@json_output.php?mode=search_values",App_Domain_Url];
    [spinner startAnimating];
    [obj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         
         // NSLog(@"result....%@",result);
         NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
         temp = [result mutableCopy];
         _Arry1 = [temp valueForKey:@"type"];
         _Arry1 = [_Arry1 valueForKey:@"type_name"];
         arry1 = [[temp valueForKey:@"type"]valueForKey:@"id"];
         
         NSLog(@"arry1.....%@",arry1);
         
         _Arry2 = [temp valueForKey:@"radius"];
         _Arry2 = [_Arry2 valueForKey:@"radius_value"];
         
         
         _Arry3 = [temp valueForKey:@"room"];
         _Arry3 = [_Arry3 valueForKey:@"number_of_rooms"];
         arry2 = [[temp valueForKey:@"room"]valueForKey:@"id"];
         NSLog(@"arry2.....%@",arry2);
         
         _Arry4 = [temp valueForKey:@"price"];
         _Arry4 = [_Arry4 valueForKey:@"price_amount"];
         arry3= [[temp valueForKey:@"price"]valueForKey:@"id"];
         NSLog(@"arry3.....%@",arry3);
         
         _Arry5 = [temp valueForKey:@"addedtime"];
         _Arry5 = [_Arry5 valueForKey:@"added_value"];
         arry4 =[[temp valueForKey:@"addedtime"]valueForKey:@"id"];
         NSLog(@"arry4.......%@",arry4);
         
         
         //         NSLog(@"Arry1%@",_Arry1);
         //         NSLog(@"Array2...%@",_Arry2);
         //         NSLog(@"Array2...%@",_Arry3);
         //
         
         [spinner stopAnimating];
         [spinner removeFromSuperview];
         [polygonView removeFromSuperview];
         
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
    [_srchFld resignFirstResponder];
    holedata = [[NSString alloc]init];
    holedata = [_Arry1 objectAtIndex:0];
    id1 = arry1 [0];
    NSLog(@"type...%@",id1);
    picker.tag=1;
    picker.dataSource=self;
    picker.delegate=self;
    
    //    [pview setHidden:NO];
    //    pview.frame =  CGRectMake(0, 0, 320, 0);
    //    [UIView animateWithDuration:0.25 animations:^{
    //        pview.frame =  CGRectMake(0, 348, 320, 173);
    //        pview.alpha = 1.0f;
    //    } completion:^(BOOL finished) {
    //    }];
    
    picker.hidden=NO;
    pview.hidden=NO;
    btntag=1;
    
    [picker selectRow:0 inComponent:0 animated:YES];
}

- (IBAction)btn2:(id)sender {
    [_srchFld resignFirstResponder];
    holedata = [[NSString alloc]init];
    holedata = [_Arry2 objectAtIndex:0];
    
    picker.tag=2;
    
    picker.dataSource=self;
    picker.delegate=self;
    
    picker.hidden=NO;
    pview.hidden=NO;
    btntag=2;
    
    //[self Pkrcanclebtn:sender];
    [picker selectRow:0 inComponent:0 animated:YES];
    
}
- (IBAction)btn3:(id)sender {
    [_srchFld resignFirstResponder];
    holedata = [[NSString alloc]init];
    holedata = [_Arry3 objectAtIndex:0];
    id2 = arry2 [0];
    picker.tag=3;
    picker.dataSource=self;
    picker.delegate=self;
    picker.hidden=NO;
    pview.hidden=NO;
    btntag=3;
    [picker selectRow:0 inComponent:0 animated:YES];
    
}
- (IBAction)btn4:(id)sender {
    [_srchFld resignFirstResponder];
    holedata = [[NSString alloc]init];
    holedata = [_Arry4 objectAtIndex:0];
    id3 = arry3 [0];
    picker.tag=4;
    picker.dataSource=self;
    picker.delegate=self;
    picker.hidden=NO;
    pview.hidden=NO;
    btntag=4;
    [picker selectRow:0 inComponent:0 animated:YES];
}
- (IBAction)btn5:(id)sender {
    [_srchFld resignFirstResponder];
    holedata = [[NSString alloc]init];
    holedata = [_Arry5 objectAtIndex:0];
    id4 = arry4 [0];
    picker.tag=5;
    picker.dataSource=self;
    picker.delegate=self;
    picker.hidden=NO;
    pview.hidden=NO;
    btntag=5;
    [picker selectRow:0 inComponent:0 animated:YES];
    
    [_srchFld resignFirstResponder];
    mytable.hidden=YES;
}


- (IBAction)Pkrcanclebtn:(id)sender {
    
    holedata = [[NSString alloc]init];
    picker.dataSource=self;
    picker.delegate=self;
    picker.hidden=YES;
    pview.hidden=YES;
    [picker selectRow:0 inComponent:0 animated:YES];
    
    
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
        
        id1 = [[NSString alloc] initWithFormat:
               @"%@", [arry1 objectAtIndex:row]];
        NSLog(@"test......%@",id1);
    }
    else if (picker.tag==2)
        
    {
        holedata = [[NSString alloc] initWithFormat:
                    @"%@", [_Arry2 objectAtIndex:row]];
        
        // NSLog(@"%@", holedata);
    }
    
    
    else if (picker.tag==3)
        
    {
        holedata = [[NSString alloc] initWithFormat:
                    @"%@", [_Arry3 objectAtIndex:row]];
        id2 = [[NSString alloc] initWithFormat:
               @"%@", [arry2 objectAtIndex:row]];
        
        NSLog(@"test3......%@",id2);
    }
    
    else if (picker.tag==4)
        
    {
        holedata = [[NSString alloc] initWithFormat:
                    @"%@", [_Arry4 objectAtIndex:row]];
        id3 = [[NSString alloc] initWithFormat:
               @"%@", [arry3 objectAtIndex:row]];
        
        NSLog(@"test4......%@",id3);
    }
    else if (picker.tag==5)
        
    {
        holedata = [[NSString alloc] initWithFormat:
                    @"%@", [_Arry5 objectAtIndex:row]];
        id4 = [[NSString alloc] initWithFormat:
               @"%@", [arry4 objectAtIndex:row]];
        
        
        NSLog(@"test4......%@",id4);
    }
    
    
    else
    {
        holedata = [[NSString alloc] initWithFormat:
                    @"%@", [_Arry1 objectAtIndex:row]];
        // NSLog(@"%@", holedata);
    }
}


- (IBAction)done:(id)sender
{
    if (btntag==1) {
        lbl1.text=holedata;
        [picker selectRow:0 inComponent:0 animated:YES];
    }
    else if (btntag==2)
    {
        lbl2.text=holedata;
        [picker selectRow:0 inComponent:0 animated:YES];
        
    }
    else if (btntag==3)
    {
        lbl3.text=holedata;
        [picker selectRow:0 inComponent:0 animated:YES];
        
    }
    
    else if (btntag==4)
    {
        lbl4.text=holedata;
        [picker selectRow:0 inComponent:0 animated:YES];
    }
    else if (btntag==5)
    {
        lbl5.text=holedata;
        [picker selectRow:0 inComponent:0 animated:YES];
    }
    picker.hidden=YES;
    pview.hidden=YES;
    
}
- (void)changeSwitch:(id)sender{
    
    
    if([sender isOn]){
        status=@"Y";
        
    }
    else
    {
        status= @"N";
    }
}

- (IBAction)searchTapped:(id)sender
{
    
    
    ///// Do not delete
    
    
    
    //    NSString *url =[NSString stringWithFormat:@"http://esolz.co.in/lab6/myproperty/web_service/json_output.php?mode=search_property&location=%@&radius=%@&min_price=0&max_price=%@&min_bed=1&max_bed=%@&property_type=%@&added_time=%@&sold_status=%@&buy_or_rent=S&latitude_val=%@&longitude_val=%@&start=0",[_srchFld text],lbl2.text,id3,id2,id1,id4,status,lat,lng];
    
    NSString *url =[NSString stringWithFormat:@"http://esolz.co.in/lab6/myproperty/web_service/json_output.php?mode=search_property&location=%@&radius=&min_price=&max_price=&min_bed=&max_bed=&property_type=%@&added_time=&sold_status=%@&buy_or_rent=S&latitude_val=%@&longitude_val=%@&start=0",[_srchFld text],id1,status,lat,lng];
    
    NSString* encodedUrl = [url stringByAddingPercentEscapesUsingEncoding:
                            NSUTF8StringEncoding];
    [obj GlobalDict:encodedUrl Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         
         
         searchArray = [result mutableCopy];
         NSLog(@"return.....%@",searchArray);
         
         
         
         if (result!=NULL)
         {
             
             Listing3ViewController *list = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"list3"];
             
             
             list.srchdata=[searchArray mutableCopy];
             list.srchtext = [_srchFld text];
             
             
             [self.navigationController pushViewController:list animated:YES];
         }
         else
         {
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"No Data Found" delegate:self  cancelButtonTitle:@"OK"  otherButtonTitles:nil];
             [alert show];
         }
         
         
     }];
    
    
    
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    picker.hidden=YES;
    pview.hidden=YES;
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    [mytable reloadData];
//    return YES;
//}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    
    [_srchFld addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    
    
}

-(void)textFieldDidChange :(UITextField *)theTextField{
    
    
    
    if (_srchFld.text.length==0) {
        mytable.hidden=YES;
    }
    
    else
    {
        NSString *url =[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?region=GB&key=AIzaSyBYt5SEMwuoCbYlYXDc01Z5DqMez7TOaOU&input=%@",[_srchFld text]];
        NSString* encodedUrl = [url stringByAddingPercentEscapesUsingEncoding:
                                NSUTF8StringEncoding];
        
        
        [obj GlobalDict:encodedUrl Globalstr:@"array" Withblock:^(id result, NSError *error)
         {
             //  NSLog(@"result%@",result);
             data = [result mutableCopy];
             //  NSLog(@"data....%@",data);
             data=[result mutableCopy];
             
             _Arraytable=[data valueForKey:@"predictions"];
             _Arraytable = [_Arraytable valueForKey:@"description"];
             // NSLog(@"description...%@",_Arraytable);
             
             
             
             
             
             mytable.hidden=NO;
             [mytable reloadData];
             
         }];
        
    }
    //     NSLog( @"text changed: %@", _srchFld.text);
    // NSLog(@"value2.....%@",_Arraytable);
}






- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //
    
    NSLog(@"arrycount...%lu",(unsigned long)_Arraytable.count);
    return _Arraytable.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    list0Cell *cell =(list0Cell *)  [mytable dequeueReusableCellWithIdentifier:@"cell"];
    
    // NSLog(@"dataaa......%@",_Arraytable [indexPath.row]);
    cell.lbl.text =[NSString stringWithFormat:@"%@",[_Arraytable objectAtIndex:indexPath.row]];
    
    
    
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [_srchFld setText:[NSString stringWithFormat:@"%@",_Arraytable[indexPath.row]]];
    mytable.hidden=YES;
    
    
    
    NSString *url=[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?address=%@",[_srchFld text]];
    NSString* encodedUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [obj GlobalDict:encodedUrl Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         
         
         NSArray *results = (NSArray *) result[@"results"];
         NSDictionary *dic = (NSDictionary *) [results objectAtIndex:0];
         NSDictionary *dic1 = (NSDictionary *) [dic objectForKey:@"geometry"];
         NSDictionary *location = (NSDictionary *) [dic1 objectForKey:@"location"];
         lat = [location objectForKey:@"lat"];
         lng =  [location objectForKey:@"lng"];
         
         // NSLog(@"lat.....%@",lat);
         //
         //NSLog(@"lng.......%@",lng);
         
         
         
         
     }];
    [_srchFld resignFirstResponder];
}







@end

