//
//  TableViewCell.h
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nome;
@property (weak, nonatomic) IBOutlet UILabel *tipo;
@property (strong, nonatomic) IBOutlet UILabel *genero;
@property (strong, nonatomic) IBOutlet UILabel *preco;
@property (strong, nonatomic) IBOutlet UIImageView *img;




@end
