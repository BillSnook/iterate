//
//  itMainVC.h
//  iterate
//
//  Created by Bill Snook on 3/28/12.
//  Copyright (c) 2012 SnoWare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorPickerController.h"


@interface itMainVC : UIViewController <UITextFieldDelegate, ColorPickerDelegate> {
	
	UIInterfaceOrientation	lastOrientation;
}


//@property (strong, nonatomic) IBOutlet UITextField *siteScheme;
@property (strong, nonatomic) IBOutlet	UITextField *siteDomain;
@property (strong, nonatomic) IBOutlet	UITextField *siteFile;

@property (strong, nonatomic) IBOutlet	UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet	UISwitch *showStatus;
@property (strong, nonatomic) IBOutlet	UISwitch *showNavbar;
@property (strong, nonatomic) IBOutlet	UISwitch *showTabbar;
@property (strong, nonatomic) IBOutlet	UIButton *showColor;

@property (strong, nonatomic) IBOutlet	UIButton *loadButton;
@property (strong, nonatomic) IBOutlet	UIButton *hintButton;


- (IBAction)changeStatus:(id)sender;
- (IBAction)changeNavbar:(id)sender;
- (IBAction)changeTabbar:(id)sender;
- (IBAction)changeColor:(id)sender;

- (IBAction)loadMore:(id)sender;

- (IBAction)loadSite:(id)sender;

- (void)saveSettings;


@end
