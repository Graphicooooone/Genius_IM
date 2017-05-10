//
//  GALoginController.m
//  Genius_IM
//
//  Created by Graphic-one on 17/2/28.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import "GALoginController.h"

@interface GALoginController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@end

@implementation GALoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [self.view endEditing:YES];
    }]];
    
    _userName.delegate = self;
    _password.delegate = self;
    
    [_loginBtn setBackgroundImage:[UIImage imageWithColor:[UIColor ColorWithHex:0x24CF5F]] forState:UIControlStateNormal];
    [_loginBtn setBackgroundImage:[UIImage imageWithColor:[UIColor ColorWithHex:0xD1D5DB]] forState:UIControlStateDisabled];
    
    _loginBtn.enabled = [RACSignal combineLatest:@[_userName.rac_textSignal,_password.rac_textSignal] reduce:^id (NSString* userName,NSString* password){
        return @((userName.length >= 8) && (password.length >= 8));
    }];

}


- (IBAction)touchLoginBtn:(UIButton *)sender {
    [self.view endEditing:YES];
        
}
- (IBAction)touchRegisterBtn:(UIButton *)sender {
    [self.view endEditing:YES];

}


#pragma mark - UITextField
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _userName) {
        [_password becomeFirstResponder];
    }else if (textField == _password){
        [self.view endEditing:YES];
    }
    return YES;
}

@end
