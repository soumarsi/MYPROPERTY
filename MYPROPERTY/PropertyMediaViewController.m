//
//  PropertyMediaViewController.m
//  MYPROPERTY
//
//  Created by soumyajit on 11/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "PropertyMediaViewController.h"

@interface PropertyMediaViewController ()

@end

@implementation PropertyMediaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [scroll setContentSize:CGSizeMake(self.view.frame.size.width, 720)];
    _imagePicker = [[UIImagePickerController alloc]init];
    i=0;
    codetxt.delegate=self;
    [scroll setShowsHorizontalScrollIndicator:NO];
    [scroll setShowsVerticalScrollIndicator:NO];
    
    
    
    // first page data
    
    NSLog(@"First Page data%@",_firstdic);
    
    _dic = [[NSMutableDictionary alloc]init];
    
    
    
    
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
}

- (IBAction)nextbtn:(id)sender
{
    if (img1==NULL)
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Uplaod Image" message:@"You must Upload one image" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        
        
    }
    
    else if(img1!=NULL)
    {
        
        
        if ( img2!=NULL )
        {
            
            [_dic setObject:img2 forKey:@"image2"];
        }
        if (img3 !=NULL)
        {
            [_dic setObject:img3 forKey:@"image3"];
        }
        if(img4 != NULL)
        {
            [_dic setObject:img4 forKey:@"image4"];
        }
        if (img5 !=NULL)
        {
            [_dic setObject:img5 forKey:@"image5"];
        }
        
        
        if (img1 !=NULL && img2 !=NULL && img3 !=NULL && img4 !=NULL && img5 !=NULL )
        {
            [_dic setObject:img1 forKey:@"image1"];
            [_dic setObject:[codetxt text] forKey:@"video_code"];
            UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            PropertyCertificateViewController *media =(PropertyCertificateViewController  *)[story instantiateViewControllerWithIdentifier:@"propertycertificate"];
            
            
            
            
            media.firstpagedata = [_firstdic mutableCopy];
            media.secondpagedata = [_dic mutableCopy];
            
            [self.navigationController pushViewController:media animated:YES];
        }
        
        else
        {
            NSLog(@"else");
            
            [_dic setObject:img1 forKey:@"image1"];
            [_dic setObject:[codetxt text] forKey:@"video_code"];
            UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            PropertyCertificateViewController *media =(PropertyCertificateViewController  *)[story instantiateViewControllerWithIdentifier:@"propertycertificate"];
            
            
            
            
            media.firstpagedata = [_firstdic mutableCopy];
            media.secondpagedata = [_dic mutableCopy];
            
            [self.navigationController pushViewController:media animated:YES];
        }
        
        
        //    [_dic setObject:img3 forKey:@"image3"];
        //    [_dic setObject:img4 forKey:@"image4"];
        //    [_dic setObject:img5 forKey:@"image5"];
        
        
        
        
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
        [imageview1 setImage:img1];
    }
    else if (i==2)
    {
        img2 = [info valueForKey:UIImagePickerControllerOriginalImage];
        [imageview2 setImage:img2];
    }
    
    else if (i==3)
    {
        img3 = [info valueForKey:UIImagePickerControllerOriginalImage];
        [imageview3 setImage:img3];
    }
    else if (i==4)
    {
        img4 = [info valueForKey:UIImagePickerControllerOriginalImage];
        [imageview4 setImage:img4];
    }
    else if (i==5)
    {
        img5 = [info valueForKey:UIImagePickerControllerOriginalImage];
        [imageview5 setImage:img5];
    }
    
    [_imagePicker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [_imagePicker dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    scroll.scrollEnabled=YES;
    CGRect rc=[scroll bounds];
    rc=[scroll convertRect:rc toView:scroll];
    CGPoint pt;
    pt=rc.origin;
    pt.x=0;
    pt.y=100;
    
    [scroll setContentOffset:pt animated:YES];
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    CGRect rc=[scroll bounds];
    rc=[scroll convertRect:rc toView:scroll];
    CGPoint pt;
    pt=rc.origin;
    pt.x=0;
    pt.y=400;
    
    [scroll setContentOffset:pt animated:YES];
    scroll.scrollEnabled =NO;
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
            
            break;
        case 1:
            _imagePicker.delegate=self;
            [self presentViewController:_imagePicker animated:YES completion:nil];
            _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
            
        default:
            break;
    }
    
}
@end
