//
//  itImgVC.m
//  iterate
//
//  Created by Bill Snook on 5/16/12.
//  Copyright (c) 2012 SnoWare. All rights reserved.
//

#import "itImgVC.h"
#import "DLog.h"


@interface itImgVC ()


@property (strong, nonatomic)			UIView		*tabbar;


@end


@implementation itImgVC


@synthesize imgView;
@synthesize imgName;
@synthesize rawData;
@synthesize activityIndicator;
@synthesize showStatus;
@synthesize showNavbar;
@synthesize showTabbar;
@synthesize tabbar;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		DLog( @"" );
   }
    return self;
}

- (void)viewDidLoad {
	DLog( @"" );
	[super viewDidLoad];
	
	// Do any additional setup after loading the view.
//	imgView.backgroundColor = [UIColor magentaColor];
	imgView.contentMode = UIViewContentModeTopLeft;
	imgView.clipsToBounds = YES;
	imgView.autoresizesSubviews = YES;
	
	CGRect f = imgView.frame;
	DLog( @"imgView frame, x: %f, y: %f, w: %f, h: %f", f.origin.x, f.origin.y, f.size.width, f.size.height );
	NSURL *imgURL = [NSURL URLWithString: imgName];
	NSURLRequest *imgReq = [NSURLRequest requestWithURL: imgURL cachePolicy: NSURLRequestReloadIgnoringLocalCacheData timeoutInterval: 10.0];
	self.rawData = [NSMutableData data];
//	NSURLConnection *imgConn = 
	[activityIndicator startAnimating];
	[NSURLConnection connectionWithRequest: imgReq delegate: self];
	
	self.tabbar = [[UIView alloc] initWithFrame: CGRectMake( 0, 1024.0, f.size.width, 49.0)];
	tabbar.backgroundColor = [UIColor darkGrayColor];
//	tabbar.hidden = YES;
	tabbar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;

	UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake( 0.0, 0.0, tabbar.frame.size.width, tabbar.frame.size.height)];
	label.font = [UIFont systemFontOfSize: 20.0];
	label.textColor = [UIColor whiteColor];
	label.backgroundColor = [UIColor clearColor];
	label.textAlignment = UITextAlignmentCenter;
	label.text = @"Tab Bar";
	label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	[tabbar addSubview: label];

	[imgView addSubview: tabbar];

	self.title = @"Nav Bar";

	lastOrientation = [UIApplication sharedApplication].statusBarOrientation;
}

