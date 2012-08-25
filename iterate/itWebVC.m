//
//  itWebVC.m
//  iterate
//
//  Created by Bill Snook on 3/31/12.
//  Copyright (c) 2012 SnoWare. All rights reserved.
//

#import "itWebVC.h"
#import "DLog.h"


@interface itWebVC ()

@end


@implementation itWebVC


@synthesize webView;
//@synthesize overView;
@synthesize overButton;
@synthesize webSite;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
	
	DLog( @"" );
    [super viewDidLoad];
	
	// Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated {
	
	NLog( @"webSite: %@", webSite );
    [super viewWillAppear: animated];
	
	[webView loadRequest: [[NSURLRequest alloc] initWithURL:[NSURL URLWithString: webSite]]];
	
	// Do any additional setup after loading the view.
}


- (void)viewWillDisappear:(BOOL)animated {
	
	NLog( @"" );
    [super viewWillDisappear: animated];
}


- (void)viewDidUnload {
	
	DLog( @"" );
	[self setWebSite: nil];
	[self setWebView: nil];
//	[self setOverView: nil];
	[self setOverButton: nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


- (void)dealloc {
	
	DLog( @"" );
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark -
#pragma mark WebView delegate routines


- (void)webViewDidFinishLoad:(UIWebView *)webView {
	
	DLog( @"" );
	
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {

	DLog( @"Error: %@", [error description] );

}


#pragma mark -
#pragma mark Touch in overButton

- (IBAction)viewTouch:(id)sender {
	
	DLog( @"" );
	[self.navigationController popViewControllerAnimated: YES];
}


@end
