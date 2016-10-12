//TODO: License

#import <UIKit/UIKit.h>
#import <SafariServices/SafariServices.h>

@interface SafariAuth : NSObject<SFSafariViewControllerDelegate>

//TODO: nullable specifiers
@property (nonatomic) NSString* startUrl;
@property (nonatomic) NSString* endUrl;

// TODO: disallow init
-(nonnull instancetype)initWithStartUrl:(nonnull NSString *)startUrl endUrl:(nonnull NSString *)endUrl;

-(NSString *)getToken;

@end


