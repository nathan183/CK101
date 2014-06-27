//
//  BookContentViewController.h
//  Ck101
//
//  Created by Nathaniel Wu on 2014/5/14.
//  Copyright (c) 2014年 Nathaniel Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookContentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) NSString* bookURL;
@property (strong, nonatomic) NSString* bookContent;
- (void)setBookURL:(NSString *)url;
@end
