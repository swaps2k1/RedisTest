//
//  ViewController.h
//  REDIS Test
//
//  Created by Salunke, Swapnil Uday (US - Mumbai) on 09/09/15.
//  Copyright (c) 2015 Salunke, Swapnil Uday (US - Mumbai). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTRedisObject.h"
@interface ViewController : UIViewController<LoggerProtocol>
@property (weak, nonatomic) IBOutlet UITextView *textOutPutView;

@property (weak, nonatomic) IBOutlet UIButton *pushData;
@property (weak, nonatomic) IBOutlet UIButton *retrieveData;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *designationText;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;

@end

