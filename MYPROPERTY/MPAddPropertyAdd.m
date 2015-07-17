//
//  MPAddPropertyAdd.m
//  MYPROPERTY
//
//  Created by Somenath on 14/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "MPAddPropertyAdd.h"
#import "Footer.h"
#import "RightMenu.h"

@interface MPAddPropertyAdd () <UITableViewDataSource, UITableViewDelegate, footerdelegate, UIPickerViewDelegate,UIPickerViewDataSource>
{
    BOOL leftslide,rightslide;
    
    RightMenu *rightView;
    UIView *blackview, *pickerview;
    Footer *footerView;
    NSMutableArray *celllblarr;
    NSMutableSet *collapsedSections;
    NSMutableDictionary *dicTab;
    NSMutableDictionary *dicBtn;
    NSMutableDictionary *dicTab1;
    NSMutableDictionary *dicBtn1;
    NSInteger prev;
    UIDatePicker *datepicker;
    UIButton *headerButton;
    UIPickerView *picker;
    NSMutableArray *hours;
    UILabel *timelblstart, *timelblend;
    NSInteger pickerflag;
    NSString *selecttime, *selecttimestart;
    UIButton *headerTapped;
    NSInteger tapcheck,tickbool;
    UIImageView *checkimg;
    NSMutableArray *selectedRows, *sectionar0, *sectionar1, *sectionar2, *sectionar3, *sectionar4 ;

}

@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UIView *mainview;
@property (strong, nonatomic) IBOutlet UILabel *datelbl;
@end

@implementation MPAddPropertyAdd

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    celllblarr = [NSMutableArray arrayWithObjects:@"STARTS FROM: ", @"FINISH BY: ", nil];
    hours = [NSMutableArray arrayWithObjects:@"00:00",@"01:00",@"02:00",@"03:00",@"04:00",@"05:00",@"06:00",@"07:00",@"08:00",@"09:00",@"10:00",@"11:00",@"12:00",@"13:00",@"14:00",@"15:00",@"16:00",@"17:00",@"18:00",@"19:00",@"20:00",@"21:00",@"22:00",@"23:00",@"24:00", nil];
    
//    arraytime = [NSMutableArray arrayWithObjects:@"00:00",@"00:00",@"00:00",@"00:00",@"00:00",@"00:00",@"00:00",@"00:00",@"00:00",@"00:00", nil];
    
    sectionar0 = [NSMutableArray arrayWithCapacity:2];
    
    sectionar0 = [NSMutableArray arrayWithObjects:@"00:00",@"00:00", nil];
    sectionar1 = [[NSMutableArray alloc]initWithObjects:@"00:00",@"00:00", nil];
    sectionar2 = [[NSMutableArray alloc]initWithObjects:@"00:00",@"00:00", nil];
    sectionar3 = [[NSMutableArray alloc]initWithObjects:@"00:00",@"00:00", nil];
    sectionar4 = [[NSMutableArray alloc]initWithObjects:@"00:00",@"00:00", nil];
    
    collapsedSections = [NSMutableSet new];
    tapcheck = 0;
    
    footerView=[[Footer alloc]init];
    blackview = [[UIView alloc]init];
    
//    [footerView setFrame:CGRectMake(0, self.view.frame.size.height - 60, self.view.frame.size.width, 60)];
    
    tickbool = 0;
    
    prev=9;
    
    dicTab=[[NSMutableDictionary alloc]init];
    dicBtn=[[NSMutableDictionary alloc]init];
    
    dicTab1=[[NSMutableDictionary alloc]init];
    dicBtn1=[[NSMutableDictionary alloc]init];
    
    selectedRows = [[NSMutableArray alloc]init];
    
//    _tableview.scrollEnabled = NO;
    
//    footerView.footerdelegate=self;
//    [self.mainview addSubview:footerView];
}

