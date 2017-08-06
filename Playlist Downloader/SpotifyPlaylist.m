//
//  SpotifyPlaylist.m
//  Playlist Downloader
//
//  Created by Sri Kalyan Ganja on 8/5/17.
//  Copyright © 2017 KLYN. All rights reserved.
//

#import "SpotifyPlaylist.h"

@implementation SpotifyPlaylist

//- (instancetype) initWithPlaylistName:(NSArray *)playlistName
//                            trackName:(NSString *)trackName
//                            albumName:(NSString *)albumName
//                       andArtistNames:(NSArray *)artistNames {
//    self = [super init];
//    
//    if (self) {
//        self.playlistName = playlistName;
//        self.trackName = trackName;
//        self.albumName = albumName;
//        self.artistNames = artistNames;
//    }
//    
//    return self;
//}

- (instancetype) initWithPlaylist:(NSArray *)playlistArray {
    
    self = [super init];
    
}

-(NSMutableDictionary *) initWithPlaylistDetialsWithName:(NSString *)playlistName {
    
    self.playlistDetialsDictionary = [[NSMutableDictionary alloc] init];
    [self.playlistDetialsDictionary setValue:self.playlistName
                            forKey:@"playlistName"];
    [self.playlistDetialsDictionary setValue:self.playlistDetials
                            forKey:@"playlistDetials"];
    
    return self.playlistDetialsDictionary;
}

-(NSMutableDictionary *) initWithTrackDetials:(NSString *)trackName {
    
    self.trackDetialsDictionary = [[NSMutableDictionary alloc] init];
    
    [self.trackDetialsDictionary setValue:self.trackName
                                    forKey:@"trackName"];
    [self.trackDetialsDictionary setValue:self.tracksDetails
                                   forKey:@"trackDetials"];
    
    return self.trackDetialsDictionary;
}

-(NSMutableDictionary *) initWithTrackWith:(NSString *)albumName
                             andArtistName:(NSArray *)artistName  {
    
    self.tracksDetails = [[NSMutableDictionary alloc] init];
    
    [self.tracksDetails setValue:self.albumName
                                    forKey:@"albumName"];
    [self.tracksDetails setValue:self.artistNamesArray
                                   forKey:@"artistNames"];
    
    return self.tracksDetails;
}

@end
