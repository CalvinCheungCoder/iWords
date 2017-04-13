//
//  ThreeViewController.m
//  iWords
//
//  Created by 张丁豪 on 2017/4/12.
//  Copyright © 2017年 zhangdinghao. All rights reserved.
//

#import "ThreeViewController.h"
#import "CenterCell.h"
#import "InviteViewController.h"
#import "HelpCenterViewController.h"
#import "UserAgreementViewController.h"
#import "LanSwitchViewController.h"
#import "JoinGroupViewController.h"

@interface ThreeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人中心";
    
    [self createTableView];
}

- (void)createTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    [self.view addSubview:self.tableView];
}

#pragma mark --
#pragma mark -- TableViewDele & DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }else{
        return 3;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        static NSString *homeTwoCell = @"HomeThreeCell";
        CenterCell *cell = [tableView dequeueReusableCellWithIdentifier:homeTwoCell];
        if (!cell) {
            cell = [[CenterCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:homeTwoCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        NSArray *arr = @[@"邀请好友",@"给我好评",@"使用帮助",@"用户协议"];
        NSArray *imgArr = @[@"center_1",@"center_2",@"center_3",@"center_4"];
        cell.titleLabel.text = arr[indexPath.row];
        cell.Img.image = [UIImage imageNamed:imgArr[indexPath.row]];
        
        return cell;
        
    }else{
        static NSString *homeTwoCell = @"HomeThreeCell";
        CenterCell *cell = [tableView dequeueReusableCellWithIdentifier:homeTwoCell];
        if (!cell) {
            cell = [[CenterCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:homeTwoCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        NSArray *arr = @[@"语言切换",@"意见反馈",@"加入群组"];
        NSArray *imgArr = @[@"center_5",@"center_6",@"center_7"];
        cell.titleLabel.text = arr[indexPath.row];
        cell.Img.image = [UIImage imageNamed:imgArr[indexPath.row]];
        
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            // 邀请好友
            InviteViewController *invite = [[InviteViewController alloc]init];
            invite.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:invite animated:YES];
            
        }else if (indexPath.row == 1) {
            
            // 给我好评
           
            
        }else if (indexPath.row == 2) {
            
            // 使用帮助
            HelpCenterViewController *help = [[HelpCenterViewController alloc]init];
            help.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:help animated:YES];
            
        }else{
            
            // 用户协议
            UserAgreementViewController *user = [[UserAgreementViewController alloc]init];
            user.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:user animated:YES];
        }
        
    }else{
        
        if (indexPath.row == 0) {
            
            // 语言切换
            LanSwitchViewController *lan = [[LanSwitchViewController alloc]init];
            lan.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:lan animated:YES];
            
        }else if (indexPath.row == 1){
            
            // 意见反馈
        }else{
            
            // 加入圈子
            JoinGroupViewController *join = [[JoinGroupViewController alloc]init];
            join.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:join animated:YES];
        }
    }
}

// section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }else{
        return 5;
    }
}
// section头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }else{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 5)];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }
}
// section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 10;
    }else{
        return 5;
    }
}
// section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }else{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 5)];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }
}


@end