//tableview data source and delegate protocols

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0f;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _tableview.frame.size.width, 40)];
    headerView.backgroundColor=[UIColor clearColor];
    UIImageView *sectionimg = [[UIImageView alloc]initWithFrame:CGRectMake (0, 0,[UIScreen mainScreen].bounds.size.width, 39)];
    sectionimg.image = [UIImage imageNamed:@"rowlbl"];
    headerView.tag=section;
    UILabel *headLbl=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 120, 40)];
    headLbl.textColor=[UIColor colorWithRed:36.0f/255.0f green:36.0f/255.0f blue:36.0f/255.0f alpha:1];
    headLbl.font=[UIFont fontWithName:@"Open Sans" size:14.0f];
//    headLbl.text=[NSString stringWithFormat:@"Section %ld",(long)section];
    
    if (section == 0)
    {
        headLbl.text = @"MONDAY";
    }
    else if(section == 1)
    {
        headLbl.text = @"TUESDAY";
    }
    else if(section == 2)
    {
        headLbl.text = @"WEDNESSDAY";
    }
    else if (section == 3)
    {
        headLbl.text = @"THURSDAY";
    }
    else
    {
        headLbl.text = @"FRIDAY";
    }

    UIImageView *plusimg = [[UIImageView alloc]initWithFrame:CGRectMake(headerView.bounds.size.width-35, (headerView.bounds.size.height-20)/2, 20, 20)];
    checkimg = [[UIImageView alloc]initWithFrame:CGRectMake(headerView.bounds.size.width-90, (headerView.bounds.size.height-20)/2, 20, 20)];
    
    plusimg.image = [UIImage imageNamed:@"plus_grey"];
    checkimg.image = [UIImage imageNamed:@"check_unselect"];
    
    headerTapped = [[UIButton alloc]initWithFrame:CGRectMake(headerView.bounds.size.width-110, 0, 50, 39)];
    headerTapped.backgroundColor = [UIColor clearColor];
    [headerTapped addTarget:self action:@selector(headerTappedAction:) forControlEvents:UIControlEventTouchUpInside];
    
    headerButton=[[UIButton alloc]initWithFrame:CGRectMake(headerView.bounds.size.width-60, 0, 60, 39)];
    headerButton.backgroundColor = [UIColor clearColor];
    headerButton.tag=section;
    NSString *key=[NSString stringWithFormat:@"%ld",(long)section];
    if([dicBtn valueForKey:key])
    {
        plusimg.image = [UIImage imageNamed:@"minus_grey"];
    }
    else
    {
        plusimg.image = [UIImage imageNamed:@"plus_grey"];
        
    }
    
    NSString *key1=[NSString stringWithFormat:@"%ld",(long)section];
    
    if ([dicBtn1 valueForKey:key1])
    {
        checkimg.image = [UIImage imageNamed:@"check"];
    }
    else
    {
        checkimg.image = [UIImage imageNamed:@"check_unselect"];
    }
    
    [headerButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [headerView addSubview:sectionimg];
    [headerView addSubview:checkimg];
    [headerView addSubview:plusimg];
    [headerView addSubview:headerButton];
    [headerView addSubview:headerTapped];
    [headerView addSubview:headLbl];
    
    // NSLog(@"Button for section %ld is created",(long)section);
    
    return headerView;
}
- (IBAction)backTaped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)headerTappedAction: (id)sender
{
    UIButton *tapped_button=(UIButton *)(id)sender;
    UIView *supView=[tapped_button superview];
    NSLog(@"Superview tag is: %ld and prev value is: %ld",(long)supView.tag,(long)prev);
    NSString *key=[NSString stringWithFormat:@"%ld",(long)supView.tag];
    NSInteger section=supView.tag;
    if(![dicBtn1 valueForKey:key])
    {
        prev=supView.tag;
        NSString *key=[NSString stringWithFormat:@"%ld",(long)supView.tag];
        [dicTab1 setObject:@"YES" forKey:key];
        [dicBtn1 setObject:@"YES" forKey:key];
        NSLog(@"dic1---%@",dicBtn1);
        [_tableview reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:NO];
//        checkimg.image = [UIImage imageNamed:@"check"];
    }
    
    else
    {
        NSLog(@"Entering second condition...");
        NSString *key=[NSString stringWithFormat:@"%ld",(long)supView.tag];
        [dicTab1 removeObjectForKey:key];
        [dicBtn1 removeObjectForKey:key];
        [_tableview reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:NO];
//        checkimg.image = [UIImage imageNamed:@"check_unselect"];
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellid";
    cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell = [[UITableViewCell alloc]init];
    
    UIImageView *divider = [[UIImageView alloc]initWithFrame:CGRectMake(0, 49, self.view.frame.size.width, 1)];
    divider.image = [UIImage imageNamed:@"divider-line"];
    
    CGFloat width = self.view.frame.size.width - 30;
    
    UIImageView *plus = [[UIImageView alloc]initWithFrame:CGRectMake(width, 16, 11, 18)];
    plus.contentMode = UIViewContentModeScaleAspectFit;
    plus.image = [UIImage imageNamed:@"arrow"];
    
    UILabel *celllbl = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 49)];
    celllbl.text = [celllblarr objectAtIndex:indexPath.row];
    
    celllbl.font = [UIFont fontWithName:@"Open Sans" size:14.0f];
    celllbl.textColor = [UIColor colorWithRed:36.0f/255.0f green:36.0f/255.0f blue:36.0f/255.0f alpha:1];
    
    timelblstart = [[UILabel alloc]initWithFrame:CGRectMake(120, 0, 150, 49)];
    timelblstart.font = [UIFont fontWithName:@"Open Sans" size:14.0f];
    timelblstart.textColor = [UIColor colorWithRed:36.0f/255.0f green:36.0f/255.0f blue:36.0f/255.0f alpha:1];
    timelblstart.text = @"00:00";
    [cell addSubview:timelblstart];
    if (indexPath.section == 0)
    {
        timelblstart.text = [sectionar0 objectAtIndex:indexPath.row];
    }
    else if(indexPath.section == 1)
    {
        timelblstart.text = [sectionar1 objectAtIndex:indexPath.row];
    }
    else if(indexPath.section == 2)
    {
        timelblstart.text = [sectionar2 objectAtIndex:indexPath.row];
    }
    else if (indexPath.section == 3)
    {
        timelblstart.text = [sectionar3 objectAtIndex:indexPath.row];
    }
    else
    {
        timelblstart.text = [sectionar4 objectAtIndex:indexPath.row];
    }
    
    
    
 
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell addSubview:plus];
    [cell addSubview:celllbl];
