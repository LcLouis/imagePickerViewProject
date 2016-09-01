//
//  imageMainColorViewController.m
//  imagePickerViewProject
//
//  Created by Lc、 on 16/4/14.
//  Copyright © 2016年 Lc、. All rights reserved.
//

#import "imageMainColorViewController.h"

@interface imageMainColorViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIColor * color;

@property (nonatomic, strong) UIImage * image;


@end

@implementation imageMainColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _image = [UIImage imageNamed:@"imageOne.jpg"];
//    CGSize size = image.size;
    self.imageView.image = _image;
    
    _color = [self mostColorintoImage:_image];
    
    
}
- (IBAction)btnClicke:(id)sender {
    self.view.backgroundColor = _color;
    
}
- (IBAction)changeqingxidu:(id)sender {
    
    [self changeImage];
    
}

-(UIColor*)mostColorintoImage:(UIImage *)image{
    
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    
    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
    CGSize thumbSize=CGSizeMake(50, 50);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,
                                                 thumbSize.height,
                                                 8,//bits per component
                                                 thumbSize.width*4,
                                                 colorSpace,
                                                 bitmapInfo);
    
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    
//    UIImage *loadImage=[UIImage imageNamed:@"imageOne.jpg"];
    CGImageRef cgimage=image.CGImage;
    
    CGContextDrawImage(context, drawRect, cgimage);
    CGColorSpaceRelease(colorSpace);
    
    
    //第二步 取每个点的像素值
    unsigned char* data = CGBitmapContextGetData (context);
    
    if (data == NULL) return nil;
    
    NSCountedSet *cls=[NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];
    
    for (int x=0; x<thumbSize.width; x++) {
        for (int y=0; y<thumbSize.height; y++) {
            
            int offset = 4*(x*y);
            
            int red = data[offset];
            int green = data[offset+1];
            int blue = data[offset+2];
            int alpha =  data[offset+3];
            
            NSArray *clr=@[@(red),@(green),@(blue),@(alpha)];
            [cls addObject:clr];
            
        }
    }
    CGContextRelease(context);
    
    
    //第三步 找到出现次数最多的那个颜色
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor = nil;
    
    NSArray *MaxColor=nil;
    NSUInteger MaxCount=0;
    
    while ( (curColor = [enumerator nextObject]) != nil )
    {
        NSUInteger tmpCount = [cls countForObject:curColor];
        
        if ( tmpCount < MaxCount ) continue;
        
        MaxCount=tmpCount;
        MaxColor=curColor;
        
    }
    
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
}



-(void)changeImage{
    
    /*..CoreImage中的模糊效果滤镜..*/
    
    //CIImage,相当于UIImage,作用为获取图片资源
    CIImage * ciImage = [[CIImage alloc]initWithImage:_image];
    
    //CIFilter,高斯模糊滤镜
    CIFilter * blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    
    //将图片输入到滤镜中
    [blurFilter setValue:ciImage forKey:kCIInputImageKey];
    
    //用来查询滤镜可以设置的参数以及一些相关的信息
//    NSLog(@"%@",[blurFilter attributes]);
    
    //设置模糊程度,默认为10,取值范围(0-100)
    [blurFilter setValue:@(20) forKey:@"inputRadius"];
    
    //将处理好的图片输出
    CIImage * outCiImage = [blurFilter valueForKey:kCIOutputImageKey];
    
    //CIContext
    CIContext * context = [CIContext contextWithOptions:nil];
    
    //获取CGImage句柄,也就是从数据流中取出图片
    CGImageRef outCGImage = [context createCGImage:outCiImage fromRect:[outCiImage extent]];
    
    //最终获取到图片
    UIImage * blurImage = [UIImage imageWithCGImage:outCGImage];
    
    //释放CGImage句柄
    CGImageRelease(outCGImage);
    
//    UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
//    imageView.image = blurImage;
//    [self.view addSubview:imageView]
//    self.image = blurImage;
    self.imageView.image = blurImage;
    
    
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
