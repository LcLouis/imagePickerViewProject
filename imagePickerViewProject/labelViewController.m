//
//  labelViewController.m
//  imagePickerViewProject
//
//  Created by Lc、 on 16/3/31.
//  Copyright © 2016年 Lc、. All rights reserved.
//

#import "labelViewController.h"
#import <UIKit/UIKit.h>

@interface labelViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textfield;

@property (weak, nonatomic) IBOutlet UIButton *stopBtn;//xxxbtn

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelLayout;//gao
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelWidthLayout;//width

@property (strong, nonatomic) NSTimer * timer;

@end

@implementation labelViewController

- (void)viewDidLoad {
//    [super viewDidLoad];
////    self.label.adjustsFontSizeToFitWidth = YES;
////    self.label.minimumScaleFactor = 1;
    
//    NSTimer *myTimer = [NSTimertimerWithTimeInterval:3.0 target:selfselector:@selector(timerFired:)userInfo:nilrepeats:NO];
//    
//    [[NSRunLoopcurrentRunLoop]addTimer:myTimerforMode:NSDefaultRunLoopMode];
    
//    _timer = [NSTimer timerWithTimeInterval:0 target:self selector:@selector(clickedBtn:) userInfo:nil repeats:NO];
//    [[NSRunLoopcurrentRunLoop]addTimer:myTimerforMode:NSDefaultRunLoopMode];
    
}

//- (IBAction)stopBtnclicked:(id)sender {
//    [_timer fire];
//}


- (IBAction)clickedBtn:(id)sender {
    
//    self.labelLayout.constant -= 1;
//    self.labelWidthLayout.constant -= 1;
    
//    if(self.labelLayout.constant < 30){
//        [_timer invalidate];
//    }
    
//    UIView * view  = [UIView new];
//    [self.label animateWithDuration:1 delay:1 options:nil animations:^{
//    
//    } completion:^{
//    
//    }];

    
//    [UIView animateWithDuration:5 animations:^{
//        self.labelLayout.constant -= 15;
//        self.labelWidthLayout.constant -= 20;
//
//    }];
//    [UIView animateWithDuration:5 animations:^{
//        self.labelLayout.constant -= 15;
//        self.labelWidthLayout.constant -= 20;
////        self.label.font = [UIFont systemFontOfSize:10];
//        [self.view layoutIfNeeded];
//        [self.textfield layoutIfNeeded];
//    } completion:^(BOOL finished) {
//         NSLog(@"1111");
//    }];
    
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.label.transform = CGAffineTransformScale(CGAffineTransformMakeTranslation(- 0.1* self.label.frame.size.width, -25),0.8f, 0.8f);
    } completion:^(BOOL finished) {
//        self.animationType = ViewAnimationTypeDown;
    }];
    
    
//
//   [UIView animateWithDuration:5 delay:2 options:1 animations:^{
//       self.labelLayout.constant -= 15;
//       self.labelWidthLayout.constant -= 20;
//       
//   } completion:^(BOOL finished) {
//       NSLog(@"1111");
//   }];
}
- (IBAction)recoverBtnClick:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.label.transform = CGAffineTransformScale(CGAffineTransformMakeTranslation(0, 0), 1.0f, 1.0f);
        // self.inputDescLable.font = [UIFont systemFontOfSize:16];
    } completion:^(BOOL finished) {
//        self.animationType = ViewAnimationTypeUp;
    }];
    
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
