//
//  LoginViewController.m
//  PhotosBox
//
//  Created by Broc on 2017/4/5.
//  Copyright © 2017年 Broc. All rights reserved.
//

#import "LoginViewController.h"
#import "ChangePassWordViewController.h"
#import "EmptyViewController.h"
#import "ShowViewController.h"
@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *inputTF;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self.navigationController.navigationBar setHidden:YES];
    [self.inputTF addTarget:self action:@selector(textValueChange:) forControlEvents:UIControlEventEditingChanged];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.inputTF.text = @"";
}
- (IBAction)loginBtnClick:(id)sender {
    if (self.inputTF.text.length == 0) {
        PBToast(@"密码不能为空");
    } else if([UserInfo checkPassword:self.inputTF.text] == 1) {
//        PBToast(@"ture");
        [self.navigationController pushViewController:[ShowViewController new] animated:YES];
    } else if ([UserInfo checkPassword:self.inputTF.text] == 2) {
//        PBToast(@"false");
        [self.navigationController pushViewController:[EmptyViewController new] animated:YES];
    } else {
        PBToast(@"密码错误");
    }
}
- (IBAction)forgetPasswordBtnClick:(id)sender {
    [self.navigationController pushViewController:[ChangePassWordViewController new] animated:YES];
}
- (void) textValueChange:(UITextField*)textField {
    NSInteger length =textField.text.length;
    NSInteger maxLength = 32;
    if(length > maxLength) {
        textField.text= [textField.text substringToIndex:maxLength];
        PBToast(@"长度限制为32位");
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
