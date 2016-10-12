//TODO: License

#import "SafariAuth.h"

@implementation SafariAuth

@synthesize startUrl = _startUrl;
@synthesize endUrl = _endUrl;

SFSafariViewController *safariViewController;

-(instancetype)initWithStartUrl:(NSString *)startUrl endUrl:(NSString *)endUrl
{
    if (self)
    {
        _startUrl = startUrl;
        _endUrl = endUrl;
        //TODO: guard against minor differences like whitespace, trailing slash..
    }
    
    return self;
}

-(UIViewController *)getViewController
{
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return viewController;
}

-(NSString *)getToken
{
    //TODO: prevent reentrancy
    
    UIViewController *viewController = [self getViewController];
    
    safariViewController = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:self.startUrl]];
    safariViewController.delegate = self;
    
    [viewController presentViewController:safariViewController animated:NO completion:^{
        // something
    }];
    
    return nil;
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
    NSLog(@"Finished loading... ");
}


@end