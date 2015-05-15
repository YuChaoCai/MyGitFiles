//
//  ViewController.m
//  ImageReflection
//
//  Created by 寻 亚楠 on 13-10-30.
//  Copyright (c) 2013年 寻 亚楠. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 10, 110, 80)];
    
    imageView.image = [UIImage imageNamed:@"Normal.png"];
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addImageReflectionView:(id)sender {
    CALayer *reflectLayer = [CALayer layer];
    reflectLayer.contents = imageView.layer.contents;
    reflectLayer.bounds = imageView.layer.bounds;
    reflectLayer.position = CGPointMake(imageView.layer.bounds.size.width/2, imageView.layer.bounds.size.height*1.5);
    reflectLayer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    
    // 给该reflection加个半透明的layer
    CALayer *blackLayer = [CALayer layer];
    blackLayer.backgroundColor = [UIColor blackColor].CGColor;
    blackLayer.bounds = reflectLayer.bounds;
    blackLayer.position = CGPointMake(blackLayer.bounds.size.width/2, blackLayer.bounds.size.height/2);
    blackLayer.opacity = 0.6;
    [reflectLayer addSublayer:blackLayer];
    
    // 给该reflection加个mask
    CAGradientLayer *mask = [CAGradientLayer layer];
    mask.bounds = reflectLayer.bounds;
    mask.position = CGPointMake(mask.bounds.size.width/2, mask.bounds.size.height/2);
    mask.colors = [NSArray arrayWithObjects:
                   (__bridge id)[UIColor clearColor].CGColor,
                   (__bridge id)[UIColor whiteColor].CGColor, nil];
    mask.startPoint = CGPointMake(0.5, 0.35);
    mask.endPoint = CGPointMake(0.5, 1.0);
    reflectLayer.mask = mask;
    
    // 作为layer的sublayer
    [imageView.layer addSublayer:reflectLayer];
}
@end
