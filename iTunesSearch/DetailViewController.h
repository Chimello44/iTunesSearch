//
//  DetailViewController.h
//  iTunesSearch
//
//  Created by Hugo Luiz Chimello on 3/13/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCell.h"
#import "TableViewController.h"

@interface DetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *nome;
@property (strong, nonatomic) IBOutlet UILabel *genero;
@property (strong, nonatomic) IBOutlet UILabel *tipo;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *preco;

@end
