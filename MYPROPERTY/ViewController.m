//
//  ViewController.m
//  myProfile
//
//  Created by soumyajit on 02/07/15.
//  Copyright (c) 2015 kausik jati. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "SearchViewController.h"
#import "LoginViewController.h"
#import "SignupViewController.h"

@interface ViewController (){
    UIView *polygonView;
    NSMutableArray *Arry1;
}
@property (nonatomic, strong) AppDelegate *appDelegate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    username=[[NSString alloc]init];
    mailid=[[NSString alloc]init];
    date=[[NSString alloc]init];
    nicename=[[NSString alloc]init];
    displayname=[[NSString alloc]init];
    fullname=[[NSString alloc]init];
    obj = [[FW_JsonClass alloc]init];
    Arry1=[[NSMutableArray alloc]init];
    defaults=[[NSUserDefaults alloc]init];
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    if(screenBounds.size.height == 667 && screenBounds.size.width == 375)
    {
        NSLog(@"iphone 6");
        _label1.frame = CGRectMake(110, 245, 108, 18);
        [_label1 setFont: [UIFont fontWithName:@"Helvetica Bold" size:17.0]];
        _label2.frame = CGRectMake(214, 245, 108, 18);
        [_label2 setFont: [UIFont fontWithName:@"Helvetica" size:17.0]];
        _label3.frame =CGRectMake(68, 265, 265, 18);
        [_label3 setFont: [UIFont fontWithName:@"Helvetica" size:18.0]];
        _labellogin.frame=CGRectMake(101, 550, 170, 18);
        [_labellogin setFont: [UIFont fontWithName:@"Helvetica Bold" size:13.0]];
    }
    else if(screenBounds.size.height == 736 && screenBounds.size.width == 414)
    {
        NSLog(@"iphone 6+");
        _label1.frame = CGRectMake(120, 270, 108, 18);
        [_label1 setFont: [UIFont fontWithName:@"Helvetica Bold" size:18.0]];
        _label2.frame = CGRectMake(229, 270, 108, 18);
        [_label2 setFont: [UIFont fontWithName:@"Helvetica" size:18.0]];
        _label3.frame =CGRectMake(73, 290, 270, 21);
        [_label3 setFont: [UIFont fontWithName:@"Helvetica" size:19.0]];
        _labellogin.frame=CGRectMake(114, 610, 180, 18);
        [_labellogin setFont: [UIFont fontWithName:@"Helvetica Bold" size:14.0]];
        
    }
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (![FBSession activeSession].state == FBSessionStateCreatedTokenLoaded)
    {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleFBSessionStateChangeWithNotification:) name:@"SessionStateChangeNotification" object:nil];
    }
    
    //    TWTRLogInButton *logInButton = [TWTRLogInButton buttonWithLogInCompletion:^(TWTRSession *session, NSError *error) {
    //        // play with Twitter session
    //    }];
    //    logInButton.center = self.view.center;
    //    [self.view addSubview:logInButton];
    
}

