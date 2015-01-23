//
//  RWKnobControl.m
//  JYKnobControl
//
//  Created by JinYong on 15-1-23.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "RWKnobControl.h"
#import "RWKnobRenderer.h"
#import "RWRotationGestureRecognizer.h"
@implementation RWKnobControl{
    RWKnobRenderer *_knobRederer;
    RWRotationGestureRecognizer *_gestureRecognizer;
}
@dynamic lineWidth;
@dynamic startAngle;
@dynamic endAngle;
@dynamic pointerLength;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor lightGrayColor];
        _minimumValue = 0.0;
        _maximumValue = 1.0;
        _value = 0.0;
        _continuous = YES;
        
        _gestureRecognizer = [[RWRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        [self addGestureRecognizer:_gestureRecognizer];
        
        [self createKnobUI];
    }
    return self;
}

- (void)handleGesture:(RWRotationGestureRecognizer *)gesture{
    CGFloat midPointAngle = (2 * M_PI + self.startAngle - self.endAngle) / 2 + self.endAngle;
    
    CGFloat boundedAngle = gesture.touchAngle;
    
    if (boundedAngle > midPointAngle) {
        boundedAngle -= 2 * M_PI;
    } else if (boundedAngle < (midPointAngle - 2 * M_PI)){
        boundedAngle += 2 * M_PI;
    }
    
    boundedAngle = MIN(self.endAngle, MAX(self.startAngle, boundedAngle));
    
    CGFloat angleRange = self.endAngle - self.startAngle;
    CGFloat valueRange = self.maximumValue - self.minimumValue;
    CGFloat valueForAngle = (boundedAngle - self.startAngle) / angleRange *valueRange + self.minimumValue;
    
    self.value = valueForAngle;
    
    if (self.continuous) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    else{
        if (_gestureRecognizer.state == UIGestureRecognizerStateEnded || _gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
    }
               
}

- (CGFloat)lineWidth{
    return _knobRederer.lineWidth;
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    _knobRederer.lineWidth = lineWidth;
}

- (CGFloat)startAngle{
    return _knobRederer.startAngle;
}

- (void)setStartAngle:(CGFloat)startAngle
{
    _knobRederer.startAngle = startAngle;
}

- (CGFloat)endAngle{
    return _knobRederer.endAngle;
}

- (void)setEndAngle:(CGFloat)endAngle{
    _knobRederer.endAngle = endAngle;
}


- (void)setValue:(CGFloat)value animated:(BOOL)animated
{
    if (value != _value) {
        [self willChangeValueForKey:@"value"];
        
        _value = MIN(self.maximumValue, MAX(self.minimumValue, value));
        
        CGFloat angleRange = self.endAngle - self.startAngle;
        CGFloat valueRange = self.maximumValue - self.minimumValue;
        CGFloat angleForValue = (_value - self.minimumValue) / valueRange * angleRange + self.startAngle;
//        _knobRederer.pointerAngle = angleForValue;
        [_knobRederer setPointerAngle:angleForValue animated:animated];
        
        [self didChangeValueForKey:@"value"];
    }
}

- (void)setValue:(CGFloat)value
{
    [self setValue:value animated:NO];
}

- (void)tintColorDidChange
{
    _knobRederer.color = self.tintColor;
}

- (CGFloat)pointerLength
{
    return _knobRederer.pointerLength;
}

- (void)setPointerLength:(CGFloat)pointerLength
{
    _knobRederer.pointerLength = pointerLength;
}

- (void)createKnobUI{
    _knobRederer = [[RWKnobRenderer alloc] init];
    [_knobRederer updateWithBounds:self.bounds];
    _knobRederer.color = self.tintColor;
    _knobRederer.startAngle = -M_PI*11/8.0;
    _knobRederer.endAngle = M_PI*3 /8.0;
    _knobRederer.pointerAngle = _knobRederer.startAngle;
    _knobRederer.lineWidth = 4.0f;
    _knobRederer.pointerLength = 8.0f;
    
    [self.layer addSublayer:_knobRederer.trackLayer];
    [self.layer addSublayer:_knobRederer.pointerLayer];
}
@end
