//
//  SignInViewController.m
//  GeneralAssemblyPhotoApp
//
//  Created by Eliot Arntz on 5/4/13.
//  Copyright (c) 2013 EliotArntz. All rights reserved.
//

#import "SignInViewController.h"
#import "FeedViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SignInViewController ()

@end

@implementation SignInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.enterEmailTextField.layer.borderColor = [UIColor blackColor].CGColor;
    self.enterEmailTextField.layer.borderWidth = 10;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signButtonPressed:(UIButton *)sender {
    
    FeedViewController *feedViewController = [[FeedViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:feedViewController animated:YES];
    
}
@end
