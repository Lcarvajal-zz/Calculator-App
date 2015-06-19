//
//  ViewController.m
//  Calculator-App
//
//  Created by Lukas Carvajal on 6/8/15.
//  Copyright (c) 2015 Lukas Carvajal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property NSMutableArray* stack;    // stack for storing operands
@property BOOL opPressed;           // true if operator pressed
@property NSString* cOperator;      // store operator type

@end

@implementation ViewController

- (IBAction) numberPressed: (id) sender {
    
    // make sure screen does not exceed 10 characters
    if (_screen.text.length >= 10)
        return;
    
    // add number to screen
    if ([_screen.text isEqualToString: @"0"]) {
        // if screen is at 0, start typing numbers from beginning
        _screen.text = [sender currentTitle];
    }
    else {
        // if screen is not at 0, add numbers to screen
        _screen.text = [_screen.text stringByAppendingString: [sender currentTitle]];
    }
}

- (IBAction) operatorPressed: (id) sender {
    
    // display operator
    _operator.text = [sender currentTitle];
    
    // set operator
    _cOperator = [ sender currentTitle ];
    
    if ( self.opPressed == NO)
        [ self operate ];   // push to stack if operator has not already been chosen
    else {
        NSString* tempOp = _cOperator;  // store current operator
        [ self calculate ];             // perform calculation
        _cOperator = tempOp;            // restore operator ( reset by calculate )
        [ self operate ];               // push new number to stack with new operator
    }
    
}

- (IBAction) equalPressed: (id) sender {
    
    // add second operand to stack
    [ self pushToStack: _screen.text ];
    
    // calculate expression
    [ self calculate ];
    
    // reset operator label
    _cOperator = @" ";
    _operator.text = @" ";
}

- (IBAction) clearPressed: (id) sender {
    
    // alert user if he/she tries to clear the screen
    UIAlertView *message = [ [ UIAlertView alloc ] initWithTitle: @"Clear"
                                                      message: @"Are you sure you want to clear the display?"
                                                     delegate: self
                                            cancelButtonTitle: @"Yes"
                                            otherButtonTitles: @"No", nil ];
    [message show];
}

// alert view for clearPressed
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    // clear screen if user presses 'Yes'
    if( [ [alertView buttonTitleAtIndex:buttonIndex] isEqualToString: @"Yes" ] )
    {

        // set screen back to 0
        _screen.text = @"0";

    }
    // else do nothing
    
}

- (void) setScreenToZero {
    self.screen.text = @"0";
}

// CALCULATION METHODS

- (void) operate {

    // push current number to stack
    [ self pushToStack: _screen.text ];

    // reset screen
    [ self setScreenToZero ];
    
    // operator has been pressed
    self.opPressed = YES;
}

- (void) calculate {
    
    // if operator has been pressed, perform calculation
    if ( self.opPressed == YES ) {
        
        // take numbers from stack
        double num2 = [ self popFromStack ];
        double num1 = [ self popFromStack ];
        
        // hold calculated value
        double calculated;
        
        // determine calculation to be performed
        if ( [ _cOperator isEqualToString: @"÷" ] )
            calculated = num1 / num2;
        else if ( [ _cOperator isEqualToString: @"x" ] )
            calculated = num1 * num2;
        else if ( [ _cOperator isEqualToString: @"+" ] )
            calculated = num1 + num2;
        else
            calculated = num1 - num2;
        
        // operator is now "unpressed"
        self.opPressed = NO;
        
        // format output
        NSNumberFormatter * formatter =  [ [ NSNumberFormatter alloc ] init ];
        [ formatter setUsesSignificantDigits: YES ];
        [ formatter setMaximumSignificantDigits: 10 ];
        [ formatter setMaximumFractionDigits: 9 ];
        [ formatter setRoundingMode: NSNumberFormatterRoundCeiling ];
        
        // use NSNumber for formatting
        NSNumber* c = [ [ NSNumber alloc ] initWithDouble: calculated ];
        
        // put calculated value on screen
        _screen.text = [formatter stringFromNumber: c];

    }
    
    // if operator has not been pressed, do nothing.
}

// END OF CALCULATION METHODS

// STACK METHODS

- (void) pushToStack:(NSString *) num {
    
    // "push number" to stack
    [ self.stack addObject: num ];
    
}

- (double) popFromStack {
    
    // Store last object in stack
    double popped = [ [ self.stack lastObject ] doubleValue ];
    
    // Remove last object put into stack
    [ self.stack removeLastObject ];
    
    return popped;
    
}

// END OF STACK METHODS

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _opPressed = NO;
    self.stack = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
