//
//  EMViewController.m
//  PageControlDemo
//
//  Created by Eric McConkie on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EMViewController.h"
#define  kPages 5
@interface EMViewController ()

@end

@implementation EMViewController
@synthesize scrollView;
@synthesize pageControl;
-(void)onTap:(EMPageControl*)sender
{
    int val  = [sender currentPage];
    CGRect toRect =  self.view.frame;
    toRect.origin.x = self.view.frame.size.width *val;
    [scrollView scrollRectToVisible:toRect
                           animated:YES];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)ascrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    [(EMPageControl*)pageControl setCurrentPage:page];
    NSLog(@"current page: %d",page);
}
-(void)addSomeViews
{
    for (int b=0; b<kPages; b++) {
        
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	[self addSomeViews];
    int pages = kPages;
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width *pages, self.view.frame.size.height)];
    
    
    CGFloat ht = 20.0;
    EMPageControl *pc = [[EMPageControl alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - ht, self.view.frame.size.width, ht)
                                                    delegate:self];
    
    /*
     // if all your page marker images are the same, but still custom to your app, you can assing them here
     // doing so frees you from implementation of   -- emPageControl:imageForPage:selected:
     
     [pc setUnselectedImage:[UIImage imageNamed:@"circle_graphic_grey.png"]];
     [pc setSelectedImage:[UIImage imageNamed:@"circle_graphic_red.png"]];
     */

    [pc setNumberOfPages:pages];    
    [pc addTarget:self action:@selector(onTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pc];    
    [self setPageControl:pc];
    [pc release];
}


#pragma mark ---------------------------------->> 
#pragma mark -------------->>page contol delegate

-(UIImage*)emPageControl:(id)pageControl imageForPage:(NSInteger)pageNumber selected:(BOOL)isSelected
{
    if (pageNumber ==0) {
        if(isSelected)
            return  [UIImage imageNamed:@"home_selected.png"];
        else 
            return  [UIImage imageNamed:@"home_unselected.png"];
    }
    if (isSelected) {
        return [UIImage imageNamed:@"reddot.png"];
    }
    return [UIImage imageNamed:@"graydot.png"];
}

-(CGSize)emPageControl:(id)pageControl sizeForPage:(NSInteger)pageNumber selected:(BOOL)isSelected
{
    if (pageNumber ==0) {
        return CGSizeMake(10, 10);
    }
    return CGSizeMake(5, 5);
}
@end