//    [cell addSubview:timelblstart];
//    [cell addSubview:timelblend];
    [cell addSubview:divider];
    return  cell;
}

-(void)buttonTapped:(id)sender
{
    UIButton *tapped_button=(UIButton *)(id)sender;
    UIView *supView=[tapped_button superview];
    NSLog(@"Superview tag is: %ld and prev value is: %ld",(long)supView.tag,(long)prev);
    NSString *key=[NSString stringWithFormat:@"%ld",(long)supView.tag];
    NSInteger section=supView.tag;
    if(![dicBtn valueForKey:key])
    {
        
        prev=supView.tag;
        NSString *key=[NSString stringWithFormat:@"%ld",(long)supView.tag];
        [dicTab setObject:@"YES" forKey:key];
        [dicBtn setObject:@"YES" forKey:key];
        [_tableview reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    
    else
    {
        NSLog(@"Entering second condition...");
        NSString *key=[NSString stringWithFormat:@"%ld",(long)supView.tag];
        [dicTab removeObjectForKey:key];
        [dicBtn removeObjectForKey:key];
        [_tableview reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}




//-(void)buttonTapped:(id)sender
//{
//    
//    
//    UIButton *tapped_button=(UIButton *)(id)sender;
//    UIView *supView=[tapped_button superview];
//    NSLog(@"Superview tag is: %ld and prev value is: %ld",(long)supView.tag,(long)_prev);
//    NSString *key=[NSString stringWithFormat:@"%ld",(long)supView.tag];
//    NSInteger section=supView.tag;
//    if(![dicBtn valueForKey:key])
//    {
//        
//        _prev=supView.tag;
//        NSString *key=[NSString stringWithFormat:@"%ld",(long)supView.tag];
//        [dicTab setObject:@"YES" forKey:key];
//        [dicBtn setObject:@"YES" forKey:key];
//        [_myTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationLeft];
//        
//    }
//    
//    else
//    {
//        NSLog(@"Entering second condition...");
//        NSString *key=[NSString stringWithFormat:@"%ld",(long)supView.tag];
//        [dicTab removeObjectForKey:key];
//        [dicBtn removeObjectForKey:key];
//        [_myTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationRight];
//        
//    }
//    
//    
//    
//}



//-(NSArray*) indexPathsForSection:(int)section withNumberOfRows:(int)numberOfRows {
//    NSMutableArray* indexPaths = [NSMutableArray new];
//    for (int i = 0; i < numberOfRows; i++) {
//        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:section];
//        [indexPaths addObject:indexPath];
//    }
//    return indexPaths;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(section==0)
    {
        if([dicTab valueForKey:@"0"])
            return 2;
        else
            return 0;
    }
    if(section==1)
    {
        if([dicTab valueForKey:@"1"])
            return 2;
        else
            return 0;
    }
    if(section==2)
    {
        if([dicTab valueForKey:@"2"])
            return 2;
        else
            return 0;
    }
    if(section==3)
    {
        if([dicTab valueForKey:@"3"])
            return 2;
        else
            return 0;
    }
    if(section==4)
    {
        if([dicTab valueForKey:@"4"])
            return 2;
        else
            return 0;
    }
    
    return 0;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![selectedRows containsObject:indexPath])
        [selectedRows addObject:indexPath];
    else
        [selectedRows removeObject:indexPath];
    NSLog(@"selected rows----%@",selectedRows);
    
//    [_tableview reloadRowsAtIndexPaths:@[indexPath]];
    
    [pickerview removeFromSuperview];
    
    if (indexPath.section == 0)
    {
        tapcheck = 1;
        if (indexPath.row == 0)
        {
            pickerflag = 0;
        }
        else if (indexPath.row == 1)
        {
            pickerflag = 1;
        }

    }
    else if (indexPath.section == 1)
    {
        tapcheck = 2;
        if (indexPath.row == 0)
        {
            pickerflag = 0;
        }
        else if (indexPath.row == 1)
        {
            pickerflag = 1;
        }
    }
    else if (indexPath.section == 2)
    {
        tapcheck = 3;
        if (indexPath.row == 0)
        {
            pickerflag = 0;
        }
        else if (indexPath.row == 1)
        {
            pickerflag = 1;
        }
    }
    else if (indexPath.section == 3)
    {
        tapcheck = 4;
        if (indexPath.row == 0)
        {
            pickerflag = 0;
        }
        else if (indexPath.row == 1)
        {
            pickerflag = 1;
        }
    }
    else if (indexPath.section == 4)
    {
        tapcheck = 5;
        if (indexPath.row == 0)
        {
            pickerflag = 0;
        }
        else if (indexPath.row == 1)
        {
            pickerflag = 1;
        }
    }
    
//    NSLog(@"array: %@",arraytime);

        [self createpicker];
    
    NSLog(@"indexpath----%ld",(long)indexPath.row);
}

//Adding animation for editing purpose

- (void) setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing
             animated:animated];
    [self.tableview setEditing:editing
                        animated:animated];
}


