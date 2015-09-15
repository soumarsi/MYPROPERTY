//
//  PropertyMediaViewController.m
//  MYPROPERTY
//
//  Created by soumyajit on 11/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "PropertyMediaViewController.h"

@interface PropertyMediaViewController ()
{
    IBOutlet UIButton *bkbtn;
    IBOutlet UILabel *toplbl;
    IBOutlet UIImageView *topbar;
    
}

@end

@implementation PropertyMediaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568  && screenBounds.size.width == 320)
    {
        toplbl.frame =CGRectMake(60, 23, 201, 25);
        scroll.frame=CGRectMake(0, 60, 320,568);
        [scroll setContentSize:CGSizeMake(self.view.frame.size.width, 765)];
    }
    
    else  if (screenBounds.size.height == 667  && screenBounds.size.width == 375)
    {
        
        
        topbar.frame=CGRectMake(0, 0, 375, 70);
        bkbtn.frame = CGRectMake(0, 0, 66, 70);
        toplbl.frame =CGRectMake(85, 30, 201, 25);
        scroll.frame=CGRectMake(0, 70, 375,667);
        [scroll setContentSize:CGSizeMake(self.view.frame.size.width, 775)];
        
        
    }
    else if (screenBounds.size.height ==736  && screenBounds.size.width == 414)
    {
        topbar.frame=CGRectMake(0, 0, 414, 78);
        bkbtn.frame = CGRectMake(0, 0, 66, 78);
        toplbl.frame =CGRectMake(85, 30, 201, 25);
        
        
        scroll.frame=CGRectMake(0, 78, 414,736);
        [scroll setContentSize:CGSizeMake(self.view.frame.size.width, 784)];
        
    }
    
    
    // [scroll setContentSize:CGSizeMake(self.view.frame.size.width, 706)];
    _imagePicker = [[UIImagePickerController alloc]init];
    i=0;
    codetxt.delegate=self;
    [scroll setShowsHorizontalScrollIndicator:NO];
    [scroll setShowsVerticalScrollIndicator:NO];
    
    
    
    // first page data
    
    NSLog(@"First Page data%@",_firstdic);
    
    //  _dic = [[NSMutableArray alloc]init];
    
    //j=0;
    
    check=1;
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

- (IBAction)upldbtn1:(id)sender
{
    i=1;
    check=1;
    //    _imagePicker.delegate=self;
    //     [self presentViewController:_imagePicker animated:YES completion:nil];
    //    _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Choose option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Galary",
                            @"Camera",nil];
    
    [popup showInView:self.view];
    
    
}

- (IBAction)upldbtn2:(id)sender
{
    i=2;
    check=1;
    
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Choose option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Galary",
                            @"Camera",nil];
    
    [popup showInView:self.view];
    scroll.scrollEnabled =YES;
    
}

- (IBAction)upldbtn3:(id)sender
{
    i=3;
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Choose option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Galary",
                            @"Camera",nil];
    
    [popup showInView:self.view];
    [codetxt resignFirstResponder];
    scroll.scrollEnabled =YES;
    
    check=1;
    
}

- (IBAction)upldbtn4:(id)sender
{
    i=4;
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Choose option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Galary",
                            @"Camera",nil];
    
    [popup showInView:self.view];
    [codetxt resignFirstResponder];
    scroll.scrollEnabled =YES;
    check=2;
    
    
}

- (IBAction)upldbtn5:(id)sender
{
    i=5;
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Choose option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Galary",
                            @"Camera",nil];
    
    [popup showInView:self.view];
    [codetxt resignFirstResponder];
    scroll.scrollEnabled =YES;
    check=3;
}

