//
//  feedback.h
//  MYPROPERTY
//
//  Created by soumyajit on 27/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FW_JsonClass.h"

@interface feedback : UIViewController<UITextViewDelegate>
{
    
    IBOutlet UIImageView *propertyImageview;
    IBOutlet UILabel *roomeslbl;
    IBOutlet UILabel *addresslbl;
    IBOutlet UILabel *appointmentDetaillbl;
    IBOutlet UITextView *feedBacktextview;
    __weak IBOutlet UILabel *paceholderlbl;
    NSString *userid;
    
    FW_JsonClass *obj;
}
- (IBAction)backTap:(id)sender;

@property (strong, nonatomic) NSMutableDictionary *data_dic;

@end
