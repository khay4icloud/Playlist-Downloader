//
//  ViewController.m
//  Playlist Downloader
//
//  Created by Sri Kalyan Ganja on 8/1/17.
//  Copyright © 2017 KLYN. All rights reserved.
//

#import "ViewController.h"
#import "MediaTableCell.h"
#import "SpotifyViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *mediaArray;
@property (nonatomic, strong) NSArray *logoArray;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mediaArray = [[NSArray alloc] initWithObjects:@"Spotify", @"Pandora", @"SoundCloud", @"iTunes", nil];
    self.logoArray = [[NSArray alloc] initWithObjects:@"itunes.png",@"Pandora.jpg",@"soundCloud.jpg",@"spotify.png", nil];
    
}

# pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.mediaArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *mediaCellIdentifier = @"mediaCellItem";
    
    MediaTableCell *cell = (MediaTableCell *)[tableView dequeueReusableCellWithIdentifier:mediaCellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"mediaCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.titleLabel.text = [self.mediaArray objectAtIndex:indexPath.row];
    cell.logoView.image = [UIImage imageNamed:[self.logoArray objectAtIndex:indexPath.row]];
    
    cell.logoView.contentMode = UIViewContentModeScaleAspectFit;
    return cell;
}

# pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    SpotifyViewController *spotifyVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SpotifySB"];
    [self presentViewController:spotifyVC animated:YES completion:nil];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

# pragma mark - MemoryWarning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
