import XCTest

import PartialTests

var tests = [XCTestCaseEntry]()
tests += PartialTests.allTests()
XCTMain(tests)
