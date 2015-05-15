
#import "ViewController.h"
@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    
    _mutableArr = [[NSMutableArray alloc]initWithCapacity:0];
    
    Mycontrol  *controlOne = [[Mycontrol alloc]init];
    controlOne.center = CGPointMake(240, 160);
    controlOne.tag = 0;
    controlOne.direction = 0;
    NSLog(@"%f %f",controlOne.center.x,controlOne.center.y);
    controlOne.bounds = CGRectMake(0, 0, 100, 170);
    controlOne.backgroundColor = [UIColor redColor];
    
    UIImageView *imgViewOne = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"0.jpg"]];
    imgViewOne.frame = CGRectMake(0, 0, 100, 170);
    
    UIImageView *imgViewTwo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"影子0.png"]];
    imgViewTwo.frame = CGRectMake(0, 168, 100, 170);
    
    [controlOne addTarget:self action:@selector(allFounction:) forControlEvents:UIControlEventTouchUpInside];
    [controlOne addSubview:imgViewOne];
    [controlOne addSubview:imgViewTwo];
    [self.view addSubview:controlOne];
    [_mutableArr addObject:controlOne];
    for (int i = 0; i< 4; i++) {
        Mycontrol *control = [[Mycontrol alloc]init];
        control.center = CGPointMake(380 + i*50, 150);
        control.bounds = CGRectMake(0, 0, 100, 170);
        control.tag = i+1;
        control.direction = 1;
        [control addTarget:self action:@selector(allFounction:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *imgViewThire = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i+1]]];
        imgViewThire.frame = CGRectMake(0, 0, 100, 170);
        
        UIImageView *imgViewFour = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"影子%d.png",i+1]]];
        imgViewFour.frame = CGRectMake(0, 168, 100, 170);
        
        
        CATransform3D scale = CATransform3DIdentity;
        scale.m34 = -1.0f/100;
        scale =CATransform3DConcat(CATransform3DMakeRotation(-20 * M_PI/180, 0, 1, 0), scale);
        scale = CATransform3DScale(scale, 0.7, 0.5, 1);
        control.layer.transform = scale;
        [control addSubview:imgViewThire];
        [control addSubview:imgViewFour];
        [_mutableArr addObject:control];
    }
    for (int i = _mutableArr.count-1;i>0 ; i--) {
        Mycontrol *control = [_mutableArr objectAtIndex:i];
        [self.view addSubview:control];
    }
    
    [self jiaohuxing];
    Mycontrol *controlUsing = [_mutableArr objectAtIndex:1];
    controlUsing.userInteractionEnabled = YES;
    
}

//设置交互性；
- (void)jiaohuxing
{
    for (Mycontrol *control in _mutableArr) {
        control.userInteractionEnabled = NO;
    }
}
- (void)allFounction:(Mycontrol*)sender
{
    if (sender.direction == 1) {
        [self rightFounction:sender];
    }else if(sender.direction == 2)
    {
        NSLog(@"这是向右移动");
        [self leftFounction:sender];
    }
}
- (void)leftFounction:(Mycontrol *)sender
{
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = 0;
    [self animationset:CGPointMake(240, 160)btn:sender];
    scale =CATransform3DConcat(CATransform3DMakeRotation(20 * M_PI/180, 0, 1, 0), scale);
    CABasicAnimation *animation = [[CABasicAnimation alloc] init];
    animation.keyPath = @"transform";
    animation.toValue = [NSValue valueWithCATransform3D:scale];
    animation.duration = 0.1;
    animation.removedOnCompletion = NO;
    [sender.layer addAnimation:animation forKey:@"donghua"];
    
    CATransform3D scaleOne = CATransform3DIdentity;
    scaleOne.m34 = -1.0f/100;
    
    Mycontrol *control = [_mutableArr objectAtIndex:sender.tag+1];
    [self animationset:CGPointMake(330,150) btn:control];
    transFrom =CATransform3DConcat(CATransform3DMakeRotation(-20 * M_PI/180, 0, 1, 0), scaleOne);
    transFrom = CATransform3DScale(transFrom, 0.7, 0.5, 1);
    [self performSelector:@selector(yanchi:) withObject:sender afterDelay:0.1];
}

