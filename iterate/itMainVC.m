//
//  itMainVC.m
//  iterate
//
//  Created by Bill Snook on 3/28/12.
//  Copyright (c) 2012 SnoWare. All rights reserved.
//

#import "itMainVC.h"
#import "itWebVC.h"
#import "itImgVC.h"
#import "DLog.h"
#import <QuartzCore/QuartzCore.h>

#import "ColorPickerController.h"


#define	kImageURLDefaultHostKey		@"http://images.billsnook.info"		// Default scheme://host URL
#define	kImageURLDefaultFileKey		@"TestImg.png"						// Default file name
#define	kImageURLDefaultFileiPadKey	@"TestImg-iPad.png"					// Default file name on iPad
// http://localhost:8080/~bill/MWA/images/TestImg.png




@interface itMainVC ()


@end


@implementation itMainVC


//@synthesize siteScheme;
@synthesize siteDomain;
@synthesize siteFile;
@synthesize scrollView;
@synthesize showStatus;
@synthesize showNavbar;
@synthesize showTabbar;
@synthesize showColor;

@synthesize loadButton;
@synthesize hintButton;


- (void)viewDidLoad {
	
	DLog( @"" );
    [super viewDidLoad];
	
	[[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleBlackOpaque];
	
	// Do any additional setup after loading the view, typically from a nib.
	NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
	NSDictionary* settingsDict = [settings dictionaryForKey:@"siteSettings"];
//	DLog( @"siteSettings dictionary: %@", [settingsDict description]);
	
//	siteScheme.text = [settingsDict objectForKey: @"siteScheme"];
//	if ( nil == siteScheme.text )
//		siteScheme.text = @"";

	showColor.backgroundColor = [UIColor clearColor];

	if ( settingsDict ) {
		siteDomain.text = [settingsDict objectForKey: @"siteDomain"];
		if ( nil == siteDomain.text )
			siteDomain.text = kImageURLDefaultHostKey;
		siteFile.text = [settingsDict objectForKey: @"siteFile"];
		if ( nil == siteFile.text ) {
			if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
				siteFile.text = kImageURLDefaultFileKey;
			} else {
				siteFile.text = kImageURLDefaultFileiPadKey;
			}
		}
		showStatus.on = [((NSNumber *)[settingsDict objectForKey: @"showStatus"]) boolValue];
		showNavbar.on = [((NSNumber *)[settingsDict objectForKey: @"showNavbar"]) boolValue];
		showTabbar.on = [((NSNumber *)[settingsDict objectForKey: @"showTabbar"]) boolValue];
		NSString *hex = [settingsDict objectForKey: @"showColor"];
//		if ( ( nil == hex ) || 0 == [hex length] )
//			hex = @"000000";	// Black

		showColor.layer.backgroundColor = [[ColorPickerController colorFromHexValue: hex] CGColor];
	} else {
		siteDomain.text = kImageURLDefaultHostKey;
		if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
			siteFile.text = kImageURLDefaultFileKey;
		else
			siteFile.text = kImageURLDefaultFileiPadKey;
		
		showStatus.on = YES;
		showNavbar.on = NO;
		showTabbar.on = NO;
		showColor.layer.backgroundColor = [[UIColor magentaColor] CGColor];
	}

//	showColor.layer.borderWidth = 0;
	showColor.layer.cornerRadius = 13.0;
	showColor.layer.masksToBounds = YES; // If image extends beyound corners

	[self.navigationController setNavigationBarHidden: NO animated: NO];
	
///	scrollView.backgroundColor = [UIColor cyanColor];
/*
	CGRect f = scrollView.frame;
	DLog( @"scrollView frame, x: %f, y: %f, w: %f, h: %f", f.origin.x, f.origin.y, f.size.width, f.size.height );
	
	CGSize s = scrollView.contentSize;
	DLog( @"scrollView contentSize, w: %f, h: %f", s.width, s.height );
*/
	scrollView.contentSize = CGSizeMake( 320.0, 222.0 );	// Enclose currently 4 settings controls
	
	lastOrientation = [UIApplication sharedApplication].statusBarOrientation;

}

- (void)viewWillAppear:(BOOL)animated {
	
 	NLog( @"" );
   [super viewWillAppear: animated];

	[[UIApplication sharedApplication] setStatusBarHidden: NO];
	[self.navigationController setNavigationBarHidden: NO animated: NO];
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
	self.navigationItem.title = @"Select URL"; // ?? Image URL ??

	UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
	RLog( @"orientation: %d, lastOrientation: %d", orientation, lastOrientation );
	if ( orientation != lastOrientation ) {
		[self willRotateToInterfaceOrientation: orientation duration: 0.25];
	}
}

