//
//  RWKnobRenderer.h
//  JYKnobControl
//
//  Created by JinYong on 15-1-23.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface RWKnobRenderer : NSObject

#pragma mark - Properties associated with all parts of the renderer
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) CGFloat lineWidth;

#pragma mark - Properties associated with the background track
@property (nonatomic, readonly, strong) CAShapeLayer *trackLayer;
@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign) CGFloat endAngle;

#pragma mark - Properties associated with the pointer element
@property (nonatomic, readonly, strong) CAShapeLayer *pointerLayer;
@property (nonatomic, assign) CGFloat pointerAngle;
@property (nonatomic, assign) CGFloat pointerLength;

- (void)updateWithBounds:(CGRect)bounds;
- (void)setPointerAngle:(CGFloat)pointerAngle animated:(BOOL)animated;
@end
