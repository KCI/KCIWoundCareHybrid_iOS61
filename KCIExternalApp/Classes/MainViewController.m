/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

//
//  MainViewController.h
//  KCIExternalApp
//
//  Created by Johnathan Iannotti on 4/18/12.
//  Copyright KCI 2012. All rights reserved.
//

#import "MainViewController.h"
/*#import "CDVDebugWebView.h"*/
#import <QuartzCore/QuartzCore.h>

@implementation MainViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)transferFiles
{
    // Custom initialization
    //Init Variables
    BOOL isDirectory = true;
    NSError *error = nil;
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *DatafolderPath = [documentsDirectory stringByAppendingPathComponent:@"Data"];
    NSString *AssetsfolderPath = [documentsDirectory stringByAppendingPathComponent:@"Assets"];
    //
    NSString *AssetsDocumentssourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Assets/documents"];
    NSString *AssetsImagessourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Assets/images"];
    NSString *DatasourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"www/data/"];
    //Check if Data Folder does not exists
    if (![[NSFileManager defaultManager] fileExistsAtPath:DatafolderPath isDirectory:&isDirectory]) {
        error = nil;
        NSDictionary *attr = [NSDictionary dictionaryWithObject:NSFileProtectionComplete
                                                         forKey:NSFileProtectionKey];
        [[NSFileManager defaultManager] createDirectoryAtPath:DatafolderPath
                                  withIntermediateDirectories:NO
                                                   attributes:attr
                                                        error:&error];
        if (error)
            NSLog(@"Error creating Data directory : %@", [error localizedDescription]);
        //Copy Data Files
        NSArray *fileList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:DatasourcePath error:&error];
        for (NSString *s in fileList) {
            NSString *newFilePath = [DatafolderPath stringByAppendingPathComponent:s];
            NSString *oldFilePath = [DatasourcePath stringByAppendingPathComponent:s];
            if (![[NSFileManager defaultManager] fileExistsAtPath:newFilePath]) {
                //File does not exist, copy it
                [[NSFileManager defaultManager] copyItemAtPath:oldFilePath toPath:newFilePath error:&error];
                NSLog(@"Copied file: %@", newFilePath);
            } else {
                [[NSFileManager defaultManager] removeItemAtPath:newFilePath error:&error];
                NSLog(@"Deleted file: %@", newFilePath);
                [[NSFileManager defaultManager] copyItemAtPath:oldFilePath toPath:newFilePath error:&error];
                NSLog(@"Copied file: %@", newFilePath);
            }
        }
    }
    //Check if Assets Folder does not exists
    if (![[NSFileManager defaultManager] fileExistsAtPath:AssetsfolderPath isDirectory:&isDirectory]) {
        error = nil;
        NSDictionary *attr = [NSDictionary dictionaryWithObject:NSFileProtectionComplete
                                                         forKey:NSFileProtectionKey];
        [[NSFileManager defaultManager] createDirectoryAtPath:AssetsfolderPath
                                  withIntermediateDirectories:YES
                                                   attributes:attr
                                                        error:&error];
        if (error)
            NSLog(@"Error creating Assets directory : %@", [error localizedDescription]);
        //Copy Assets/Documents Files
        NSArray *fileList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:AssetsDocumentssourcePath error:&error];
        for (NSString *s in fileList) {
            NSString *newFilePath = [AssetsfolderPath stringByAppendingPathComponent:s];
            NSString *oldFilePath = [AssetsDocumentssourcePath stringByAppendingPathComponent:s];
            if (![[NSFileManager defaultManager] fileExistsAtPath:newFilePath]) {
                //File does not exist, copy it
                [[NSFileManager defaultManager] copyItemAtPath:oldFilePath toPath:newFilePath error:&error];
                NSLog(@"Copied file: %@", newFilePath);
            } else {
                [[NSFileManager defaultManager] removeItemAtPath:newFilePath error:&error];
                NSLog(@"Deleted file: %@", newFilePath);
                [[NSFileManager defaultManager] copyItemAtPath:oldFilePath toPath:newFilePath error:&error];
                NSLog(@"Copied file: %@", newFilePath);
            }
        }
        //Copy Assets/Images Files
        fileList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:AssetsImagessourcePath error:&error];
        for (NSString *s in fileList) {
            NSString *newFilePath = [AssetsfolderPath stringByAppendingPathComponent:s];
            NSString *oldFilePath = [AssetsImagessourcePath stringByAppendingPathComponent:s];
            if (![[NSFileManager defaultManager] fileExistsAtPath:newFilePath]) {
                //File does not exist, copy it
                [[NSFileManager defaultManager] copyItemAtPath:oldFilePath toPath:newFilePath error:&error];
                NSLog(@"Copied file: %@", newFilePath);
            } else {
                [[NSFileManager defaultManager] removeItemAtPath:newFilePath error:&error];
                NSLog(@"Deleted file: %@", newFilePath);
                [[NSFileManager defaultManager] copyItemAtPath:oldFilePath toPath:newFilePath error:&error];
                NSLog(@"Copied file: %@", newFilePath);
            }
        }
    }

}

