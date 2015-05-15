//
//  RootViewController.m
//  GradientView
//
//  Created by xun yanan on 14-6-14.
//  Copyright (c) 2014年 xun yanan. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    UILabel *label0 = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 200, 20)];
    label0.text = @"透明度渐变";
    [self.view addSubview:label0];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 200, 20)];
    label1.text = @"Test message from gradient view";
    [self.view addSubview:label1];
    GradientView *view1 = [[GradientView alloc] initWithFrame:CGRectMake(20, 100, 200, 20) type:TRANSPARENT_GRADIENT_TYPE];
    [self.view addSubview:view1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 180, 200, 20)];
    label2.text = @"颜色渐变";
    [self.view addSubview:label2];
    GradientView *view2 = [[GradientView alloc] initWithFrame:CGRectMake(20, 200, 200,20) type:COLOR_GRADIENT_TYPE];
    view2.alpha = 1.0;
    [self.view addSubview:view2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
