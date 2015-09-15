//

//  Listing0ViewController.m

//  MyProperty

//

//  Created by soumyajit on 03/07/15.

//  Copyright (c) 2015 kausik jati. All rights reserved.

//



#import "Listing0ViewController.h"


@interface Listing0ViewController ()
{
    NSString *url3;
    
    IBOutlet UIImageView *srchImage;
    IBOutlet UIActivityIndicatorView *spinnerSrch;
    UIView *polygonView;
    UIActivityIndicatorView *spinner;
}

@end



@implementation Listing0ViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //  NSLog(@"check...%@",_check);
    
    // Do any additional setup after loading the view.
    
    
    temp = [[NSMutableDictionary alloc]init];
    
    if (lbl4.text.length>0 )
    {
        hipen2.hidden=NO;
        
        
    }
    if ( maxbedroom.text.length>0)
    {
        hipen1.hidden=NO;
    }
    else
    {
        hipen1.hidden=YES;
        
        hipen2.hidden=YES;
    }
    
    minlbl.hidden=YES;
    maxlbl.hidden= YES;
    
    obj = [[FW_JsonClass alloc]init];
    
    
    //[lodertext stopAnimating];
    
    app = (AppDelegate *) [[UIApplication sharedApplication]delegate];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectCD:) name:@"no_internet" object:nil];
    
    _Arry1 =[[NSMutableArray alloc]init];
    
    _Arry2 =[[NSMutableArray alloc]init];
    
    _Arry3 =[[NSMutableArray alloc]init];
    
    _Arry4 =[[NSMutableArray alloc]init];
    
    _Arry5 =[[NSMutableArray alloc]init];
    arry1= [[NSMutableArray alloc]init];
    arry2 = [[NSMutableArray alloc]init];
    arry3 = [[NSMutableArray alloc]init];
    arry4 = [[NSMutableArray alloc]init];
    
    
    
    _Arraytable= [[NSMutableArray alloc]init];
    
    
    
    
    searchArray = [[NSMutableArray alloc]init];
    mytable.backgroundColor = [UIColor whiteColor];
    
    
    userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
    
    parking.onTintColor = [UIColor colorWithRed:58.0/255.0 green:85.0/255.0 blue:140.0/255.0 alpha:1.0];
    
    
    srchclickview.hidden=YES;
    spinner1.hidden=YES;
    
    [spinnerSrch stopAnimating];
    
    
    
    
    mytable.hidden=YES;
    tablebackview.hidden=YES;
    blackview.hidden = YES;
    
    
    mytable.delegate=self;
    
    mytable.dataSource=self;
    
    [mytable setShowsHorizontalScrollIndicator:NO];
    
    [mytable setShowsVerticalScrollIndicator:NO];
    
    
    UITapGestureRecognizer *messagesTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(messagesBucketTap:)];
    [messagesTap setDelegate:self];
    [messagesTap setNumberOfTapsRequired:1];
    [blackview addGestureRecognizer:messagesTap];
    
    polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0,self.view.frame.origin.y+header.frame.size.height, self.view.frame.size.width,self.view.frame.size.height )];
    
    polygonView.backgroundColor=[UIColor blackColor];
    
    polygonView.alpha=0.3;
    
    [self.view addSubview:polygonView];
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
    
    
    
    [polygonView addSubview:spinner];
    
    
    
    
    picker.tag=1;
    
    
    
    [parking addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
    
    
    status =@"N";
    
    //    if ([_check isEqualToString:@"srch"])
    //    {
    //        // NSLog(@"working");
    //        _check=@"change";
    //    }
    //    else
    //    {
    //       status =@"Y";
    //
    //    }
    
    
    
    
    
    
    [spinner startAnimating];
    
    
    NSManagedObjectContext *context = [app managedObjectContext];
    NSEntityDescription *entityDesc =[NSEntityDescription entityForName:@"List0"inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    NSError *error;
    NSArray *objects1 = [context executeFetchRequest:request
                                               error:&error];
    
    
    if (objects1.count==0)
    {
        
        // [self putdata];
        
        
        NSString *url = [NSString stringWithFormat:@"%@json_output.php?mode=search_values",App_Domain_Url];
        
        [obj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error)
         
         {
             
             
             
             
             
             
             temp = [result mutableCopy];
             
             
             
             
             
             
             
             _Arry1 = [[temp valueForKey:@"type"]valueForKey:@"type_name"];
             
             
             NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:_Arry1];
             NSManagedObjectContext *context=[app managedObjectContext];
             NSManagedObject *newUser=[NSEntityDescription insertNewObjectForEntityForName:@"List0" inManagedObjectContext:context];
             [newUser setValue:data1 forKey:@"data1"];
             [app saveContext];
             
             
             //_Arry1 = [_Arry1 valueForKey:@"type_name"];
             
             arry1 = [[temp valueForKey:@"type"]valueForKey:@"id"];
             
             
             NSData *data1id = [NSKeyedArchiver archivedDataWithRootObject:arry1];
             NSManagedObjectContext *context1=[app managedObjectContext];
             NSManagedObject *newUser1=[NSEntityDescription insertNewObjectForEntityForName:@"List0" inManagedObjectContext:context1];
             [newUser1 setValue:data1id forKey:@"data1id"];
             [app saveContext];
             
             
             //  NSLog(@"core data insert====%@",newUser);
             
             
             
             
             _Arry2 = [[temp valueForKey:@"radius"]valueForKey:@"radius_value"];
             
             NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:_Arry2];
             NSManagedObjectContext *context2=[app managedObjectContext];
             NSManagedObject *newUser2=[NSEntityDescription insertNewObjectForEntityForName:@"List0" inManagedObjectContext:context2];
             [newUser2 setValue:data2 forKey:@"data2"];
             [app saveContext];
             
             
             //  _Arry2 = [_Arry2 valueForKey:@"radius_value"];
             
             
             
             
             
             _Arry3 = [[temp valueForKey:@"room"]valueForKey:@"number_of_rooms"];
             
             
             NSData *data3 = [NSKeyedArchiver archivedDataWithRootObject:_Arry3];
             NSManagedObjectContext *context3=[app managedObjectContext];
             NSManagedObject *newUser3=[NSEntityDescription insertNewObjectForEntityForName:@"List0" inManagedObjectContext:context3];
             [newUser3 setValue:data3 forKey:@"data3"];
             [app saveContext];
             
             // _Arry3 = [_Arry3 valueForKey:@"number_of_rooms"];
             
             arry2 = [[temp valueForKey:@"room"]valueForKey:@"id"];
             
             // NSLog(@"arry2.....%@",arry2);
             
             NSData *data3id = [NSKeyedArchiver archivedDataWithRootObject:arry2];
             NSManagedObjectContext *context4=[app managedObjectContext];
             NSManagedObject *newUser4=[NSEntityDescription insertNewObjectForEntityForName:@"List0" inManagedObjectContext:context4];
             [newUser4 setValue:data3id forKey:@"data3id"];
             [app saveContext];
             
             
             _Arry4 = [[temp valueForKey:@"price"]valueForKey:@"price_amount"];
             
             NSData *data4 = [NSKeyedArchiver archivedDataWithRootObject:_Arry4];
             NSManagedObjectContext *context5=[app managedObjectContext];
             NSManagedObject *newUser5=[NSEntityDescription insertNewObjectForEntityForName:@"List0" inManagedObjectContext:context5];
             [newUser5 setValue:data4 forKey:@"data4"];
             [app saveContext];
             
             // _Arry4 = [_Arry4 valueForKey:@"price_amount"];
             
             arry3= [[temp valueForKey:@"price"]valueForKey:@"id"];
             
             
             NSData *data4id = [NSKeyedArchiver archivedDataWithRootObject:arry3];
             NSManagedObjectContext *context6=[app managedObjectContext];
             NSManagedObject *newUser6=[NSEntityDescription insertNewObjectForEntityForName:@"List0" inManagedObjectContext:context6];
             [newUser6 setValue:data4id forKey:@"data4id"];
             [app saveContext];
             
             // NSLog(@"arry3.....%@",arry3);
             
             
             
             _Arry5 = [[temp valueForKey:@"addedtime"]valueForKey:@"added_value"];
             NSData *data5 = [NSKeyedArchiver archivedDataWithRootObject:_Arry5];
             NSManagedObjectContext *context7=[app managedObjectContext];
             NSManagedObject *newUser7=[NSEntityDescription insertNewObjectForEntityForName:@"List0" inManagedObjectContext:context7];
             [newUser7 setValue:data5 forKey:@"data5"];
             [app saveContext];
             
             // _Arry5 = [_Arry5 valueForKey:@"added_value"];
             
             arry4 =[[temp valueForKey:@"addedtime"]valueForKey:@"id"];
             NSData *data5id = [NSKeyedArchiver archivedDataWithRootObject:arry4];
             NSManagedObjectContext *context8=[app managedObjectContext];
             NSManagedObject *newUser8=[NSEntityDescription insertNewObjectForEntityForName:@"List0" inManagedObjectContext:context8];
             [newUser8 setValue:data5id forKey:@"data5id"];
             [app saveContext];
             
             
             
             [spinner stopAnimating];
             
             [spinner removeFromSuperview];
             
             [polygonView removeFromSuperview];
             
             
             
             
         }];
        
    }
    
    else
    {
        [self fatch];
        
        
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
                       {
                           
                           // Background work
                           dispatch_async(dispatch_get_main_queue(), ^(void)
                                          {
                                              // Main thread work (UI usually)
                                              [self putdata];
                                              
                                          });
                       });
        
        
    }
    
    
    
    
    
    
    
    
    //int buttonTagIndex = done.tag;
    
    
    
    
    
    pview.hidden=YES;
    
    [pview addSubview:picker];
    
    // picker.hidden=YES;
    
    
    
    
    
    
    
    
    
    [myView setBackgroundColor:[UIColor colorWithRed:31/255.0 green:55/255.0 blue:97/255.0 alpha:1]];
    
    //[self viewCorrection];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    if ([_check isEqualToString:@"srch"])
    {
        // NSLog(@"working");
        _check=@"change";
    }
    else
    {
        // NSLog(@"pop");
        [parking setOn:NO animated:NO];
        [self viewDidLoad];
    }
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    
    // Dispose of any resources that can be recreated.
    
}