- (IBAction)nextbtn:(id)sender
{
    if (img1==NULL && img2==NULL && img3==NULL && img4==NULL && img5==NULL )
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Uplaod Image" message:@"You must Upload First image" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        
        
    }
    
    else
    {
        //[_dic addObject:img1];
        
        
        //         [_dic addObject:img2];
        //         [_dic addObject:img3];
        //         [_dic addObject:img4];
        //         [_dic addObject:img5];
        
        
        //        NSLog(@"Image array count----> %lu",_dic.count);
        //
        //        NSLog(@"Image array obj--->%@ ...... %@",_dic[0],_dic[1]);
        
        
        
        UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        PropertyCertificateViewController *media =(PropertyCertificateViewController  *)[story instantiateViewControllerWithIdentifier:@"propertycertificate"];
        
        media.secondpagevideocode=[codetxt text];
        
        
        media.firstpagedata = [_firstdic mutableCopy];
        // media.secondpagedata = [_dic mutableCopy];
        if (img1>0)
        {
            media.imgdata1 = UIImagePNGRepresentation(img1);
        }
        if (img2>0)
        {
            media.imgdata2 = UIImagePNGRepresentation(img2);
        }
        if (img3>0)
        {
            media.imgdata3 = UIImagePNGRepresentation(img3);
        }
        if (img4>0)
        {
            media.imgdata4 = UIImagePNGRepresentation(img4);
        }
        if (img5>0)
        {
            media.imgdata5 = UIImagePNGRepresentation(img5);
        }
        
        [self.navigationController pushViewController:media animated:YES];
        
        
    }
}

