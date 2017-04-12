//
//  GuideViewController.m
//  iWords
//
//  Created by 张丁豪 on 2017/4/12.
//  Copyright © 2017年 zhangdinghao. All rights reserved.
//

#import "GuideViewController.h"
#import "MainTabBar.h"

#define PageNumber 4

@interface GuideViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIPageControl *pageControl;


@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
}

- (void)createUI{
    UIScrollView *guideScrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    guideScrollView.delegate = self;
    guideScrollView.contentSize = CGSizeMake(ScreenWidth * PageNumber, ScreenHeight);
    guideScrollView.contentOffset = CGPointMake(0, 0);
    guideScrollView.showsVerticalScrollIndicator = NO;
    guideScrollView.showsHorizontalScrollIndicator = NO;
    guideScrollView.bounces = NO;
    guideScrollView.pagingEnabled = YES;
    [self.view addSubview:guideScrollView];
    
    
    for (int i = 0; i < PageNumber; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * ScreenWidth, 0, ScreenWidth, ScreenHeight)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"guide-%d",i]];
        [guideScrollView addSubview:imageView];
        
        if (i == (PageNumber - 1)) {
            imageView.userInteractionEnabled = YES;
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAction)];
            tapGesture.numberOfTapsRequired = 1;
            [imageView addGestureRecognizer:tapGesture];
        }
    }
    
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.numberOfPages = PageNumber;
    self.pageControl.center = CGPointMake(ScreenWidth / 2, ScreenHeight - 20);
    self.pageControl.currentPageIndicatorTintColor = RGB(253, 98, 42);
    self.pageControl.pageIndicatorTintColor = RGB(189, 189, 189);
}

- (void)createButtonOnView:(UIImageView *)imageView{
    
    UIButton *startButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    startButton.layer.cornerRadius = 5;
    startButton.clipsToBounds = YES;
    startButton.backgroundColor = [UIColor clearColor];
    startButton.center = CGPointMake(ScreenWidth / 2, ScreenHeight * 0.8);
    [startButton addTarget:self action:@selector(startAction) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];
}

- (void)startAction{
    [UIApplication sharedApplication].keyWindow.rootViewController = [[MainTabBar alloc] init];
    // 进入主页面打开statusbar
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

- (void)startAction:(UIPanGestureRecognizer *)recognizer{
    CGPoint point = [recognizer translationInView:self.view];
    if (point.x < 0) {
        [UIApplication sharedApplication].keyWindow.rootViewController = [[MainTabBar alloc] init];
    }
}

#pragma mark --
#pragma mark -- scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    int currentpage = point.x/ScreenWidth;
    self.pageControl.currentPage = currentpage;
}

@end
