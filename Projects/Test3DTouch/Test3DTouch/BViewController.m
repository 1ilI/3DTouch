//
//  BViewController.m
//  Test3DTouch
//
//  Created by Yue on 2018/5/7.
//  Copyright © 2018年 Yue. All rights reserved.
//

#import "BViewController.h"

@interface BViewController ()

@property (strong, nonatomic) UILabel *label;

@end

@implementation BViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"B--->viewWillAppear------>%@",self);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"B--->viewDidAppear------->%@",self);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"B--->viewWillDisappear--->%@",self);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"B--->viewDidDisappear---->%@",self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"BViewController";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.label];
    NSLog(@"B--->viewDidLoad--------->%@",self);
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.label.frame = CGRectMake(0, 0, 200, 50);
    self.label.center = self.view.center;
}

- (UILabel *)label {
    if (!_label) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor lightGrayColor];
        label.textColor = [UIColor whiteColor];
        label.text = self.parameter;
        _label = label;
    }
    return _label;
}

- (void)dealloc {
    NSLog(@"B--->dealloc------------->%@",self);
}

#pragma mark - ===== previewActionItems =====
- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"Selected" style:UIPreviewActionStyleSelected handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"点击了Selected");
    }];
    
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"Destructive" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"点击了Destructive");
    }];
    
    UIPreviewAction *group1 = [UIPreviewAction actionWithTitle:@"选项一" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"点击了选项一");
    }];
    UIPreviewAction *group2 = [UIPreviewAction actionWithTitle:@"选项二" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"点击了选项二");
    }];
    UIPreviewActionGroup *group = [UIPreviewActionGroup actionGroupWithTitle:@"更多选项" style:UIPreviewActionStyleDefault actions:@[group1,group2]];
    
    return @[action1,action2,group];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
