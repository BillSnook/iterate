//
//  itSettingsVC.m
//  iterate
//
//  Created by Bill Snook on 4/1/12.
//  Copyright (c) 2012 SnoWare. All rights reserved.
//

#import "itHintsVC.h"
#import "DLog.h"


// Local, private methods
@interface itHintsVC ()

@end


@implementation itHintsVC


//@synthesize scrollView;
@synthesize webView;


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
	
	NLog( @"" );
    [super viewWillAppear: animated];
	
	// Do any additional setup after loading the view.
	[self.navigationController setNavigationBarHidden: NO animated: YES];
	
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
	self.navigationController.navigationBar.backItem.title = @"Back";
//	self.navigationController.navigationItem.title = @"Hints1";

	[webView loadRequest: [NSURLRequest requestWithURL: [NSURL fileURLWithPath: [[NSBundle mainBundle] pathForResource: @"hints" ofType: @"html"] isDirectory: NO]]];
}

- (void)viewDidAppear:(BOOL)animated {
	
	NLog( @"" );
    [super viewDidAppear: animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	
	NLog( @"" );
    [super viewWillDisappear: animated];
	
	// Do any additional setup after loading the view.
	[self.navigationController setNavigationBarHidden: YES animated: YES];
}

- (void)viewDidDisappear:(BOOL)animated {
	
	NLog( @"" );
    [super viewDidDisappear: animated];
}

- (void)viewDidUnload {
	
	DLog( @"" );
//	[self setScrollView: nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


- (void)dealloc {
	
	DLog( @"" );
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//	RLog( @"" );
	
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
	    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	} else {
	    return YES;
	}
}


#pragma mark - UIWebView Delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	
	DLog( @"" );
	
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {

	DLog( @"%@", [error description] );

}


@end
