//
//  InviteFriendsViewController.m
//  MYPROPERTY
//
//  Created by Shwetaa's iMac on 22/07/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "InviteFriendsViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "InviteFriendcellTableViewCell.h"

@interface InviteFriendsViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UITextFieldDelegate>
{
    NSMutableDictionary *dOfPerson;
    ABAddressBookRef addressbook ;
    NSMutableArray *contactList,*finaldata;
    
    IBOutlet UITextField *searchtext;
    UIImage *img;
    
    NSMutableArray *searchResult,*arry;
    NSMutableArray *backup;
    IBOutlet UISearchBar *srchbar;
    NSMutableDictionary *dic;
    
}


@property (strong, nonatomic) IBOutlet UITableView *tableviewmain;

@end

@implementation InviteFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    finaldata=[[NSMutableArray alloc]init];
    searchResult=[[NSMutableArray alloc]init];
    backup=[[NSMutableArray alloc]init];
    arry = [[NSMutableArray alloc]init];
    
    addressbook = ABAddressBookCreateWithOptions(NULL, NULL);
    [self getAccessForPhonebook] ;
    // Do any additional setup after loading the view.
    
    backup=[finaldata mutableCopy];
    // searchResult = [NSMutableArray arrayWithCapacity:[finaldata count]];
    
    
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



-(void)getAccessForPhonebook
{
    __block BOOL accessGranted = NO;
    
    if (&ABAddressBookRequestAccessWithCompletion != NULL) { // We are on iOS 6
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(addressbook, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(semaphore);
        });
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        //dispatch_release(semaphore);
    }
    
    else { // We are on iOS 5 or Older
        accessGranted = YES;
        [self getContactsWithAddressBook:addressbook];
    }
    
    if (accessGranted) {
        [self getContactsWithAddressBook:addressbook];
    }
}




