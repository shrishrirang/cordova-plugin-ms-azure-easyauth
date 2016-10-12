//TODO: License

#import "SafariAuth.h"

@implementation SafariAuth

@synthesize authUrl = _authUrl;

SFSafariViewController *safariViewController;

-(instancetype)initWithAuthUrl:(NSString *)url
{
    if (self)
    {
        _authUrl = url;
        //TODO: guard against minor differences like whitespace, trailing slash..
    }
    
    return self;
}

-(UIViewController *)getViewController
{
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return viewController;
}

-(void)beginAuth
{
    //TODO: prevent reentrancy
    
    UIViewController *viewController = [self getViewController];
    
    safariViewController = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:self.authUrl]];
    safariViewController.delegate = self;
    
    [viewController presentViewController:safariViewController animated:NO completion:^{
        // something
    }];
}

-(void)dismiss
{
    [safariViewController dismissViewControllerAnimated:NO completion:nil];
}

-(void)safariViewController:(SFSafariViewController *)controller didCompleteInitialLoad:(BOOL)didLoadSuccessfully
{
    NSLog(@"didCompleteInitialLoad: %@", controller.title);
    
    //    [controller dismissViewControllerAnimated:NO completion:nil];
}

-(NSArray<UIActivity *> *)safariViewController:(SFSafariViewController *)controller activityItemsForURL:(NSURL *)URL title:(NSString *)title {
    return nil;
}

-(void)safariViewControllerDidFinish:(SFSafariViewController *)controller
{
    [self dismiss];
    
    NSLog(@"Finished loading... ");
}


@end