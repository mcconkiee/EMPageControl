//
//  EMPageControl.m
//  PageControlTest
//
//  Created by Eric McConkie on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EMPageControl.h"

#define kSpacing   15.0;

@implementation EMPageControl
@synthesize unselectedImage = _unselectedImage;
@synthesize selectedImage = _selectedImage;
@synthesize currentPage;
@synthesize numberOfPages;
@synthesize delegate = _delegate;


#pragma mark ---------------------------------->> 
#pragma mark -------------->>privates
//retrun a default dot image
-(UIImage*)dotWithColor:(UIColor *)clr forRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    CGContextSetFillColorWithColor(ctx, clr.CGColor);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextAddPath(ctx, path);
    CGContextFillPath(ctx);
    CGPathRelease(path);
    
    CGImageRef imgref = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:imgref];
    CGImageRelease(imgref);
    return img;
}

-(void)_updateImages:(CGRect)rect
{
    float x,y;
    float space =  kSpacing;
    float width = rect.size.width;
    int ct = numberOfPages;        
    float totalspace = (ct-1)*space;
    
    x= (width/2) - (totalspace/2);
    y = rect.size.height/2;
    
    for (int b=0; b<numberOfPages; b++) {
        UIImage *img = _unselectedImage;
        UIImage *imgS = _selectedImage;
        BOOL _isselected = (b==self.currentPage);
        if (!_isselected) {
            if ([_delegate respondsToSelector:@selector(emPageControl:imageForPage:selected:)]) {
                img = [_delegate emPageControl:self imageForPage:b selected:NO];
            }           
        }else {
            if ([_delegate respondsToSelector:@selector(emPageControl:imageForPage:selected:)]) {
                imgS = [_delegate emPageControl:self imageForPage:b selected:YES];
            }                        
        }
        
        //CGSize sz = img.size;
        CGSize sz = CGSizeMake(5,5);
        if ([_delegate respondsToSelector:@selector(emPageControl:sizeForPage:selected:)]) {
            sz = [_delegate emPageControl:self sizeForPage:b selected:_isselected];
        }
        
        CGPoint pt = CGPointMake(x - sz.width/2, y - sz.height/2);
        
        CGRect inRect = {pt,sz};
        
        if (_isselected) {
            if(imgS==nil)
                imgS = [self dotWithColor:[UIColor darkGrayColor] forRect:inRect];
            [imgS drawInRect:inRect];
        }else {
            if (img == nil)
                img = [self dotWithColor:[UIColor lightGrayColor] forRect:inRect];
            [img drawInRect:inRect];
        }
        
        x+=space;
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame delegate:(id<EMPageControlDelegate>)aDelegate
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        [self setDelegate:aDelegate];
    }
    return self;
}



-(void)setCurrentPage:(NSInteger)acurrentPage
{
    currentPage = acurrentPage;
    [self setNeedsDisplay];
}

- (void)dealloc
{
    _delegate = nil;
    [_unselectedImage release];
    [_selectedImage release];
    [super dealloc];
}

//some touch logic
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSInteger cp = self.currentPage;
    UITouch *touch = [touches anyObject];
    CGPoint here =[touch locationInView:self];
    if (here.x < self.frame.size.width/2) {
        //left side touch
        
        if (cp >0) {
            self.currentPage--;
        }
    }else if (here.x > self.frame.size.width/2) {
        //right side touch
        if (cp < self.numberOfPages-1) {
            self.currentPage++;
        }
    }else {
        //middle touch exactly
    }
    [self setNeedsDisplay];
    [super touchesEnded:touches withEvent:event];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClearRect(ctx, rect);
    [self _updateImages:rect];   
}


@end
