//
//  Listing3ViewController.h
//  myProfile
//
//  Created by soumyajit on 02/07/15.
//  Copyright (c) 2015 kausik jati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Listing3TableViewCell.h"
#import <FacebookSDK/FacebookSDK.h>
#import "ViewController.h"

@interface Listing3ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableviewlisting3;
- (IBAction)gridviewbutton:(id)sender;
- (IBAction)listviewbutton:(id)sender;

@end
