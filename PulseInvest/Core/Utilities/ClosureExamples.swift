import Foundation

struct ClosureExamples {
    
    static func simpleClosureExample() {
        
        let greet = {
            print("Hello from closure")
        }
        
        greet()
    }
    
    static func closureWithParameters() {
        
        let sum: (Int, Int) -> Int = { a, b in
            a + b
        }
        
        print(sum(2, 3))
    }
    
    static func trailingClosureExample() {
        
        performAction {
            print("Trailing closure executed")
        }
        
    }
    
    static func performAction(action: () -> Void) {
        action()
    }
}
