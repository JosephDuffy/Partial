import XCTest

import PartialTests

var tests = [XCTestCaseEntry]()
tests += PartialTests.__allTests()

XCTMain(tests)