- (void)messagesBucketTap:(UITapGestureRecognizer *)gestureRecognizer
{
    mytable.hidden=YES;
    tablebackview.hidden=YES;
    blackview.hidden = YES;
    [_srchFld resignFirstResponder];
    
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
    
    
    
    // NSLog(@"type...%@",id1);
    
    picker.tag=1;
    
    picker.dataSource=self;
    
    picker.delegate=self;
    minlbl.hidden=YES;
    maxlbl.hidden= YES;
    
    
    
    
    picker.hidden=NO;
    
    pview.hidden=NO;
    
    btntag=1;
    
    
    
    [picker selectRow:0 inComponent:0 animated:YES];
    
}



- (IBAction)btn2:(id)sender {
    
    [_srchFld resignFirstResponder];
    
    holedata = [[NSString alloc]init];
    
    holedata = [_Arry2 objectAtIndex:0];
    
    minlbl.hidden=YES;
    maxlbl.hidden= YES;
    
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
    
    minlbl.hidden=NO;;
    maxlbl.hidden= NO;
    
    holedata = [[NSString alloc]init];
    
    holedata = [_Arry3 objectAtIndex:0];
    
    comp0= [_Arry3 objectAtIndex:0];
    
    
    
    picker.tag=3;
    
    picker.dataSource=self;
    
    picker.delegate=self;
    
    picker.hidden=NO;
    
    pview.hidden=NO;
    
    btntag=3;
    
    [picker selectRow:0 inComponent:0 animated:YES];
    
    [picker selectRow:0 inComponent:1 animated:YES];
    
    
    
}