- (IBAction)backbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (i==1)
    {
        img1 = [info valueForKey:UIImagePickerControllerOriginalImage];
        UIImage *tempimg = [ImageResize imageWithImage:img1 scaledToSize:CGSizeMake(120,150)];
        
        img1= [ImageResize imageWithImage:img1 scaledToSize:CGSizeMake(320,200)];
        [imageview1 setImage:tempimg];
        
        NSLog(@"img====%@",img1);
        //  [_dic insertObject:img1 atIndex:0];
        
        //j++;
        
    }
    else if (i==2)
    {
        img2 = [info valueForKey:UIImagePickerControllerOriginalImage];
        UIImage *tempimg = [ImageResize imageWithImage:img2 scaledToSize:CGSizeMake(120,150)];
        [imageview2 setImage:tempimg];
        img2= [ImageResize imageWithImage:img2 scaledToSize:CGSizeMake(320,200)];
        
        //
        //        [_dic insertObject:img2 atIndex:j];
        //
        //        j++;
        
    }
    
    else if (i==3)
    {
        img3 = [info valueForKey:UIImagePickerControllerOriginalImage];
        UIImage *tempimg = [ImageResize imageWithImage:img3 scaledToSize:CGSizeMake(120,150)];
        [imageview3 setImage:tempimg];
        
        img3= [ImageResize imageWithImage:img3 scaledToSize:CGSizeMake(320,200)];
        
        
        //        [_dic insertObject:img3 atIndex:j];
        //
        //        j++;
        
        
    }
    else if (i==4)
    {
        img4 = [info valueForKey:UIImagePickerControllerOriginalImage];
        UIImage *tempimg = [ImageResize imageWithImage:img4 scaledToSize:CGSizeMake(120,150)];
        [imageview4 setImage:tempimg];
        
        img4= [ImageResize imageWithImage:img4 scaledToSize:CGSizeMake(320,200)];
        
        //
        //        [_dic insertObject:img4 atIndex:j];
        //
        //        j++;
        //
        
        
        
    }
    else if (i==5)
    {
        img5 = [info valueForKey:UIImagePickerControllerOriginalImage];
        UIImage *tempimg = [ImageResize imageWithImage:img5 scaledToSize:CGSizeMake(120,150)];
        [imageview5 setImage:tempimg];
        
        img5= [ImageResize imageWithImage:img5 scaledToSize:CGSizeMake(320,200)];
        
        
        //        [_dic insertObject:img5 atIndex:j];
        //
        //        j++;
        
        
        
        
    }
    
    [_imagePicker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [_imagePicker dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    scroll.scrollEnabled =YES;
    [textField resignFirstResponder];
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
    {
        [scroll setContentOffset:CGPointMake(0.0f, 198.0f) animated:YES];
        return YES;
    }
    else if (screenBounds.size.height == 667  && screenBounds.size.width == 375)
    {
        [scroll setContentOffset:CGPointMake(0.0f, 99.0f) animated:YES];
        return YES;
    }
    
    
    else
    {
        [scroll setContentOffset:CGPointMake(0.0f, 30.0f) animated:YES];
        return YES;
    }
    
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    scroll.scrollEnabled =NO;
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
        
    {
        CGRect rc=[scroll bounds];
        rc=[scroll convertRect:rc toView:scroll];
        CGPoint pt;
        pt=rc.origin;
        pt.x=0;
        pt.y=400;
        [scroll setContentOffset:pt animated:YES];
        return YES;
    }
    else if (screenBounds.size.height == 667  && screenBounds.size.width == 375)
    {
        CGRect rc=[scroll bounds];
        rc=[scroll convertRect:rc toView:scroll];
        CGPoint pt;
        pt=rc.origin;
        pt.x=0;
        pt.y=300;
        [scroll setContentOffset:pt animated:YES];
        return YES;
    }
    else
    {
        CGRect rc=[scroll bounds];
        rc=[scroll convertRect:rc toView:scroll];
        CGPoint pt;
        pt=rc.origin;
        pt.x=0;
        pt.y=255;
        [scroll setContentOffset:pt animated:YES];
        return YES;
    }
    
    
    
    return YES;
}
- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    //
    //    CGRect rc=[scroll bounds];
    //    rc=[scroll convertRect:rc toView:scroll];
    //    CGPoint pt;
    //    pt=rc.origin;
    //    pt.x=0;
    //    pt.y=0;
    
    //   [scroll setContentOffset:pt animated:YES];
    
    switch (buttonIndex) {
        case 0:
            _imagePicker.delegate=self;
            [self presentViewController:_imagePicker animated:YES completion:nil];
            _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //[scroll setContentOffset:CGPointMake(0.0f, 200.0f) animated:YES];
            scroll.scrollEnabled =YES;
            if ( check==2 || check ==3)
            {
                
                CGRect screenBounds=[[UIScreen mainScreen] bounds];
                if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
                {
                    [scroll setContentOffset:CGPointMake(0.0f, 198.0f) animated:YES];
                    
                }
                else if (screenBounds.size.height == 667  && screenBounds.size.width == 375)
                {
                    [scroll setContentOffset:CGPointMake(0.0f, 99.0f) animated:YES];
                }
                else
                {
                    [scroll setContentOffset:CGPointMake(0.0f, 30.0f) animated:YES];
                }
            }
            
            
            break;
        case 1:
            _imagePicker.delegate=self;
            [self presentViewController:_imagePicker animated:YES completion:nil];
            _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            //[scroll setContentOffset:CGPointMake(0.0f, 200.0f) animated:YES];
            scroll.scrollEnabled =YES;
            if (check==2 || check==3)
            {
                
                CGRect screenBounds=[[UIScreen mainScreen] bounds];
                if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
                {
                    [scroll setContentOffset:CGPointMake(0.0f, 198.0f) animated:YES];
                    
                }
                else if (screenBounds.size.height == 667  && screenBounds.size.width == 375)
                {
                    [scroll setContentOffset:CGPointMake(0.0f, 99.0f) animated:YES];
                }
                else
                {
                    [scroll setContentOffset:CGPointMake(0.0f, 30.0f) animated:YES];
                }
            }
            
            break;
            
        default:
            //[scroll setContentOffset:CGPointMake(0.0f, 200.0f) animated:YES];
            scroll.scrollEnabled =YES;
            if (check==2 || check==3)
            {
                
                CGRect screenBounds=[[UIScreen mainScreen] bounds];
                if(screenBounds.size.height == 568  && screenBounds.size.width == 320)
                {
                    [scroll setContentOffset:CGPointMake(0.0f, 198.0f) animated:YES];
                    
                }
                else if (screenBounds.size.height == 667  && screenBounds.size.width == 375)
                {
                    [scroll setContentOffset:CGPointMake(0.0f, 99.0f) animated:YES];
                }
                else
                {
                    [scroll setContentOffset:CGPointMake(0.0f, 30.0f) animated:YES];
                }
            }
            
            break;
    }
    
}


@end
