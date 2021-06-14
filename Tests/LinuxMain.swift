import XCTest
import Quick

@testable import PartialTests

QCKMain([
    Partial_CodableTests.self,
    Partial_PartialConvertibleTests.self,
    PartialBuilder_CodableTests.self,
    PartialBuilder_PartialConvertibleTests.self,
    PartialBuilderSubscriptionTests.self,
    PartialBuilderTests.self,
    PartialBuilderSubscriptionTests.self,
    PartialTests.self,
])
