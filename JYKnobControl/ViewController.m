//
//  ViewController.m
//  JYKnobControl
//
//  Created by JinYong on 15-1-22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import "RWKnobControl.h"
@interface ViewController (){
    RWKnobControl *_knobControl;
}
@property (nonatomic, weak) IBOutlet UIView *knobPlaceholder;
@property (nonatomic, weak) IBOutlet UISlider *valueSlider;
@property (nonatomic, weak) IBOutlet UISwitch *animateSwitch;
@property (nonatomic, weak) IBOutlet UILabel *valueLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _knobControl = [[RWKnobControl alloc] initWithFrame:self.knobPlaceholder.bounds];
    [self.knobPlaceholder addSubview:_knobControl];
    
    self.view.tintColor = [UIColor redColor];
    
    [_knobControl addObserver:self forKeyPath:@"value" options:0 context:NULL];
    
    [_knobControl addTarget:self action:@selector(handleValueChanged:) forControlEvents:UIControlEventValueChanged];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == _knobControl && [keyPath isEqualToString:@"value"]) {
        self.valueLabel.text = [NSString stringWithFormat:@"%0.2f",_knobControl.value];
    }
}

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key
{
    if ([key isEqualToString:@"value"]) {
        return NO;
    }
    else
    {
        return [super automaticallyNotifiesObserversForKey:key];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (IBAction)handleValueChanged:(id)sender{
    if (sender == self.valueSlider) {
        _knobControl.value = self.valueSlider.value;
    }
    else
    {
        self.valueSlider.value = _knobControl.value;
    }
//    _knobControl.value = self.valueSlider.value;
}

- (IBAction)handleRandomButtonPressed:(id)sender{
    CGFloat randomValue = (arc4random()%101)/100.f;
    [_knobControl setValue:randomValue animated:self.animateSwitch.on];
    [self.valueSlider setValue:randomValue animated:self.animateSwitch.on];
}
@end
