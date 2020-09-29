import XCTest
@testable import E_num

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
