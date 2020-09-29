import XCTest
@testable import E

internal struct E_num {
    var text: Variable = "Hello, World!"
}

final class ETests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        var count: Variable = .int(0)
        
        let stillIntValue = count
            .update { .string($0 ?? "Hello, World!") } // returns .int(0)
            .update { .int($0 + 27) }
        
        let defaultedStringValue = count.modify { value in
            .string(value ?? "Hello, World!")
        }
        
        XCTAssertEqual(count, 0)
        XCTAssertEqual(stillIntValue, 27)
        XCTAssertEqual(defaultedStringValue, "Hello, World!")
        
        Control.loop(0 ... 5,
                     .in { index in
                        count = count.update { value in
                            .int(value + (index.value() ?? 0))
                        }
                     })
            .run()
        
        XCTAssertEqual(count, 15)
        XCTAssertEqual(E_num().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
