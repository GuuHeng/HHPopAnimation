//
//  HHPopAnimationNavigationController.h
//  HHPopAnimation
//
//  Created by HuHeng on 2016/12/23.
//  Copyright © 2016年 Bric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHPopAnimationNavigationController : UINavigationController

/**
 需要禁止pop时手势动画的视图控制器
 */
@property (nonatomic, strong) NSArray *disableViewControllers;

@end
