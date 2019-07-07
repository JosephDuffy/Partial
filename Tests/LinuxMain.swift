import XCTest
import Quick

@testable import PartialTests

QCKMain([
    PartialTests.self,
    Partial_PartialConvertibleTests.self,
    PartialBuilderTests.self,
    PartialBuilder_PartialConvertibleTests.self,
    PartialBuilderSubscriptionTests.self,
])
