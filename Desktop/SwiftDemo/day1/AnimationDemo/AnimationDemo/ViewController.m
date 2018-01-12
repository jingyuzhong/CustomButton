//
//  ViewController.m
//  AnimationDemo
//
//  Created by 休杰克曼 on 2017/11/23.
//  Copyright © 2017年 jingyuzhong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
<CAAnimationDelegate>
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.leftBtn.clipsToBounds = YES;
    self.leftBtn.layer.cornerRadius = 25;
    
    [self shakeAnimationLeftWithLayer:self.leftBtn.layer];
    [self shakeAnimationRightWithLayer:self.rightBtn.layer];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self shakeAnimationLeftWithLayer:self.leftBtn.layer];
    [self shakeAnimationRightWithLayer:self.rightBtn.layer];
}
- (IBAction)testDemoBtn:(id)sender {
    [self leftBackAnimation:self.leftBtn.layer];
    [self rightBackAnimation:self.rightBtn.layer];
}


- (void)leftBackAnimation:(CALayer *)layer {
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    
    animationGroup.duration =.4;
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    CGFloat positionX = layer.position.x;
    animation.values = @[@(positionX+10),@(positionX),@(positionX-70)];
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    
    rotationAnimation.byValue = @(-M_PI/2);
    
    animationGroup.animations = @[animation,rotationAnimation];
    
    animationGroup.autoreverses = NO;
    
    animationGroup.removedOnCompletion = NO;
    
    [layer addAnimation:animationGroup forKey:@"back"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        layer.hidden = YES;
    });
}
- (void)shakeAnimationLeftWithLayer:(CALayer *)layer
{
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration =.4;
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    CGFloat positionX = layer.position.x;
    animation.values = @[@(positionX-70),@(positionX+10),@(positionX)];
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.byValue = @(M_PI/2);
    animationGroup.animations = @[animation,rotationAnimation];
    [layer addAnimation:animationGroup forKey:nil];
}

- (void)shakeAnimationRightWithLayer:(CALayer *)layer
{
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration =.4;
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    CGFloat positionX = layer.position.x;
    animation.values = @[@(positionX+70),@(positionX-10),@(positionX)];
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.byValue = @(-M_PI/2);
    animationGroup.animations = @[animation,rotationAnimation];
    [layer addAnimation:animationGroup forKey:nil];
}

- (void)rightBackAnimation:(CALayer *)layer {
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration =.4;
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    CGFloat positionX = layer.position.x;
    animation.values = @[@(positionX-10),@(positionX),@(positionX+70)];
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.byValue = @(-M_PI/2);
    animationGroup.animations = @[animation,rotationAnimation];
    animationGroup.autoreverses = NO;
    animationGroup.removedOnCompletion = NO;
    animationGroup.delegate = self;
    [layer addAnimation:animationGroup forKey:@"back"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        layer.hidden = YES;
    });
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
