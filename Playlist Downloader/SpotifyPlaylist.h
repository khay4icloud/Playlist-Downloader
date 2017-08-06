//
//  SpotifyPlaylist.h
//  Playlist Downloader
//
//  Created by Sri Kalyan Ganja on 8/5/17.
//  Copyright © 2017 KLYN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpotifyPlaylist : NSObject

@property (nonatomic, strong) NSArray *playlistsArray;
@property (nonatomic, strong) NSMutableDictionary *playlistDetialsDictionary;
@property (nonatomic, strong) NSMutableDictionary *playlistDetials;
@property (nonatomic, strong) NSString *playlistName;


@property (nonatomic, strong) NSArray *tracksArray;
@property (nonatomic, strong) NSMutableDictionary *trackDetialsDictionary;
@property (nonatomic, strong) NSMutableDictionary *tracksDetails;
@property (nonatomic, strong) NSString *trackName;


@property (nonatomic, strong) NSString *albumName;
@property (nonatomic, strong) NSArray *artistNamesArray;

- (instancetype) initWithPlaylistName: (NSArray *)playlistName
                         trackName: (NSString *)trackName
                         albumName: (NSString *)albumName
                    andArtistNames: (NSArray *) artistNames;

@end
