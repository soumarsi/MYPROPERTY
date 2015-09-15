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
#import "MPMyAddvertisementViewController.h"


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
    NSMutableArray *hours,*hours2;
    UILabel *timelblstart, *timelblend;
    NSInteger pickerflag;
    NSString *selecttime, *selecttimestart;
    UIButton *headerTapped;
    NSInteger tapcheck,tickbool;
    UIImageView *checkimg;
    NSMutableArray *selectedRows, *sectionar0, *sectionar1, *sectionar2, *sectionar3, *sectionar4 ;
    NSString *chkstring0;
    NSString *chkstring1;
    NSString *chkstring2;
    NSString *chkstring3;
    NSString *chkstring4;
    UIView *polygonView;
    NSUserDefaults *userinfo;
    NSString *userid;
    NSInteger mondaysrttimechk,mondayendtimechk,tuesdaysrttime,tuesdayendtime,wednessdaysrttime,wednessdayendtime,thurdaysrttime,thurdayendime,fridaysrttime,fridayendtime;
    BOOL finishtimetap,finishtimetap1,finishtimetap2,finishtimetap3,finishtimetap4,cellchk;
    NSUserDefaults *chakingdata;
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
    chakingdata=[[NSUserDefaults alloc] init];
    
    userinfo=[[NSUserDefaults alloc]init];
    
    userid = [userinfo objectForKey:@"id"];
    NSLog(@"userid is : %@",userid);
    
    celllblarr = [NSMutableArray arrayWithObjects:@"STARTS FROM: ", @"FINISH BY: ", nil];
    hours = [NSMutableArray arrayWithObjects:@"00:00",@"01:00",@"02:00",@"03:00",@"04:00",@"05:00",@"06:00",@"07:00",@"08:00",@"09:00",@"10:00",@"11:00",@"12:00",@"13:00",@"14:00",@"15:00",@"16:00",@"17:00",@"18:00",@"19:00",@"20:00",@"21:00",@"22:00", nil];
    
    hours2 = [NSMutableArray arrayWithObjects:@"00:00",@"01:00",@"02:00",@"03:00",@"04:00",@"05:00",@"06:00",@"07:00",@"08:00",@"09:00",@"10:00",@"11:00",@"12:00",@"13:00",@"14:00",@"15:00",@"16:00",@"17:00",@"18:00",@"19:00",@"20:00",@"21:00",@"22:00",@"23:00", nil];
    
    
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
    obj=[[FW_JsonClass alloc]init];
    NSLog(@"finalbutton%@",_mypropertyRent);
    NSLog(@"finalbutton%@",_mypropertySell);
    NSLog(@"finalbutton%@",_editforRent);
    NSLog(@"finalbutton%@",_editforSell);
    
    
    NSLog(@"data1%@",_price_text);
    NSLog(@"data2%@",_rentofproperty1);
    NSLog(@"data2%@",_rentalterm1);
    NSLog(@"data2%@",_propertycontent1);
    NSLog(@"data2%@",_saleofproperty1);
    
    finishtimetap=true;
    finishtimetap1=true;
    finishtimetap2=true;
    finishtimetap3=true;
    finishtimetap4=true;
    
    
    
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
        
        if (section==0) {
            chkstring0=@"Y";
        }
        if (section==1) {
            chkstring1=@"Y";
        }
        if (section==2) {
            chkstring2=@"Y";
        }
        if (section==3) {
            chkstring3=@"Y";
        }
        if (section==4) {
            chkstring4=@"Y";
        }
        
        NSLog(@"%@",chkstring0);
        NSLog(@"%@",chkstring1);
        NSLog(@"%@",chkstring2);
        NSLog(@"%@",chkstring3);
        NSLog(@"%@",chkstring4);
    }
    else
    {
        checkimg.image = [UIImage imageNamed:@"check_unselect"];
        if (section==0) {
            chkstring0=@"N";
        }
        if (section==1) {
            chkstring1=@"N";
        }
        if (section==2) {
            chkstring2=@"N";
        }
        if (section==3) {
            chkstring3=@"N";
        }
        if (section==4) {
            chkstring4=@"N";
        }
        NSLog(@"%@",chkstring0);
        NSLog(@"%@",chkstring1);
        NSLog(@"%@",chkstring2);
        NSLog(@"%@",chkstring3);
        NSLog(@"%@",chkstring4);
        
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
            _dateAvailableTapped.hidden=YES;
            pickerflag = 0;
            cellchk=true;
        }
        else if (indexPath.row == 1)
        {
            _dateAvailableTapped.hidden=YES;
            pickerflag = 1;
            cellchk=false;
        }
        
    }
    else if (indexPath.section == 1)
    {
        tapcheck = 2;
        if (indexPath.row == 0)
        {
            _dateAvailableTapped.hidden=YES;
            pickerflag = 0;
        }
        else if (indexPath.row == 1)
        {
            _dateAvailableTapped.hidden=YES;
            pickerflag = 1;
        }
    }
    else if (indexPath.section == 2)
    {
        tapcheck = 3;
        if (indexPath.row == 0)
        {
            _dateAvailableTapped.hidden=YES;
            pickerflag = 0;
        }
        else if (indexPath.row == 1)
        {
            _dateAvailableTapped.hidden=YES;
            pickerflag = 1;
        }
    }
    else if (indexPath.section == 3)
    {
        tapcheck = 4;
        if (indexPath.row == 0)
        {
            _dateAvailableTapped.hidden=YES;
            pickerflag = 0;
        }
        else if (indexPath.row == 1)
        {
            _dateAvailableTapped.hidden=YES;
            pickerflag = 1;
        }
    }
    else if (indexPath.section == 4)
    {
        tapcheck = 5;
        if (indexPath.row == 0)
        {
            _dateAvailableTapped.hidden=YES;
            pickerflag = 0;
        }
        else if (indexPath.row == 1)
        {
            _dateAvailableTapped.hidden=YES;
            pickerflag = 1;
        }
    }
    
    //    NSLog(@"array: %@",arraytime);
    
    [self createpicker];\
    _mainview.userInteractionEnabled=NO;
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
    //[dateFormator setDateFormat:@"dd-MM-YYYY"];
    [dateFormator setDateFormat:@"YYYY-MM-dd"];
    NSString *datenew=[dateFormator stringFromDate:datepicker.date];
    [self.datelbl setText:datenew];
    
    //date pick.......////.......
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
    if (cellchk==true) {
        return hours.count;
    }
    else if (cellchk==false)
    {
    return hours2.count;
    }
    return 0;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (cellchk==true) {
        return [hours objectAtIndex:row];
    }
    else if (cellchk==false)
    {
        return [hours2 objectAtIndex:row];
    }
    return 0;
}


