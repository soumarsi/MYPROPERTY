//
//  AddadvertisementViewController.m
//  MYPROPERTY
//
//  Created by Shwetaa's iMac on 14/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "AddadvertisementViewController.h"
#import "MPAddPropertyAdd.h"

@interface AddadvertisementViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>
{
    NSMutableArray *data1;
    NSMutableArray *data2;
    NSMutableArray *data3;
    NSMutableArray *data4;
    NSMutableArray *temp;
    NSString *holedata;
    UIView *polygonView;
    NSString *rentofproperty;
    NSString *rentalterm;
    NSString *propertycontent;
    NSString *price;
    NSString *saleofproperty;
    
    NSString *rentofproperty1;
    NSString *rentalterm1;
    NSString *propertycontent1;
    NSString *price1;
    NSString *saleofproperty1;
    NSMutableArray *finaldata1,*finaldata2,*finaldata3,*finaldata4;
    
    
    BOOL finalmove;
}
@property (strong, nonatomic) IBOutlet UIImageView *headerview;

@end

@implementation AddadvertisementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    obj = [[FW_JsonClass alloc]init];
    //data1=[[NSMutableArray alloc]initWithObjects:@"Kolkata",@"Delhi",@"MM",@"GG", nil];
    //data2=[[NSMutableArray alloc]initWithObjects:@"aa",@"bb",@"cc",@"dd", nil];
    data1=[[NSMutableArray alloc]init];
    data2=[[NSMutableArray alloc]init];
    data3=[[NSMutableArray alloc]init];
    data4=[[NSMutableArray alloc]init];
    temp=[[NSMutableArray alloc]init];
    _pricetextfield.delegate=self;
    _pricetextfield.autocorrectionType = UITextAutocorrectionTypeNo;
    _pricetextfield.text=_prevprice;
    polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
    polygonView.backgroundColor=[UIColor blackColor];
    polygonView.alpha=0.3;
    [self.view addSubview:polygonView];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
     [polygonView addSubview:spinner];
    
    [spinner startAnimating];
    if ([_chkdata isEqualToString:@"S"])
    {
        _pagetitle.text=@"Add Property Advertisements For Sell";
        finalmove=true;
        _rentofpropertylabel.hidden=YES;
        _rentofpropertysubimage.hidden=YES;
        _PMlabel.hidden=YES;
        _pmbutton.hidden=YES;
        
        _rentaltermlabel.hidden=YES;
        _rentaltermssubimage.hidden=YES;
        _monthslabel.hidden=YES;
        _monthsbutton.hidden=YES;
        
        _propertycontentslabel.hidden=YES;
        _propertycontentssubimage.hidden=YES;
        _furnishedbutton.hidden=YES;
        _furnishedlabel.hidden=YES;
        
        CGRect screenBounds=[[UIScreen mainScreen] bounds];
        if(screenBounds.size.height == 667 && screenBounds.size.width == 375)
        {
            
            [_saleofpropertylabel setFrame:CGRectMake(0, self.headerview.frame.size.height + self.pricetextfield.frame.size.height, self.view.frame.size.width, 40)];
            [_offerslabel setFrame:CGRectMake(13, self.headerview.frame.size.height + self.pricetextfield.frame.size.height + _saleofpropertylabel.frame.size.height, 164, 40)];
            [_offerarrowimage setFrame:CGRectMake(self.view.frame.size.width - 30, self.headerview.frame.size.height + self.pricetextfield.frame.size.height + _saleofpropertylabel.frame.size.height + 11, 11, 18)];
            [_saleofpropertybutton setFrame:CGRectMake(0, self.headerview.frame.size.height + self.pricetextfield.frame.size.height + _saleofpropertylabel.frame.size.height, self.view.frame.size.width, 40)];
            
        }
        else if(screenBounds.size.height == 736 && screenBounds.size.width == 414)
        {
            [_saleofpropertylabel setFrame:CGRectMake(0, self.headerview.frame.size.height + self.pricetextfield.frame.size.height, self.view.frame.size.width, 40)];
            [_offerslabel setFrame:CGRectMake(13, self.headerview.frame.size.height + self.pricetextfield.frame.size.height + _saleofpropertylabel.frame.size.height, 164, 40)];
            [_offerarrowimage setFrame:CGRectMake(self.view.frame.size.width - 30, self.headerview.frame.size.height + self.pricetextfield.frame.size.height + _saleofpropertylabel.frame.size.height + 11, 11, 18)];
            [_saleofpropertybutton setFrame:CGRectMake(0, self.headerview.frame.size.height + self.pricetextfield.frame.size.height + _saleofpropertylabel.frame.size.height, self.view.frame.size.width, 40)];
            
        }
        else
        {
            [_saleofpropertylabel setFrame:CGRectMake(0, self.headerview.frame.size.height + self.pricetextfield.frame.size.height, self.view.frame.size.width, 40)];
            [_offerslabel setFrame:CGRectMake(13, self.headerview.frame.size.height + self.pricetextfield.frame.size.height + _saleofpropertylabel.frame.size.height, 164, 40)];
            [_offerarrowimage setFrame:CGRectMake(self.view.frame.size.width - 30, self.headerview.frame.size.height + self.pricetextfield.frame.size.height + _saleofpropertylabel.frame.size.height + 11, 11, 18)];
            [_saleofpropertybutton setFrame:CGRectMake(0, self.headerview.frame.size.height + self.pricetextfield.frame.size.height + _saleofpropertylabel.frame.size.height, self.view.frame.size.width, 40)];
        }
    }
    else  if ([_chkdata isEqualToString:@"R"])
    {
        finalmove=false;
        _saleofpropertylabel.hidden=YES;
        _offerslabel.hidden=YES;
        _offerarrowimage.hidden=YES;
        _saleofpropertybutton.hidden=YES;
    }
    
    
    NSString *url1 = [NSString stringWithFormat:@"%@json_output.php?mode=price_parameters",App_Domain_Url];
    [obj GlobalDict:url1 Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
      
         NSLog(@"price %@",result);
         temp=[result mutableCopy];
         data1=[temp valueForKey:@"rent_to_property"];
         finaldata1=[data1 valueForKey:@"value"];
         data1=[data1 valueForKey:@"name"];
        
         data2=[temp valueForKey:@"rental_term"];
         finaldata2=[data2 valueForKey:@"value"];
         data2=[data2 valueForKey:@"name"];
         
         data3=[temp valueForKey:@"property_contents"];
         finaldata3=[data3 valueForKey:@"value"];
         data3=[data3 valueForKey:@"name"];
        
        
         data4=[temp valueForKey:@"sale_of_property"];
         finaldata4=[data4 valueForKey:@"value"];
         data4=[data4 valueForKey:@"name"];
         
         
         
         
         
         [spinner stopAnimating];
         [spinner removeFromSuperview];
         [polygonView removeFromSuperview];
    }];
    
    
    [self.view addSubview:_myview];
    [_myview addSubview:_mainpicker];
    _myview.hidden=YES;
    _mainpicker.hidden=YES;
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
        return 1;
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (_mainpicker.tag==1)
    {
        return [data1 count];
    }
    else if (_mainpicker.tag==2)
    {
        return [data2 count];
    }
    else if (_mainpicker.tag==3)
    {
        return [data3 count];
    }
    else if (_mainpicker.tag==4)
    {
        return [data4 count];
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(_mainpicker.tag==1)
    {
    return [data1 objectAtIndex:row];
    }
    else if (_mainpicker.tag==2)
    {
        return [data2 objectAtIndex:row];
    }
    else if (_mainpicker.tag==3)
    {
        return [data3 objectAtIndex:row];
    }
    else if (_mainpicker.tag==4)
    {
        return [data4 objectAtIndex:row];
    }
    return 0;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (_mainpicker.tag==1)
    {
        self.PMlabel.text=[data1 objectAtIndex:row];
        rentofproperty=_PMlabel.text;
        rentofproperty1=[finaldata1 objectAtIndex:row];
        holedata=[data1 objectAtIndex:row];
    }
    else if(_mainpicker.tag==2)
    {
        self.monthslabel.text=[data2 objectAtIndex:row];
        rentalterm=_monthslabel.text;
        rentalterm1=[finaldata2 objectAtIndex:row];
        holedata=[data2 objectAtIndex:row];
    }
    else if (_mainpicker.tag==3)
    {
        self.furnishedlabel.text=[data3 objectAtIndex:row];
        propertycontent=_furnishedlabel.text;
        propertycontent1=[finaldata3 objectAtIndex:row];
        holedata=[data3 objectAtIndex:row];
    }
    else if (_mainpicker.tag==4)
    {
        _offerslabel.text=[data4 objectAtIndex:row];
        saleofproperty=_offerslabel.text;
        saleofproperty1=[finaldata4 objectAtIndex:row];
        holedata=[data4 objectAtIndex:row];
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

- (IBAction)pmbutton:(id)sender
{
    [_pricetextfield resignFirstResponder];
    holedata=[[NSString alloc]init];
    _myview.hidden=NO;
    _mainpicker.hidden=NO;
    _mainpicker.delegate=self;
    _mainpicker.dataSource=self;
    _mainpicker.tag=1;
    _pmbutton.tag=1;
    holedata=[data1 objectAtIndex:0];
    _PMlabel.text=holedata;
    rentofproperty=_PMlabel.text;
    rentofproperty1=[finaldata1 objectAtIndex:0];
    [_mainpicker selectRow:0 inComponent:0 animated:YES];
    
}

- (IBAction)monthsbutton:(id)sender
{
    [_pricetextfield resignFirstResponder];
     holedata=[[NSString alloc]init];
    _myview.hidden=NO;
    _mainpicker.hidden=NO;
    _mainpicker.delegate=self;
    _mainpicker.dataSource=self;
    _mainpicker.tag=2;
    _monthsbutton.tag=2;
    holedata=[data2 objectAtIndex:0];
    _monthslabel.text=holedata;
    rentalterm=_monthslabel.text;
    rentalterm1=[finaldata2 objectAtIndex:0];
    [_mainpicker selectRow:0 inComponent:0 animated:YES];
}

- (IBAction)furnishedbutton:(id)sender
{
    [_pricetextfield resignFirstResponder];
     holedata=[[NSString alloc]init];
    _myview.hidden=NO;
    _mainpicker.hidden=NO;
    _mainpicker.delegate=self;
    _mainpicker.dataSource=self;
    _mainpicker.tag=3;
    _furnishedbutton.tag=3;
    holedata=[data3 objectAtIndex:0];
    _furnishedlabel.text=holedata;
     propertycontent=_furnishedlabel.text;
    propertycontent1=[finaldata3 objectAtIndex:0];
    [_mainpicker selectRow:0 inComponent:0 animated:YES];
}

- (IBAction)saleofpropertybutton:(id)sender
{
    [_pricetextfield resignFirstResponder];
    holedata=[[NSString alloc]init];
    _myview.hidden=NO;
    _mainpicker.hidden=NO;
    _mainpicker.delegate=self;
    _mainpicker.dataSource=self;
    _mainpicker.tag=4;
    _saleofpropertybutton.tag=3;
    holedata=[data4 objectAtIndex:0];
    _offerslabel.text=holedata;
    saleofproperty=_offerslabel.text;
    saleofproperty1=[finaldata4 objectAtIndex:0];
    [_mainpicker selectRow:0 inComponent:0 animated:YES];
}


- (IBAction)pickerdonebutton:(id)sender
{
   
        if (_mainpicker.tag==1)
        {
            _PMlabel.text=holedata;
            rentofproperty=_PMlabel.text;
        }
        else if (_mainpicker.tag==2)
        {
            _monthslabel.text=holedata;
            rentalterm=_monthslabel.text;
        }
        else if (_mainpicker.tag==3)
        {
            _furnishedlabel.text=holedata;
             propertycontent=_furnishedlabel.text;
        }
    
    _mainpicker.hidden=YES;
    _myview.hidden=YES;
    
    
}
- (IBAction)pickercancelbutton:(id)sender
{
    _mainpicker.hidden=YES;
    _myview.hidden=YES;

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _mainpicker.hidden=YES;
    _myview.hidden=YES;
    return YES;
}
- (IBAction)nextbutton:(id)sender
{
    if (finalmove==false)
    {
        price=_pricetextfield.text;
        NSLog(@"%@",rentofproperty1);
        NSLog(@"%@",rentalterm1);
        NSLog(@"%@", propertycontent1);
        if (([self TarminateWhiteSpace:_pricetextfield.text].length==0) || rentofproperty==NULL || rentalterm==NULL || propertycontent==NULL)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Please enter all fields"
                                                       message: @"All fields are mandatory"
                                                      delegate: self
                                             cancelButtonTitle:@"Cancel"
                                             otherButtonTitles:nil,nil];
        
            [alert show];
        
        }
        
        MPAddPropertyAdd *mpadd = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"addproperty"];
        [self.navigationController pushViewController:mpadd animated:YES];
    }
    else if (finalmove==true)
    {
        NSLog(@"sale");
        NSLog(@"%@", saleofproperty1);
        if (([self TarminateWhiteSpace:_pricetextfield.text].length==0) || saleofproperty1==NULL)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Please enter all fields"
                                                           message: @"All fields are mandatory"
                                                          delegate: self
                                                 cancelButtonTitle:@"Cancel"
                                                 otherButtonTitles:nil,nil];
            
            [alert show];
        }
        else
        {
            MPAddPropertyAdd *mpadd = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"addproperty"];
            [self.navigationController pushViewController:mpadd animated:YES];
        }
    }
    
    
}


-(NSString *)TarminateWhiteSpace:(NSString *)Str
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [Str stringByTrimmingCharactersInSet:whitespace];
    return trimmed;
}


- (IBAction)backtodashbordbutton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