- (IBAction)btn4:(id)sender {
    
    [_srchFld resignFirstResponder];
    
    holedata = [[NSString alloc]init];
    
    holedata = [_Arry4 objectAtIndex:0];
    
    
    
    minlbl.hidden=NO;
    maxlbl.hidden= NO;
    
    comp1 = _Arry4[0];
    
    
    
    picker.tag=4;
    
    picker.dataSource=self;
    
    picker.delegate=self;
    
    picker.hidden=NO;
    
    pview.hidden=NO;
    
    btntag=4;
    
    [picker selectRow:0 inComponent:0 animated:YES];
    
    [picker selectRow:0 inComponent:1 animated:YES];
    
}

- (IBAction)btn5:(id)sender {
    
    minlbl.hidden=YES;
    maxlbl.hidden= YES;
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
    tablebackview.hidden=YES;
    blackview.hidden = YES;
    
    
    
}









- (IBAction)Pkrcanclebtn:(id)sender
{
    if (lbl1.text.length==0 )
    {
        id1=nil;
    }
    if (lbl5.text.length==0)
    {
        id4=nil;
    }
    
    if (btntag==1 )
    {
        id1=nil;
    }
    if (btntag==4)
    {
        id3=nil;
    }
    if (btntag==3)
    {
        id2=nil;
    }
    
    if (btntag==5)
    {
        id4=nil;
    }
    picker.dataSource=self;
    
    picker.delegate=self;
    
    picker.hidden=YES;
    
    pview.hidden=YES;
    
    [picker selectRow:0 inComponent:0 animated:YES];
    
    
    
    
    
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    
    if (picker.tag==3 || picker.tag ==4)
        
    {
        
        
        
        return 2;
        
    }
    
    else
        
    {
        
        
        
        return 1;
        
    }
    
    
    
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
    
    
    
    else if (picker.tag==3 )
        
    {
        
        return _Arry3.count;
        
    }
    
    
    
    else if (picker.tag==4)
        
    {
        
        return _Arry4.count;
        
    }
    
    
    
    else if (picker.tag==5 )
        
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
    
    
    
    
    
    else if (picker.tag==3 )
        
    {
        
        return _Arry3[row];
        
        
        
    }
    
    else if (picker.tag==4 )
        
    {
        
        return _Arry4[row];
        
        
        
    }
    
    else if (picker.tag==5 )
        
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
    
    
    
    
    
    else if (picker.tag==3 )
        
        
        
    {
        
        if (component == 0) {
            
            holedata = [[NSString alloc] initWithFormat:
                        
                        @"%@", [_Arry3 objectAtIndex:row]];
            
            id2 = [[NSString alloc] initWithFormat:
                   
                   @"%@", [arry2 objectAtIndex:row]];
            
            // [pickerView reloadComponent:1];
            
            NSLog(@"component0......%@",id2);
            
        }
        
        else
            
        {
            
            comp0 = [[NSString alloc] initWithFormat:
                     
                     @"%@", [_Arry3 objectAtIndex:row]];
            
            idzero = [[NSString alloc] initWithFormat:
                      
                      @"%@", [arry2 objectAtIndex:row]];
            
            // [pickerView reloadComponent:1];
            
            NSLog(@"Component1......%@",idzero);
            
        }
        
        
        
        
        
    }
    
    
    
    else if (picker.tag==4)
        
        
        
    {
        
        if (component == 0) {
            
            holedata = [[NSString alloc] initWithFormat:
                        
                        @"%@", [_Arry4 objectAtIndex:row]];
            
            id3 = [[NSString alloc] initWithFormat:
                   
                   @"%@", [arry3 objectAtIndex:row]];
            
            
            
            NSLog(@"component0......%@",id3);
            
        }
        
        else
            
        {
            
            comp1 = [[NSString alloc] initWithFormat:
                     
                     @"%@", [_Arry4 objectAtIndex:row]];
            
            idfirst = [[NSString alloc] initWithFormat:
                       
                       @"%@", [arry3 objectAtIndex:row]];
            
            
            
            NSLog(@"component1......%@",idfirst);
            
        }
        
        
        
    }
    
    
    
    else if (picker.tag==5  )
        
        
        
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
        
        idzero = [arry2 objectAtIndex:0];
        
        id2 = arry2 [0];
        
        NSInteger min = [holedata intValue];
        
        NSInteger max = [comp0 intValue];
        
        
        
        if (min<max)
            
        {
            
            lbl3.text=holedata;
            
            maxbedroom.text = comp0;
            
            hipen1.hidden=NO;
            
        }
        
        else
            
        {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"  message:@"Please Choose Correct Value" delegate:self  cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alert show];
            
            
            
        }
        
        
        
        
        
        
        
    }
    
    
    
    else if (btntag==4)
        
    {
        
        id3 = arry3 [0];
        idfirst = arry3[0];
        
        NSInteger min = [holedata intValue];
        
        NSInteger max = [comp1 intValue];
        
        if (min<max)
            
        {
            
            lbl4.text=holedata;
            
            maxprice.text = comp1;
            
            hipen2.hidden=NO;
            
            
            
        }
        
        else
            
        {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"  message:@"Please Choose Correct Value" delegate:self  cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alert show];
            
            
            
        }
        
        
        
        
        
        
        
    }
    
    else if (btntag==5)
        
    {
        
        
        lbl5.text=holedata;
        
        [picker selectRow:0 inComponent:0 animated:YES];
        
    }
    
    
    if (lbl1.text.length==0 )
    {
        id1=nil;
    }
    if (lbl5.text.length==0)
    {
        id4=nil;
    }
    
    
    picker.hidden=YES;
    
    pview.hidden=YES;
    
    
    
}

