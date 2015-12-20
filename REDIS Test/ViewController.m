//
//  ViewController.m
//  REDIS Test
//
//  Created by Salunke, Swapnil Uday (US - Mumbai) on 09/09/15.
//  Copyright (c) 2015 Salunke, Swapnil Uday (US - Mumbai). All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic, strong)NSMutableString *statusString;
@property(nonatomic, weak)GTRedisObject *localRedis;
- (IBAction)push:(UIButton *)sender;
- (IBAction)retrieve:(UIButton *)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewDidAppear:(BOOL)animated
{
    self.localRedis = [GTRedisObject redisObject];
    self.localRedis.delegate = self;
    [self.localRedis connect];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)logThis:(id)someText
{
    if (!self.statusString) {
        self.statusString = [[NSMutableString alloc]init];
    }
    
    [self.statusString appendString:someText];
    [self.statusString appendString:@"\n"];
    self.textOutPutView.text = self.statusString;
}

- (IBAction)push:(UIButton *)sender {
    NSString *name = self.nameText.text;
    NSString *designation = self.designationText.text;
    [self pushName:name andDesignation:designation];
}

-(void)pushName:(NSString *)name andDesignation:(NSString *)desgination
{
    if (name!=nil&&desgination!=nil) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
        
        NSString *dateFromString = [formatter stringFromDate:[NSDate date]];
        
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              name,@"Name",
                              desgination,@"Level",
                              dateFromString,@"DateTimeStamp",
                              nil];
        //NSString *stringPush = [NSString stringWithFormat:@"%@",dict];
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
        NSString *stringPush = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        [self.localRedis executeCommand:[NSString stringWithFormat:@"RPUSH VAN %@",stringPush]];
        
    }
}

- (IBAction)retrieve:(UIButton *)sender {
    
    NSArray *returnArray = [self.localRedis executeCommand:[NSString stringWithFormat:@"LRANGE VAN 0 100"]];
    NSLog(@"%ld",returnArray.count);

}

- (IBAction)clearDB:(id)sender
{
    [self.localRedis executeCommand:[NSString stringWithFormat:@"FLUSHDB"]];
}
@end
