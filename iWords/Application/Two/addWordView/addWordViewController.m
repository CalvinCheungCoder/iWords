//
//  addWordViewController.m
//  iWords
//
//  Created by 张丁豪 on 2017/4/26.
//  Copyright © 2017年 zhangdinghao. All rights reserved.
//

#import "addWordViewController.h"

@interface addWordViewController ()<UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic, strong) UITextField *wordTextfield;

@property (nonatomic, strong) UITextView *wordExpView;

@property (nonatomic, strong) UIButton *wordTypeBtn;

@property (nonatomic, strong) NSArray *typeArr;

@end

@implementation addWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = DHLocalizedString(@"添加单词");
    [self createAddWordUI];
}

- (void)createAddWordUI
{
    self.wordTextfield = [[UITextField alloc]initWithFrame:CGRectMake(10, 20, ScreenWidth-20, 40)];
    self.wordTextfield.delegate = self;
    self.wordTextfield.backgroundColor = [UIColor whiteColor];
    self.wordTextfield.placeholder = DHLocalizedString(@"添加单词");
    self.wordTextfield.borderStyle = UITextBorderStyleNone;
    self.wordTextfield.font = [UIFont fontWithName:@"ComicSansMS" size:16];
    self.wordTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.wordTextfield.keyboardType = UIKeyboardTypeWebSearch;
    [self.view addSubview:self.wordTextfield];
    
    
    self.wordExpView = [[UITextView alloc]initWithFrame:CGRectMake(10, 65, ScreenWidth-20, 60)];
    self.wordExpView.delegate = self;
    self.wordExpView.font = [UIFont fontWithName:@"ComicSansMS" size:16];
    [self.view addSubview:self.wordExpView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.wordTextfield resignFirstResponder];
    [self.wordExpView resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