- (void)getContactsWithAddressBook:(ABAddressBookRef )addressBook {
    
    
    
    
    
    
    contactList = [[NSMutableArray alloc] init];
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBook);
    
    for (int i=0;i < nPeople;i++) {
        dOfPerson=[NSMutableDictionary dictionary];
        
        ABRecordRef ref = CFArrayGetValueAtIndex(allPeople,i);
        
        //For username and surname
        ABMultiValueRef phones =(__bridge ABMultiValueRef)((__bridge NSString*)ABRecordCopyValue(ref, kABPersonPhoneProperty));
        
        CFStringRef firstName, lastName,ContactImg;
        firstName = ABRecordCopyValue(ref, kABPersonFirstNameProperty);
        lastName  = ABRecordCopyValue(ref, kABPersonLastNameProperty);
        ContactImg =ABRecordCopyValue(ref, kABPersonImageFormatOriginalSize);
        
        
        
        
        
        if (ABPersonHasImageData(ref)) {
            NSData *imgData = (__bridge NSData*)ABPersonCopyImageDataWithFormat(ref, kABPersonImageFormatThumbnail);
            img = [UIImage imageWithData: imgData];
            
            if (img!=NULL) {
                
                [dOfPerson setObject:img forKey:@"picture"];
            }
        }
        
        
        
        NSLog(@"contact >>>>>>>%@",dOfPerson);
        if (firstName==NULL) {
            [dOfPerson setObject:[NSString stringWithFormat:@"%@",lastName] forKey:@"name"];
        }
        else if (lastName==NULL)
        {
            [dOfPerson setObject:[NSString stringWithFormat:@"%@", firstName] forKey:@"name"];
            
        }
        else
        {
            [dOfPerson setObject:[NSString stringWithFormat:@"%@ %@", firstName, lastName] forKey:@"name"];
        }
        //For Email ids
        ABMutableMultiValueRef eMail  = ABRecordCopyValue(ref, kABPersonEmailProperty);
        if(ABMultiValueGetCount(eMail) > 0) {
            [dOfPerson setObject:(__bridge NSString *)ABMultiValueCopyValueAtIndex(eMail, 0) forKey:@"email"];
            
        }
        
        //For Phone number
        NSString* mobileLabel;
        
        for(CFIndex i = 0; i < ABMultiValueGetCount(phones); i++) {
            mobileLabel = (__bridge NSString*)ABMultiValueCopyLabelAtIndex(phones, i);
            
            
            if([mobileLabel isEqualToString:(NSString *)kABPersonPhoneMobileLabel])
            {
                [dOfPerson setObject:(__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, i) forKey:@"Phone"];
            }
            else if ([mobileLabel isEqualToString:(NSString *)kABPersonPhoneHomeFAXLabel])
            {
                [dOfPerson setObject:(__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, i) forKey:@"Phone"];
            }
            
            else if ([mobileLabel isEqualToString:(NSString *)kABPersonPhoneIPhoneLabel ])
            {
                [dOfPerson setObject:(__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, i) forKey:@"Phone"];
            }
            
            else if ([mobileLabel isEqualToString:(NSString*)kABPersonPhoneOtherFAXLabel])
            {
                [dOfPerson setObject:(__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, i) forKey:@"Phone"];
                break ;
            }
            
            
            //  ABAddressBookRef addressBook = ABAddressBookCreate();
            
            
            //
            //            NSMutableArray *people = [(__bridge NSArray*) ABAddressBookCopyArrayOfAllPeople(addressBook) mutableCopy];
            //            NSLog(@"people=========%@",people);
            //
            //
            //            for (int i = 0; i < [people count]; i++)
            //            {
            //
            //
            //
            //
            //                }
            //                       NSLog(@"doperson=======%@",dOfPerson);
            
            
            
        }
        if([dOfPerson valueForKey:@"email"]!=NULL)
        {
            [contactList addObject:dOfPerson];
        }
    }
    
    finaldata=[contactList mutableCopy];
    NSLog(@"final data = %@",finaldata);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    
    
    return [finaldata count];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InviteFriendcellTableViewCell *cell;
    cell=(InviteFriendcellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"userdetails"];
    
    
    
    
    
    
    cell.conname.text=[[finaldata objectAtIndex:indexPath.row] valueForKey:@"name"];
    cell.conemail.text=[[finaldata objectAtIndex:indexPath.row] valueForKey:@"email"];
    
    if([[finaldata objectAtIndex:indexPath.row] valueForKey:@"picture"]!=NULL)
    {
        UIImage *pic=[[finaldata objectAtIndex:indexPath.row] valueForKey:@"picture"];
        cell.conimage.image=pic;
    }
    else
    {
        cell.conimage.image=[UIImage imageNamed:@"profile-pic1"];
    }
    return cell;
    
    
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if (searchText.length==0)
    {
        
        finaldata=[backup mutableCopy];
        [_tableviewmain reloadData];
        
        NSLog(@"working");
    }
    
    
    
    else
    {
        
        NSLog(@"search text========>%@",searchText);
        
        NSLog(@"filterContentForSearchText");
        //   NSMutableArray *ary;
        NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchText];
        
        
        
        // arry   = [[finaldata valueForKey:@"name"]filteredArrayUsingPredicate:resultPredicate];
        searchResult   = [[finaldata valueForKey:@"name"]                          filteredArrayUsingPredicate:resultPredicate];
        
        int j = 0;
        
        
        
        if (searchResult.count>0)
        {
            arry= [[NSMutableArray alloc]init];
            
            for (int i=0; i<finaldata.count; i++)
            {
                
                
                NSString *name = [NSString stringWithFormat:@"%@",[finaldata[i] valueForKey:@"name"]];
                NSLog(@"string=======%@",name);
                
                
                
                
                for (int a=0; a<searchResult.count; a++)
                {
                    NSString *check = [NSString stringWithFormat:@"%@",searchResult [a]];
                    
                    
                    if ([check isEqualToString:name])
                    {
                        NSLog(@"Name===%@=%@",name,check );
                        
                        [arry insertObject:[finaldata objectAtIndex:i] atIndex:j];
                        
                        j++;
                        
                    }
                }
                
                
                
                
                
                
                
                
            }
        }
        
        
        
        
        
        
        NSLog(@"array=========%@",arry);
        
        NSLog(@"searchResults-----%@",searchResult);
        finaldata = [[NSMutableArray alloc]init];
        finaldata=[arry mutableCopy];
        [_tableviewmain reloadData];
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [srchbar resignFirstResponder];
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *recipt =[NSArray arrayWithObjects:[finaldata [indexPath.row]valueForKey:@"email"],nil];
    NSDictionary *name = (NSDictionary *)finaldata [indexPath.row][@"name"];
    
    NSLog(@"name.....%@",name);
    NSString *subject= [NSString stringWithFormat:@"My Property Invite by %@",name];
    
    mailComposer = [[MFMailComposeViewController alloc]init];
    mailComposer.mailComposeDelegate = self;
    [mailComposer setToRecipients:recipt];
    [mailComposer setSubject:subject];
    [mailComposer setMessageBody:[NSString stringWithFormat:@"Hello You Have Been Invited On My Property by %@",name] isHTML:NO];
    //[self presentModalViewController:mailComposer animated:YES];
    [self presentViewController:mailComposer animated:YES completion:nil];
}


- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}










@end
