//
//  ChangePassWordViewController.m
//  PhotosBox
//
//  Created by Broc on 2017/4/6.
//  Copyright © 2017年 Broc. All rights reserved.
//

#import "ChangePassWordViewController.h"

@interface ChangePassWordViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UITextField *answerTF;
@property (weak, nonatomic) IBOutlet UITextField *inputPasswordTF;

@end

@implementation ChangePassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _questionLabel.text = [UserInfo toGetQuestion];
}
#pragma clang diagnostic push 
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (IBAction)submitBtnClick:(id)sender {
    if (self.answerTF.text.length == 0 || self.inputPasswordTF.text == 0) {
        alert(@"请完整填写两项内容");
        return;
    } else if ([UserInfo checkAnswer:self.answerTF.text] == 2) {
        [UserInfo saveHypocrisyPassword:self.inputPasswordTF.text];
        [[[UIAlertView alloc]initWithTitle:nil message:@"修改成功" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil] show];
    } else if ([UserInfo checkAnswer:self.answerTF.text] == 1){
        [UserInfo savePassword:self.inputPasswordTF.text];
        [[[UIAlertView alloc]initWithTitle:nil message:@"修改成功" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil] show];
    } else {
        alert(@"答案错误")
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:YES];
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
