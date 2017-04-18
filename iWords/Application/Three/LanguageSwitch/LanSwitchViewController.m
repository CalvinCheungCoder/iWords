//
//  LanSwitchViewController.m
//  iWords
//
//  Created by 张丁豪 on 2017/4/12.
//  Copyright © 2017年 zhangdinghao. All rights reserved.
//

#import "LanSwitchViewController.h"
#import "LanSwitchCell.h"

@interface LanSwitchViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LanSwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = DHLocalizedString(@"语言切换");
    
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
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *homeTwoCell = @"HomeThreeCell";
    LanSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:homeTwoCell];
    if (!cell) {
        cell = [[LanSwitchCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:homeTwoCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSArray *arr = @[@"简体中文",@"繁體中文",@"English"];
    cell.titleLabel.text = arr[indexPath.section];
    
    NSString *lan = [Tools returnValueforKey:@"userLanguage"];
    NSString *jian = ([lan isEqualToString:@"zh-Hans"] || [lan isEqualToString:@"zh-Hans-CN"]) ? @"centercheck" : @"";
    NSString *fan = [lan isEqualToString:@"zh-Hant"] ? @"centercheck" : @"";
    NSString *eng = [lan isEqualToString:@"en"] ? @"centercheck" : @"";
    NSArray *imgArr = @[jian,fan,eng];
    cell.Img.image = [UIImage imageNamed:imgArr[indexPath.section]];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.section == 0) {
        
        [DHLanguageTool setUserlanguage:DHSimplifiedChinese];
        
    }else if (indexPath.section == 1){
        
        [DHLanguageTool setUserlanguage:DHTraditionalChinese];
        
    }else{
        
        [DHLanguageTool setUserlanguage:DHEnglish];
    }
}

// section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }else{
        return 0.5;
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
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }
}
// section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}
// section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}



@end
