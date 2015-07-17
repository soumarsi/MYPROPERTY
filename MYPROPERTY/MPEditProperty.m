//
//  MPEditProperty.m
//  MYPROPERTY
//
//  Created by Somenath on 13/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "MPEditProperty.h"
#import "MPEditMedia.h"

@interface MPEditProperty ()

@property (strong, nonatomic) IBOutlet UIScrollView *mainscroll;
@end

@implementation MPEditProperty

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.mainscroll setContentSize:CGSizeMake(self.view.frame.size.width, 922)];
    
    NSLog(@"MPEditProperty----->%@",self.regisdetail);
    
    
    if ((NSNull *)[self.regisdetail valueForKey:@"relationsip_property"]== [NSNull null])
    {
        self.relationToProperty.text == @"";
    }
    else
    {
        self.relationToProperty.text = [self.regisdetail valueForKey:@"relationsip_property"];
    }
    
    if ((NSNull *)[self.regisdetail valueForKey:@"property_type"]== [NSNull null])
    {
        self.propertyType.text = @"";
    }
    else
    {
        self.propertyType.text = [self.regisdetail valueForKey:@"property_type"];
    }
    
    if ((NSNull *)[self.regisdetail valueForKey:@"status_val"]== [NSNull null])
    {
        self.currentStatus.text = @"";
    }
    else
    {
        self.currentStatus.text = [self.regisdetail valueForKey:@"status_val"];
    }
    
    if ((NSNull *)[self.regisdetail valueForKey:@"postcode"]== [NSNull null])
    {
        self.postCode.text = @"";
    }
    else
    {
        self.postCode.text = [self.regisdetail valueForKey:@"postcode"];
    }
    
    if ((NSNull *)[self.regisdetail valueForKey:@"address1"]== [NSNull null])
    {
        self.address1.text = @"";
    }
    else
    {
        self.address1.text = [self.regisdetail valueForKey:@"town"];
    }
    
    if ((NSNull *)[self.regisdetail valueForKey:@"town"]== [NSNull null])
    {
        self.town.text = @"";
    }
    else
    {
        self.town.text = [self.regisdetail valueForKey:@"town"];
    }
    
    if ((NSNull *)[self.regisdetail valueForKey:@"country"]== [NSNull null])
    {
        self.country.text = @"";
    }
    else
    {
        self.country.text = [self.regisdetail valueForKey:@"country"];
    }
    
    if ((NSNull *)[self.regisdetail valueForKey:@"postcode"]== [NSNull null])
    {
        self.postcodezip.text = @"";
    }
    else
    {
        self.postcodezip.text = [self.regisdetail valueForKey:@"postcode"];
    }
    
    if ((NSNull *)[self.regisdetail valueForKey:@"no_of_beds"]== [NSNull null])
    {
        self.noOfBedRooms.text = @"";
    }
    else
    {
        self.noOfBedRooms.text = [self.regisdetail valueForKey:@"no_of_beds"];
    }
    
    if ((NSNull *)[self.regisdetail valueForKey:@"no_of_rooms"]== [NSNull null])
    {
        self.noOfRooms.text = @"";
    }
    else
    {
        self.noOfRooms.text = [self.regisdetail valueForKey:@"no_of_rooms"];
    }
    
    if ((NSNull *)[self.regisdetail valueForKey:@"no_of_baths"]== [NSNull null])
    {
        self.noOfBathRooms.text = @"";
    }
    else
    {
        self.noOfBathRooms.text = [self.regisdetail valueForKey:@"no_of_baths"];
    }
    
    if ((NSNull *)[self.regisdetail valueForKey:@"property_description"] == [NSNull null])
    {
        self.prop_desc_lbl.hidden = NO;
    }
    else
    {
        self.prop_desc_lbl.hidden = YES;
        self.summaryDescrp.text = [self.regisdetail valueForKey:@"property_description"];
    }
    
    if ((NSNull *)[self.regisdetail valueForKey:@"property_full_description"] == [NSNull null])
    {
        self.prop_full_desc.hidden = NO;
    }
    else
    {
        self.prop_full_desc.hidden = YES;
        self.fullDescrp.text = [self.regisdetail valueForKey:@"property_full_description"];
    }
    
    if ([[self.regisdetail valueForKey:@"off_strt_parkng_flag"] isEqualToString:@"Y"])
    {
        [self.parkingFlag setOn:YES animated:YES];
    }
    else
    {
        [self.parkingFlag setOn:NO animated:YES];
    }
    
    if ([[self.regisdetail valueForKey:@"garden_flag"] isEqualToString:@"Y"])
    {
        [self.gardenFlag setOn:YES animated:YES];
    }
    else
    {
        [self.gardenFlag setOn:NO animated:YES];
    }
}

- (IBAction)nextTapped:(id)sender
{
    MPEditMedia *editmedia = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"editmedia"];
    editmedia.data_dictionary = [self.regisdetail mutableCopy];
    [self.navigationController pushViewController:editmedia animated:YES];
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

@end
