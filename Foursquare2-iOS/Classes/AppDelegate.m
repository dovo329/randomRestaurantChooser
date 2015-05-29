//
//  AppDelegate.m
//  Foursquare2
//
//  Created by Douglas Voss on 5/15/15.
//
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "Foursquare2.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // Toolbar
    // Food
    // Coffee
    // Wine
    // Entertainment
    
    ViewController *viewController = [[ViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    self.window.rootViewController = navigationController;
    
    [self.window makeKeyAndVisible];
    
    [Foursquare2 setupFoursquareWithClientId:@"Y0D0NQHGKR4CZY4PYVJHL5N55AZUZJICDNY43C4M24GYQZNC"
                                      secret:@"II2HF3VKGMCDH2IEM5TO2LDH4SJYVQA4MFD0T4FUOZM1MT4B"
                                     callbackURL:@"http://songloopslowdowninfo.webs.com"];
    
    return YES;
}

@end
