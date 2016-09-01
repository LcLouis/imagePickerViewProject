//
//  imageCirleViewController.m
//  imagePickerViewProject
//
//  Created by Lc、 on 16/8/18.
//  Copyright © 2016年 Lc、. All rights reserved.
//

#import "imageCirleViewController.h"
#import "Masonry.h"

@interface imageCirleViewController ()

@end

@implementation imageCirleViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    UICollectionViewLayout * collectionLayout = [[UICollectionViewLayout alloc]init];
//    collectionLayout
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:collectionLayout];
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    
    
    
}

@end
