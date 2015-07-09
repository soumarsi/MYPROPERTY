//
//  Footer.h
//  MYPROPERTY
//
//  Created by Somenath on 03/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol footerdelegate<NSObject>

@optional
-(void)pushmethod:(UIButton *)sender;

@end

@interface Footer : UIView

//- (IBAction)Footer_button_action:(UIButton *)sender;

-(void)TapCheck:(int)Buttontag;
@property(assign)id<footerdelegate>footerdelegate;

@property (strong, nonatomic) IBOutlet UIButton *home;

@property (strong, nonatomic) IBOutlet UIButton *love;

@property (strong, nonatomic) IBOutlet UIButton *plus;

@property (strong, nonatomic) IBOutlet UIButton *bell;

@property (strong, nonatomic) IBOutlet UIButton *man;

@end