-(void)OpenDatePicker
{
    pickerview = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - self.view.frame.size.height * .45, self.view.frame.size.width, self.view.frame.size.height * .45)];
    
    pickerview.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *okbtn=[[UIButton alloc]initWithFrame:CGRectMake(0, pickerview.frame.size.height - 40, pickerview.frame.size.width/2, 40)];
    UIButton *cancelbtn=[[UIButton alloc]initWithFrame:CGRectMake(pickerview.frame.size.width/2, pickerview.frame.size.height - 40, pickerview.frame.size.width/2, 40)];
    cancelbtn.backgroundColor=[UIColor darkGrayColor];
    [cancelbtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelbtn setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1] forState:UIControlStateNormal];
    
    [pickerview addSubview:cancelbtn];
    [pickerview addSubview:okbtn];
    okbtn.backgroundColor=[UIColor darkGrayColor];
    [okbtn setTitle:@"Ok" forState:UIControlStateNormal];
    [okbtn setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1] forState:UIControlStateNormal];
    
    [okbtn addTarget:self action:@selector(okDateAction) forControlEvents:UIControlEventTouchUpInside];
    
    [cancelbtn addTarget:self action:@selector(cancelDateAction) forControlEvents:UIControlEventTouchUpInside];
    
    datepicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, pickerview.frame.size.height - okbtn.frame.size.height)];
    //    [datepicker sizeToFit];
    [datepicker setDatePickerMode:UIDatePickerModeDate];
    [datepicker setMinimumDate:[NSDate date]];
    
    [pickerview addSubview:datepicker];
    [self.view addSubview:pickerview];
}

