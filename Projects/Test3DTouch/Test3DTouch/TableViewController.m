//
//  TableViewController.m
//  Test3DTouch
//
//  Created by Yue on 2018/5/7.
//  Copyright © 2018年 Yue. All rights reserved.
//

#import "TableViewController.h"
#import "BViewController.h"

static NSString * const CellIdentifier = @"CellReuseIdentifier";
@interface TableViewController ()<UIViewControllerPreviewingDelegate>

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"3DTouch-Previewing";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    //注册3DTouch
    if ([self.traitCollection respondsToSelector:@selector(forceTouchCapability)] &&
        (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable)) {
        [self registerForPreviewingWithDelegate:self sourceView:self.tableView];
    }
}

#pragma mark - ===== UITableViewDataSource =====
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"-----> UITableViewCell <------ %ld",indexPath.row];
    return cell;
}

#pragma mark - ===== UITableViewDelegate =====
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BViewController *bVC = [[BViewController alloc] init];
    bVC.parameter = [NSString stringWithFormat:@"BVC--->%ld",indexPath.row];
    [self.navigationController pushViewController:bVC animated:YES];
}

#pragma mark - ===== UIViewControllerPreviewingDelegate =====
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    
    if ([self.presentedViewController isKindOfClass:[BViewController class]]) {
        return nil;
    }
    else {
        UITableView *tableView = (UITableView *)previewingContext.sourceView;
        NSIndexPath *indexPath = [tableView indexPathForRowAtPoint:location];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            return nil;
        }
        
        //设置不被虚化的范围
        previewingContext.sourceRect = cell.frame;
        
        BViewController *previewingVC = [[BViewController alloc] init];
        previewingVC.parameter = [NSString stringWithFormat:@"BVC--->%ld",indexPath.row];
        //可调整预览视图的大小
        previewingVC.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/(indexPath.row%2 + 1));
        
        return previewingVC;
    }
}

- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(nonnull UIViewController *)viewControllerToCommit {
    
    //方式一
//    [self showViewController:viewControllerToCommit sender:self];
    
    //方式二
//    [self.navigationController pushViewController:viewControllerToCommit animated:YES];
//    [self presentViewController:viewControllerToCommit animated:YES completion:nil];
    
    //方式三
    BViewController *pushVC = [[BViewController alloc] init];
    pushVC.parameter = [(BViewController *)viewControllerToCommit parameter];
    [self.navigationController pushViewController:pushVC animated:YES];
}

@end
