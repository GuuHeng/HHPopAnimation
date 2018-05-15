//
//  HHPopAnimationNavigationController.m
//  HHPopAnimation
//
//  Created by HuHeng on 2016/12/23.
//  Copyright © 2016年 Bric. All rights reserved.
//

#import "HHPopAnimationNavigationController.h"
#import "ScreenShotView.h"


@interface HHPopAnimationNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSMutableArray *screenShotArray;
@property (nonatomic, strong) ScreenShotView *screenShotView;
@property (nonatomic, strong) UIPanGestureRecognizer *panGes;

@end

@implementation HHPopAnimationNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.screenShotArray = [NSMutableArray array];
    self.delegate = self;
    self.panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    self.panGes.delegate = self;
    self.panGes.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:self.panGes];
    
    [self screenShot];
}

- (void)pan:(UIPanGestureRecognizer *)panGes
{
    [[UIApplication sharedApplication] sendAction: @selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
    UIViewController *rootVC = [UIApplication sharedApplication].delegate.window.rootViewController;
    UIViewController *presentedVC = rootVC.presentedViewController;
    if (self.viewControllers.count == 1)
    {
        return;
    }
    if (panGes.state == UIGestureRecognizerStateBegan)
    {
        self.screenShotView.hidden = NO;
    }
    else if (panGes.state == UIGestureRecognizerStateChanged)
    {
        CGPoint pt = [panGes translationInView:self.view];
        
        if (pt.x >= 10)
        {
            rootVC.view.transform = CGAffineTransformMakeTranslation(pt.x - 10, 0);
            presentedVC.view.transform = CGAffineTransformMakeTranslation(pt.x - 10, 0);
            [self.screenShotView showEffectChange:CGPointMake(rootVC.view.transform.tx, 0) ];
        }
    }
    else if (panGes.state == UIGestureRecognizerStateEnded)
    {
        CGPoint pt = [panGes translationInView:self.view];
        
        if (pt.x >= 100)
        {
            [UIView animateWithDuration:0.3 animations:^{
                rootVC.view.transform = CGAffineTransformMakeTranslation([UIScreen mainScreen].bounds.size.width, 0);
                presentedVC.view.transform = CGAffineTransformMakeTranslation([UIScreen mainScreen].bounds.size.width, 0);
                [self.screenShotView showEffectChange:CGPointMake(rootVC.view.transform.tx, 0)];
            } completion:^(BOOL finished) {
                [self popViewControllerAnimated:NO];
                rootVC.view.transform = CGAffineTransformIdentity;
                presentedVC.view.transform = CGAffineTransformIdentity;
                self.screenShotView.hidden = YES;
            }];
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                rootVC.view.transform = CGAffineTransformIdentity;
                presentedVC.view.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                self.screenShotView.hidden = YES;
            }];
        }
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.view == self.view) {
        if (self.childViewControllers.count < 1) {
            return NO;
        }
        return YES;
    }
    return NO;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[UIApplication sharedApplication] sendAction: @selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    if (self.viewControllers.count == 0)
        return [super pushViewController:viewController animated:animated];
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake([UIApplication sharedApplication].delegate.window.bounds.size.width,
                                                      [UIApplication sharedApplication].delegate.window.bounds.size.height), YES, 0);
    
    [[UIApplication sharedApplication].delegate.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.screenShotArray addObject:viewImage];
    
    self.screenShotView.imgView.image = viewImage;
    [super pushViewController:viewController animated:animated];
    [viewController.navigationController setNavigationBarHidden:NO animated:YES];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    [[UIApplication sharedApplication] sendAction: @selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
    [self.screenShotArray removeLastObject];
    UIImage *image = [self.screenShotArray lastObject];
    
    if (image)
        self.screenShotView.imgView.image = image;
    UIViewController *v = [super popViewControllerAnimated:animated];
    return v;
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    if (self.screenShotArray.count > 2)
    {
        [self.screenShotArray removeObjectsInRange:NSMakeRange(1, self.screenShotArray.count - 1)];
    }
    UIImage *image = [self.screenShotArray lastObject];
    if (image)
        self.screenShotView.imgView.image = image;
    
    return [super popToRootViewControllerAnimated:animated];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSArray *arr = [super popToViewController:viewController animated:animated];
    
    if (self.screenShotArray.count > arr.count)
    {
        for (int i = 0; i < arr.count; i++) {
            [self.screenShotArray removeLastObject];
        }
    }
    return arr;
}

#pragma mark - UINavigationControllerDelegate
/**
 设置不需要拖拽手势的页面
 */
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count < 1) {
        [navigationController.view removeGestureRecognizer:self.panGes];
    }
    
    for (UIViewController *vc in self.disableViewControllers) {
        if ([[viewController class] isSubclassOfClass:[vc class]]) {
            [navigationController.view removeGestureRecognizer:self.panGes];
            break;
        }
    }
}

/**
 插入屏幕截图
 */
- (void)screenShot
{
    self.screenShotView = [[ScreenShotView alloc] initWithFrame:CGRectMake(0, 0, [UIApplication sharedApplication].delegate.window.frame.size.width, [UIApplication sharedApplication].delegate.window.frame.size.height)];
    [[UIApplication sharedApplication].delegate.window insertSubview:self.screenShotView atIndex:0];
    self.screenShotView.hidden = YES;
}

@end
