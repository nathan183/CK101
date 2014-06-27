//
//  BookListViewController.h
//  Ck101
//
//  Created by Nathaniel Wu on 2014/5/13.
//  Copyright (c) 2014年 Nathaniel Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *bookTableView;
@property (strong, nonatomic) NSString* bookURL;
- (void)setBookURL:(NSString *)url;
@end
