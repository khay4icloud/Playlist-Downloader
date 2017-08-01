//
//  MediaTableCell.h
//  Playlist Downloader
//
//  Created by Sri Kalyan Ganja on 8/1/17.
//  Copyright © 2017 KLYN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MediaTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *logoView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;



@end