-(void)okDateAction
{
    [pickerview removeFromSuperview];
    NSDateFormatter *dateFormator=[[NSDateFormatter alloc] init];
    [dateFormator setDateFormat:@"dd-MM-YYYY"];
//    [dateFormator setDateFormat:@"YYYY-MM-dd"];
    NSString *datenew=[dateFormator stringFromDate:datepicker.date];
    [self.datelbl setText:datenew];
}

-(void) cancelDateAction
{
    [pickerview removeFromSuperview];
}

- (IBAction)dateAvailableTapped:(id)sender
{
    NSLog(@"pickUpDateTapped");
    
    [pickerview removeFromSuperview];
    [datepicker removeFromSuperview];
    [self OpenDatePicker];
}

-(void)createpicker
{
    pickerview = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - self.view.frame.size.height * .4, self.view.frame.size.width, self.view.frame.size.height * .4)];
    
    //    pickerview.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1];
    
    pickerview.backgroundColor = [UIColor whiteColor];
    
    UIButton *okbtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, pickerview.frame.size.width/2, 40)];
    UIButton *cancelbtn=[[UIButton alloc]initWithFrame:CGRectMake(pickerview.frame.size.width/2, 0, pickerview.frame.size.width/2, 40)];
    cancelbtn.backgroundColor=[UIColor darkGrayColor];
    [cancelbtn setTitle:@"Cancel" forState:UIControlStateNormal];
    
    [pickerview addSubview:cancelbtn];
    [pickerview addSubview:okbtn];
    okbtn.backgroundColor=[UIColor darkGrayColor];
    [okbtn setTitle:@"Ok" forState:UIControlStateNormal];
    
    [okbtn addTarget:self action:@selector(okaction) forControlEvents:UIControlEventTouchUpInside];
    
    [cancelbtn addTarget:self action:@selector(cancelaction) forControlEvents:UIControlEventTouchUpInside];
    
    
    picker=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 40,[UIScreen mainScreen].bounds.size.width, pickerview.frame.size.height - 40)];
    
    [pickerview addSubview:picker];
    [self.view addSubview:pickerview];
    //    [picker setBackgroundColor: [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1]];
    
    picker.delegate = self;
    picker.dataSource = self;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return hours.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [hours objectAtIndex:row];
}