- (void)viewDidAppear:(BOOL)animated {
	
	NLog( @"" );
    [super viewDidAppear: animated];
	
	[scrollView flashScrollIndicators];
}


- (void)viewWillDisappear:(BOOL)animated {
	
	NLog( @"" );
    [super viewWillDisappear: animated];
}


- (void)viewDidDisappear:(BOOL)animated {
	
	NLog( @"" );
    [super viewDidDisappear: animated];
}


- (void)viewDidUnload {
	
	DLog( @"" );
	self.siteFile = nil;
	self.siteDomain = nil;
//	self.siteScheme = nil;
	
	[self setLoadButton: nil];
	[self setHintButton:nil];
	
	[self setShowStatus:nil];
	[self setShowNavbar:nil];
	[self setShowTabbar:nil];
	[self setScrollView:nil];
	[self setShowColor:nil];
    [super viewDidUnload];
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
	
	[UIView animateWithDuration: 0.25
						  delay: 0
						options: UIViewAnimationOptionBeginFromCurrentState
					 animations: ^{
						 RLog( @"Animation started" );
						 if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
							 if ( UIInterfaceOrientationIsLandscape( toInterfaceOrientation ) ) {
								 siteDomain.frame = CGRectMake(20.0, 10.0, 200.0, 31.0 );
								 siteFile.frame = CGRectMake( 240.0, 10.0, 220.0, 31.0 );
								 scrollView.frame = CGRectMake( 0, 50.0, 480.0, 155.0 );
								 hintButton.frame = CGRectMake( 340.0, 215.0, 120.0, 44.0 );
								 loadButton.frame = CGRectMake( 20.0, 215.0, 300.0, 44.0 );
								 RLog( @"Landscape" );
							 } else if ( UIInterfaceOrientationIsPortrait( toInterfaceOrientation ) ) {
								 siteDomain.frame = CGRectMake(100.0, 10.0, 200.0, 31.0 );
								 siteFile.frame = CGRectMake( 20.0, 50.0, 280.0, 31.0 );
								 scrollView.frame = CGRectMake( 0, 90.0, 320.0, 180.0 );
								 hintButton.frame = CGRectMake( 20.0, 280.0, 280.0, 44.0 );
								 loadButton.frame = CGRectMake( 20.0, 332.0, 280.0, 78.0 );
								 RLog( @"Portrait" );
							 }
						 } else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
							 if ( UIInterfaceOrientationIsLandscape( toInterfaceOrientation ) ) {
//									 siteDomain.frame = CGRectMake(20.0, 10.0, 200.0, 31.0 );
//									 siteFile.frame = CGRectMake( 240.0, 10.0, 220.0, 31.0 );
								 scrollView.frame = CGRectMake( 0, 50.0, 1024.0, 560.0 );
								 hintButton.frame = CGRectMake( 648.0, 620.0, 358.0, 78.0 );
								 loadButton.frame = CGRectMake( 20.0, 620.0, 610.0, 78.0 );
								 RLog( @"Landscape" );
							 } else if ( UIInterfaceOrientationIsPortrait( toInterfaceOrientation ) ) {
//									 siteDomain.frame = CGRectMake(100.0, 10.0, 200.0, 31.0 );
//									 siteFile.frame = CGRectMake( 20.0, 50.0, 280.0, 31.0 );
								 scrollView.frame = CGRectMake( 0, 50.0, 768.0, 570.0 );
								 hintButton.frame = CGRectMake( 20.0, 630.0, 728.0, 100.0 );
								 loadButton.frame = CGRectMake( 20.0, 740.0, 728.0, 210.0 );
								 RLog( @"Portrait" );
							 }
						 }
					 }
					 completion: ^(BOOL finished) {
						 RLog( @"Animation completed" );
					 }
	];
	lastOrientation = toInterfaceOrientation;
}


- (IBAction)changeStatus:(id)sender {
	
	DLog( @"%@", [sender description] );
	
	[self saveSettings];
}


- (IBAction)changeNavbar:(id)sender {
	
	DLog( @"%@", [sender description] );
	
	[self saveSettings];
}


- (IBAction)changeTabbar:(id)sender {
	
	DLog( @"%@", [sender description] );
	
	[self saveSettings];
}


