//
//  GTRedisObject.h
//  GoTogetherApp
//


//

#import <Foundation/Foundation.h>
#import "ObjCHiredis.h"

@protocol LoggerProtocol <NSObject>

@optional
-(void)logThis:(id)someText;

@end


@interface GTRedisObject : ObjCHiredis

@property (nonatomic, readonly) ObjCHiredis *redis;
@property (weak) id<LoggerProtocol>delegate;

+ (GTRedisObject *)redisObject;

- (void)connect;
- (void)close;

- (id)executeCommand:(NSString *)command;
- (id)executeCommandList:(NSArray *)commandList;

@end
