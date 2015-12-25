//
//  WDDecayAnimationViewController.m
//  WDPOPDemo
//
//  Created by wd on 15/12/25.
//  Copyright © 2015年 wd. All rights reserved.
//

#import "WDDecayAnimationViewController.h"

@interface WDDecayAnimationViewController ()

@property (nonatomic, strong) UIView    *popCircle;//冰壶圈

@end

@implementation WDDecayAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupViews
{
    self.popCircle = [[UIView alloc] initWithFrame:CGRectZero];
    self.popCircle.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.popCircle];
    self.popCircle.layer.cornerRadius = 50;
    [self.popCircle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
    [self.popCircle addGestureRecognizer:panGesture];
}

- (void)panGestureRecognizer:(UIPanGestureRecognizer *)gesture
{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            [self.popCircle.layer pop_removeAllAnimations];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [self.popCircle.layer pop_removeAllAnimations];
            CGPoint translation = [gesture translationInView:self.view];
            CGPoint center = self.popCircle.center;
            center.x += translation.x;
            center.y += translation.y;
            self.popCircle.center = center;
            [gesture setTranslation:CGPointZero inView:self.popCircle];
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            CGPoint velocity = [gesture velocityInView:self.view];
            [self addDecayPositionAnimationWithVelocity:velocity];
        }
            break;
        default:
            break;
    }
}

- (void)addDecayPositionAnimationWithVelocity:(CGPoint)newPoint
{
    POPDecayAnimation *anim = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPosition];
    anim.velocity = [NSValue valueWithCGPoint:CGPointMake(newPoint.x, newPoint.y)];
    [self.popCircle pop_addAnimation:anim forKey:@"DecayAnimation"];
}

@end
