//
//  itImgVC.h
//  iterate
//
//  Created by Bill Snook on 5/16/12.
//  Copyright (c) 2012 SnoWare. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface itImgVC : UIViewController <NSURLConnectionDataDelegate> {
	
	UIInterfaceOrientation	lastOrientation;
}


@property (strong, nonatomic) IBOutlet	UIImageView		*imgView;
@property (strong, nonatomic) IBOutlet	UIActivityIndicatorView	*activityIndicator;

@property (strong, nonatomic)			NSString		*imgName;
@property (strong, nonatomic)			NSMutableData	*rawData;

@property (nonatomic)					BOOL			showStatus;
@property (nonatomic)					BOOL			showNavbar;
@property (nonatomic)					BOOL			showTabbar;


@end
