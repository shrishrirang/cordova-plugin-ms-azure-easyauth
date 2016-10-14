/********* easyauth.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import "SafariAuth.h"

@interface easyauth : CDVPlugin {

}

@property (strong, nonatomic) SafariAuth *safariAuth;

- (void)login:(CDVInvokedUrlCommand*)command;
@end

@implementation easyauth

CDVInvokedUrlCommand *_command;

- (void)login:(CDVInvokedUrlCommand*)command
{
    NSString* authUrl = [command.arguments objectAtIndex:0];
    NSString *easyAuthAppId = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"EASYAUTH_APPID"];

    NSString *redirectUrl = [NSString stringWithFormat:@"%@://abc.def", easyAuthAppId];
    authUrl = [NSString stringWithFormat:@"%@?post_login_redirect_url=%@", authUrl, redirectUrl];

    self.safariAuth = [[SafariAuth alloc] initWithAuthUrl:authUrl];
    
    [self.safariAuth beginAuthWithViewController:self.viewController];
    _command = command;
}

/* NOTE: calls into JavaScript must not call or trigger any blocking UI, like alerts */
- (void)handleOpenURL:(NSNotification*)notification
{
    // override to handle urls sent to your app
    // register your url schemes in your App-Info.plist
    
    NSURL* url = [notification object];
    
    if ([url isKindOfClass:[NSURL class]]) {
        
        NSString *easyAuthAppId = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"EASYAUTH_APPID"];
        NSString *redirectUri = [NSString stringWithFormat:@"%@://abc.def", easyAuthAppId];
        NSString *base = [NSString stringWithFormat:@"%@/#token=", redirectUri];
        
        NSString *absoluteUrl = [[url absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSRange range = [absoluteUrl rangeOfString:base];
        NSString *tokenText = [absoluteUrl substringFromIndex:range.length];
        
        [self.safariAuth dismiss];

        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:tokenText];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:_command.callbackId];
    }

    // TODO: Error
}

@end
