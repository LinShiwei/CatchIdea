//
//  ColorSelectionPopoverVC.h
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/7/6.
//  Copyright © 2017年 Linsw. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class Theme;
@interface ColorSelectionPopoverVC_OC : NSViewController
@property (weak) IBOutlet NSView *containerView;
@property (nonatomic) NSInteger *selectedColorIndex;
@end