-(void)okaction
{   if (tapcheck == 1)
    {
        if (pickerflag == 0)
        {
            selecttime = [hours objectAtIndex:[picker selectedRowInComponent:0]];
            NSLog(@"picker selected:----%@",selecttime);
//            timelblstart.text = selecttimestart;
            [sectionar0 insertObject:selecttime atIndex:0];
            [pickerview removeFromSuperview];
        }
        else if (pickerflag == 1)
        {
            selecttime = [hours objectAtIndex:[picker selectedRowInComponent:0]];
            NSLog(@"picker selected:----%@",selecttime);
//            timelblend.text = selecttime;
            [sectionar0 insertObject:selecttime atIndex:1];
            [pickerview removeFromSuperview];

        }
        [_tableview reloadData];
    }
    else if (tapcheck == 2)
    {
        if (pickerflag == 0)
        {
            selecttime = [hours objectAtIndex:[picker selectedRowInComponent:0]];
            NSLog(@"picker selected:----%@",selecttime);
//            timelblstart.text = selecttimestart;
            [sectionar1 insertObject:selecttime atIndex:0];
            [pickerview removeFromSuperview];
        }
        else if (pickerflag == 1)
        {
            selecttime = [hours objectAtIndex:[picker selectedRowInComponent:0]];
            NSLog(@"picker selected:----%@",selecttime);
//            timelblend.text = selecttime;
            [sectionar1 insertObject:selecttime atIndex:1];
            [pickerview removeFromSuperview];
            
        }
        [_tableview reloadData];
    }
    else if (tapcheck == 3)
    {
        if (pickerflag == 0)
        {
            selecttime = [hours objectAtIndex:[picker selectedRowInComponent:0]];
            NSLog(@"picker selected:----%@",selecttime);
//            timelblstart.text = selecttimestart;
            [sectionar2 insertObject:selecttime atIndex:0];
            [pickerview removeFromSuperview];
        }
        else if (pickerflag == 1)
        {
            selecttime = [hours objectAtIndex:[picker selectedRowInComponent:0]];
            NSLog(@"picker selected:----%@",selecttime);
//            timelblend.text = selecttime;
            [sectionar2 insertObject:selecttime atIndex:1];
            [pickerview removeFromSuperview];
        }
        [_tableview reloadData];
    }
    else if (tapcheck == 4)
    {
        if (pickerflag == 0)
        {
            selecttime = [hours objectAtIndex:[picker selectedRowInComponent:0]];
            NSLog(@"picker selected:----%@",selecttime);
//            timelblstart.text = selecttimestart;
            [sectionar3 insertObject:selecttime atIndex:0];
            [pickerview removeFromSuperview];
        }
        else if (pickerflag == 1)
        {
            selecttime = [hours objectAtIndex:[picker selectedRowInComponent:0]];
            NSLog(@"picker selected:----%@",selecttime);
//            timelblend.text = selecttime;
            [sectionar3 insertObject:selecttime atIndex:1];
            [pickerview removeFromSuperview];
        }
        [_tableview reloadData];
    }
    else if (tapcheck == 5)
    {
        if (pickerflag == 0)
        {
            selecttime = [hours objectAtIndex:[picker selectedRowInComponent:0]];
            NSLog(@"picker selected:----%@",selecttime);
//            timelblstart.text = selecttimestart;
            [sectionar4 insertObject:selecttime atIndex:0];
            [pickerview removeFromSuperview];
        }
        else if (pickerflag == 1)
        {
            selecttime = [hours objectAtIndex:[picker selectedRowInComponent:0]];
            NSLog(@"picker selected:----%@",selecttime);
//            timelblend.text = selecttime;
            [sectionar4 insertObject:selecttime atIndex:1];
            [pickerview removeFromSuperview];
        }
        [_tableview reloadData];
    }
    NSLog(@"array0:-----%@,arr1-----%@,arr2-----%@,arr3-----%@,arr4-----%@",sectionar0,sectionar1,sectionar2,sectionar3,sectionar4);
}

-(void)cancelaction
{
    [pickerview removeFromSuperview];
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
