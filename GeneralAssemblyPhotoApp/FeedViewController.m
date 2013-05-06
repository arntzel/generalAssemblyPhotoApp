//
//  FeedViewController.m
//  GeneralAssemblyPhotoApp
//
//  Created by Eliot Arntz on 5/5/13.
//  Copyright (c) 2013 EliotArntz. All rights reserved.
//

#import "FeedViewController.h"
#import "CameraViewController.h"
#import "Photo.h"
#import "MapViewController.h"

@interface FeedViewController ()

@end

@implementation FeedViewController

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
    self.feedTableView.delegate = self;
    self.feedTableView.dataSource = self;
}

- (void)viewDidAppear:(BOOL)animated {
    
    self.photos = [NSMutableArray arrayWithArray:[Photo findAll]];
    NSLog(@"*** self.photos %@", self.photos);
    [self.feedTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cameraButtonPressed:(UIButton *)sender {
    CameraViewController *cameraVC = [[CameraViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:cameraVC animated:YES];
    
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.photos.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"none"];
    Photo *photo = [self.photos objectAtIndex:indexPath.row];
    tableViewCell.textLabel.text = photo.tag;
    tableViewCell.imageView.image = photo.image;
    CLPlacemark *placemark = photo.placemark;
    NSLog(@"%@", placemark);
    tableViewCell.detailTextLabel.text = placemark.country;
    
    return tableViewCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    CGFloat height = 70;
    return height;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Photo *photo = [self.photos objectAtIndex:indexPath.row];
    MapViewController *mapViewController = [[MapViewController alloc] initWithNibName:nil bundle:nil];
    mapViewController.photo = photo;
    [self.navigationController pushViewController:mapViewController animated:YES];
}

@end
