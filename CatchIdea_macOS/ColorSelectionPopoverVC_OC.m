//
//  ColorSelectionPopoverVC.m
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/7/6.
//  Copyright © 2017年 Linsw. All rights reserved.
//

#import "ColorSelectionPopoverVC_OC.h"

@interface ColorSelectionPopoverVC_OC ()

@property NSMutableArray<NSView *> *cells;
@property CALayer *cellRingLayer;

@end

@implementation ColorSelectionPopoverVC_OC

CGFloat cellSideLength = 20;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cells = [NSMutableArray array];
    
    _cellRingLayer.frame = CGRectMake(0, 0, cellSideLength+10, cellSideLength+10);
    _cellRingLayer.cornerRadius = _cellRingLayer.frame.size.width/2;
    _cellRingLayer.borderColor = [[NSColor lightGrayColor] CGColor];
    _cellRingLayer.borderWidth = 2;
    
    NSClickGestureRecognizer *clickGesture = [[NSClickGestureRecognizer alloc] initWithTarget:self action:@selector(didClick:)];
    [self.view addGestureRecognizer:clickGesture];
    
    NSPanGestureRecognizer *panGesture = [[NSPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    [self.view addGestureRecognizer:panGesture];
}

- (void)viewDidLayout{
    [super viewDidLayout];
    [self initCellsWithContainerViewFrame:[self.view frame]];
}

- (void)initCellsWithContainerViewFrame:(CGRect)containerViewFrame {
    if (_cells&&[_cells count] == 0) {
        CGFloat sideSpace = 20;
        CGSize cellSize = CGSizeMake(cellSideLength, cellSideLength);
        CGFloat cellCount = 7;
        CGFloat cellGap = 20;
        for (NSInteger index = 0; index < cellCount-1; index++) {
            NSView *cell = [[NSView alloc] initWithFrame:CGRectMake(sideSpace+(cellSize.width+cellGap)*index, 5, cellSideLength, cellSideLength)];
            cell.wantsLayer = true;
            cell.layerContentsRedrawPolicy = NSViewLayerContentsRedrawOnSetNeedsDisplay;
            if (index == 0) {
                cell.layer.backgroundColor = [[NSColor whiteColor] CGColor];
            }else{
//                cell.layer.backgroundColor = [[Theme shared] markColor] objectAtIndex:<#(NSUInteger)#>
            }
        }
    }
}

- (void)didClick:(NSClickGestureRecognizer *)sender{
    
}

- (void)didPan:(NSPanGestureRecognizer *)sender{
    
}
@end
