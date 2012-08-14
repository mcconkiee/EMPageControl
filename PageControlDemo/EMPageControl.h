//
//  EMPageControl.h
//  PageControlTest
//
//  Created by Eric McConkie on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EMPageControlDelegate <NSObject>

@optional
//can return nil for default dark/light grey dots (like those of standard UIPageControl
-(UIImage*)emPageControl:(id)pageControl imageForPage:(NSInteger)pageNumber selected:(BOOL)isSelected;
//size of space to which we will draw the image
-(CGSize)emPageControl:(id)pageControl sizeForPage:(NSInteger)pageNumber selected:(BOOL)isSelected;
@end

@interface EMPageControl : UIControl
//making this more "UIPageControl"-like
@property (nonatomic)NSInteger currentPage;
@property (nonatomic)NSInteger numberOfPages;

/*
 //utilize the unselected/selected image setters if all the "dots" of the page control are to be the same image     
 */
@property (nonatomic,retain)UIImage *unselectedImage;
@property (nonatomic,retain)UIImage *selectedImage;

//optional, but highly recomended 
@property (nonatomic,assign)id<EMPageControlDelegate> delegate;
- (id)initWithFrame:(CGRect)frame delegate:(id<EMPageControlDelegate>)aDelegate;
@end
