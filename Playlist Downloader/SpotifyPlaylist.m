//
//  SpotifyPlaylist.m
//  Playlist Downloader
//
//  Created by Sri Kalyan Ganja on 8/5/17.
//  Copyright © 2017 KLYN. All rights reserved.
//

#import "SpotifyPlaylist.h"

@implementation SpotifyPlaylist

-(instancetype) init {
    self = [super init];
    
    self.tracksArray = [[NSMutableArray alloc] init];
    self.playlistsArray = [[NSMutableArray alloc] init];
    
    return self;
}

-(void) addAlbumName:(NSString *)albumName
          ArtistName:(NSString *)artistName
        forTrackName:(NSString *)trackName {
    
    self.albumName = albumName;
    self.artistName = artistName;
    
    self.trackDetails = [[NSMutableDictionary alloc] init];
    [self.trackDetails setValue:self.albumName forKey:@"albumName"];
    [self.trackDetails setValue:self.artistName forKey:@"artistName"];
    
    self.trackName = trackName;
    
    self.tracksDictionary = [[NSMutableDictionary alloc] init];
    [self.tracksDictionary setValue:trackName forKey:@"trackName"];
    [self.tracksDictionary setValue:self.trackDetails forKey:@"trackDetials"];
    
    [self.tracksArray addObject:self.tracksDictionary];
}

-(void) addTracksToPlaylistWithName:(NSString *)playlistName {
    
    self.playlistName = playlistName;
    
    self.playlistDetials = [[NSMutableDictionary alloc] init];
    [self.playlistDetials setValue:self.playlistName forKey:@"playlistName"];
    [self.playlistDetials setValue:self.tracksArray forKey:@"tracks"];
    
    [self.playlistsArray addObject:self.playlistDetials];
}

@end
