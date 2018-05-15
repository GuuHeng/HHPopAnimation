//
//  AViewController.m
//  HHPopAnimationDemo
//
//  Created by Hu Heng on 2018/5/14.
//  Copyright © 2018年 Hu Heng. All rights reserved.
//

#import "AViewController.h"

@interface AViewController ()

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<"
                                                                             style:UIBarButtonItemStyleDone
                                                                            target:self
                                                                            action:@selector(pop)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"push"
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(push)];
}

- (void)push {
    UIViewController *bVC = [[NSClassFromString(@"BViewController") alloc] init];
    [self.navigationController pushViewController:bVC animated:YES];
}

- (void)pop {
    [self dismissViewControllerAnimated:YES completion:nil];
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
