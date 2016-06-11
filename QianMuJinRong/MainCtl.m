//
//  ViewController.m
//  QianMuJinRong
//
//  Created by Zec on 16/6/2.
//  Copyright © 2016年 Zec. All rights reserved.
//

#import "MainCtl.h"

@interface MainCtl ()

@end

@implementation MainCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)jumpToTestPage:(UIButton *)sender {
    [self performSegueWithIdentifier:@"MainToTest" sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
