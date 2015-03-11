//
//  Musica.h
//  iTunesSearch
//
//  Created by Hugo Luiz Chimello on 3/11/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Musica : NSObject

@property (nonatomic, strong) NSString *nome;
@property (nonatomic, strong) NSString *trackId;
@property (nonatomic, strong) NSString *artista;
@property (nonatomic, strong) NSString *duracao;
@property (nonatomic, strong) NSString *genero;
@property (nonatomic, strong) NSString *pais;
@property (nonatomic, strong) NSNumber *preco;

@end
