//
//  ViewController.m
//  CollectionDemo
//
//  Created by Kondya on 08/06/18.
//  Copyright © 2018 Kondya. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property NSMutableArray *imageArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self doSomethingWithTheJson];
}
- (void)doSomethingWithTheJson
{
    NSDictionary *dict = [self JSONFromFile];
    
    NSLog(@"%@",dict);
    NSDictionary *gallery = [dict objectForKey:@"gallery"];
    NSArray *images = [gallery objectForKey:@"images"];

    self.imageArray = [[NSMutableArray alloc]init];
    for (NSString *url in images) {
        
        NSLog(@"url ::: %@", url);
        [self.imageArray addObject:url];
       
        }
    [self.colletion reloadData];
    
}

- (NSDictionary *)JSONFromFile
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Resopnse" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^{
                       NSURL *imageURL = [NSURL URLWithString: [self.imageArray objectAtIndex:indexPath.row]];
                       NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                       
                       //This is your completion handler
                       dispatch_sync(dispatch_get_main_queue(), ^{
                           //If self.image is atomic (not declared with nonatomic)
                           // you could have set it directly above
                           cell.image.image = [UIImage imageWithData:imageData];
                           cell.namelbl.text = [NSURL URLWithString: [self.imageArray objectAtIndex:indexPath.row]].lastPathComponent;
                           //This needs to be set here now that the image is downloaded
                           // and you are back on the main thread
                           
                           
                       });
                   });
    
    return cell;
    
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  self.imageArray.count;
}






@end
