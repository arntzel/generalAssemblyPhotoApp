//
//  FeedViewController.h
//  GeneralAssemblyPhotoApp
//
//  Created by Eliot Arntz on 5/5/13.
//  Copyright (c) 2013 EliotArntz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

- (IBAction)cameraButtonPressed:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UITableView *feedTableView;
@property (strong, nonatomic) NSMutableArray *photos;


@end
