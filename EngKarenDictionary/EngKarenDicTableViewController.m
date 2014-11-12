//
//  EngKarenDicTableViewController.m
//  EngKarenDictionary
//
//  Created by Ehkalu Moo on 11/11/14.
//  Copyright (c) 2014 Ehkalu Moo. All rights reserved.
//

#import "EngKarenDicTableViewController.h"
#import "EngKarenDic.h"
@interface EngKarenDicTableViewController ()

@end

@implementation EngKarenDicTableViewController
@synthesize WordsArray;

- (void)viewDidLoad
{
    // Sample Data for candyArray
    WordsArray = [NSArray arrayWithObjects:
                  [EngKarenDic WordsOfCategory:@"chocolate" name:@"chocolate bar"],
                  [EngKarenDic WordsOfCategory:@"chocolate" name:@"chocolate chip"],
                  [EngKarenDic WordsOfCategory:@"chocolate" name:@"dark chocolate"],
                  [EngKarenDic WordsOfCategory:@"hard" name:@"lollipop"],
                  [EngKarenDic WordsOfCategory:@"hard" name:@"candy cane"],
                  [EngKarenDic WordsOfCategory:@"hard" name:@"jaw breaker"],
                  [EngKarenDic WordsOfCategory:@"other" name:@"caramel"],
                  [EngKarenDic WordsOfCategory:@"other" name:@"sour chew"],
                  [EngKarenDic WordsOfCategory:@"other" name:@"peanut butter cup"],
                  [EngKarenDic WordsOfCategory:@"other" name:@"gummi bear"], nil];
    
    // Initialize the filteredCandyArray with a capacity equal to the candyArray's capacity
    self.filteredWordsArray = [NSMutableArray arrayWithCapacity:[WordsArray count]];

    // Reload the table
    [self.tableView reloadData];

}

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [self.filteredWordsArray removeAllObjects];
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
    _filteredWordsArray = [NSMutableArray arrayWithArray:[WordsArray filteredArrayUsingPredicate:predicate]];
}
#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Check to see whether the normal table or search results table is being displayed and return the count from the appropriate array
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [_filteredWordsArray count];
    } else {
        return [WordsArray count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Create a new Candy Object
    EngKarenDic *Words = nil;
    
    // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        Words= [_filteredWordsArray objectAtIndex:indexPath.row];
    } else {
        Words = [WordsArray objectAtIndex:indexPath.row];
    }
    // Configure the cell
    cell.textLabel.text = Words.name;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

#pragma mark - TableView Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Perform segue to candy detail
    [self performSegueWithIdentifier:@"EngKarenDicDetail" sender:tableView];
}

#pragma mark - Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"EngKarenDicDetail"]) {
        UIViewController *EngKarenDicDetailViewController = [segue destinationViewController];
        // In order to manipulate the destination view controller, another check on which table (search or normal) is displayed is needed
        if(sender == self.searchDisplayController.searchResultsTableView) {
            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            NSString *destinationTitle = [[_filteredWordsArray objectAtIndex:[indexPath row]] name];
            [EngKarenDicDetailViewController setTitle:destinationTitle];
        }
        else {
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            NSString *destinationTitle = [[WordsArray objectAtIndex:[indexPath row]] name];
            [EngKarenDicDetailViewController setTitle:destinationTitle];
        }
        
    }
}


@end
