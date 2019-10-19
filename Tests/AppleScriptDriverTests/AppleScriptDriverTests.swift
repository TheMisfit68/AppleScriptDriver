import XCTest
@testable import AppleScriptDriver

final class AppleScriptDriverTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(AppleScriptDriver().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