- (void)viewDidUnload {
	DLog( @"" );
	
	self.tabbar = nil;

	[self setImgView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated {
	NLog( @"" );
	[super viewWillAppear: animated];
	
//	CGRect f = [UIScreen mainScreen].bounds;
//	DLog( @"screen bounds, x: %f, y: %f, w: %f, h: %f", f.origin.x, f.origin.y, f.size.width, f.size.height );
//	f = [UIScreen mainScreen].applicationFrame;
//	DLog( @"screen  frame, x: %f, y: %f, w: %f, h: %f", f.origin.x, f.origin.y, f.size.width, f.size.height );
//	f = imgView.frame;
//	DLog( @"imgView frame, x: %f, y: %f, w: %f, h: %f", f.origin.x, f.origin.y, f.size.width, f.size.height );
	
	if ( showStatus ) {
		[[UIApplication sharedApplication] setStatusBarHidden: NO];
	} else {
		[[UIApplication sharedApplication] setStatusBarHidden: YES];
	}
	if ( showNavbar ) {
		// Display Navbar placeholder
		[self.navigationController setNavigationBarHidden: NO animated: NO];
		self.navigationController.navigationBar.backItem.title = @"Back";
//		self.navigationController.navigationItem.title = @"Image Display"; // ?? Image URL ??
	} else {
		[self.navigationController setNavigationBarHidden: YES animated: NO];
	}
	if ( showTabbar ) {
		// Display Tabbar placeholder
		tabbar.hidden = NO;
		CGRect tabframe = tabbar.frame;
		tabframe.origin.y = imgView.frame.size.height - 49.0;
		tabbar.frame = tabframe;
	} else {
		tabbar.hidden = YES;
		[imgView sendSubviewToBack: tabbar];
	}
//	f =	imgView.frame;
//	DLog( @"imgView frame, x: %f, y: %f, w: %f, h: %f", f.origin.x, f.origin.y, f.size.width, f.size.height );
///	imgView.frame = f;

	UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
	RLog( @"orientation: %d, lastOrientation: %d", orientation, lastOrientation );
	if ( orientation != lastOrientation ) {
		[self willRotateToInterfaceOrientation: orientation duration: 0.25];
	}
}


- (void)viewDidAppear:(BOOL)animated {
	NLog( @"" );
	[super viewDidAppear: animated];
}


- (void)viewWillDisappear:(BOOL)animated {
	NLog( @"" );
	[super viewWillDisappear: animated];
	
}


- (void)viewDidDisappear:(BOOL)animated {
	NLog( @"" );
	[super viewDidDisappear: animated];
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


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
//	RLog( @"toInterfaceOrientation: %d", toInterfaceOrientation );
	
	RLog( @"Animation starting" );
/*
	CGRect f = [UIScreen mainScreen].bounds;
	
	CGRect frame = tabbar.frame;
	if ( UIInterfaceOrientationIsLandscape( toInterfaceOrientation ) ) {
		frame.origin.y = f.size.width - 49.0;
		if ( showStatus )
			frame.origin.y -= 20.0;
		if ( showNavbar )
			frame.origin.y -= 44.0;
		RLog( @"Landscape" );
	} else if ( UIInterfaceOrientationIsPortrait( toInterfaceOrientation ) ) {
		frame.origin.y = f.size.height - 49.0;
		if ( showStatus )
			frame.origin.y -= 20.0;
		if ( showNavbar )
			frame.origin.y -= 44.0;
		RLog( @"Portrait" );
	}
	
	[UIView animateWithDuration: 0.25
						  delay: 0
						options: UIViewAnimationOptionBeginFromCurrentState
					 animations: ^{
						 RLog( @"Animation started" );
						 tabbar.frame = frame;
					 }
					 completion: ^(BOOL finished) {
						 RLog( @"Animation completed" );
					 }
	];
*/
	lastOrientation = toInterfaceOrientation;
}


#pragma mark - Touch in view

- (IBAction)viewTouch:(id)sender {
	
	DLog( @"sender: %@", [sender description] );
	[self.navigationController popViewControllerAnimated: YES];
}


#pragma mark - NSURLConnection delegate methods

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	
	DLog( @"error: %@", [error description] );

	[activityIndicator stopAnimating];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	
//	DLog( @"" );
//	DLog( @"connection: %@\nData:\n%@", [connection description], [data description] );
	[rawData appendData: data];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	
	[activityIndicator stopAnimating];

	DLog( @"connection: %@", [connection description] );
	UIImage *fileImg = [UIImage imageWithData: rawData];
	CGSize s = [fileImg size];
	DLog( @"downloaded image size, w: %f, h: %f", s.width, s.height );
	CGRect f = imgView.frame;
	DLog( @"imgView frame size, w: %f, h: %f", f.size.width, f.size.height );
	imgView.image = fileImg;
}


/*
- (void)connectionDidFinishDownloading:(NSURLConnection *)connection destinationURL:(NSURL *) destinationURL {
	
	[activityIndicator stopAnimating];

	DLog( @"destinationURL: %@", [destinationURL description] );
	NSFileManager *fm = [NSFileManager defaultManager];
	if ( [destinationURL isFileURL] ) {
		NSString *destPath = [destinationURL path];
		DLog( @"destination path: %@", destPath );
		
		UIImage *fileImg = [UIImage imageWithContentsOfFile: destPath];
		DLog( @"destination image: %@", [fileImg description] );
		imgView.image = fileImg;
//		[imgView setNeedsLayout];
//		[imgView layoutIfNeeded];
	}
}
*/



@end
