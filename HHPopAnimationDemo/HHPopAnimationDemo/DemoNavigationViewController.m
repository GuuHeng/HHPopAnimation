//
//  DemoNavigationViewController.m
//  HHPopAnimationDemo
//
//  Created by Hu Heng on 2018/5/14.
//  Copyright © 2018年 Hu Heng. All rights reserved.
//

#import "DemoNavigationViewController.h"

@interface DemoNavigationViewController ()

@end

@implementation DemoNavigationViewController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.disableViewControllers = [NSArray arrayWithObjects:
                                       [NSClassFromString(@"CViewController") class],
                                       nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