- (void)changeSwitch:(id)sender{
    
    
    picker.hidden=YES;
    
    pview.hidden=YES;
    
    
    if (lbl1.text.length==0 )
    {
        id1=nil;
    }
    if (lbl5.text.length==0)
    {
        id4=nil;
    }
    
    
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
    
    if (_srchFld.text.length==0)
        
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"  message:@"Please Select Location" delegate:self  cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        
    }
    
    
    
    else{
        
        srchclickview.hidden=NO;
        spinner1.hidden =NO;
        
        
        if (lbl2.text ==NULL)
            
        {
            
            lbl2.text=@"";
            
        }
        
        if (lbl4.text==NULL)
            
        {
            
            lbl4.text=@"";
            
        }
        
        if (maxprice.text==NULL) {
            
            
            
            maxprice.text=@"";
            
        }
        
        if (id2==NULL)
            
        {
            
            id2=@"";
            
            
            
        }
        
        if (idzero==NULL) {
            
            
            
            idzero=@"";
            
        }
        
        if (id1==NULL) {
            
            id1=@"";
            
            
            
        }
        
        if (id4==NULL) {
            
            
            
            id4=@"";
            
        }
        
        if (status==NULL) {
            
            
            
            status=@"";
            
            
            
        }
        
        if (lbl3.text==NULL) {
            
            lbl3.text=@"";
            
        }
        
        if (maxbedroom.text==NULL)
            
        {
            
            maxbedroom.text=@"";
            
        }
        
        
        
        
        
        if ([_srchtype isEqualToString:@"S"])
            
        {
            
            url3 =[NSString stringWithFormat:@"%@json_output.php?mode=search_property&location=%@&radius=%@&min_price=%@&max_price=%@&min_bed=%@&max_bed=%@&property_type=%@&added_time=%@&sold_status=%@&buy_or_rent=S&latitude_val=%@&longitude_val=%@&start=0&user_id=%@",App_Domain_Url,[_srchFld text],lbl2.text,lbl4.text,maxprice.text,lbl3.text,maxbedroom.text,id1,id4,status,lat,lng,userid];
            
        }
        
        else if([_srchtype isEqualToString:@"R"])
            
        {
            
            url3 =[NSString stringWithFormat:@"%@json_output.php?mode=search_property&location=%@&radius=%@&min_price=%@&max_price=%@&min_bed=%@&max_bed=%@&property_type=%@&added_time=%@&sold_status=%@&buy_or_rent=R&latitude_val=%@&longitude_val=%@&start=0&user_id=%@",App_Domain_Url,[_srchFld text],lbl2.text,lbl4.text,maxprice.text,lbl3.text,maxbedroom.text,id1,id4,status,lat,lng,userid];
            
        }
        
        
        
        //   NSString *url =[NSString stringWithFormat:@"http://esolz.co.in/lab6/myproperty/web_service/json_output.php?mode=search_property&location=%@&radius=&min_price=&max_price=&min_bed=&max_bed=&property_type=&added_time=&sold_status=%@&buy_or_rent=S&latitude_val=%@&longitude_val=%@&start=0",[_srchFld text],status,lat,lng];
        
        
        
        NSString* encodedUrl = [url3 stringByAddingPercentEscapesUsingEncoding:
                                
                                NSUTF8StringEncoding];
        
        [obj GlobalDict:encodedUrl Globalstr:@"array" Withblock:^(id result, NSError *error)
         
         {
             
             
             
             
             
             searchArray = [result mutableCopy];
             
             // NSLog(@"return.....%@",searchArray);
             
             
             
             
             
             
             
             if (result!=NULL)
                 
             {
                 
                 
                 srchclickview.hidden=YES;
                 spinner1.hidden=YES;
                 
                 
                 obj=Nil;
                 Listing3ViewController *list = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"list3"];
                 
                 
                 list.tempsrchdata=[[searchArray valueForKey:@"all_property"] mutableCopy];
                 list.nextstartvalue=[searchArray valueForKey:@"next_start"];
                 list.srchtext = [_srchFld text];
                 
                 list.location=[_srchFld text];
                 list.radius=lbl2.text;
                 list.minprice=lbl4.text;
                 list.maxprice=maxprice.text;
                 list.minbed=lbl3.text;
                 list.maxbed=maxbedroom.text;
                 list.propertytype=id1;
                 list.addedtime=id4;
                 list.soldstatus=status;
                 //list.buyorrent=;
                 list.lativalue=lat;
                 list.longvalue=lng;
                 list.mymap =[[MKMapView alloc]init];
                 
                 list.resulttype=_srchtype;
                 
                 
                 
                 [self.navigationController pushViewController:list animated:YES];
                 
                 
                 
             }
             
             else
                 
             {
                 
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"No Data Found" delegate:self  cancelButtonTitle:@"OK"  otherButtonTitles:nil];
                 
                 [alert show];
                 
             }
             
             
             
             
             
         }];
        
        
        
        
        
    }
    
    
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField

