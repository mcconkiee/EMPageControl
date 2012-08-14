//
//  EMViewController.h
//  PageControlDemo
//
//  Created by Eric McConkie on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMPageControl.h"
@interface EMViewController : UIViewController<UIScrollViewDelegate,EMPageControlDelegate>
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain,nonatomic)UIControl *pageControl;
@end
