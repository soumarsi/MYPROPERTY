//
//  BookAgentCell.h
//  MYPROPERTY
//
//  Created by Somenath on 21/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookAgentCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *timminglbl;
@property (strong, nonatomic) IBOutlet UIButton *bookbtn;
@property (strong, nonatomic) IBOutlet UILabel *nodataavailable;
@property (strong, nonatomic) IBOutlet UILabel *alreadyBooked;
@end