{
    
    picker.hidden=YES;
    
    pview.hidden=YES;
    
    
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    
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
    
    
    
    //[lodertext stopAnimating];
    
    
    
    if (_srchFld.text.length==0)
        
    {
        obj=[[FW_JsonClass alloc]init];
        mytable.hidden=YES;
        tablebackview.hidden=YES;
        blackview.hidden = YES;
        srchImage.hidden=NO;
        [spinnerSrch stopAnimating];
        
    }
    
    
    
    else
        
    {
        
        
        // Main thread work (UI usually)
        
        
        NSString *urlll =[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?region=GB&key=AIzaSyA9CuugBNIOxYTO_GVn0fTEUaPzM03jvNo&input=%@",[_srchFld text]];
        
        
        NSString* encodedUrl = [urlll stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        
        
        
        NSURL *url = [NSURL URLWithString:encodedUrl];
        
        
        //--------------- GET Method-----------  //
        
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
        
        
        
        NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithURL:url
                                                        completionHandler:^(NSData *data1, NSURLResponse *response, NSError *error) {
                                                            if(error == nil)
                                                            {
                                                                NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data1 options:kNilOptions error:&error];
                                                                
                                                                NSLog(@"RETURN DATA------> %@",dictionary);
                                                                
                                                                
                                                                if ([[dictionary valueForKey:@"status"] isEqualToString:@"OK"])
                                                                {
                                                                    
                                                                    
                                                                    
                                                                    data = [dictionary mutableCopy];
                                                                    
                                                                    
                                                                    _Arraytable=[data valueForKey:@"predictions"];
                                                                    
                                                                    _Arraytable = [_Arraytable valueForKey:@"description"];
                                                                    
                                                                    // NSLog(@"working");
                                                                    tablebackview.hidden=NO;
                                                                    blackview.hidden = NO;
                                                                    mytable.hidden=NO;
                                                                    
                                                                    
                                                                    [mytable reloadData];
                                                                    
                                                                    srchImage.hidden=NO;
                                                                    [spinnerSrch stopAnimating];
                                                                    
                                                                    
                                                                    
                                                                    
                                                                }
                                                                
                                                                else if ([[dictionary valueForKey:@"status"] isEqualToString:@"ZERO_RESULTS"])
                                                                {
                                                                    obj=Nil;
                                                                    tablebackview.hidden=YES;
                                                                    blackview.hidden = YES;
                                                                    mytable.hidden=YES;
                                                                    
                                                                    srchImage.hidden=NO;
                                                                    [spinnerSrch stopAnimating];
                                                                    
                                                                    //[lodertext stopAnimating];
                                                                }
                                                                
                                                                
                                                                
                                                                
                                                                else
                                                                {
                                                                    UIAlertView *alart = [[UIAlertView alloc]initWithTitle:[data valueForKey:@"status"] message:[data valueForKey:@"error_message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                                                    [alart show];
                                                                    srchImage.hidden=NO;
                                                                    [spinnerSrch stopAnimating];
                                                                    
                                                                }
                                                                
                                                            }
                                                            
                                                        }];
        
        [dataTask resume];
        
        
        
        
        
        
        
        /*  [obj GlobalDict:encodedUrl Globalstr:@"array" Withblock:^(id result, NSError *error)
         
         {
         srchImage.hidden=YES;
         [spinnerSrch startAnimating];
         
         //[lodertext startAnimating];
         //NSLog(@"start");
         
         if ([[result valueForKey:@"status"] isEqualToString:@"OK"])
         {
         
         
         
         data = [result mutableCopy];
         
         
         _Arraytable=[data valueForKey:@"predictions"];
         
         _Arraytable = [_Arraytable valueForKey:@"description"];
         
         // NSLog(@"working");
         tablebackview.hidden=NO;
         blackview.hidden = NO;
         mytable.hidden=NO;
         
         
         [mytable reloadData];
         
         srchImage.hidden=NO;
         [spinnerSrch stopAnimating];
         
         
         
         
         }
         
         else if ([[result valueForKey:@"status"] isEqualToString:@"ZERO_RESULTS"])
         {
         obj=Nil;
         tablebackview.hidden=YES;
         blackview.hidden = YES;
         mytable.hidden=YES;
         
         srchImage.hidden=NO;
         [spinnerSrch stopAnimating];
         
         //[lodertext stopAnimating];
         }
         
         else
         {
         UIAlertView *alart = [[UIAlertView alloc]initWithTitle:[result valueForKey:@"status"] message:[result valueForKey:@"error_message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [alart show];
         srchImage.hidden=NO;
         [spinnerSrch stopAnimating];
         
         }
         
         
         
         
         //[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         
         // [lodertext stopAnimating];
         
         }];
         
         */
        
        
        
        
        
        
    }
    
    //     NSLog( @"text changed: %@", _srchFld.text);
    
    // NSLog(@"value2.....%@",_Arraytable);
    
}












- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    //
    
    
    
    
    return _Arraytable.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    
    
    list0Cell *cell =(list0Cell *)  [mytable dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    // NSLog(@"dataaa......%@",_Arraytable [indexPath.row]);
    
    cell.lbl.text =[NSString stringWithFormat:@"%@",[_Arraytable objectAtIndex:indexPath.row]];
    
    
    
    
    
    
    
    
    
    return cell;
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    //[lodertext stopAnimating];
    srchImage.hidden=NO;
    [spinnerSrch stopAnimating];
    
    
    [_srchFld setText:[NSString stringWithFormat:@"%@",_Arraytable[indexPath.row]]];
    
    mytable.hidden=YES;
    tablebackview.hidden=YES;
    blackview.hidden = YES;
    
    
    //    [UIView animateWithDuration:0.25 animations:^{
    //        tablebackview.frame =  CGRectMake(130, 30, 0, 0);
    //        [tablebackview setAlpha:0.0f];
    //    } completion:^(BOOL finished) {
    //        [tablebackview setHidden:YES];
    //        [mytable setHidden:YES];
    //    }];
    /*
     NSString *url=[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?address=%@",[_srchFld text]];
     
     NSString* encodedUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     
     
     dispatch_async(dispatch_get_main_queue(), ^(void)
     {
     // Main thread work (UI usually)
     [obj GlobalDict:encodedUrl Globalstr:@"array" Withblock:^(id result, NSError *error)
     
     {
     
     if ([[result valueForKey:@"status"]isEqualToString:@"OK"])
     
     {
     
     
     NSArray *results = (NSArray *) result[@"results"];
     
     NSDictionary *dic = (NSDictionary *) [results objectAtIndex:0];
     
     NSDictionary *dic1 = (NSDictionary *) [dic objectForKey:@"geometry"];
     
     NSDictionary *location = (NSDictionary *) [dic1 objectForKey:@"location"];
     
     lat = [location objectForKey:@"lat"];
     
     lng =  [location objectForKey:@"lng"];
     
     
     }
     }];
     });
     
     
     */
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:[_srchFld text] completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            CLLocation *location = placemark.location;
            CLLocationCoordinate2D coordinate = location.coordinate;
            NSLog(@"coordinate = (%f, %f)", coordinate.latitude, coordinate.longitude);
            
            
            lat =[NSString stringWithFormat:@"%f",coordinate.latitude];
            
            lng =  [NSString stringWithFormat:@"%f",coordinate.longitude];
            
            // NSLog(@"lat----%f---%f ",region.center.latitude,placemark.location.coordinate.latitude);
            // NSLog(@"lon----%f -----%f",region.center.longitude, placemark.location.coordinate.longitude);
            
            
            
            
        }
    }];
    
    
    
    
    
    
    
    
    
    [_srchFld resignFirstResponder];
    
}

