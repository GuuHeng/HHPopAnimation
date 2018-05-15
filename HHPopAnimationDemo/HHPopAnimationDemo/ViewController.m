//
//  ViewController.m
//  HHPopAnimationDemo
//
//  Created by Hu Heng on 2018/5/14.
//  Copyright © 2018年 Hu Heng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(100, 100, 100, 100);
    [button setTitle:@"present" forState:UIControlStateNormal];
    [button setTitle:@"presenting" forState:UIControlStateHighlighted];
    [button setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
}

- (void)push {
    UIViewController *aVC = [[NSClassFromString(@"AViewController") alloc] init];
    UINavigationController *nav = [[NSClassFromString(@"DemoNavigationViewController") alloc] initWithRootViewController:aVC];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
