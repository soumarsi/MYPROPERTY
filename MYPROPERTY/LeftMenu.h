//
//  LeftMenu.h
//  MYPROPERTY
//
//  Created by Somenath on 08/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol leftDelegate<NSObject>
@optional
-(void)leftclk:(UIButton *)sender;
@end

@interface LeftMenu : UIView

@property(assign)id<leftDelegate>leftDelegate;

@property (strong, nonatomic) IBOutlet UIButton *myDashBoard;
@end
