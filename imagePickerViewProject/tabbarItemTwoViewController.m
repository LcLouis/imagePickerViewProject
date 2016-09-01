//
//  tabbarItemTwoViewController.m
//  imagePickerViewProject
//
//  Created by Lc、 on 16/4/21.
//  Copyright © 2016年 Lc、. All rights reserved.
//

#import "tabbarItemTwoViewController.h"
#import "BackgroundTransferServiceViewController.h"
#import "jsViewController.h"
#import "imageViewViewController.h"

@interface tabbarItemTwoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray * dataArr;

@end

@implementation tabbarItemTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDecimalNumber * num = 0;
    if([num integerValue] == 0){
        NSLog(@"===================");
    }
    _dataArr = @[@"电子书",@"后台传输数据",@"js交互",@"图片圆角处理",@"不同样式ImageView"];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellId = @"cellId";
    UITableViewCell * tableViewcell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!tableViewcell){
        tableViewcell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
        tableViewcell.textLabel.text = _dataArr[indexPath.row];
    }
    return tableViewcell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        UIViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"textBookController"];
        
        [self.navigationController pushViewController:next animated:YES];
    }else if (indexPath.row == 1){
        BackgroundTransferServiceViewController * vc = [[BackgroundTransferServiceViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.row == 2){
        jsViewController * vc = [[jsViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if(indexPath.row == 4){
        imageViewViewController * vc = [[imageViewViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
    
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
