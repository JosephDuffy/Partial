@testable import Partial
import XCTest

final class PartiallyBuiltTests: XCTestCase {
    func testIncompletePartialValue() {
        let partiallyBuilt = PartiallyBuilt<StringWrapper>()
        XCTAssertNil(partiallyBuilt.wrappedValue)
    }

    func testCompletePartialValue() {
        var partiallyBuilt = PartiallyBuilt<StringWrapper>()
        let expectedValue = StringWrapper(stringLiteral: "test")
        partiallyBuilt.projectedValue.string = expectedValue.string

        XCTAssertEqual(partiallyBuilt.wrappedValue, expectedValue)
    }

    func testInitialisedWithACompletePartial() {
        let expectedValue = StringWrapper(stringLiteral: "test")
        var partial = Partial<StringWrapper>()
        partial.string = expectedValue.string
        let partiallyBuilt = PartiallyBuilt(partial: partial)

        XCTAssertEqual(partiallyBuilt.wrappedValue, expectedValue)
    }
}
