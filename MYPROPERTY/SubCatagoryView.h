//
//  SubCatagoryView.h
//  MYPROPERTY
//
//  Created by Somenath on 05/08/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SubCatagoryDelegate<NSObject>

@optional

-(void)subCatagoryClk:(UIButton *)sender;

@end

@interface SubCatagoryView : UIView

-(void)TapCheck:(int)Buttontag;

@property(assign)id<SubCatagoryDelegate>SubCatagoryDelegate;


@property (strong, nonatomic) IBOutlet UIView *markerView;
@property (strong, nonatomic) IBOutlet UIButton *searchAlertBtn;
@property (strong, nonatomic) IBOutlet UIButton *propertyStatusBtn;
@property (strong, nonatomic) IBOutlet UIButton *appoBtn;
@property (strong, nonatomic) IBOutlet UIButton *offerAlertBtn;
@property (strong, nonatomic) IBOutlet UIButton *renewAlertBtn;
@property (strong, nonatomic) IBOutlet UIButton *propertyIssueBtn;

@end
