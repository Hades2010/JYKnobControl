//
//  RWKnobControl.h
//  JYKnobControl
//
//  Created by JinYong on 15-1-23.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RWKnobControl : UIControl

#pragma mark - Knob value
/**
 *  当前值
 */
@property (nonatomic, assign) CGFloat value;
- (void) setValue:(CGFloat)value animated:(BOOL)animated;

#pragma mark - Value limit
@property (nonatomic, assign) CGFloat minimumValue;
@property (nonatomic, assign) CGFloat maximumValue;
@property (nonatomic, assign, getter=isContinuous) BOOL continuous;

@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign) CGFloat endAngle;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat pointerLength;
@end
