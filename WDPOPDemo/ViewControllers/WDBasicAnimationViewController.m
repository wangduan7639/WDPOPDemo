//
//  WDLabelValueViewController.m
//  WDPOPDemo
//
//  Created by wd on 15/12/24.
//  Copyright © 2015年 wd. All rights reserved.
//

#import "WDBasicAnimationViewController.h"

@interface WDBasicAnimationViewController ()

@property (nonatomic, strong) UILabel   *numberLabel;

@end

@implementation WDBasicAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    @weakify(self);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"Play" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItem = rightItem;
    rightItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self startAnimation];
        return [RACSignal empty];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupViews
{
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.numberLabel.text = @"0";
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    self.numberLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.numberLabel];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(100);
    }];
}

- (void)startAnimation
{
    POPBasicAnimation *animation = [POPBasicAnimation animation];
    animation.property = [self animationProperty];
    animation.fromValue = @(0);
    animation.toValue = @(8000);
    animation.duration = 10.0f;
    //增加animation 时间函数控制
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.12 :1 :0.11 :0.94];
    
    [self.numberLabel pop_addAnimation:animation forKey:@"numberLabelAnimation"];
}

- (POPMutableAnimatableProperty *)animationProperty {
    return [POPMutableAnimatableProperty
            propertyWithName:@"com.curer.test"
            initializer:^(POPMutableAnimatableProperty *prop) {
                prop.writeBlock = ^(id obj, const CGFloat values[]) {
                    UILabel *label = (UILabel *)obj;
                    NSNumber *number = @(values[0]);
                    int num = [number intValue];
                    label.text = [@(num) stringValue];
                };
            }];
}
@end
