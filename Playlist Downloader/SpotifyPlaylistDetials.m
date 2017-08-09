//
//  SpotifyPlaylistDetials.m
//  Playlist Downloader
//
//  Created by Sri Kalyan Ganja on 8/9/17.
//  Copyright © 2017 KLYN. All rights reserved.
//

#import "SpotifyPlaylistDetials.h"

@implementation SpotifyPlaylistDetials

-(instancetype) initWithUserName:(NSString *)userName forPlaylists:(NSMutableArray *)playlists {
    
    self.userPlaylist = [[NSMutableDictionary alloc] init];
    [self.userPlaylist setObject:userName forKey:playlists];
    
    return self;
}

@end


@implementation SpotifyPlaylistTrackLists

-(instancetype) init {
    
    self.playlistDict = [[NSMutableDictionary alloc] init];
    self.playlistArray = [[NSMutableArray alloc] init];
    
    return self;
}

-(NSMutableArray *) addPlaylistName:(NSString *)playlistName forTracksList:(NSMutableArray *)tracks {
    
    [self.playlistDict setObject:tracks forKey:playlistName];
    [self.playlistArray addObject:self.playlistDict];

    return self.playlistArray;
}

@end


@implementation SpotifyTracks

-(instancetype) init {
    
    self.tracksDict = [[NSMutableDictionary alloc] init];
    self.tracksArray = [[NSMutableArray alloc] init];
    
    return self;
}

-(NSMutableArray *) addTrackName:(NSString *)trackName forTrackDetials:(NSDictionary *)trackDetials {

    [self.tracksDict setObject:trackName forKey:trackDetials];
    [self.tracksArray addObject:self.tracksDict];
    
    return self.tracksArray;
}

@end


@implementation SpotifyTrackDetials

-(instancetype) initWithTrackDetialsWithAlbumName:(NSString *)albumName andArtistName:(NSString *)artistName {
    
    self.albumName = albumName;
    self.artistName = artistName;
    
    return self;
}

@end
