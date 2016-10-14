//TODO: License

#import <UIKit/UIKit.h>
#import <SafariServices/SafariServices.h>

@interface SafariAuth : NSObject<SFSafariViewControllerDelegate>

//TODO: nullable specifiers
@property (nonatomic) NSString* authUrl;

// TODO: disallow init
-(nonnull instancetype)initWithAuthUrl:(nonnull NSString *)url;

-(void)beginAuthWithViewController:(UIViewController *)viewController;
-(void)dismiss;

@end


