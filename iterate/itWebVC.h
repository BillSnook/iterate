//
//  itWebVC.h
//  iterate
//
//  Created by Bill Snook on 3/31/12.
//  Copyright (c) 2012 SnoWare. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface itWebVC : UIViewController <UIWebViewDelegate>


@property (strong, nonatomic)			NSString		*webSite;
@property (strong, nonatomic) IBOutlet	UIWebView		*webView;
//@property (strong, nonatomic) IBOutlet	UIView			*overView;
@property (strong, nonatomic) IBOutlet	UIButton		*overButton;

- (IBAction)viewTouch:(id)sender;


@end
