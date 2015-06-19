### Calculator Application
[by Lukas Carvajal](https://lcarvajal.github.io)

This is an iphone application that performs basic arithmetic.

For this assignment we are required to have the buttons 0-9, support addition subtraction, multiplication, and division. 

The operands must be stored in a "stack" with [NSMutableArray](https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSMutableArray_Class/index.html). 

One method "pushes" the operands to the stack with **addObject** and another method "pops" them with **lastObject** and **removeObject**. 

When the equal sign is pressed, the operands are popped and the operation is performed on them, displaying the output to the screen. 

Additionally, the clr button asks the user if they are sure they want to clear the screen and then clears it if they accept.
