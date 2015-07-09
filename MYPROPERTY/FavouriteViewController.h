//
//  FavouriteViewController.h
//  myProfile
//
//  Created by Shwetaa's iMac on 03/07/15.
//  Copyright (c) 2015 kausik jati. All rights reserved.
//

#import "ViewController.h"
#import "FavouriteTableViewCell.h"
#import <FacebookSDK/FacebookSDK.h>

@interface FavouriteViewController : ViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableviewfevourite;
- (IBAction)grideviewbutton:(id)sender;

- (IBAction)listviewbutton:(id)sender;



@end
