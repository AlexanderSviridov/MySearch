//
//  ViewController.m
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSViewController.h"

#import "MSGithubNetworkManager.h"
#import "MSSearchResultTableView.h"
#import "MSSearchResultCellViewModel.h"

@interface MSViewController ()

@property MSGithubNetworkManager *githubManager;
@property (weak, nonatomic) IBOutlet MSSearchResultTableView *tableView;

@end

@implementation MSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _githubManager = [MSGithubNetworkManager new];
    __weak typeof(self) weakself = self;
    [self.githubManager searchWithQuery:@"reactivecocoa" compleationBlock:^(NSArray<id<MSSearchResultCellViewModel>> *results) {
        weakself.tableView.cellArray = results;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