-(void)handleFBSessionStateChangeWithNotification:(NSNotification *)notification{
    // Get the session, state and error values from the notification's userInfo dictionary.
    polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
    polygonView.backgroundColor=[UIColor blackColor];
    polygonView.alpha=0.3;
    [self.view addSubview:polygonView];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
    
    [polygonView addSubview:spinner];
    
    NSDictionary *userInfo = [notification userInfo];
    
    [spinner startAnimating];
    FBSessionState sessionState = [[userInfo objectForKey:@"state"] integerValue];
    NSError *error = [userInfo objectForKey:@"error"];
    NSLog(@"session %lu",(unsigned long)sessionState);
    // Handle the session state.
    // Usually, the only interesting states are the opened session, the closed session and the failed login.
    if (!error) {
        // In case that there's not any error, then check if the session opened or closed.
        if (sessionState == FBSessionStateOpen) {
            // The session is open. Get the user information and update the UI.
            [FBRequestConnection startWithGraphPath:@"me"
                                         parameters:@{@"fields": @"first_name, last_name, picture.type(normal), email"}
                                         HTTPMethod:@"GET"
                                  completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                      if (!error) {
                                          // Set the use full name.
                                          NSLog(@"user name-%@",[NSString stringWithFormat:@"%@ %@",
                                                                 [result objectForKey:@"first_name"],
                                                                 [result objectForKey:@"last_name"]
                                                                 ]);
                                          fullname=[NSString stringWithFormat:@"%@%@",
                                                    [result objectForKey:@"first_name"],[result objectForKey:@"last_name"]
                                                    ];
                                          username=fullname;
                                          displayname=username;
                                          nicename=username;
                                          mailid=[NSString stringWithFormat:@"%@",
                                                  [result objectForKey:@"email"]
                                                  ];
                                          
                                          [defaults setValue:username forKey:@"username"];
                                          [defaults setValue:[result objectForKey:@"email"] forKey:@"email"];
                                          [defaults synchronize];
                                          
                                          NSLog(@" ARRY %@",result);
                                          
                                          
                                          NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
                                          
                                          NSInteger day = [components day];
                                          NSInteger week = [components month];
                                          NSInteger year = [components year];
                                          
                                          NSString *string = [NSString stringWithFormat:@"%ld.%ld.%ld",(long)year, (long)week, (long)day];
                                          NSLog(@"st%@",string);
                                          
                                          // Make the user info visible.
                                          
                                          
                                          
                                          
                                          NSString *url = [NSString stringWithFormat:@"%@json_output.php?mode=login_via_facebook&user_login=%@&user_nicename=%@&user_email=%@&user_registered=%@&display_name=%@",App_Domain_Url,username,nicename,mailid,string,displayname];
                                          
                                          [obj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error)
                                           {
                                               
                                               Arry1 =[[NSMutableArray alloc]init];
                                               
                                               
                                               Arry1=[result mutableCopy];
                                               
                                               if ([[Arry1 valueForKey:@"message"]isEqualToString:@"successfully logged in"]) {
                                                   
                                                   [spinner stopAnimating];
                                                   [spinner removeFromSuperview];
                                                   [polygonView removeFromSuperview];
                                                   SearchViewController *home=(SearchViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:Nil]instantiateViewControllerWithIdentifier:@"searchView"];
                                                   [self.navigationController pushViewController:home animated:YES];
                                                   
                                               }
                                               else
                                               {
                                                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Faild"
                                                                                                   message:[Arry1 valueForKey:@"message"]
                                                                                                  delegate:self
                                                                                         cancelButtonTitle:@"Cancel"
                                                                                         otherButtonTitles:nil,nil];
                                                   [alert show];
                                               }
                                               
                                               
                                               NSLog(@"Arry1%@",Arry1);
                                               
                                               
                                           }];
                                          
                                          
                                          
                                          
                                          
                                          // Stop the activity indicator from animating and hide the status label.
                                      }
                                      else{
                                          [spinner stopAnimating];
                                          [spinner removeFromSuperview];
                                          [polygonView removeFromSuperview];
                                          NSLog(@"%@", [error localizedDescription]);
                                      }
                                  }];
            
            
        }
        else if (sessionState == FBSessionStateClosed || sessionState == FBSessionStateClosedLoginFailed){
            // A session was closed or the login was failed. Update the UI accordingly.
            
            [spinner stopAnimating];
            [spinner removeFromSuperview];
            [polygonView removeFromSuperview];
            NSLog(@"login again");
        }
    }
    else{
        // In case an error has occurred, then just log the error and update the UI accordingly.
        [spinner stopAnimating];
        [spinner removeFromSuperview];
        [polygonView removeFromSuperview];
        NSLog(@"Error: %@", [error localizedDescription]);
        
    }
}




- (IBAction)loginTapped:(id)sender {
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)fbloginbutton:(id)sender
{
    
    if ([FBSession activeSession].state != FBSessionStateOpen &&
        [FBSession activeSession].state != FBSessionStateOpenTokenExtended) {
        
        [self.appDelegate openActiveSessionWithPermissions:@[@"public_profile", @"email"] allowLoginUI:YES];
        
        
    }
    else{
        // Close an existing session.
        [[FBSession activeSession] closeAndClearTokenInformation];
        
        // Update the UI.
        NSLog(@"close of existing session");
    }
}

//- (IBAction)twitterloginbutton:(id)sender
//{
//    polygonView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, self.view.bounds.size.width,self.view.bounds.size.height )];
//    polygonView.backgroundColor=[UIColor blackColor];
//    polygonView.alpha=0.3;
//    [self.view addSubview:polygonView];
//    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25);
//
//    [polygonView addSubview:spinner];
//    [spinner startAnimating];
//    [[Twitter sharedInstance] logInWithCompletion:^
//     (TWTRSession *session, NSError *error) {
//         if (session) {
//             NSLog(@"signed in as %@", [session userName]);
//             [spinner stopAnimating];
//             [spinner removeFromSuperview];
//             [polygonView removeFromSuperview];
//             SearchViewController *home=(SearchViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:Nil]instantiateViewControllerWithIdentifier:@"searchView"];
//             [self.navigationController pushViewController:home animated:YES];
//         } else {
//             [spinner stopAnimating];
//             [spinner removeFromSuperview];
//             [polygonView removeFromSuperview];
//             NSLog(@"error: %@", [error localizedDescription]);
//         }
//     }];
//}
- (IBAction)loginbutton:(id)sender
{
    LoginViewController *loginpg=(LoginViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:Nil]instantiateViewControllerWithIdentifier:@"login"];
    //                 //[self.navigationController pushViewController:loginpg animated:YES];
    [UIView  beginAnimations: @"Showinfo"context: nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    [self.navigationController pushViewController:loginpg  animated:YES];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
    
    
    
    
}

- (IBAction)signupbutton:(id)sender
{
    SignupViewController *singupg=(SignupViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:Nil]instantiateViewControllerWithIdentifier:@"signup"];
    //[self.navigationController pushViewController:singupg animated:UIViewAnimationTransitionFlipFromLeft];
    [UIView  beginAnimations: @"Showinfo"context: nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    [self.navigationController pushViewController:singupg  animated:YES];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
}
@end
