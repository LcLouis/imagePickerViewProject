//
//  imageViewViewController.m
//  imagePickerViewProject
//
//  Created by Lc、 on 16/8/23.
//  Copyright © 2016年 Lc、. All rights reserved.
//

#import "imageViewViewController.h"
#import "drawImgView.h"

@interface imageViewViewController ()

@property (nonatomic, strong) UIImageView * imgView;

@end

@implementation imageViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    drawImgView * imgV = [[drawImgView alloc]initWithFrame:CGRectMake(0, 0, 110, 170)];
//    [self.view addSubview:imgV];
//    
//    imgV.image = [UIImage imageNamed:@"5.pic.jpg"];
    
    self.imgView  = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.imgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imgView];
    
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100, 100), NO, 0);
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    [[UIColor redColor] setStroke];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(90, 0)];
    [path addLineToPoint:CGPointMake(90, 30)];
    [path addLineToPoint:CGPointMake(100, 40)];
    [path addLineToPoint:CGPointMake(90, 50)];
    [path addLineToPoint:CGPointMake(90, 100)];
    [path addLineToPoint:CGPointMake(00, 100)];
    [path closePath];
    
    [path addClip];

    UIImage * image = [UIImage imageNamed:@"123.png"];
    [image drawInRect:CGRectMake(0, 0, 100, 100)];
    UIImage * imgV = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    self.imgView.image = imgV;
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
