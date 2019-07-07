import XCTest
import Quick

@testable import PartialTests

QCKMain([
    PartialNonOptionalPropertyTests.self,
    PartialOptionalPropertyTests.self,
    PartialNonOptionalPartialConvertiblePropertyTests.self,
    PartialOptionalPartialConvertiblePropertyTests.self,
    PartialBuilderNonOptionalPropertyTests.self,
    PartialBuilderOptionalPropertyTests.self,
    PartialBuilderNonOptionalPartialConvertiblePropertyTests.self,
    PartialBuilderOptionalPartialConvertiblePropertyTests.self,
    PartialOptionalPropertyTests.self,
])