- (void)rightFounction:(Mycontrol*)sender
{
        CATransform3D scale = CATransform3DIdentity;
        scale.m34 = 0;
        [self animationset:CGPointMake(240, 160) btn:sender];
        scale =CATransform3DConcat(CATransform3DMakeRotation(20 * M_PI/180, 0, 1, 0), scale);
        CABasicAnimation *animation = [[CABasicAnimation alloc] init];
        animation.keyPath = @"transform";
        animation.toValue = [NSValue valueWithCATransform3D:scale];
        animation.duration = 0.1;
        animation.removedOnCompletion = NO;
        [sender.layer addAnimation:animation forKey:@"donghua"];
        
        //延迟改变图片属性
        CATransform3D scaleOne = CATransform3DIdentity;
        scaleOne.m34 = -1.0f/100;
        [self animationset:CGPointMake(150, 150)btn:[_mutableArr objectAtIndex:sender.tag-1]];
        transFrom =CATransform3DConcat(CATransform3DMakeRotation(20 * M_PI/180, 0, 1, 0), scaleOne);
        transFrom = CATransform3DScale(transFrom, 0.7, 0.5, 1);
        [self performSelector:@selector(yanchi:) withObject:sender afterDelay:0.1];
    
    
}


- (void)animationset:(CGPoint)point btn:(Mycontrol *)sender
{
       //改变位移
    [UIView animateWithDuration:0.5 animations:^{
        sender.center = point;
        
    } completion:^(BOOL finished) {
        
    }];
    if (sender.direction == 1) {
        NSLog(@"%d++++++++++",sender.tag);
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(movingOne:) userInfo:sender repeats:YES];
    }else if(sender.direction == 2)
    {
        NSLog(@"这是左边");
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(movingTwo:) userInfo:sender repeats:YES];
    }
}

- (void)movingTwo:(NSTimer *)timer
{
    Mycontrol *sender = timer.userInfo;
    for (int i = 0; i<_mutableArr.count; i++) {
        if (i != sender.tag) {
            Mycontrol *control = [_mutableArr objectAtIndex:i];
            CGPoint pointOne = control.center;
            pointOne.x = pointOne.x+1;///////*************************
            control.center = pointOne;
            Mycontrol *controlOne = [_mutableArr objectAtIndex:sender.tag+1];
            if (controlOne.center.x >380 && controlOne.center.x <382) {
                [timer invalidate];
                timer = nil;
                break;
            }
        }
    }

}

- (void)movingOne:(NSTimer *)timer
{
    Mycontrol *sender = timer.userInfo;
    
    for (int i = 0; i<_mutableArr.count; i++) {
        if (sender.direction == 1) {
            for (int j = 0; j<sender.tag; j++) {
            Mycontrol *mycontrol = [_mutableArr objectAtIndex:j];
            [self.view addSubview:mycontrol];
        }
    }
        if (i != sender.tag) {
        Mycontrol *control = [_mutableArr objectAtIndex:i];
            CGPoint pointOne = control.center;
                pointOne.x = pointOne.x-1;///////*************************
                control.center = pointOne;
                Mycontrol *controlOne = [_mutableArr objectAtIndex:sender.tag-1];
                if (controlOne.center.x >99 && controlOne.center.x <101) {
                    [timer invalidate];
                    timer = nil;
                    break;
            }
        }
    }
}

- (void)yanchi:(Mycontrol *)sender
{
    
    if (sender.direction == 1) {
        CATransform3D scale = CATransform3DIdentity;
        sender.layer.transform = scale;
        Mycontrol * control = [_mutableArr objectAtIndex:sender.tag-1];
        control.layer.transform = transFrom;
        sender.direction = 0;
        control.direction = 2;
        
    }
    else if(sender.direction == 2)
    {
        CATransform3D scale = CATransform3DIdentity;
        sender.layer.transform = scale;
        Mycontrol * control = [_mutableArr objectAtIndex:sender.tag+1];
        control.layer.transform = transFrom;
        sender.direction = 0;
        control.direction = 1;
    }
    [self jiaohuxing];
    if (sender.tag == 0) {
        Mycontrol * controlRight = [_mutableArr objectAtIndex:sender.tag+1];
        controlRight.userInteractionEnabled = YES;
       
    }else if(sender.tag == _mutableArr.count-1)
    {
        Mycontrol * controlLeft = [_mutableArr objectAtIndex:sender.tag-1];
         controlLeft.userInteractionEnabled = YES;
    }else
    {
        Mycontrol * controlRight = [_mutableArr objectAtIndex:sender.tag+1];
        Mycontrol * controlLeft = [_mutableArr objectAtIndex:sender.tag-1];
         controlRight.userInteractionEnabled = YES;
         controlLeft.userInteractionEnabled = YES;

    }
}



@end
