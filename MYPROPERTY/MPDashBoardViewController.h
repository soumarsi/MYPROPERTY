//
//  MPDashBoardViewController.h
//  MYPROPERTY
//
//  Created by Shwetaa's iMac on 11/08/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPDashBoardViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *mainview;
- (IBAction)backbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *headerimg;
@property (strong, nonatomic) IBOutlet UIView *subCatgoryView;

- (IBAction)subcatbtn:(id)sender;
@end
