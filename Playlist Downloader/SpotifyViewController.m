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

@implementation SpotifyViewController {
    NSMutableData *responseData;
}



#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.firstLoad = YES;
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

        return;
    }
    
    // Oh noes, the token has expired, if we have a token refresh service set up, we'll call tat one.
    self.statusLabel.text = @"Token expired.";
    if (auth.hasTokenRefreshService) {
//        [self renewTokenAndShowPlayer];
        return;
    }
    
    // Else, just show login dialog
}

- (void)startAuthenticationFlow {
    
    self.authWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.authWebView.delegate = self;
    
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

#pragma mark - SPTStoreControllerDelegate

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
            [self.authWebView setHidden:YES];
            // Parse the incoming url to a session object
            [self.auth handleAuthCallbackWithTriggeredAuthURL:request.URL callback:^(NSError *error, SPTSession *session) {
                if (session) {
                    // Request Playlist
                    NSString *spotifyAPIEndpoint = @"https://api.spotify.com/v1";
                    NSString *spotifyPlaylistList = [NSString stringWithFormat:@"%@/users/%@/playlists -H \"Authorization: Bearer %@\"",
                                                     spotifyAPIEndpoint, session.canonicalUsername, session.accessToken];
                    NSURL *spotifyPlaylistURL = [NSURL URLWithString:spotifyPlaylistList];
                    
                    // Create the request.
                    NSURLRequest *spotifyPlaylistRequest = [NSURLRequest requestWithURL:spotifyPlaylistURL];
                    
//                    // Create url connection and fire request
//                    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
                    
                    //create the Method "GET"
//                    [spotifyPlaylistRequest ];
                    
                    NSURLSession *session = [NSURLSession sharedSession];
                    
                    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:spotifyPlaylistRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                    {
                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                        if(httpResponse.statusCode == 200)
                        {
                            NSError *parseError = nil;
                            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
                            NSLog(@"The response is - %@",responseDictionary);
                        }
                        else
                        {
                            NSLog(@"Error");     
                        }
                    }];
                    
                }
            }];
            return YES;
        }
        return NO;
    }
}

#pragma mark - NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    
    
    responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    
    
    [responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    // The request has failed for some reason!
    // Check the error var
    
}

- (void)loadUIWebViewWith: (NSURL *)currentURL {
   
    [self.authWebView loadRequest:[NSURLRequest requestWithURL:currentURL]];
    [self.view addSubview:self.authWebView];
}

- (void)clearLocalCookies {
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
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
