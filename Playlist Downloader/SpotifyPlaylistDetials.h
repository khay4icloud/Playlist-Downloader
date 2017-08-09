//
//  SpotifyPlaylistDetials.h
//  Playlist Downloader
//
//  Created by Sri Kalyan Ganja on 8/9/17.
//  Copyright © 2017 KLYN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpotifyPlaylistDetials : NSObject

@property (nonatomic, strong) NSMutableDictionary *userPlaylist;

-(instancetype) initWithUserName:(NSString *)userName forPlaylists:(NSMutableArray *)playlists;

@end


@interface SpotifyPlaylistTrackLists : NSObject

@property (nonatomic, strong) NSString *playlistName;
@property (nonatomic, strong) NSMutableArray *tracks;

@property (nonatomic, strong) NSMutableDictionary *playlistDict;
@property (nonatomic, strong) NSMutableArray *playlistArray;

-(NSMutableArray *) addPlaylistName:(NSString *)playlistName
                      forTracksList:(NSMutableArray *)tracks;

@end


@interface SpotifyTracks : NSObject

@property (nonatomic, strong) NSMutableArray *tracksArray;
@property (nonatomic, strong) NSMutableDictionary *tracksDict;

-(NSMutableArray *) addTrackName:(NSString *)trackName
                 forTrackDetials:(NSDictionary *)trackDetials;

@end


@interface SpotifyTrackDetials : NSObject

@property (nonatomic, strong) NSString *albumName;
@property (nonatomic, strong) NSString *artistName;

-(instancetype) initWithTrackDetialsWithAlbumName:(NSString *)albumName
                                    andArtistName:(NSString *)artistName;

@end
