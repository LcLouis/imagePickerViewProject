//
//  ViewController.m
//  imagePickerViewProject
//
//  Created by Lc、 on 16/3/19.
//  Copyright © 2016年 Lc、. All rights reserved.
//


//选取图片

#import "ViewController.h"
#import "PECropViewController.h"
//#import "YYTimer.h"
@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,PECropViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *cameraBtn;
@property (weak, nonatomic) IBOutlet UIButton *albumBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = self.imageView.frame.size.height/2;
    
    
}
- (IBAction)clickCameraBtn:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"保存或删除数据" message:@"删除数据将不可恢复" preferredStyle: UIAlertControllerStyleActionSheet];
    
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self addPicEvent:UIImagePickerControllerSourceTypeCamera];
    }];

    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self addPicEvent:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [alertController addAction:archiveAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
//    UIAlertAction
    
//    [self addPicEvent:UIImagePickerControllerSourceTypeCamera];
}



- (IBAction)clickAlbumBtn:(id)sender {
    NSLog(@"!@#!@#");
}


//拍照
-(void) addPicEvent:(UIImagePickerControllerSourceType)sourceType
{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    
    
    picker.delegate = self;
//    if (self.istxPhoto==0)
//    {
//        //是否可以裁剪
        picker.allowsEditing = NO;
//    }
//    else
//    {
//        picker.allowsEditing = YES;
//    }
    picker.sourceType = sourceType;
    
    [self presentViewController:picker animated:YES completion:nil];
    
}

#pragma mark Camera View Delegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    UIImage *image=nil;
//    image = [info objectForKey:UIImagePickerControllerEditedImage];
//        
//        image=[self scaleToSize:image size:CGSizeMake(150, image.size.height*150/image.size.width)];
//
//    self.imageView.image = image;
//    [picker dismissViewControllerAnimated:YES completion:nil];

    
    self.navigationController.navigationBarHidden = NO;
    
    [self preferredStatusBarStyle];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [self openEditor:image];
    }];
}


- (void)openEditor:(UIImage *)image
{
    PECropViewController *controller = [[PECropViewController alloc] init];
    controller.delegate = self;
    controller.image = image;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
//    [Tools setCustomNav:navigationController];
    
    [self presentViewController:navigationController animated:YES completion:NULL];
}

- (void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage
{
    [controller dismissViewControllerAnimated:YES completion:^{
        self.imageView.image = croppedImage;
    }];
    
}
- (void)cropViewControllerDidCancel:(PECropViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:^{
        
    }];
}



//图片大小
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)newsize{
    
    UIGraphicsBeginImageContext(newsize);
    
    
    [img drawInRect:CGRectMake(0, 0, newsize.width, newsize.height)];
    
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)addXXXXX {
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path setLineWidth:1.0f];
    
    
}



@end
