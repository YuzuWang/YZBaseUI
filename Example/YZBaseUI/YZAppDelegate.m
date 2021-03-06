//
//  YZAppDelegate.m
//  YZBaseUI
//
//  Created by niansi.no@gmail.com on 03/20/2020.
//  Copyright (c) 2020 niansi.no@gmail.com. All rights reserved.
//

#import "YZAppDelegate.h"
#import "YZViewController.h"

@implementation YZAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    YZViewController *vc = [[YZViewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    self.window = [[UIWindow alloc] init];
    self.window.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
       [self.window makeKeyAndVisible];
    
    [self.window setRootViewController:nav];

//    [self quickSort:@[@"5",@"3",@"7",@"6",@"4",@"1",@"0",@"2",@"9",@"10",@"8",].mutableCopy low:0 high:10];
    
    return YES;
}


- (void)quickSort:(NSMutableArray *)m low:(int)low high:(int)high{
    if (low >= high) {
        return;
    }
    int i = low;
    int j = high;
    id key = m[i];
    while (i<j) {
        while (i<j && [m[j] intValue] >= [key intValue]) {
            j--;
        }
        if (i == j) { // 当key是目前最小的数时，会出现i=j的情况，
            break;
        }
        m[i++] = m[j]; // i++ 会减少一次m[i]和key的比较
 
        while (i < j && [m[i] intValue] <= [key intValue]) {
            i++;
        }
        if (i == j) { // 当key是目前最大的数时(m[j]的前面)，会出现i=j的情况
            break;
        }
        m[j--] = m[i]; //j-- 会减少一次m[j]和key的比较
    }
    m[i] = key;
    [self quickSort: m low: low high: i-1];
    [self quickSort: m low: i+1 high: high];
     NSLog(@"快速排序 %@",m);
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
