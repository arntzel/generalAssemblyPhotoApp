//
//  CameraViewController.m
//  GeneralAssemblyPhotoApp
//
//  Created by Eliot Arntz on 5/5/13.
//  Copyright (c) 2013 EliotArntz. All rights reserved.
//

#import "CameraViewController.h"
#import "BFAddFilter.h"
#import "Photo.h"

@interface CameraViewController ()

@end

@implementation CameraViewController

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
    self.tagTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takePhotoButtonPressed:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    //Logic if camera is avaliable.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else{
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)filterButtonPressed:(id)sender {
    
    self.photoImageView.image = [BFAddFilter addFilter:self.photoImageView.image];
    
}

- (IBAction)saveButtonPressed:(id)sender {
    
    Photo *photoVariableName = [Photo createEntity];
    photoVariableName.tag = self.tagTextField.text;
    
    photoVariableName.image = self.photoImageView.image;
    
    [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreAndWait];
    
    NSLog(@"%@", [Photo findAll]);
}

#pragma mark - UIPickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *originalImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    self.photoImageView.image = originalImage;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.tagTextField resignFirstResponder];
    
    return YES;
}

@end
