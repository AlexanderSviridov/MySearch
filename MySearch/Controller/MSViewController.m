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
#import "MSPromise.h"

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textfieldAction:(UITextField *)sender
{
    [sender resignFirstResponder];
    [[self.githubManager searchWithQuery:sender.text] then:^MSPromise *(NSArray<id<MSSearchResultCellViewModel>> *items) {
        self.tableView.cellArray = items;
        return nil;
    }];
}

@end
