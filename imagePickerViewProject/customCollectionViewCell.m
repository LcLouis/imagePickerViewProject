//
//  customCollectionViewCell.m
//  imagePickerViewProject
//
//  Created by Lc、 on 16/9/1.
//  Copyright © 2016年 Lc、. All rights reserved.
//

#import "customCollectionViewCell.h"
#import "Masonry.h"

@interface customCollectionViewCell ()

@end

@implementation customCollectionViewCell

//- (void)awakeFromNib {
//    [super awakeFromNib];
//
//    
//}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.imgView = [[UIImageView alloc]init];
        [self addSubview:_imgView];
        _imgView.image = [UIImage imageNamed:@"123.png"];
        _imgView.backgroundColor = [UIColor redColor];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(2);
            make.right.mas_equalTo(-2);
            make.top.mas_equalTo(2);
            make.bottom.mas_equalTo(-2);
        }];
        [_imgView layoutIfNeeded];
        _imgView.layer.cornerRadius = _imgView.frame.size.height/2;
        _imgView.layer.masksToBounds = YES;
    }
    return self;
}


@end
