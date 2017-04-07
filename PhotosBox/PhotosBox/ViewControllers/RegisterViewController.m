//
//  RegisterViewController.m
//  PhotosBox
//
//  Created by Broc on 2017/4/6.
//  Copyright © 2017年 Broc. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *falsePasswordTF;
@property (weak, nonatomic) IBOutlet UITextField *questionTF;
@property (weak, nonatomic) IBOutlet UITextField *answerTF;
@property (weak, nonatomic) IBOutlet UITextField *falseAnswerTF;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.passwordTF addTarget:self action:@selector(textValueChange:) forControlEvents:UIControlEventEditingChanged];
     [self.falsePasswordTF addTarget:self action:@selector(textValueChange:) forControlEvents:UIControlEventEditingChanged];
     [self.questionTF addTarget:self action:@selector(textValueChange:) forControlEvents:UIControlEventEditingChanged];
     [self.answerTF addTarget:self action:@selector(textValueChange:) forControlEvents:UIControlEventEditingChanged];
     [self.falseAnswerTF addTarget:self action:@selector(textValueChange:) forControlEvents:UIControlEventEditingChanged];
}
- (IBAction)submitBtnClick:(id)sender {// 提交按钮
    if(self.passwordTF.text.length == 0 || self.falsePasswordTF.text.length == 0 || self.questionTF.text.length == 0 || self.answerTF.text.length == 0 || self.falseAnswerTF.text.length == 0 ) {
#pragma clang diagnostic push 
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
         [[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"有未填的选项,提交失败!请补全后再次提交!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
    } else {
        [UserInfo savePassword:self.passwordTF.text];
        [UserInfo saveHypocrisyPassword:self.falsePasswordTF.text];
        [UserInfo saveHintQuestion:self.questionTF.text];
        [UserInfo saveAnswer:self.answerTF.text];
        [UserInfo saveHypocrisyAnswer:self.falseAnswerTF.text];
         [[[UIAlertView alloc]initWithTitle:nil message:@"注册成功" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil] show];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) textValueChange:(UITextField*)textField {
    NSInteger length =textField.text.length;
    NSInteger maxLength = 32;
    if(length > maxLength) {
        textField.text= [textField.text substringToIndex:maxLength];
        [[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"长度限制为32位" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
    }
}


#pragma clang diagnostic pop
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
