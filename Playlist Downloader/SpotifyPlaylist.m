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

//- (instancetype) initWithPlaylist:(NSArray *)playlistArray {
//    
//    
//    [self initWithPlaylistDetialsWithName:self.playlistName];
//}
//
//-(NSMutableDictionary *) initWithPlaylistDetialsWithName:(NSString *)playlistName {
//    
//    self.playlistDetialsDictionary = [[NSMutableDictionary alloc] init];
//    [self.playlistDetialsDictionary setValue:playlistName
//                            forKey:@"playlistName"];
//    [self.playlistDetialsDictionary setValue:self.playlistDetials
//                            forKey:@"playlistDetials"];
//    
//    [self initWithTrackDetials:self.trackName];
//}
//
//-(NSMutableDictionary *) initWithTrackDetials:(NSString *)trackName {
//    
//    self.trackDetialsDictionary = [[NSMutableDictionary alloc] init];
//    
//    [self.trackDetialsDictionary setValue:trackName
//                                    forKey:@"trackName"];
//    [self.trackDetialsDictionary setValue:self.tracksDetails
//                                   forKey:@"trackDetials"];
//    
//    [self initWithTrackWith:self.albumName andArtistName:self.artistNamesArray];
//}
//
//-(NSMutableDictionary *) initWithTrackWith:(NSString *)albumName
//                             andArtistName:(NSArray *)artistName  {
//    
//    self = [super init];
//    
//    self.tracksDetails = [[NSMutableDictionary alloc] init];
//    
//    [self.tracksDetails setValue:albumName
//                                    forKey:@"albumName"];
//    [self.tracksDetails setValue:artistName
//                                   forKey:@"artistNames"];
//    
//    return self;
//}

-(instancetype) initWithTitle:(NSString *)aTitle date:(NSDate *)aDate {
    
    if (self = [super init]) {
        title = [aTitle copy];
    }
    
}

@end
