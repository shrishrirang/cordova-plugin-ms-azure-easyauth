/********* easyauth.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import "SafariAuth.h"

@interface easyauth : CDVPlugin {

}

@property (strong, nonatomic) SafariAuth *safariAuth;

- (void)coolMethod:(CDVInvokedUrlCommand*)command;
@end

@implementation easyauth

CDVInvokedUrlCommand *_command;

- (void)coolMethod:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* echo = [command.arguments objectAtIndex:0];

    self.safariAuth = [[SafariAuth alloc] initWithStartUrl:@"https://shrirs-demo.azurewebsites.net/.auth/login/facebook?post_login_redirect_url=zzz://abc.def" endUrl:@"http://taco.visualstudio.com/"];
    
    NSString *token = [self.safariAuth getToken];

//    if (echo != nil && [echo length] > 0) {
//        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
//    } else {
//        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
//    }

//    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    _command = command;
}

/* NOTE: calls into JavaScript must not call or trigger any blocking UI, like alerts */
- (void)handleOpenURL:(NSNotification*)notification
{
    // override to handle urls sent to your app
    // register your url schemes in your App-Info.plist
    
    NSURL* url = [notification object];
    
    if ([url isKindOfClass:[NSURL class]]) {
        
        NSString *redirectUri = @"zzz://abc.def";
        NSString *base = [NSString stringWithFormat:@"%@/#token=", redirectUri];
        
        NSString *absoluteUrl = [[url absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSRange range = [absoluteUrl rangeOfString:base];
        NSString *tokenText = [absoluteUrl substringFromIndex:range.length];
        
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:tokenText];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:_command.callbackId];
    }

    // TODO: Error
}

@end
