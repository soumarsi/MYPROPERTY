//
//  InviteFriendsViewController.h
//  MYPROPERTY
//
//  Created by Shwetaa's iMac on 22/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface InviteFriendsViewController : UIViewController<MFMailComposeViewControllerDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchControllerDelegate>
{
    MFMailComposeViewController *mailComposer;
}
@property (nonatomic, strong) NSMutableArray *arrContactsData;

@end
