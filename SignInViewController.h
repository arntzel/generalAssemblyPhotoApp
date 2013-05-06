//
//  SignInViewController.h
//  GeneralAssemblyPhotoApp
//
//  Created by Eliot Arntz on 5/4/13.
//  Copyright (c) 2013 EliotArntz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignInViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *enterEmailTextField;
@property (strong, nonatomic) IBOutlet UITextField *enterPasswordTextField;
- (IBAction)signButtonPressed:(UIButton *)sender;

@end
