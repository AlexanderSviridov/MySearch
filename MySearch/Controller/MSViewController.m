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
#import "MSDependencyManager.h"
#import "MSNetworkManagerProtocol.h"
#import "UIViewController+ShowModal.h"
#import "MSPreviewViewController.h"
#import "MSSearchResultCellProtocol.h"
#import "MSLoadingScreenView.h"
#import "MSSearchResultContainerProtocol.h"
#import "MSGlobalConstaints.h"

static NSString *kMSViewControllerShowModalSeque = @"MSViewControllerShowModalSeque";

@interface MSViewController ()

@property (weak, nonatomic) IBOutlet MSSearchResultTableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *topSegmentControl;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property id<MSNetworkManagerProtocol> currentNetworkManager;
@property (weak, nonatomic) IBOutlet MSLoadingScreenView *loadingScreen;
@property (copy) NSString *serviceName;

@end

@implementation MSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [MSDependencyManager.sharedManager getDependenciesForObject:self];
    
    [self.topSegmentControl removeAllSegments];
    [self.networkManagers enumerateObjectsUsingBlock:^(MSViewControllerManagerContainer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.topSegmentControl insertSegmentWithTitle:obj.name atIndex:idx animated:NO];
    }];
    [self.topSegmentControl setSelectedSegmentIndex:0];
    _currentNetworkManager = self.networkManagers[0].networkManager;
    self.serviceName = self.networkManagers[0].name;
    __weak MSViewController *self_weak = self;
    [self.tableView setImageButtonHavePressedWithModel:^(id<MSSearchResultCellViewModel> model, id<MSSearchResultCellProtocol> cell) {
        [self_weak.previewController showModalWithDuration:kMSDefaultAnimationDuration];
        self_weak.previewController.transferImageView = [cell unattachImageViewFromCell];
        [self_weak.previewController setCompleationHandler:^(MSPreviewViewController *previewController) {
            [cell attachImageView:previewController.transferImageView];
        }];
    }];
    [[[[self.tableView getMoreCells] then:^MSPromise *(MSSearchResultTableView *tableview) {
        return [self_weak.currentNetworkManager getMoreResults];
    }] then:^id(id<MSSearchResultContainerProtocol> result) {
        if ( !result.cellArray.count )
            return [NSError errorWithDomain:@"" code:0 userInfo:nil];
        self_weak.tableView.isAllCells = result.isIncompleteResult;
        [self_weak.tableView insertCells:result.cellArray];
        return nil;
    }] catch:^MSPromise *(NSError *error) {
        self_weak.tableView.isAllCells = YES;
        self_weak.tableView.cellArray = self_weak.tableView.cellArray;
        return nil;
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textfieldAction:(UITextField *)sender
{
    [sender resignFirstResponder];
    MSPromise *promise = [[[self.currentNetworkManager searchWithQuery:sender.text] then:^MSPromise *(id<MSSearchResultContainerProtocol> result) {
        if ( !result.cellArray.count )
        {
            self.tableView.isAllCells = YES;
            self.tableView.cellArray = @[];
        }
        else
        {
            self.tableView.isAllCells = result.isIncompleteResult;
            self.tableView.cellArray = result.cellArray;
        }
        return nil;
    }] catch:^MSPromise *(NSError *error) {
        self.tableView.cellArray = @[];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        return nil;
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kMSDefaultAnimationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ( !promise.isCompleated )
        {
            [self.loadingScreen startAnimationWithQuery:sender.text serviceName:self.serviceName];
            [[promise then:^MSPromise *(id value) {
                [self.loadingScreen stopAnimating];
                return nil;
            }] catch:^MSPromise *(NSError *error) {
                [self.loadingScreen stopAnimating];
                return nil;
            }];
        }
    });
}

- (IBAction)topSegmentControlValueChanged:(UISegmentedControl *)sender
{
    self.currentNetworkManager = self.networkManagers[sender.selectedSegmentIndex].networkManager;
    self.serviceName = self.networkManagers[sender.selectedSegmentIndex].name;
    [self textfieldAction:self.searchTextField];
}

@end
