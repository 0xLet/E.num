import XCTest
@testable import E_num

internal struct E_num {
    var list: Variable = .array(
        [
            .bool(false),
            .string("False"),
            .int(0),
            .dictionary(
                [
                    .bool(false): .double(3.14)
                ]
            )
        ]
    )
    
    var dictionary: Variable = .dictionary(
        [
            .bool(false): .double(3.14)
        ]
    )
    
    var text: Variable = .string("Hello, World!")
    
    var stu = Function.void {
        print("STFU")
    }
    
    func stupid() {
        if case .string(let value) = text {
            print("Stupid String: \(value)")
        }
        
        if case .array(let value) = list,
           let firstValue = value.last,
           case .int(let number) = firstValue {
            print(number * 99)
        }
        
        stu()
    }
}


final class E_numTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(E_num().text, .string("Hello, World!"))
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
