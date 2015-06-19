//
//  ViewController.h
//  Calculator-App
//
//  Created by Lukas Carvajal on 6/8/15.
//  Copyright (c) 2015 Lukas Carvajal. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController :  UIViewController <UIAlertViewDelegate>

// button methods
- (IBAction) numberPressed: (id) sender;
- (IBAction) operatorPressed: (id) sender;
- (IBAction) equalPressed: (id) sender;
- (IBAction) clearPressed: (id) sender;

// clear screen
- (void) setScreenToZero;

// calculation methods
- (void) operate;
- (void) calculate;

// stack methods
- (void) pushToStack: (NSString*) num;
- (double) popFromStack;

// calculator screen
@property (weak, nonatomic) IBOutlet UITextField *screen;

// displays operator on calculator screen
@property (weak, nonatomic) IBOutlet UILabel *operator;

@end

