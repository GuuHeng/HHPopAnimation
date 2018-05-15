//
//  ScreenShotView.h
//  HHPopAnimation
//
//  Created by HuHeng on 2016/12/8.
//  Copyright © 2016年 Bric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScreenShotView : UIView

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIView *maskView;

- (void)showEffectChange:(CGPoint)pt;

@end
