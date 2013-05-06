//
//  CameraViewController.h
//  GeneralAssemblyPhotoApp
//
//  Created by Eliot Arntz on 5/5/13.
//  Copyright (c) 2013 EliotArntz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UIViewController <UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *photoImageView;

@property (strong, nonatomic) IBOutlet UITextField *tagTextField;

- (IBAction)takePhotoButtonPressed:(id)sender;

- (IBAction)filterButtonPressed:(id)sender;

- (IBAction)saveButtonPressed:(id)sender;

@end
