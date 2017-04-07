//
//  HomeViewController.m
//  PhotosBox
//
//  Created by Broc on 2017/4/6.
//  Copyright © 2017年 Broc. All rights reserved.
//

#import "HomeViewController.h"
#import "RegisterViewController.h"
#import "LoginViewController.h"


@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *registerOrLoginBtn;

@end

@implementation HomeViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([UserInfo isSavePassword]) {
        [self.registerOrLoginBtn setTitle:@"登录" forState:UIControlStateNormal];
    } else {
        [self.registerOrLoginBtn setTitle:@"注册" forState:UIControlStateNormal];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)registerOrLoginBtnClick:(id)sender {
    if ([UserInfo isSavePassword]) {// 去登录
        [self.navigationController pushViewController:[LoginViewController new] animated:YES];
    } else {// 去注册
         [self.navigationController pushViewController:[RegisterViewController new] animated:YES];
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