-(void)okaction
{
    if (tapcheck == 1)
    {
        if (pickerflag == 0)
        {
            [sectionar0 removeObjectAtIndex:0];
            selecttime = [hours objectAtIndex:[picker selectedRowInComponent:0]];
            mondaysrttimechk=[selecttime integerValue];
            NSLog(@"picker selected:----%@",selecttime);
            //            timelblstart.text = selecttimestart;
            //[sectionar0 insertObject:selecttime atIndex:0];
            if (finishtimetap==false) {
                if (mondaysrttimechk>mondayendtimechk || mondaysrttimechk==mondayendtimechk) {
                    [sectionar0 insertObject:@"00.00" atIndex:0];
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Finish Time Must Be Greater Than Start Time"
                                                                   message: @"It is mandatory"
                                                                  delegate: self
                                                         cancelButtonTitle:@"Cancel"
                                                         otherButtonTitles:nil,nil];
                    
                    [alert show];
                }
                else
                {
                    _dateAvailableTapped.hidden=NO;
                    [pickerview removeFromSuperview];
                    [sectionar0 insertObject:selecttime atIndex:0];
                    _mainview.userInteractionEnabled=YES;
                }
            }
            else
            {
                _dateAvailableTapped.hidden=NO;
                [pickerview removeFromSuperview];
                [sectionar0 insertObject:selecttime atIndex:0];
                _mainview.userInteractionEnabled=YES;
            }
        }
        else if (pickerflag == 1)
        {
            finishtimetap=false;
            [sectionar0 removeObjectAtIndex:1];
            selecttime = [hours2 objectAtIndex:[picker selectedRowInComponent:0]];
            mondayendtimechk=[selecttime integerValue];
            NSLog(@"picker selected:----%@",selecttime);
            //            timelblend.text = selecttime;
            //[sectionar0 insertObject:selecttime atIndex:1];
            if (mondayendtimechk > mondaysrttimechk) {
                
                [pickerview removeFromSuperview];
                [sectionar0 insertObject:selecttime atIndex:1];
                _dateAvailableTapped.hidden=NO;
                _mainview.userInteractionEnabled=YES;
                
            }
            else
            {
                [sectionar0 insertObject:@"00.00" atIndex:1];
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Finish Time Must Be Greater Than Start Time"
                                                               message: @"It is mandatory"
                                                              delegate: self
                                                     cancelButtonTitle:@"Cancel"
                                                     otherButtonTitles:nil,nil];
                
                [alert show];
            }
            
            
        }
        [_tableview reloadData];
    }
    else if (tapcheck == 2)
    {
        if (pickerflag == 0)
        {
            [sectionar1 removeObjectAtIndex:0];
            selecttime = [hours objectAtIndex:[picker selectedRowInComponent:0]];
            tuesdaysrttime=[selecttime integerValue];
            NSLog(@"picker selected:----%@",selecttime);
            //            timelblstart.text = selecttimestart;
            //[sectionar1 insertObject:selecttime atIndex:0];
            if (finishtimetap1==false) {
                if (tuesdaysrttime > tuesdayendtime || tuesdaysrttime==tuesdayendtime) {
                    [sectionar1 insertObject:@"00.00" atIndex:0];
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Finish Time Must Be Greater Than Start Time"
                                                                   message: @"It is mandatory"
                                                                  delegate: self
                                                         cancelButtonTitle:@"Cancel"
                                                         otherButtonTitles:nil,nil];
                    
                    [alert show];
                }
                else
                {
                    _dateAvailableTapped.hidden=NO;
                    [pickerview removeFromSuperview];
                    [sectionar1 insertObject:selecttime atIndex:0];
                    _mainview.userInteractionEnabled=YES;
                }
            }
            else
            {
                _dateAvailableTapped.hidden=NO;
                [pickerview removeFromSuperview];
                [sectionar1 insertObject:selecttime atIndex:0];
                _mainview.userInteractionEnabled=YES;
            }
            
        }
        else if (pickerflag == 1)
        {
            finishtimetap1=false;
            [sectionar1 removeObjectAtIndex:1];
            selecttime = [hours2 objectAtIndex:[picker selectedRowInComponent:0]];
            tuesdayendtime=[selecttime integerValue];
            NSLog(@"picker selected:----%@",selecttime);
            //            timelblend.text = selecttime;
            // [sectionar1 insertObject:selecttime atIndex:1];
            
            
            if (tuesdayendtime > tuesdaysrttime)
            {
                [pickerview removeFromSuperview];
                [sectionar1 insertObject:selecttime atIndex:1];
                _dateAvailableTapped.hidden=NO;
                _mainview.userInteractionEnabled=YES;
            }
            else
            {
                [sectionar1 insertObject:@"00.00" atIndex:1];
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Finish Time Must Be Greater Than Start Time"
                                                               message: @"It is mandatory"
                                                              delegate: self
                                                     cancelButtonTitle:@"Cancel"
                                                     otherButtonTitles:nil,nil];
                
                [alert show];
            }
            
            
            
        }
        [_tableview reloadData];
    }
    else if (tapcheck == 3)
    {
        if (pickerflag == 0)
        {
            [sectionar2 removeObjectAtIndex:0];
            selecttime = [hours objectAtIndex:[picker selectedRowInComponent:0]];
            wednessdaysrttime=[selecttime integerValue];
            NSLog(@"picker selected:----%@",selecttime);
            //            timelblstart.text = selecttimestart;
            //[sectionar2 insertObject:selecttime atIndex:0];
            if (finishtimetap2==false)
            {
                if (wednessdaysrttime>wednessdayendtime || wednessdaysrttime==wednessdayendtime) {
                    [sectionar2 insertObject:@"00.00" atIndex:0];
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Finish Time Must Be Greater Than Start Time"
                                                                   message: @"It is mandatory"
                                                                  delegate: self
                                                         cancelButtonTitle:@"Cancel"
                                                         otherButtonTitles:nil,nil];
                    
                    [alert show];
                }
                else
                {
                    _dateAvailableTapped.hidden=NO;
                    [pickerview removeFromSuperview];
                    [sectionar2 insertObject:selecttime atIndex:0];
                    _mainview.userInteractionEnabled=YES;
                }
            }
            else
            {
                _dateAvailableTapped.hidden=NO;
                [pickerview removeFromSuperview];
                [sectionar2 insertObject:selecttime atIndex:0];
                _mainview.userInteractionEnabled=YES;
                
            }
            
        }
        else if (pickerflag == 1)
        {
            finishtimetap2=false;
            [sectionar2 removeObjectAtIndex:1];
            selecttime = [hours2 objectAtIndex:[picker selectedRowInComponent:0]];
            wednessdayendtime=[selecttime integerValue];
            NSLog(@"picker selected:----%@",selecttime);
            //            timelblend.text = selecttime;
            //[sectionar2 insertObject:selecttime atIndex:1];
            if (wednessdayendtime > wednessdaysrttime) {
                
                [pickerview removeFromSuperview];
                [sectionar2 insertObject:selecttime atIndex:1];
                _dateAvailableTapped.hidden=NO;
                _mainview.userInteractionEnabled=YES;
            }
            else
            {
                [sectionar2 insertObject:@"00.00" atIndex:1];
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Finish Time Must Be Greater Than Start Time"
                                                               message: @"It is mandatory"
                                                              delegate: self
                                                     cancelButtonTitle:@"Cancel"
                                                     otherButtonTitles:nil,nil];
                
                [alert show];
            }
        }
        [_tableview reloadData];
    }
    else if (tapcheck == 4)
    {
        if (pickerflag == 0)
        {
            [sectionar3 removeObjectAtIndex:0];
            selecttime = [hours objectAtIndex:[picker selectedRowInComponent:0]];
            thurdaysrttime=[selecttime integerValue];
            NSLog(@"picker selected:----%@",selecttime);
            //            timelblstart.text = selecttimestart;
            //[sectionar3 insertObject:selecttime atIndex:0];
            if (finishtimetap3==false) {
                if (thurdaysrttime>thurdayendime || thurdaysrttime==thurdayendime) {
                    [sectionar3 insertObject:@"00.00" atIndex:0];
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Finish Time Must Be Greater Than Start Time"
                                                                   message: @"It is mandatory"
                                                                  delegate: self
                                                         cancelButtonTitle:@"Cancel"
                                                         otherButtonTitles:nil,nil];
                    
                    [alert show];
                }
                else
                {
                    _dateAvailableTapped.hidden=NO;
                    [pickerview removeFromSuperview];
                    [sectionar3 insertObject:selecttime atIndex:0];
                    _mainview.userInteractionEnabled=YES;
                }
            }
            else
            {
                _dateAvailableTapped.hidden=NO;
                [pickerview removeFromSuperview];
                [sectionar3 insertObject:selecttime atIndex:0];
                _mainview.userInteractionEnabled=YES;
            }
        }
        else if (pickerflag == 1)
        {
            finishtimetap3=false;
            [sectionar3 removeObjectAtIndex:1];
            selecttime = [hours2 objectAtIndex:[picker selectedRowInComponent:0]];
            thurdayendime=[selecttime integerValue];
            NSLog(@"picker selected:----%@",selecttime);
            //            timelblend.text = selecttime;
            //[sectionar3 insertObject:selecttime atIndex:1];
            if (thurdayendime > thurdaysrttime) {
                [pickerview removeFromSuperview];
                [sectionar3 insertObject:selecttime atIndex:1];
                _dateAvailableTapped.hidden=NO;
                _mainview.userInteractionEnabled=YES;
            }
            else
            {
                [sectionar3 insertObject:@"00.00" atIndex:1];
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Finish Time Must Be Greater Than Start Time"
                                                               message: @"It is mandatory"
                                                              delegate: self
                                                     cancelButtonTitle:@"Cancel"
                                                     otherButtonTitles:nil,nil];
                
                [alert show];
            }
        }
        [_tableview reloadData];
    }
    else if (tapcheck == 5)
    {
        if (pickerflag == 0)
        {
            [sectionar4 removeObjectAtIndex:0];
            selecttime = [hours objectAtIndex:[picker selectedRowInComponent:0]];
            fridaysrttime=[selecttime integerValue];
            NSLog(@"picker selected:----%@",selecttime);
            //            timelblstart.text = selecttimestart;
            //[sectionar4 insertObject:selecttime atIndex:0];
            if (finishtimetap4==false) {
                if (fridaysrttime>fridayendtime || fridaysrttime==fridayendtime) {
                    [sectionar4 insertObject:@"00.00" atIndex:0];
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Finish Time Must Be Greater Than Start Time"
                                                                   message: @"It is mandatory"
                                                                  delegate: self
                                                         cancelButtonTitle:@"Cancel"
                                                         otherButtonTitles:nil,nil];
                    
                    [alert show];
                }
                else
                {
                    _dateAvailableTapped.hidden=NO;
                    [pickerview removeFromSuperview];
                    [sectionar4 insertObject:selecttime atIndex:0];
                    _mainview.userInteractionEnabled=YES;
                }
            }
            else
            {
                _dateAvailableTapped.hidden=NO;
                [pickerview removeFromSuperview];
                [sectionar4 insertObject:selecttime atIndex:0];
                _mainview.userInteractionEnabled=YES;
            }
        }
        else if (pickerflag == 1)
        {
            finishtimetap4=false;
            [sectionar4 removeObjectAtIndex:1];
            selecttime = [hours2 objectAtIndex:[picker selectedRowInComponent:0]];
            fridayendtime=[selecttime integerValue];
            NSLog(@"picker selected:----%@",selecttime);
            //            timelblend.text = selecttime;
            //[sectionar4 insertObject:selecttime atIndex:1];
            if (fridayendtime > fridaysrttime) {
                [pickerview removeFromSuperview];
                [sectionar4 insertObject:selecttime atIndex:1];
                _dateAvailableTapped.hidden=NO;
                _mainview.userInteractionEnabled=YES;
                
            }
            else
            {
                [sectionar4 insertObject:@"00.00" atIndex:1];
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Finish Time Must Be Greater Than Start Time"
                                                               message: @"It is mandatory"
                                                              delegate: self
                                                     cancelButtonTitle:@"Cancel"
                                                     otherButtonTitles:nil,nil];
                
                [alert show];
            }
        }
        [_tableview reloadData];
    }
    NSLog(@"array0:-----%@,arr1-----%@,arr2-----%@,arr3-----%@,arr4-----%@",sectionar0,sectionar1,sectionar2,sectionar3,sectionar4);
}

