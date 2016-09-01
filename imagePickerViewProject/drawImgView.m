//
//  drawImgView.m
//  imagePickerViewProject
//
//  Created by Lc、 on 16/8/23.
//  Copyright © 2016年 Lc、. All rights reserved.
//

#import "drawImgView.h"

@implementation drawImgView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(100, 100)];
    [path addLineToPoint:CGPointMake(100, 120)];
    [path addLineToPoint:CGPointMake(110, 130)];
    [path addLineToPoint:CGPointMake(100, 140)];
    [path addLineToPoint:CGPointMake(100, 170)];
    [path addLineToPoint:CGPointMake(20, 170)];
    [path addLineToPoint:CGPointMake(20, 100)];
    [path closePath];
    [path addClip];
}


@end
