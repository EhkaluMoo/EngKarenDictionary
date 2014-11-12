//
//  EngKarenDicTableViewController.h
//  EngKarenDictionary
//
//  Created by Ehkalu Moo on 11/11/14.
//  Copyright (c) 2014 Ehkalu Moo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EngKarenDicTableViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>
@property (strong,nonatomic) NSMutableArray *filteredWordsArray;
@property IBOutlet UISearchBar *SearchBar;

@property (strong,nonatomic) NSArray *WordsArray;
@end
