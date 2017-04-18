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
#import "MainTabBar.h"
#import "AboutMeViewController.h"
#import <MessageUI/MessageUI.h>

@interface ThreeViewController ()<UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = DHLocalizedString(@"个人中心");
    
    [self createTableView];
    
    [Tools logUserdefault];
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
    if (section == 0) {
        return 4;
    }else if (section == 2){
        return 1;
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
        
        NSArray *arr = @[DHLocalizedString(@"邀请好友"),DHLocalizedString(@"给我好评"),DHLocalizedString(@"使用帮助"),DHLocalizedString(@"用户协议")];
        NSArray *imgArr = @[@"center_1",@"center_2",@"center_3",@"center_4"];
        cell.titleLabel.text = arr[indexPath.row];
        cell.Img.image = [UIImage imageNamed:imgArr[indexPath.row]];
        
        return cell;
        
    }else if (indexPath.section == 2){
        
        static NSString *homeTwoCell = @"HomeThreeCell";
        CenterCell *cell = [tableView dequeueReusableCellWithIdentifier:homeTwoCell];
        if (!cell) {
            cell = [[CenterCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:homeTwoCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        NSArray *arr = @[DHLocalizedString(@"关于我")];
        NSArray *imgArr = @[@"center_8"];
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
        
        NSArray *arr = @[DHLocalizedString(@"语言切换"),DHLocalizedString(@"意见反馈"),DHLocalizedString(@"加入群组")];
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
        
    }else if (indexPath.section == 2){
        
        if (indexPath.row == 0) {
            
            // 关于我
            AboutMeViewController *about = [[AboutMeViewController alloc]init];
            about.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:about animated:YES];
        }
        
    }else{
        
        if (indexPath.row == 0) {
            
            // 语言切换
            LanSwitchViewController *lan = [[LanSwitchViewController alloc]init];
            lan.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:lan animated:YES];
            
        }else if (indexPath.row == 1){
            
            // 意见反馈 检测是否安装邮箱
            if ([MFMailComposeViewController canSendMail]) { // 用户已设置邮件账户
                
                [self sendBySysMail];
                
            }else{
                setToast(@"未检测到您手机上的邮件客户端");
            }
            
        }else{
            
            // 加入圈子
            JoinGroupViewController *join = [[JoinGroupViewController alloc]init];
            join.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:join animated:YES];
        }
    }
}

#pragma mark --
#pragma mark -- 系统邮箱
- (void)sendBySysMail
{
    // 邮件服务器
    MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
    // 设置邮件代理
    [mailCompose setMailComposeDelegate:self];

    // 设置邮件主题
    [mailCompose setSubject:@"iWords 意见反馈"];
    // 设置收件人
    [mailCompose setToRecipients:@[@"984382258@qq.com"]];

    // 设置抄送人
//    [mailCompose setCcRecipients:@[@"邮箱号码"]];
    // 设置密抄送
//    [mailCompose setBccRecipients:@[@"邮箱号码"]];

    /**
     *  设置邮件的正文内容
     */
    NSString *nowVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    NSString *emailContent = [NSString stringWithFormat:@"\n\n\n\n\n\n机型:%@，系统版本:%@，iWords:%@",[Tools getCurrentDeviceModel],[[UIDevice currentDevice] systemVersion],nowVersion];
    // 是否为HTML格式
    [mailCompose setMessageBody:emailContent isHTML:NO];
    // 如使用HTML格式，则为以下代码
    //    [mailCompose setMessageBody:@"<html><body><p>Hello</p><p>World！</p></body></html>" isHTML:YES];

    /**
     *  添加附件
     */
//    UIImage *image = [UIImage imageNamed:@"image"];
//    NSData *imageData = UIImagePNGRepresentation(image);
//    [mailCompose addAttachmentData:imageData mimeType:@"" fileName:@"custom.png"];

//    NSString *file = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"pdf"];
//    NSData *pdf = [NSData dataWithContentsOfFile:file];
//    [mailCompose addAttachmentData:pdf mimeType:@"" fileName:@"7天精通iOS"];
    
    // 弹出邮件发送视图
    [self presentViewController:mailCompose animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled: // 用户取消编辑
            NSLog(@"Mail send canceled...");
            break;
        case MFMailComposeResultSaved: // 用户保存邮件
            NSLog(@"Mail saved...");
            break;
        case MFMailComposeResultSent: // 用户点击发送
            NSLog(@"Mail sent...");
            break;
        case MFMailComposeResultFailed: // 用户尝试保存或发送邮件失败
            NSLog(@"Mail send errored: %@...", [error localizedDescription]);
            break;
    }
    // 关闭邮件发送视图
    [self dismissViewControllerAnimated:YES completion:nil];
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
    if (section == 2) {
        return 10;
    }else{
        return 5;
    }
}
// section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    if (section == 2) {
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
