//
//  iTunesManager.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "iTunesManager.h"
#import "Filme.h"
#import "Musica.h"
#import "Podcast.h"
#import "Ebook.h"

@implementation iTunesManager

static iTunesManager *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];    
    });
    
    return SINGLETON;
}


- (NSArray *)buscarMidias:(NSString *)termo {
    if (!termo) {
        termo = @"";
    }
    
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&limit=200", termo];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *error;
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&error];
    if (error) {
        NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
        return nil;
    }
    
    NSArray *resultados = [resultado objectForKey:@"results"];
    NSMutableArray *filmes = [[NSMutableArray alloc] init];
    NSMutableArray *musicas =[[NSMutableArray alloc] init];
    NSMutableArray *podcasts= [[NSMutableArray alloc] init];
    NSMutableArray *ebooks= [[NSMutableArray alloc] init];
    
    NSString *type;
    
    
    for (NSDictionary *item in resultados) {
        
        type=[item objectForKey:@"kind"];
        if([type isEqualToString:@"feature-movie"]){
          Filme *filme = [[Filme alloc] init];
          [filme setNome:[item objectForKey:@"trackName"]];
          [filme setTrackId:[item objectForKey:@"trackId"]];
          [filme setArtista:[item objectForKey:@"artistName"]];
         [filme setDuracao:[item objectForKey:@"trackTimeMillis"]];
        [filme setGenero:[item objectForKey:@"primaryGenreName"]];
            [filme setPreco:[item objectForKey:@"trackPrice"]];
        [filme setPais:[item objectForKey:@"country"]];
            [filme setImg:[item objectForKey:@"artworkUrl100"]];
                       [filmes addObject:filme];
    }
        else if([type isEqualToString:@"song"]){
            Musica  *musica = [[Musica alloc] init];
            [musica setNome:[item objectForKey:@"trackName"]];
            [musica setTrackId:[item objectForKey:@"trackId"]];
            [musica setArtista:[item objectForKey:@"artistName"]];
            [musica setDuracao:[item objectForKey:@"trackTimeMillis"]];
            [musica setGenero:[item objectForKey:@"primaryGenreName"]];
            [musica setPais:[item objectForKey:@"country"]];
            [musica setPreco:[item objectForKey:@"trackPrice"]];
            [musica setImg:[item objectForKey:@"artworkUrl100"]];
            
            [musicas addObject:musica];
            
        }
        else if([type isEqualToString:@"podcast"]){
            Podcast  *podcast = [[Podcast alloc] init];
            [podcast setNome:[item objectForKey:@"trackName"]];
            [podcast setTrackId:[item objectForKey:@"trackId"]];
            [podcast setArtista:[item objectForKey:@"artistName"]];
            [podcast setPreco:[item objectForKey:@"trackPrice"]];
            [podcast setImg:[item objectForKey:@"artworkUrl100"]];
            [podcasts addObject:podcast];
            
        }
        else if([type isEqualToString:@"ebook"]){
            Ebook  *ebook = [[Ebook alloc] init];
            [ebook setNome:[item objectForKey:@"trackName"]];
            [ebook setTrackId:[item objectForKey:@"trackId"]];
            [ebook setArtista:[item objectForKey:@"artistName"]];
            [ebook setPreco:[item objectForKey:@"trackPrice"]];
            [ebook setImg:[item objectForKey:@"artworkUrl100"]];
            [ebooks addObject: ebook];
        }
        
           }
    NSArray *mid = [[NSArray alloc]initWithObjects:filmes,musicas,podcasts,ebooks, nil];
    
    return mid;
}




#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[iTunesManager alloc] init];
}

- (id)mutableCopy
{
    return [[iTunesManager alloc] init];
}

- (id) init
{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    return self;
}


@end
