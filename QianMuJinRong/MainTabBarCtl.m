//
//  MainTabBarCtl.m
//  QianMuJinRong
//
//  Created by Zec on 16/6/2.
//  Copyright © 2016年 Zec. All rights reserved.
//

#import "MainTabBarCtl.h"
#import "MainCtl.h"
#import "InvestmentCtl.h"
#import "AccountCtl.h"
#import "ZecNavigationCtl.h"


@interface MainTabBarCtl ()

@end

@implementation MainTabBarCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ZecNavigationCtl *nav1 = (ZecNavigationCtl *)[self storyboard:@"Main" identifier:@"MainNavCtl"];
    [self tabbarItem:@"主页" image:@"image" nav:nav1];
    ZecNavigationCtl *nav2 = (ZecNavigationCtl *)[self storyboard:@"Investment" identifier:@"InvestmentNavCtl"];
    [self tabbarItem:@"投资" image:@"image" nav:nav2];
    ZecNavigationCtl *nav3 = (ZecNavigationCtl *)[self storyboard:@"Account" identifier:@"AccountNavCtl"];
    [self tabbarItem:@"个人资料" image:@"image" nav:nav3];
    
    self.viewControllers = @[nav1,nav2,nav3];
    
}
- (id)storyboard:(NSString *)sbdName identifier:(NSString *)identifier {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:sbdName bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:identifier];
}

- (void)tabbarItem:(NSString *)title image:(NSString *)imgName nav:(UINavigationController *)nav
{
    UIImage *img = [[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectiImg = [[UIImage imageNamed:[NSString stringWithFormat:@"%@", imgName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:img selectedImage:selectiImg];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
