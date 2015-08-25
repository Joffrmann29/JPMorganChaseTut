//
//  ATMViewController.m
//  JPMorganChaseSample
//
//  Created by Joffrey Mann on 7/29/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#import "ATMViewController.h"
#import "ATMDetailViewController.h"
#import "MapViewController.h"
#import "MBProgressHUD.h"

@interface ATMViewController ()

@property (strong, nonatomic) NSMutableArray *myLocations;

@property (strong, nonatomic) MBProgressHUD *hud;
@end

@implementation ATMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //_locations = [[NSMutableArray alloc]init];
    ATMModel *model = [[ATMModel alloc]init];
    [model getItems];
    model.delegate = self;
    [self loadingOverlay];
    _myLocations = [NSMutableArray array];
}

-(void)loadingOverlay
{
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.labelText = @"Loading ATM Locations";
}

-(void)hideOverlay
{
    [_hud hide:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)itemsRetrieved:(NSData *)itemData
{
    // Create an array to store the locations
    NSArray *locations = [[NSArray alloc] init];
    
    // Parse the JSON that came in
    NSError *error;
    
    // Type to id and allow determination of type at runtime
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:itemData options:NSJSONReadingAllowFragments error:&error];
    
    locations = jsonDict[@"locations"] ;
    
    for (int i = 0; i < locations.count; i++)
    {
        NSDictionary *jsonElement = locations[i];
        
        // Create a new location object and set its props to JsonElement properties
        Location *newLocation = [[Location alloc] initWithDictionary:jsonElement];
        
        [_myLocations addObject:newLocation];
    }
    // Reload the table view
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_myLocations count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ATMCell"];
    
    Location *locationAtIndex = _myLocations[indexPath.row];
    
    cell.textLabel.text = locationAtIndex.name;
    
    cell.detailTextLabel.text = locationAtIndex.locType;
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.destinationViewController isKindOfClass:[ATMDetailViewController class]])
    {
        // Create an instance of ATMDetailViewController and set it as segue's destination view controller.
        ATMDetailViewController *advc = (ATMDetailViewController *)segue.destinationViewController;
        
        // Assign the selected row of the tableview to an instance of NSIndexPath.
        NSIndexPath *indexPath = [_tableView indexPathForSelectedRow];
        
        // Assign the dictionary object at the index of the array to a variable called selectedDict of type NSDictionary.
        Location *selectedLocation = _myLocations[indexPath.row];
        
        // Set the passedDict property of the ATMDetailViewController to selectedDict.
        advc.passedLocation= selectedLocation;
    }
    
    else if([segue.destinationViewController isKindOfClass:[MapViewController class]])
    {
        MapViewController *mvc = (MapViewController *)segue.destinationViewController;
        
        mvc.locations = _myLocations;
    }
}

@end
