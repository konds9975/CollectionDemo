//
//  CollectionViewCell.h
//  CollectionDemo
//
//  Created by Kondya on 08/06/18.
//  Copyright © 2018 Kondya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *namelbl;

@end
