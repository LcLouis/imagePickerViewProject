//
//  cellViewController.m
//  imagePickerViewProject
//
//  Created by Lc、 on 16/3/31.
//  Copyright © 2016年 Lc、. All rights reserved.
//

#import "cellViewController.h"
#import "autolaoutTableViewCell.h"
@interface cellViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation cellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//     Do any additional setup after loading the view.
//    [_tableView registerNib:[UINib nibWithNibName:@"autolaoutTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellId"];
//    [self.tableView registerClass:[autolaoutTableViewCell class] forCellReuseIdentifier:@"cellId"];
    _tableView.estimatedRowHeight = 44;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    autolaoutTableViewCell * cell = [_tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if(cell == nil){
//        cell = [[autolaoutTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"autolaoutTableViewCell" owner:self options:nil]lastObject];
    }
//       autolaoutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
    return cell;
    
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