- (IBAction)changeColor:(id)sender {
	
//	DLog( @"%@", [sender description] );
	DLog( @"%@", [ColorPickerController hexValueFromColor: [UIColor colorWithCGColor: showColor.layer.backgroundColor]]);
	ColorPickerController *colorPicker = [[ColorPickerController alloc] initWithColor: [UIColor colorWithCGColor: showColor.layer.backgroundColor] andTitle: @"Background Color"];
	colorPicker.delegate = self;
	[self.navigationController pushViewController: colorPicker animated: YES];
	
	self.navigationController.navigationBarHidden = NO;
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}


- (IBAction)loadMore:(id)sender {
	
	DLog( @"%@", [sender description] );
}


- (IBAction)loadSite:(id)sender {
	
	DLog( @"%@", [NSString stringWithFormat: @"%@/%@", siteDomain.text, siteFile.text] );
	
}


- (void)saveSettings {
	
	NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
	NSMutableDictionary* settingsMutableDict = [[settings dictionaryForKey: @"siteSettings"] mutableCopy];
	if ( nil == settingsMutableDict ) {
		settingsMutableDict = [NSMutableDictionary dictionaryWithCapacity: 5];
	}
//	DLog( @"prepareForSegue siteSettings dictionary before: %@", [settingsMutableDict description]);
	
	[settingsMutableDict setObject: siteDomain.text forKey: @"siteDomain"];
	[settingsMutableDict setObject: siteFile.text forKey: @"siteFile"];
	
	[settingsMutableDict setObject: [NSNumber numberWithBool: showStatus.on] forKey: @"showStatus"];
	[settingsMutableDict setObject: [NSNumber numberWithBool: showNavbar.on] forKey: @"showNavbar"];
	[settingsMutableDict setObject: [NSNumber numberWithBool: showTabbar.on] forKey: @"showTabbar"];
	
	NSString *hex = [ColorPickerController hexValueFromColor: [UIColor colorWithCGColor: showColor.layer.backgroundColor]];
//	DLog( @"%@", hex );
	
	[settingsMutableDict setObject: hex forKey: @"showColor"];
	
//	DLog( @"prepareForSegue siteSettings dictionary after: %@", [settingsMutableDict description]);
	[settings setObject: settingsMutableDict forKey: @"siteSettings"];
	[settings synchronize];
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	
	// First, save site URL in settings in case anything changed
//	[self saveSettings];
	
	// Prepare for specific new pages to be loaded
	if ( [segue.identifier isEqualToString: @"toWebSite"] ) {	// Deprecated
		NLog( @"toWebSite" );
		// Then setup web view with site URL
		itWebVC *dest = segue.destinationViewController;
		dest.webSite = [NSString stringWithFormat: @"%@/%@", siteDomain.text, siteFile.text];
	} else 
	if ( [segue.identifier isEqualToString: @"toImgView"] ) {
		NLog( @"toImgView" );
		itImgVC *imgVC = segue.destinationViewController;
		imgVC.imgName = [NSString stringWithFormat: @"%@/%@", siteDomain.text, siteFile.text];
		imgVC.showStatus = showStatus.on;
		imgVC.showNavbar = showNavbar.on;
		imgVC.showTabbar = showTabbar.on;
		imgVC.view.backgroundColor = [UIColor colorWithCGColor: showColor.layer.backgroundColor];
	} else
	if ( [segue.identifier isEqualToString: @"toDbgView"] ) {
		NLog( @"toDbgView" );
	} else
	if ( [segue.identifier isEqualToString: @"toHintView"] ) {
		NLog( @"toHintView" );
	} else {
		NLog( @"UNPROCESSED - %@", segue.identifier);
	}
}



- (void)colorPickerSaved:(ColorPickerController *)controller {
	
	DLog( @"" );
	[self.navigationController popViewControllerAnimated: YES];
	showColor.layer.backgroundColor = [controller.selectedColor CGColor];
	
	[self saveSettings];
}


- (void)colorPickerCancelled:(ColorPickerController *)controller {

	DLog( @"" );
	[self.navigationController popViewControllerAnimated: YES];
}



#pragma mark - Text field delegates


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
	
//	DLog(@"YES");
	return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
	
//	DLog(@"");
	[textField resignFirstResponder];
	
	[self saveSettings];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	
//	DLog(@"YES");
	[textField resignFirstResponder];
	return YES;
}


#pragma mark - Touch to end keyboard


- (void)touchesEnded: (NSSet *)touches withEvent: (UIEvent *)event {	// Releases keyboard when touch outside textfield
	
	DLog(@"");

	for (UIView* view in self.view.subviews) {
		if ([view isKindOfClass:[UITextField class]])
			[view resignFirstResponder];
	}
}


@end
