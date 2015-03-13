//
//  ViewController.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "iTunesManager.h"
#import "Filme.h"
#import "Musica.h"
#import "Podcast.h"
#import "Ebook.h"


@interface TableViewController () {
    NSArray *midias;
    NSArray *mid;
}

@end



@implementation TableViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    

    
  
}
- (void)didReceiveMemoryWarnin
 {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *dnav =[[DetailViewController alloc]init];
    [self.navigationController pushViewController:dnav animated:YES];
}
#pragma mark - Metodos do UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
     return [midias count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return [[midias objectAtIndex:section] count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch(section){
case 0: return @"Filme";
case 1: return @"Musica";
case 2: return @"Podcast";
case 3: return @"Ebook";
    }
    return @"oi";
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    

    mid=[[NSArray alloc] initWithArray:[midias objectAtIndex:indexPath.section]];
    
    Filme *filme;
    Musica *musica;
    Podcast *podcast;
    Ebook *ebook;
    
    long row=[indexPath row];
    switch (indexPath.section){
    
        case 0:
                filme=[mid objectAtIndex:indexPath.row];
                [celula.nome setText:filme.nome];
                [celula.tipo setText:@"Filme"];
                [celula.genero setText:filme.genero];
                [celula.preco setText:[NSString stringWithFormat:@"%@", filme.preco]];
                [celula.img setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:filme.img]]]];
            
            break;
            
        case 1:
                musica=[mid objectAtIndex:row];
                [celula.nome setText:musica.nome];
                [celula.tipo setText:@"Musica"];
                [celula.genero setText:musica.genero];
                [celula.preco setText:[NSString stringWithFormat:@"%@", musica.preco]];
                [celula.img setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:musica.img]]]];
            break;
        case 2:
                podcast=[mid objectAtIndex:row];
                [celula.nome setText:podcast.nome];
                [celula.tipo setText:@"podcast"];
                [celula.genero setText:podcast.genero];
                [celula.preco setText:[NSString stringWithFormat:@"%@", podcast.preco]];
            [celula.img setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:podcast.img]]]];
            break;
            
        case 3:
        
            ebook=[mid objectAtIndex:row];
            [celula.nome setText:ebook.nome];
            [celula.tipo setText:@"ebook"];
            [celula.genero setText:ebook.genero];
            [celula.preco setText:[NSString stringWithFormat:@"%@", ebook.preco]];
            [celula.img setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:ebook.img]]]];
            break;
        default:
            break;
    }
    return celula;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}


- (IBAction)searchButton:(id)sender {
    _txtSearch=_searchText.text;
    //nomes compostos
    _txtSearch=[_txtSearch stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    [self search];
}


-(void)search{
    iTunesManager *itunes=[iTunesManager sharedInstance];
    midias=[itunes buscarMidias:_txtSearch];
    [_tableview reloadData];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
        [_searchText resignFirstResponder];
}
@end