-(void)cancelaction
{
    if (mondaysrttimechk>mondayendtimechk || mondayendtimechk<mondaysrttimechk || mondaysrttimechk==mondayendtimechk) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Please Select Appropriate Time"
                                                       message: @"It is mandatory"
                                                      delegate: self
                                             cancelButtonTitle:@"Cancel"
                                             otherButtonTitles:nil,nil];
        
        [alert show];
    }
    else if (tuesdaysrttime > tuesdayendtime || tuesdayendtime < tuesdaysrttime || tuesdayendtime == tuesdaysrttime)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Please Select Appropriate Time"
                                                       message: @"It is mandatory"
                                                      delegate: self
                                             cancelButtonTitle:@"Cancel"
                                             otherButtonTitles:nil,nil];
        
        [alert show];
    }
    else if (wednessdaysrttime > wednessdayendtime || wednessdayendtime < wednessdaysrttime|| wednessdayendtime == wednessdaysrttime)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Please Select Appropriate Time"
                                                       message: @"It is mandatory"
                                                      delegate: self
                                             cancelButtonTitle:@"Cancel"
                                             otherButtonTitles:nil,nil];
        
        [alert show];
    }
    else if (thurdaysrttime > thurdayendime || thurdayendime < thurdaysrttime || thurdayendime == thurdaysrttime)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Please Select Appropriate Time"
                                                       message: @"It is mandatory"
                                                      delegate: self
                                             cancelButtonTitle:@"Cancel"
                                             otherButtonTitles:nil,nil];
        
        [alert show];
    }
    else if (fridaysrttime > fridayendtime || fridayendtime < fridaysrttime || fridayendtime == fridaysrttime)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Please Select Appropriate Time"
                                                       message: @"It is mandatory"
                                                      delegate: self
                                             cancelButtonTitle:@"Cancel"
                                             otherButtonTitles:nil,nil];
        
        [alert show];
    }
    else
    {
        [pickerview removeFromSuperview];
        _mainview.userInteractionEnabled=YES;
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

- (IBAction)submit:(id)sender
{
    if ([_datelbl.text isEqual:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Please Enter Available Date"
                                                       message: @"It is mandatory"
                                                      delegate: self
                                             cancelButtonTitle:@"Cancel"
                                             otherButtonTitles:nil,nil];
        
        [alert show];
    }
    else if ([chkstring0 isEqualToString:@"N"] && [chkstring1 isEqualToString:@"N"] && [chkstring2 isEqualToString:@"N"] && [chkstring3 isEqualToString:@"N"] && [chkstring4 isEqualToString:@"N"])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Please Select at least one Available Day"
                                                       message: @"It is mandatory"
                                                      delegate: self
                                             cancelButtonTitle:@"Cancel"
                                             otherButtonTitles:nil,nil];
        
        [alert show];
    }
    
    
    else
    {
        
        
        if ([_mypropertyRent isEqualToString:@"mypropertyrentbtn"])
        {
            NSLog(@"i am from myproperty rent");//Url for add advertisements to rent
            
            polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
            polygonView.backgroundColor=[UIColor blackColor];
            polygonView.alpha=0.3;
            [self.view addSubview:polygonView];
            UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
            
            [polygonView addSubview:spinner];
            [spinner startAnimating];
            
            
            
            NSString *url1 = [NSString stringWithFormat:@"%@json_output.php?mode=add_adver_for_rent&property_id=%@&added_by=%@&add_for=R&property_price=%@&avl_after=%@&rent_property=%@&rental_term=%@&property_contents=%@&mon_stats=%@&mon_start=%@&mon_finish_by=%@&mon_break_opt=&mon_break_start=&mon_break_end=&tue_stats=%@&tue_start=%@&tue_finish_by=%@&tue_break_opt=&tue_break_start=&tue_break_end=&wed_stats=%@&wed_start=%@&wed_finish_by=%@&wed_break_opt=&wed_break_start=&wed_break_end=&thur_stats=%@&thur_start=%@&thur_finish_by=%@&thur_break_opt=&thur_break_start=&thur_break_end=&fri_stats=%@&fri_start=%@&fri_finish_by=%@&fri_break_opt=&fri_break_start=&fri_break_end=",App_Domain_Url,_p_id,userid,_price_text,_datelbl.text,_rentofproperty1,_rentalterm1,_propertycontent1,chkstring0,[sectionar0 objectAtIndex:0],[sectionar0 objectAtIndex:1],chkstring1,[sectionar1 objectAtIndex:0],[sectionar1 objectAtIndex:1],chkstring2,[sectionar2 objectAtIndex:0],[sectionar2 objectAtIndex:1],chkstring3,[sectionar3 objectAtIndex:0],[sectionar3 objectAtIndex:1],chkstring4,[sectionar4 objectAtIndex:0],[sectionar4 objectAtIndex:1]];
            
            NSString *submit=[url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            [obj GlobalDict:submit Globalstr:@"array" Withblock:^(id result, NSError *error)
             {
                 
                 
                 if ([[result valueForKey:@"message"]isEqualToString:@"Advertisement Successfully Added"])
                 {
                     NSLog(@"register");
                     [spinner stopAnimating];
                     [spinner removeFromSuperview];
                     [polygonView removeFromSuperview];
                     
                     [chakingdata setValue:@"data change" forKey:@"data"];
                     [chakingdata synchronize];
                     
                     MPMyAddvertisementViewController *mpdash=(MPMyAddvertisementViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:Nil]instantiateViewControllerWithIdentifier:@"myaddvertise"];
                     
                     
                     
                     [self.navigationController pushViewController:mpdash  animated:YES];
                 }
                 else
                 {
                     [spinner stopAnimating];
                     [spinner removeFromSuperview];
                     [polygonView removeFromSuperview];
                     UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Faild"
                                                                    message: [result valueForKey:@"message"]
                                                                   delegate: self
                                                          cancelButtonTitle:@"Cancel"
                                                          otherButtonTitles:nil,nil];
                     
                     [alert show];
                 }
             }];
            
        }
        else if ([_mypropertySell isEqualToString:@"mypropertysellbtn"])
        {
            NSLog(@"i am from myproperty sell");//Url for add advertisements to sell
            polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
            polygonView.backgroundColor=[UIColor blackColor];
            polygonView.alpha=0.3;
            [self.view addSubview:polygonView];
            UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
            
            [polygonView addSubview:spinner];
            [spinner startAnimating];
            
            
            NSString *url1 = [NSString stringWithFormat:@"%@json_output.php?mode=add_adver_for_sell&property_id=%@&added_by=%@&add_for=S&property_price=%@&avl_after=%@&sale_property=%@&rental_term=&mon_stats=%@&mon_start=%@&mon_finish_by=%@&mon_break_opt=&mon_break_start=&mon_break_end=&tue_stats=%@&tue_start=%@&tue_finish_by=%@&tue_break_opt=&tue_break_start=&tue_break_end=&wed_stats=%@&wed_start=%@&wed_finish_by=%@&wed_break_opt=&wed_break_start=&wed_break_end=&thur_stats=%@&thur_start=%@&thur_finish_by=%@&thur_break_opt=&thur_break_start=&thur_break_end=&fri_stats=%@&fri_start=%@&fri_finish_by=%@&fri_break_opt=&fri_break_start=&fri_break_end=",App_Domain_Url,_p_id,userid,_price_text,_datelbl.text,_saleofproperty1,chkstring0,[sectionar0 objectAtIndex:0],[sectionar0 objectAtIndex:1],chkstring1,[sectionar1 objectAtIndex:0],[sectionar1 objectAtIndex:1],chkstring2,[sectionar2 objectAtIndex:0],[sectionar2 objectAtIndex:1],chkstring3,[sectionar3 objectAtIndex:0],[sectionar3 objectAtIndex:1],chkstring4,[sectionar4 objectAtIndex:0],[sectionar4 objectAtIndex:1]];
            [obj GlobalDict:url1 Globalstr:@"array" Withblock:^(id result, NSError *error)
             {
                 if ([[result valueForKey:@"message"]isEqualToString:@"Advertisement Successfully Added"])
                 {
                     [spinner stopAnimating];
                     [spinner removeFromSuperview];
                     [polygonView removeFromSuperview];
                     NSLog(@"register");
                     [chakingdata setValue:@"data change" forKey:@"data"];
                     [chakingdata synchronize];
                     MPMyAddvertisementViewController *mpdash=(MPMyAddvertisementViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:Nil]instantiateViewControllerWithIdentifier:@"myaddvertise"];
                     
                     [self.navigationController pushViewController:mpdash  animated:YES];
                     
                }
                 else
                 {
                     [spinner stopAnimating];
                     [spinner removeFromSuperview];
                     [polygonView removeFromSuperview];
                     UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Faild"
                                                                    message: [result valueForKey:@"message"]
                                                                   delegate: self
                                                          cancelButtonTitle:@"Cancel"
                                                          otherButtonTitles:nil,nil];
                     
                     [alert show];
                 }
                 
             }];
            
        }
        else if ([_editforRent isEqualToString:@"editforrentbtn"])
        {
            NSLog(@"i am from add rent");//Url for edit advertisements to rent
            polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
            polygonView.backgroundColor=[UIColor blackColor];
            polygonView.alpha=0.3;
            [self.view addSubview:polygonView];
            UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
            
            [polygonView addSubview:spinner];
            [spinner startAnimating];
            
            
            NSString *url1 = [NSString stringWithFormat:@"%@json_output.php?mode=edit_adver_for_rent&property_id=%@&advert_id=%@&property_price=%@&avl_after=%@&rent_property=%@&rental_term=%@&property_contents=%@&mon_stats=%@&mon_start=%@&mon_finish_by=%@&mon_break_opt=&mon_break_start=&mon_break_end=&tue_stats=%@&tue_start=%@&tue_finish_by=%@&tue_break_opt=&tue_break_start=&tue_break_end=&wed_stats=%@&wed_start=%@&wed_finish_by=%@&wed_break_opt=&wed_break_start=&wed_break_end=&thur_stats=%@&thur_start=%@&thur_finish_by=%@&thur_break_opt=&thur_break_start=&thur_break_end=&fri_stats=%@&fri_start=%@&fri_finish_by=%@&fri_break_opt=&fri_break_start=&fri_break_end=",App_Domain_Url,_p_id,_addfinal_id,_price_text,_datelbl.text,_rentofproperty1,_rentalterm1,_propertycontent1,chkstring0,[sectionar0 objectAtIndex:0],[sectionar0 objectAtIndex:1],chkstring1,[sectionar1 objectAtIndex:0],[sectionar1 objectAtIndex:1],chkstring2,[sectionar2 objectAtIndex:0],[sectionar2 objectAtIndex:1],chkstring3,[sectionar3 objectAtIndex:0],[sectionar3 objectAtIndex:1],chkstring4,[sectionar4 objectAtIndex:0],[sectionar4 objectAtIndex:1]];
            
            NSString *submit=[url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [obj GlobalDict:submit Globalstr:@"array" Withblock:^(id result, NSError *error)
             {
                 if ([[result valueForKey:@"message"]isEqualToString:@"Advertisement Successfully Updated"])
                 {
                     [spinner stopAnimating];
                     [spinner removeFromSuperview];
                     [polygonView removeFromSuperview];
                     NSLog(@"register");
                     MPMyAddvertisementViewController *mpdash=(MPMyAddvertisementViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:Nil]instantiateViewControllerWithIdentifier:@"myaddvertise"];
                     mpdash.datachagechaking=@"data edited";
                     [self.navigationController pushViewController:mpdash  animated:YES];
                     
                     UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Sucess" message:[result valueForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alert show];
                     
                     
                 }
                 else
                 {
                     [spinner stopAnimating];
                     [spinner removeFromSuperview];
                     [polygonView removeFromSuperview];
                     UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Faild"
                                                                    message: [result valueForKey:@"message"]
                                                                   delegate: self
                                                          cancelButtonTitle:@"Cancel"
                                                          otherButtonTitles:nil,nil];
                     
                     [alert show];
                 }
                 
             }];
            
        }
        else if ([_editforSell isEqualToString:@"editforsellbtn"])
        {
            NSLog(@"i am from add sell");//Url for edit advertisements for sell
            polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
            polygonView.backgroundColor=[UIColor blackColor];
            polygonView.alpha=0.3;
            [self.view addSubview:polygonView];
            UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
            
            [polygonView addSubview:spinner];
            [spinner startAnimating];
            
            NSString *url1 = [NSString stringWithFormat:@"%@json_output.php?mode=edit_adver_for_sell&property_id=%@&advert_id=%@&property_price=%@&avl_after=%@&sale_property=%@&mon_stats=%@&mon_start=%@&mon_finish_by=%@&mon_break_opt=&mon_break_start=&mon_break_end=&tue_stats=%@&tue_start=%@&tue_finish_by=%@&tue_break_opt=&tue_break_start=&tue_break_end=&wed_stats=%@&wed_start=%@&wed_finish_by=%@&wed_break_opt=&wed_break_start=&wed_break_end=&thur_stats=%@&thur_start=%@&thur_finish_by=%@&thur_break_opt=&thur_break_start=&thur_break_end=&fri_stats%@&fri_start=%@0&fri_finish_by=%@&fri_break_opt=&fri_break_start=&fri_break_end=",App_Domain_Url,_p_id,_addfinal_id,_price_text,_datelbl.text,_saleofproperty1,chkstring0,[sectionar0 objectAtIndex:0],[sectionar0 objectAtIndex:1],chkstring1,[sectionar1 objectAtIndex:0],[sectionar1 objectAtIndex:1],chkstring2,[sectionar2 objectAtIndex:0],[sectionar2 objectAtIndex:1],chkstring3,[sectionar3 objectAtIndex:0],[sectionar3 objectAtIndex:1],chkstring4,[sectionar4 objectAtIndex:0],[sectionar4 objectAtIndex:1]];
            [obj GlobalDict:url1 Globalstr:@"array" Withblock:^(id result, NSError *error)
             {
                 if ([[result valueForKey:@"message"]isEqualToString:@"Advertisement Successfully Updated"])
                 {
                     [spinner stopAnimating];
                     [spinner removeFromSuperview];
                     [polygonView removeFromSuperview];
                     NSLog(@"register");
                     MPMyAddvertisementViewController *mpdash=(MPMyAddvertisementViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:Nil]instantiateViewControllerWithIdentifier:@"myaddvertise"];
                     mpdash.datachagechaking=@"data edited";
                     [self.navigationController pushViewController:mpdash  animated:YES];

                 }
                 else
                 {
                     [spinner stopAnimating];
                     [spinner removeFromSuperview];
                     [polygonView removeFromSuperview];
                     UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Faild"
                                                                    message: [result valueForKey:@"message"]
                                                                   delegate: self
                                                          cancelButtonTitle:@"Cancel"
                                                          otherButtonTitles:nil,nil];
                     
                     [alert show];
                 }
             }];
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
}
@end
