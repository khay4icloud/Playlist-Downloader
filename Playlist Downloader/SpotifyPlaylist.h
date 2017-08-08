//
//  SpotifyPlaylist.h
//  Playlist Downloader
//
//  Created by Sri Kalyan Ganja on 8/5/17.
//  Copyright © 2017 KLYN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpotifyPlaylist : NSObject

@property (nonatomic, strong) NSString *albumName;
@property (nonatomic, strong) NSString *artistName;
@property (nonatomic, strong) NSMutableDictionary *trackDetails;
@property (nonatomic, strong) NSString *trackName;
@property (nonatomic, strong) NSMutableDictionary *tracksDictionary;
@property (nonatomic, strong) NSMutableArray *tracksArray;

@property (nonatomic, strong) NSString *playlistName;
@property (nonatomic, strong) NSMutableDictionary *playlistDetials;
@property (nonatomic, strong) NSMutableArray *playlistsArray;

-(void) addAlbumName:(NSString *)albumName
          ArtistName:(NSString *)artistName
        forTrackName:(NSString *)trackName;

-(void) addTracksToPlaylistWithName:(NSString *)playlistName;

@end
