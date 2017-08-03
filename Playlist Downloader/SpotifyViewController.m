//
//  SpotifyViewController.m
//  Playlist Downloader
//
//  Created by Sri Kalyan Ganja on 8/1/17.
//  Copyright © 2017 KLYN. All rights reserved.
//

#define kClientId "db50dd31f39341848da9ba2bf7312cc5"
#define kRedirectURL "playlist-downloader://com.veer.Playlist-Downloader"
#define kBaseAuthorize @"https://accounts.spotify.com/authorize"
#define kCurrentUserPlaylists @"https://api.spotify.com/v1/me/playlists"

#import "SpotifyViewController.h"


@interface SpotifyViewController ()

@property (atomic, readwrite) BOOL firstLoad;

@end

@implementation SpotifyViewController

@synthesize authWebView;
@synthesize usernameField;


#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionUpdatedNotification:) name:@"sessionUpdated" object:nil];
    
    self.firstLoad = YES;
    authWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    authWebView.delegate = self;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    SPTAuth *auth = [SPTAuth defaultInstance];
    // Uncomment to turn off native/SSO/flip-flop login flow
    //auth.allowNativeLogin = NO;
    
    // Check if we have a token at all
    if (auth.session == nil) {
        return;
    }
    
    // Check if it's still valid
    if ([auth.session isValid] && self.firstLoad) {
        // It's still valid, show the player.
//        [self showPlayer];
        return;
    }
    
    // Oh noes, the token has expired, if we have a token refresh service set up, we'll call tat one.
//    self.statusLabel.text = @"Token expired.";
    if (auth.hasTokenRefreshService) {
//        [self renewTokenAndShowPlayer];
        return;
    }
    
    // Else, just show login dialog
}

- (void)sessionUpdatedNotification:(NSNotification *)notification
{
//    self.statusLabel.text = @"";
    
    SPTAuth *auth = [SPTAuth defaultInstance];
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    
    if (auth.session && [auth.session isValid]) {
//        self.statusLabel.text = @"";
//        [self showPlayer];
        
        
        
        [authWebView setHidden:YES];
    } else {
//        self.statusLabel.text = @"Login failed.";
        NSLog(@"*** Failed to log in");
    }
}

- (void)startAuthenticationFlow
{
    
    // Check if we can use the access token we already have
    if ([self.auth.session isValid]) {
        // Use it to log in
//        [self startLoginFlow];
    } else {
        // Get the URL to the Spotify authorization portal
        NSURL *authURL = [self.auth spotifyWebAuthenticationURL];
        // Present in SafariViewController
        [self loadUIWebViewWith:authURL];
//        self.authViewController = [[SFSafariViewController alloc] initWithURL:authURL];
//        self.definesPresentationContext = YES;
//        [self presentViewController:self.authViewController animated:YES completion:nil];
    }
    
}

#pragma mark - SPTStoreControllerDelegate

- (void)openLoginPage
{
//    self.statusLabel.text = @"Logging in...";
    
    [authWebView loadRequest:[NSURLRequest requestWithURL:[[SPTAuth defaultInstance] spotifyWebAuthenticationURL]]];
    self.definesPresentationContext = YES;
    [self.view addSubview:authWebView];
    
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
                    // Request Playlist
                    
                    NSURLRequest *playlistrequest = [SPTPlaylistList createRequestForGettingPlaylistsForUser:session.canonicalUsername
                                                                                             withAccessToken:session.accessToken
                                                                                                       error:nil];
                    
                    [[SPTRequest sharedHandler] performRequest:playlistrequest
                                                      callback:^(NSError *error, NSURLResponse *response, NSData *data) {
                        if (error != nil) {
                            NSLog(@"*** failed to play: %@", error.description);
                            return ;
                        }
                        SPTPlaylistList *playlists = [SPTPlaylistList playlistListFromData:data withResponse:response error:nil];
                        NSLog(@"Got possan's playlists, first page: %@", playlists);
                        }];
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
    self.auth.clientID = @kClientId;
    // The redirect URL as you entered in at the developer site
    self.auth.redirectURL = [NSURL URLWithString:@kRedirectURL];
    // Setting the 'sessionUserDefaultsKey' enables SPTAuth to automatically store the session for future use.
    self.auth.sessionUserDefaultsKey = @"current session";
    // Set the scopes you need the user to authorize. 'SPTAuthPlaylistReadCollaborativeScope' lets you read users collaborative playlists.
    self.auth.requestedScopes = @[SPTAuthPlaylistReadCollaborativeScope];

    
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