-(void)connectCD:(NSNotification *)note
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Faild"   message:@"Connection Faild!" delegate:self  cancelButtonTitle:@"Cancel" otherButtonTitles:nil,nil];
    [alert show];
    
    
    
    
    
    
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0)
    {
        
        [self clearNotifications];
    }
}

- (void) clearNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"no_internet" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
    //    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}



-(void)fatch
{
    
    NSManagedObjectContext *context = [app managedObjectContext];
    NSEntityDescription *entityDesc =[NSEntityDescription entityForName:@"List0"inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    objects = [NSKeyedUnarchiver unarchiveObjectWithData:[[objects objectAtIndex:0]valueForKey:@"data1"]];
    
    [_Arry1 addObjectsFromArray:objects];
    
    
    
    
    NSManagedObjectContext *context1 = [app managedObjectContext];
    NSEntityDescription *entityDesc1 =[NSEntityDescription entityForName:@"List0"inManagedObjectContext:context1];
    NSFetchRequest *request1 = [[NSFetchRequest alloc] init];
    [request1 setEntity:entityDesc1];
    
    
    NSArray *objects1 = [context1 executeFetchRequest:request1
                                                error:&error];
    
    objects1 = [NSKeyedUnarchiver unarchiveObjectWithData:[[objects1 objectAtIndex:1]valueForKey:@"data1id"]];
    
    [arry1 addObjectsFromArray:objects1];
    
    
    
    
    
    
    NSManagedObjectContext *context2 = [app managedObjectContext];
    NSEntityDescription *entityDesc2 =[NSEntityDescription entityForName:@"List0"inManagedObjectContext:context2];
    NSFetchRequest *request2 = [[NSFetchRequest alloc] init];
    [request2 setEntity:entityDesc2];
    
    
    NSArray *objects2 = [context2 executeFetchRequest:request2
                                                error:&error];
    
    objects2 = [NSKeyedUnarchiver unarchiveObjectWithData:[[objects2 objectAtIndex:2]valueForKey:@"data2"]];
    
    [_Arry2 addObjectsFromArray:objects2];
    
    
    
    
    
    
    NSManagedObjectContext *context3 = [app managedObjectContext];
    NSEntityDescription *entityDesc3 =[NSEntityDescription entityForName:@"List0"inManagedObjectContext:context3];
    NSFetchRequest *request3 = [[NSFetchRequest alloc] init];
    [request3 setEntity:entityDesc3];
    
    
    NSArray *objects3 = [context3 executeFetchRequest:request
                                                error:&error];
    
    objects3 = [NSKeyedUnarchiver unarchiveObjectWithData:[[objects3 objectAtIndex:3]valueForKey:@"data3"]];
    
    [_Arry3 addObjectsFromArray:objects3];
    
    
    
    NSManagedObjectContext *context4 = [app managedObjectContext];
    NSEntityDescription *entityDesc4 =[NSEntityDescription entityForName:@"List0"inManagedObjectContext:context4];
    NSFetchRequest *request4 = [[NSFetchRequest alloc] init];
    [request4 setEntity:entityDesc4];
    
    
    NSArray *objects4 = [context4 executeFetchRequest:request4
                                                error:&error];
    
    objects4 = [NSKeyedUnarchiver unarchiveObjectWithData:[[objects4 objectAtIndex:4]valueForKey:@"data3id"]];
    
    [arry2 addObjectsFromArray:objects4];
    
    
    
    
    
    
    NSManagedObjectContext *context5 = [app managedObjectContext];
    NSEntityDescription *entityDesc5 =[NSEntityDescription entityForName:@"List0"inManagedObjectContext:context5];
    NSFetchRequest *request5 = [[NSFetchRequest alloc] init];
    [request5 setEntity:entityDesc5];
    
    
    NSArray *objects5 = [context5 executeFetchRequest:request
                                                error:&error];
    
    objects5 = [NSKeyedUnarchiver unarchiveObjectWithData:[[objects5 objectAtIndex:5]valueForKey:@"data4"]];
    
    [_Arry4 addObjectsFromArray:objects5];
    
    
    
    
    
    NSManagedObjectContext *context6 = [app managedObjectContext];
    NSEntityDescription *entityDesc6 =[NSEntityDescription entityForName:@"List0"inManagedObjectContext:context6];
    NSFetchRequest *request6 = [[NSFetchRequest alloc] init];
    [request6 setEntity:entityDesc6];
    
    
    NSArray *objects6 = [context6 executeFetchRequest:request6
                                                error:&error];
    
    objects6 = [NSKeyedUnarchiver unarchiveObjectWithData:[[objects6 objectAtIndex:6]valueForKey:@"data4id"]];
    
    [arry3 addObjectsFromArray:objects6];
    
    
    
    NSManagedObjectContext *context7 = [app managedObjectContext];
    NSEntityDescription *entityDesc7 =[NSEntityDescription entityForName:@"List0"inManagedObjectContext:context7];
    NSFetchRequest *request7 = [[NSFetchRequest alloc] init];
    [request7 setEntity:entityDesc7];
    
    
    NSArray *objects7 = [context7 executeFetchRequest:request7
                                                error:&error];
    
    objects7 = [NSKeyedUnarchiver unarchiveObjectWithData:[[objects7 objectAtIndex:7]valueForKey:@"data5"]];
    
    [_Arry5 addObjectsFromArray:objects7];
    
    
    
    
    
    NSManagedObjectContext *context8 = [app managedObjectContext];
    NSEntityDescription *entityDesc8 =[NSEntityDescription entityForName:@"List0"inManagedObjectContext:context8];
    NSFetchRequest *request8 = [[NSFetchRequest alloc] init];
    [request8 setEntity:entityDesc8];
    
    
    NSArray *objects8 = [context8 executeFetchRequest:request8
                                                error:&error];
    
    objects8 = [NSKeyedUnarchiver unarchiveObjectWithData:[[objects8 objectAtIndex:8]valueForKey:@"data5id"]];
    
    [arry4 addObjectsFromArray:objects8];
    
    
    
    
    
    [spinner stopAnimating];
    
    [spinner removeFromSuperview];
    
    [polygonView removeFromSuperview];
    
    
    
    
    
    
}
-(void)putdata
{
    NSString *url = [NSString stringWithFormat:@"%@json_output.php?mode=search_values",App_Domain_Url];
    
    
    [obj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error)
     
     {
         
         
         
         
         
         
         
         temp = [result mutableCopy];
         
         
         
         NSLog(@"temp count==%lu",(long)temp.count);
         
         
         
         // _Arry1 = [[temp valueForKey:@"type"]valueForKey:@"type_name"];
         
         
         NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:[[temp valueForKey:@"type"]valueForKey:@"type_name"]];
         NSManagedObjectContext *context=[app managedObjectContext];
         NSManagedObject *newUser=[NSEntityDescription insertNewObjectForEntityForName:@"List0" inManagedObjectContext:context];
         [newUser setValue:data1 forKey:@"data1"];
         [app saveContext];
         
         
         //_Arry1 = [_Arry1 valueForKey:@"type_name"];
         
         //  arry1 = [[temp valueForKey:@"type"]valueForKey:@"id"];
         
         
         NSData *data1id = [NSKeyedArchiver archivedDataWithRootObject:[[temp valueForKey:@"type"]valueForKey:@"id"]];
         NSManagedObjectContext *context1=[app managedObjectContext];
         NSManagedObject *newUser1=[NSEntityDescription insertNewObjectForEntityForName:@"List0" inManagedObjectContext:context1];
         [newUser1 setValue:data1id forKey:@"data1id"];
         [app saveContext];
         
         
         //  NSLog(@"core data insert====%@",newUser);
         
         
         
         
         //  _Arry2 = [[temp valueForKey:@"radius"]valueForKey:@"radius_value"];
         
         NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:[[temp valueForKey:@"radius"]valueForKey:@"radius_value"]];
         NSManagedObjectContext *context2=[app managedObjectContext];
         NSManagedObject *newUser2=[NSEntityDescription insertNewObjectForEntityForName:@"List0" inManagedObjectContext:context2];
         [newUser2 setValue:data2 forKey:@"data2"];
         [app saveContext];
         
         
         //  _Arry2 = [_Arry2 valueForKey:@"radius_value"];
         
         
         
         
         
         // _Arry3 = [[temp valueForKey:@"room"]valueForKey:@"number_of_rooms"];
         
         
         NSData *data3 = [NSKeyedArchiver archivedDataWithRootObject:[[temp valueForKey:@"room"]valueForKey:@"number_of_rooms"]];
         NSManagedObjectContext *context3=[app managedObjectContext];
         NSManagedObject *newUser3=[NSEntityDescription insertNewObjectForEntityForName:@"List0" inManagedObjectContext:context3];
         [newUser3 setValue:data3 forKey:@"data3"];
         [app saveContext];
         
         // _Arry3 = [_Arry3 valueForKey:@"number_of_rooms"];
         
         //arry2 = [[temp valueForKey:@"room"]valueForKey:@"id"];
         
         // NSLog(@"arry2.....%@",arry2);
         
         NSData *data3id = [NSKeyedArchiver archivedDataWithRootObject:[[temp valueForKey:@"room"]valueForKey:@"id"]];
         NSManagedObjectContext *context4=[app managedObjectContext];
         NSManagedObject *newUser4=[NSEntityDescription insertNewObjectForEntityForName:@"List0" inManagedObjectContext:context4];
         [newUser4 setValue:data3id forKey:@"data3id"];
         [app saveContext];
         
         
         //   _Arry4 = [[temp valueForKey:@"price"]valueForKey:@"price_amount"];
         
         NSData *data4 = [NSKeyedArchiver archivedDataWithRootObject:[[temp valueForKey:@"price"]valueForKey:@"price_amount"]];
         NSManagedObjectContext *context5=[app managedObjectContext];
         NSManagedObject *newUser5=[NSEntityDescription insertNewObjectForEntityForName:@"List0" inManagedObjectContext:context5];
         [newUser5 setValue:data4 forKey:@"data4"];
         [app saveContext];
         
         // _Arry4 = [_Arry4 valueForKey:@"price_amount"];
         
         //arry3= [[temp valueForKey:@"price"]valueForKey:@"id"];
         
         
         NSData *data4id = [NSKeyedArchiver archivedDataWithRootObject:[[temp valueForKey:@"price"]valueForKey:@"id"]];
         NSManagedObjectContext *context6=[app managedObjectContext];
         NSManagedObject *newUser6=[NSEntityDescription insertNewObjectForEntityForName:@"List0" inManagedObjectContext:context6];
         [newUser6 setValue:data4id forKey:@"data4id"];
         [app saveContext];
         
         // NSLog(@"arry3.....%@",arry3);
         
         
         
         //   _Arry5 = [[temp valueForKey:@"addedtime"]valueForKey:@"added_value"];
         
         NSData *data5 = [NSKeyedArchiver archivedDataWithRootObject:[[temp valueForKey:@"addedtime"]valueForKey:@"added_value"]];
         NSManagedObjectContext *context7=[app managedObjectContext];
         NSManagedObject *newUser7=[NSEntityDescription insertNewObjectForEntityForName:@"List0" inManagedObjectContext:context7];
         [newUser7 setValue:data5 forKey:@"data5"];
         [app saveContext];
         
         // _Arry5 = [_Arry5 valueForKey:@"added_value"];
         
         // arry4 =[[temp valueForKey:@"addedtime"]valueForKey:@"id"];
         NSData *data5id = [NSKeyedArchiver archivedDataWithRootObject:[[temp valueForKey:@"addedtime"]valueForKey:@"id"]];
         NSManagedObjectContext *context8=[app managedObjectContext];
         NSManagedObject *newUser8=[NSEntityDescription insertNewObjectForEntityForName:@"List0" inManagedObjectContext:context8];
         [newUser8 setValue:data5id forKey:@"data5id"];
         [app saveContext];
         
         
         NSLog(@"core data reload================================");
         [spinner stopAnimating];
         
         [spinner removeFromSuperview];
         
         [polygonView removeFromSuperview];
         
         
     }];
    
    
    
    
    
    
    
    
    
}



@end