- (void)viewWillAppear:(BOOL)animated
{
    
    // Set the main view to utilize the entire application frame space of the device.
    // Change this to suit your view's UI footprint needs in your application.
    
    UIView* rootView = [[[[UIApplication sharedApplication] keyWindow] rootViewController] view];
    CGRect webViewFrame = [[[rootView subviews] objectAtIndex:0] frame];  // first subview is the UIWebView
    
    if (CGRectEqualToRect(webViewFrame, CGRectZero)) { // UIWebView is sized according to its parent, here it hasn't been sized yet
        self.view.frame = [[UIScreen mainScreen] applicationFrame]; // size UIWebView's parent according to application frame, which will in turn resize the UIWebView
        NSLog(@"ViewWillAppear");
        //NSLog(@"Screen Size: %@, %@", [NSString stringWithFormat:@"%1.6f", self.view.frame.size.height], [NSString stringWithFormat:@"%1.6f", self.view.frame.size.width]);
        
        
        self.LaunchTextView.contentMode = UIViewContentModeRedraw;
        self.LaunchTextView.center = CGPointMake(self.view.frame.size.height/2, self.view.frame.size.width/2);
        self.LaunchTextView.layer.cornerRadius = 5.0;
        self.LaunchTextView.font = [UIFont boldSystemFontOfSize:17.0 ];
        
        self.LaunchLabel.contentMode = UIViewContentModeRedraw;
        self.LaunchLabel.center = CGPointMake(self.view.frame.size.height/2, self.view.frame.size.width/2);
        self.LaunchLabel.text = @"\n\n Please wait while the app is updated. This may take a few moments!";
        
        self.LaunchActivityIndicatorView.contentMode = UIViewContentModeRedraw;
        self.LaunchActivityIndicatorView.center = CGPointMake(self.view.frame.size.height/2, self.view.frame.size.width/2);
        
        
        
    }
    
    [super viewWillAppear:animated];
}


- (void) didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}
UIActivityIndicatorView *activityIndicator;
- (void) viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if( UIInterfaceOrientationIsPortrait(interfaceOrientation) )
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

/* Comment out the block below to over-ride */
/*
#pragma CDVCommandDelegate implementation

- (id) getCommandInstance:(NSString*)className
{
	return [super getCommandInstance:className];
}

- (BOOL) execute:(CDVInvokedUrlCommand*)command
{
	return [super execute:command];
}

- (NSString*) pathForResource:(NSString*)resourcepath;
{
	return [super pathForResource:resourcepath];
}
 
- (void) registerPlugin:(CDVPlugin*)plugin withClassName:(NSString*)className
{
    return [super registerPlugin:plugin withClassName:className];
}
*/

- (void) webViewDidFinishLoad:(UIWebView*) theWebView
{
    //
    [self.LaunchActivityIndicatorView stopAnimating];
    [self.LaunchActivityIndicatorView release];
    
    [self.LaunchTextView removeFromSuperview];
    [self.LaunchTextView release];
    
    [self.LaunchLabel removeFromSuperview];
    [self.LaunchLabel release];
    
    [self.LaunchImageView removeFromSuperview ];
    [self.LaunchImageView release];
    
    NSLog(@"In webViewDidFinishLoad");
    // Black base color for background matches the native apps
    theWebView.backgroundColor = [UIColor blackColor];
    
	return [super webViewDidFinishLoad:theWebView];
}

/*
#pragma UIWebDelegate implementation

- (void) webViewDidFinishLoad:(UIWebView*) theWebView 
{
 /*
     // only valid if ___PROJECTNAME__-Info.plist specifies a protocol to handle
     //if (self.invokeString)
     //{
        // this is passed before the deviceready event is fired, so you can access it in js when you receive deviceready
        NSString* jsString = [NSString stringWithFormat:@"var invokeString = \"%@\";", self.invokeString];
        NSLog(@"JS String is: %@", jsString);
        [theWebView stringByEvaluatingJavaScriptFromString:jsString];
     //}
     
 
     // Black base color for background matches the native apps
     theWebView.backgroundColor = [UIColor blackColor];

	return [super webViewDidFinishLoad:theWebView];
}
 */

//Added for Cordova debugview
/*
- (CDVCordovaView*) newCordovaViewWithFrame:(CGRect)bounds
{
    return [[CDVDebugWebView alloc] initWithFrame:bounds];
}
 */
//end debugview
/* Comment out the block below to over-ride */

- (void) webViewDidStartLoad:(UIWebView*)theWebView 
{

    
    
    [self.LaunchActivityIndicatorView startAnimating];
    
    [self transferFiles];

    //
    NSLog(@"webViewDidStartLoad");
	return [super webViewDidStartLoad:theWebView];
}

- (void) webView:(UIWebView*)theWebView didFailLoadWithError:(NSError*)error 
{
    NSLog(@"didFailLoadWithError: %@", [error localizedDescription]);
	return [super webView:theWebView didFailLoadWithError:error];
}

- (BOOL) webView:(UIWebView*)theWebView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"shouldStartLoadWithRequest: %@", [request description]);
	return [super webView:theWebView shouldStartLoadWithRequest:request navigationType:navigationType];
}

- (void)dealloc {
    [_LaunchImageView release];
    [_LaunchActivityIndicatorView release];
    [_LaunchTextView release];
    [_LaunchLabel release];
    [super dealloc];
}
@end
