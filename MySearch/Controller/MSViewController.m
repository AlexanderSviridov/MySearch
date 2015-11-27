//
//  ViewController.m
//  MySearch
//
//  Created by Alexander Sviridov on 27/11/15.
//  Copyright © 2015 Alexander Sviridov. All rights reserved.
//

#import "MSViewController.h"

#import "MSGithubNetworkManager.h"

@interface MSViewController ()

@property MSGithubNetworkManager *githubManager;

@end

@implementation MSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _githubManager = [MSGithubNetworkManager new];
    [self.githubManager searchWithQuery:@"reactivecocoa" compleationBlock:^(NSArray *results) {
        NSLog(@"%s %@", __PRETTY_FUNCTION__, results );
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
