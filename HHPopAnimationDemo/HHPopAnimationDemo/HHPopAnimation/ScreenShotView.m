//
//  ScreenShotView.m
//  HHPopAnimation
//
//  Created by HuHeng on 2016/12/8.
//  Copyright © 2016年 Bric. All rights reserved.
//

#import "ScreenShotView.h"

@implementation ScreenShotView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.imgView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.maskView = [[UIView alloc] initWithFrame:self.bounds];
        self.maskView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.4];
        
        [self addSubview:self.imgView];
        [self addSubview:self.maskView];
    }
    return self;
}

- (void)showEffectChange:(CGPoint)pt
{
    if (pt.x > 0)
    {
        self.maskView.backgroundColor = [UIColor colorWithHue:0 saturation:0
                                                   brightness:0
                                                        alpha:-pt.x / [UIScreen mainScreen].bounds.size.width * 0.4 + 0.4];
        self.imgView.transform = CGAffineTransformMakeScale(0.95 + (pt.x / [UIScreen mainScreen].bounds.size.width  * 0.05),
                                                            0.95 + (pt.x / [UIScreen mainScreen].bounds.size.width  * 0.05));
    }
}

@end
