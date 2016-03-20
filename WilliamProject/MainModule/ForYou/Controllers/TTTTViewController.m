//
//  TTTTViewController.m
//  WilliamProject
//
//  Created by WilliamChen on 16/1/20.
//  Copyright © 2016年 WilliamChen. All rights reserved.
//

#import "TTTTViewController.h"

@interface TTTTViewController ()
{
    CAShapeLayer *shapeLayer;
}
@property (nonatomic, strong) CATextLayer *textLayer;
@end

@implementation TTTTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBezierPath *path = [[UIBezierPath alloc]init];
    [path moveToPoint:CGPointMake(175, 100)];
    
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    
    shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    
    [self.view.layer addSublayer:shapeLayer];
    
    _textLayer = [CATextLayer layer];
    _textLayer.frame = CGRectMake(20, 260, self.view.width - 40, 100);
    [self.view.layer addSublayer:_textLayer];
    _textLayer.foregroundColor = [UIColor blackColor].CGColor;
    _textLayer.alignmentMode = kCAAlignmentJustified;
    _textLayer.wrapped = YES;
    
    UIFont *font = [UIFont systemFontOfSize:15];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    _textLayer.font = fontRef;
    _textLayer.fontSize = font.pointSize;
    _textLayer.contentsScale = [UIScreen mainScreen].scale;
    CGFontRelease(fontRef);
    
    
    NSString *string = @"终于做了这个决定，别人怎么说我都不理，只要你也一样的肯定，我不能，我不能";
    _textLayer.string = string;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(100, CGRectGetMaxY(_textLayer.frame) + 10, self.view.width - 200, 100);
    [self.view.layer addSublayer:gradientLayer];
    
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor, (__bridge id)[UIColor blueColor].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    
    CAReplicatorLayer *repeatLayer = [CAReplicatorLayer layer];
    repeatLayer.frame = CGRectMake(10, CGRectGetMaxY(gradientLayer.frame)+10, self.view.width - 20, 300);
    [self.view.layer addSublayer:repeatLayer];
    
    repeatLayer.instanceCount = 10;
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 200, 0);
    transform = CATransform3DRotate(transform, M_PI/5.0, 0, 0, 1);
    transform = CATransform3DTranslate(transform, 0, -200, 0);
    repeatLayer.instanceTransform = transform;
    repeatLayer.instanceBlueOffset = -0.1;
    repeatLayer.instanceGreenOffset = -0.1;
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(100, 100, 100, 100);
    layer.backgroundColor = [UIColor redColor].CGColor;
    [repeatLayer addSublayer:layer];
    
    
    self.navigationController.toolbarHidden = NO;
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"点击" style:UIBarButtonItemStylePlain target:self action:@selector(clickAction)];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    self.toolbarItems = @[item1, item, item1];
}

- (void)clickAction
{
//    [CATransaction begin];
//    [CATransaction setAnimationDuration:3];
//    [CATransaction setCompletionBlock:^{
//        CGAffineTransform transform = _textLayer.affineTransform;
//        transform = CGAffineTransformRotate(transform, M_PI);
//        _textLayer.affineTransform = transform;
//    }];
//    CGRect rect = _textLayer.frame;
//    rect.origin.y += 40;
//    _textLayer.frame = rect;
//    [CATransaction commit];
    
    
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
//    animation.keyPath = @"backgroundColor";
//    animation.duration = 3.0;
//    CAMediaTimingFunction *fn = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    animation.timingFunctions = @[fn, fn, fn];
//    
//    animation.values = @[(__bridge id)[UIColor blueColor].CGColor,
//                         (__bridge id)[UIColor redColor].CGColor,
//                         (__bridge id)[UIColor greenColor].CGColor,
//                         (__bridge id)[UIColor blueColor].CGColor];
//    [_textLayer addAnimation:animation forKey:nil];
    
//    CALayer *miniLayer = [CALayer layer];
//    miniLayer.frame = CGRectMake(0, 0, 10, 10);
//    miniLayer.backgroundColor = [UIColor blueColor].CGColor;
//    [self.view.layer addSublayer:miniLayer];
//    
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
//    animation.path = shapeLayer.path;
//    animation.keyPath = @"position";
//    animation.duration = 10;
//    [miniLayer addAnimation:animation forKey:nil];
    
    void (^aBlock)(void) = nil;
    if (!aBlock) {
        aBlock = ^{
            printf("Hehe");
        };
    }
    
    aBlock();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
