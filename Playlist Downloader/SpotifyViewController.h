//
//  SpotifyViewController.h
//  Playlist Downloader
//
//  Created by Sri Kalyan Ganja on 8/1/17.
//  Copyright © 2017 KLYN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpotifyAuthentication/SpotifyAuthentication.h>
#import <SpotifyAudioPlayback/SpotifyAudioPlayback.h>
#import <SpotifyMetadata/SpotifyMetadata.h>
#import <SafariServices/SafariServices.h>



@interface SpotifyViewController : UIViewController <SPTAudioStreamingDelegate, UIWebViewDelegate, SFSafariViewControllerDelegate>

@property (nonatomic, strong) SPTAuth *auth;
@property (nonatomic, strong) SPTAudioStreamingController *player;
@property (nonatomic, strong) UIViewController *authViewController;
@property (nonatomic, strong) UIWebView *authWebView;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;


- (IBAction)playListButton:(id)sender;
- (IBAction)backButton:(id)sender;

@end
