import XCTest
import Quick

@testable import PartialTests

QCKMain([
    Partial_PartialConvertibleTests.self,
    PartialBuilder_PartialConvertibleTests.self,
    PartialBuilderSubscriptionTests.self,
    PartialBuilderTests.self,
    PartialCodableTests.self,
    PartialBuilderSubscriptionTests.self,
    PartialTests.self,
])
