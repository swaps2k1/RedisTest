//
//  GTRedisObject.m
//  GoTogetherApp
//
//  Created by MSPiMac2 on 7/30/14.
//

#import "GTRedisObject.h"

@interface GTRedisObject ()

@property (nonatomic, strong) ObjCHiredis *redis;
@property (nonatomic, strong) NSString *loggerString;

@end

@implementation GTRedisObject

+ (GTRedisObject *)redisObject
{
	static GTRedisObject *redisObject = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		redisObject = [[self alloc] init];
	});

	return redisObject;
}

- (void)connect
{
	if (self.redis) {
    return;
	}

	id retVal = [self.redis command:@"PING"];
    self.loggerString = retVal;

	if ([retVal isEqualToString:@"PONG"]) {
		return;
	}
	else {
		[self.redis close];
		self.redis = nil;
	}


    self.redis = [ObjCHiredis redis];
	//self.redis = [ObjCHiredis redis:@"internal-redis-elb-1777069599.us-east-1.elb.amazonaws.com" on:@(80)];
//	self.redis = [ObjCHiredis redis:@"pub-redis-10303.us-east-1-1.2.ec2.garantiadata.com"
//																			on:@(10303)];
//
//	retVal = [self.redis command:@"AUTH loveme1234"];

	if (self.redis || [retVal isEqualToString:@"OK"]) {
		NSLog(@"Connected to redis server.");
        self.loggerString = @"Connected to redis server.";
	}
	else {
		NSLog(@"Could not connect to redis server.");
        self.loggerString = @"Could not connect to redis server.";
	}
    [self.delegate logThis:self.loggerString];
}

- (void)close
{
	[self.redis close];
	self.redis = nil;
}

- (id)executeCommand:(NSString *)command
{
	NSLog(@"Command ==> %@", command);
    self.loggerString = [NSString stringWithFormat:@"Command ==> %@", command];
	id 	retVal = [self.redis command:command];

	NSLog(@"Command ==> %@ - type(%@).", retVal, [retVal class]);
    self.loggerString = [NSString stringWithFormat:@"Command ==> %@ - type(%@).", retVal, [retVal class]];
	return retVal;
}

- (id)executeCommandList:(NSArray *)commandList
{
	id 	retVal = [self.redis commandArgv:commandList];
    
    self.loggerString = [NSString stringWithFormat:@"Command ==> %@ - type(%@).", retVal, [retVal class]];

	return retVal;
}

@end
