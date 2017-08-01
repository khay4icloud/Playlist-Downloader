//
//  SpotifyViewController.m
//  Playlist Downloader
//
//  Created by Sri Kalyan Ganja on 8/1/17.
//  Copyright © 2017 KLYN. All rights reserved.
//

#define kBaseAuthorize @"https://accounts.spotify.com/authorize"


#import "SpotifyViewController.h"

@interface SpotifyViewController ()

@end

@implementation SpotifyViewController

@synthesize authWebView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self clearLocalCookies];
    
    authWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    authWebView.delegate = self;
    
}

- (void)startAuthenticationFlow {
    
    // Check if we can use the access token we already have
    if ([self.auth.session isValid]) {
        // Use it to log in
//        [self startLoginFlow];
    } else {
        // Get the URL to the Spotify authorization portal
        NSURL *authURL = [self.auth spotifyWebAuthenticationURL];
        // Present in SafariViewController
        [self loadUIWebViewWith:authURL];
    }
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    
    NSLog(@"Start request");
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
navigationType:(UIWebViewNavigationType)navigationType {
    
    NSLog(@"Request: %@",request);
    
    NSString *urlString = request.URL.absoluteString;
    if ([urlString.lowercaseString hasPrefix:kBaseAuthorize]) {
        return YES;
    } else {
        // If the incoming url is what we expect we handle it
        if ([self.auth canHandleURL:request.URL]) {
            // Close the authentication window
            [authWebView setHidden:YES];
            // Parse the incoming url to a session object
            [self.auth handleAuthCallbackWithTriggeredAuthURL:request.URL callback:^(NSError *error, SPTSession *session) {
                if (session) {
                    // login to the player
                    [self.player loginWithAccessToken:self.auth.session.accessToken];
                    [self clearLocalCookies];
                }
            }];
            return YES;
        }
        return NO;
    }
}

- (void)loadUIWebViewWith: (NSURL *)currentURL {
   
    [authWebView loadRequest:[NSURLRequest requestWithURL:currentURL]];
    [self.view addSubview:authWebView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSCachedURLResponse *resp = [[NSURLCache sharedURLCache] cachedResponseForRequest:webView.request];
    NSLog(@"%@",[(NSHTTPURLResponse*)resp.response allHeaderFields]);
}

- (void)clearLocalCookies {
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)audioStreamingDidLogin:(SPTAudioStreamingController *)audioStreaming {
    [self.player playSpotifyURI:@"spotify:track:58s6EuEYJdlb0kO7awm3Vp" startingWithIndex:0 startingWithPosition:0 callback:^(NSError *error) {
        if (error != nil) {
            NSLog(@"*** failed to play: %@", error);
            return;
        }
    }];
}

#pragma mark - MemoryWarning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIAction

- (IBAction)playListButton:(id)sender {
    
    self.auth = [SPTAuth defaultInstance];
    self.player = [SPTAudioStreamingController sharedInstance];
    
    // The client ID you got from the developer site
    self.auth.clientID = @"db50dd31f39341848da9ba2bf7312cc5";
    // The redirect URL as you entered in at the developer site
    self.auth.redirectURL = [NSURL URLWithString:@"playlist-downloader://com.veer.Playlist-Downloader"];
    // Setting the 'sessionUserDefaultsKey' enables SPTAuth to automatically store the session for future use.
    self.auth.sessionUserDefaultsKey = @"current session";
    // Set the scopes you need the user to authorize. 'SPTAuthStreamingScope' is required for playing audio.
    self.auth.requestedScopes = @[SPTAuthStreamingScope];
    
    // Become the streaming contorller delegate
    self.player.delegate = self;
    
    // Start up the streaming contoller.
    NSError *audioStreamingInitError;
    NSAssert([self.player startWithClientId:self.auth.clientID error:&audioStreamingInitError], @"There was a problem streaming the Spotify SDK: %@", audioStreamingInitError.description);
    
    // Start authentication when the app is finished launching
    dispatch_async(dispatch_get_main_queue(), ^{
        [self startAuthenticationFlow];
    });
}

- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
