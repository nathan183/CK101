//
//  BookContentViewController.m
//  Ck101
//
//  Created by Nathaniel Wu on 2014/5/14.
//  Copyright (c) 2014年 Nathaniel Wu. All rights reserved.
//

#import "TFHpple.h"
#import "Tutorial.h"
#import "Contributor.h"
#import "BookContentViewController.h"

@interface BookContentViewController ()
@end

@implementation BookContentViewController
@synthesize bookURL = _bookURL;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textView.text = self.bookContent;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadBook
{
    // 1
    NSURL *tutorialsUrl = [NSURL URLWithString:self.bookURL];
    NSData *tutorialsHtmlData = [NSData dataWithContentsOfURL:tutorialsUrl];
    
    // 2
    TFHpple *tutorialsParser = [TFHpple hppleWithHTMLData:tutorialsHtmlData];
    
    // 3
    NSString *tutorialsXpathQueryString = @"//div[@class='pcb']/div[@class='t_fsz']/table/tr/td";
    NSArray *tutorialsNodes = [tutorialsParser searchWithXPathQuery:tutorialsXpathQueryString];
    
    // 4
    NSMutableArray *newTutorials = [[NSMutableArray alloc] initWithCapacity:0];
    
    self.bookContent = @"";
    for (TFHppleElement *element in tutorialsNodes) {
        // 5
        Tutorial *tutorial = [[Tutorial alloc] init];
        [newTutorials addObject:tutorial];
        
        // 6
        //tutorial.title = element.children[1]
        //tutorial.title = [[element firstChild] content];
        //tutorial.title = [[element firstChild] content];
        for (TFHppleElement *subelement in element.children)
        {
            NSString *dds = [subelement content];
            if (dds != nil)
            {
                self.bookContent = [self.bookContent stringByAppendingString:[subelement content]];
            }
        }
        // 7
        tutorial.url = [element objectForKey:@"href"];
    }
}
- (void)setBookURL:(NSString *)url
{
    _bookURL = url;
    [self loadBook];
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
