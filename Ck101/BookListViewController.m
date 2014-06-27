//
//  BookListViewController.m
//  Ck101
//
//  Created by Nathaniel Wu on 2014/5/13.
//  Copyright (c) 2014年 Nathaniel Wu. All rights reserved.
//

#import "TFHpple.h"
#import "Tutorial.h"
#import "Contributor.h"
#import "BookListViewController.h"

@interface BookListViewController () {
 
    NSMutableArray *books;
}
@end

@implementation BookListViewController

@synthesize bookTableView = _bookTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
    return [books count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"BookCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Tutorial *book = [books objectAtIndex:indexPath.row];
   cell.textLabel.text = book.title;
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadBooks
{
    // 1
    NSURL *tutorialsUrl = [NSURL URLWithString:self.bookURL];
    NSData *tutorialsHtmlData = [NSData dataWithContentsOfURL:tutorialsUrl];
    
    // 2
    TFHpple *tutorialsParser = [TFHpple hppleWithHTMLData:tutorialsHtmlData];
    
    // 3
    NSString *tutorialsXpathQueryString = @"//th[@class='common subject']/a";
    NSArray *tutorialsNodes = [tutorialsParser searchWithXPathQuery:tutorialsXpathQueryString];
    
    // 4
    NSMutableArray *newTutorials = [[NSMutableArray alloc] initWithCapacity:0];

    for (TFHppleElement *element in tutorialsNodes) {
        // 5
        Tutorial *tutorial = [[Tutorial alloc] init];
        [newTutorials addObject:tutorial];
        
        // 6
        //tutorial.title = element.children[1]
        tutorial.title = [[element firstChild] content];
        TFHppleElement *data = [element firstChild];
        data = [data firstChild];
        tutorial.title = [data content];
        
        // 7
        tutorial.url = [element objectForKey:@"href"];
    }
    
    // 8
    books = newTutorials;
    [self.bookTableView reloadData];
}
- (void)setBookURL:(NSString *)url
{
    _bookURL = url;
    [self loadBooks];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showBook"]) {
        NSIndexPath *indexPath = [self.bookTableView indexPathForSelectedRow];
        //NSDate *object = _objects[indexPath.row];
        Tutorial *tutorial = [books objectAtIndex:indexPath.row];
        NSString *url = tutorial.url;
        [[segue destinationViewController] setBookURL:url];
        // [[segue destinationViewController] setDetailItem:object];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
