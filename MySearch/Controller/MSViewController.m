//
//  ViewController.m
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSViewController.h"

#import "MSSearchResultTableView.h"
#import "MSSearchResultCellViewModel.h"
#import "MSPromise.h"

#import "MSGithubNetworkManager.h"
#import "MSiTunesNetworkManager.h"

@implementation MSViewControllerManagerContainer

+ (instancetype)networkManagerWithManager:(id<MSNetworkManagerProtocol>)manager name:(NSString *)name
{
    MSViewControllerManagerContainer *container = [MSViewControllerManagerContainer new];
    container.networkManager = manager;
    container.name = name;
    return container;
}

@end

@interface MSViewController ()

@property (weak, nonatomic) IBOutlet MSSearchResultTableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *topSegmentControl;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property id<MSNetworkManagerProtocol> currentNetworkManager;

@end

@implementation MSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.networkManagers = @[
        [MSViewControllerManagerContainer networkManagerWithManager:[MSGithubNetworkManager new] name:@"Github"],
        [MSViewControllerManagerContainer networkManagerWithManager:[MSiTunesNetworkManager new] name:@"iTunes"]
    ];
    [self.topSegmentControl removeAllSegments];
    [self.networkManagers enumerateObjectsUsingBlock:^(MSViewControllerManagerContainer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.topSegmentControl insertSegmentWithTitle:obj.name atIndex:idx animated:NO];
    }];
    [self.topSegmentControl setSelectedSegmentIndex:0];
    _currentNetworkManager = self.networkManagers[0].networkManager;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textfieldAction:(UITextField *)sender
{
    [sender resignFirstResponder];
    [[[self.currentNetworkManager searchWithQuery:sender.text] then:^MSPromise *(NSArray<id<MSSearchResultCellViewModel>> *items) {
        self.tableView.cellArray = items;
        return nil;
    }] catch:^MSPromise *(NSError *error) {
        self.tableView.cellArray = @[];
        return nil;
    }];
}

- (IBAction)topSegmentControlValueChanged:(UISegmentedControl *)sender
{
    self.currentNetworkManager = self.networkManagers[sender.selectedSegmentIndex].networkManager;
    [self textfieldAction:self.searchTextField];
}

@end
