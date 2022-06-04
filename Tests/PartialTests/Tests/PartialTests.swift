@testable import Partial
import XCTest

final class PartialTests: XCTestCase {
    func testDescription() {
        let partial = Partial<StringWrapperWrapper>()
        XCTAssertTrue(String(describing: partial).contains(String(describing: StringWrapperWrapper.self)))
    }

    func testFunctionalAPI() {
        var partial = Partial<StringWrapperWrapper>()
        XCTAssertNil(try? partial.value(for: \.stringWrapper))
        XCTAssertNil(try? partial.value(for: \.optionalStringWrapper) ?? nil)

        partial.setValue("test string", for: \.stringWrapper)
        XCTAssertEqual(try? partial.value(for: \.stringWrapper), "test string")
        XCTAssertNil(try? partial.value(for: \.optionalStringWrapper) ?? nil)
        XCTAssertNil(try? partial.unwrapped())

        partial.removeValue(for: \.stringWrapper)
        XCTAssertNil(try? partial.value(for: \.stringWrapper))
        XCTAssertNil(try? partial.value(for: \.optionalStringWrapper) ?? nil)
        XCTAssertNil(try? partial.unwrapped())

        partial.setValue("test string", for: \.optionalStringWrapper)
        XCTAssertNil(try? partial.value(for: \.stringWrapper))
        XCTAssertEqual(try? partial.value(for: \.optionalStringWrapper), "test string")
        XCTAssertNil(try? partial.unwrapped())

        partial.setValue(nil, for: \.optionalStringWrapper)
        XCTAssertNil(try? partial.value(for: \.stringWrapper))
        XCTAssertNil(try? partial.value(for: \.optionalStringWrapper) ?? nil)
        XCTAssertNil(try? partial.unwrapped())

        partial.setValue("test string", for: \.optionalStringWrapper)
        partial.removeValue(for: \.optionalStringWrapper)
        XCTAssertNil(try? partial.value(for: \.stringWrapper))
        XCTAssertNil(try? partial.value(for: \.optionalStringWrapper) ?? nil)
        XCTAssertNil(try? partial.unwrapped())

        partial.setValue("test string", for: \.stringWrapper)
        partial.setValue(StringWrapper?.none, for: \.optionalStringWrapper)
        XCTAssertEqual(try? partial.unwrapped(), StringWrapperWrapper(stringWrapper: "test string", optionalStringWrapper: nil))
    }

    func testSubscript() {
        var partial = Partial<StringWrapperWrapper>()
        XCTAssertNil(partial[\.stringWrapper])
        XCTAssertNil(partial[\.optionalStringWrapper] ?? nil)

        partial[\.stringWrapper] = "test string"
        XCTAssertEqual(partial[\.stringWrapper], "test string")
        XCTAssertNil(partial[\.optionalStringWrapper] ?? nil)
        XCTAssertNil(try? partial.unwrapped())

        partial[\.stringWrapper] = nil
        XCTAssertNil(partial[\.stringWrapper])
        XCTAssertNil(partial[\.optionalStringWrapper] ?? nil)
        XCTAssertNil(try? partial.unwrapped())

        partial[\.optionalStringWrapper] = "test string"
        XCTAssertNil(partial[\.stringWrapper])
        XCTAssertEqual(partial[\.optionalStringWrapper], "test string")
        XCTAssertNil(try? partial.unwrapped())

        partial[\.optionalStringWrapper] = nil
        XCTAssertNil(partial[\.stringWrapper])
        XCTAssertNil(partial[\.optionalStringWrapper] ?? nil)
        XCTAssertNil(try? partial.unwrapped())

        partial[\.stringWrapper] = "test string"
        partial[\.optionalStringWrapper] = StringWrapper?.none
        XCTAssertEqual(try? partial.unwrapped(), StringWrapperWrapper(stringWrapper: "test string", optionalStringWrapper: nil))
    }

    func testDynamicMemberLookup() {
        var partial = Partial<StringWrapperWrapper>()
        XCTAssertNil(partial.stringWrapper)
        XCTAssertNil(partial.optionalStringWrapper ?? nil)

        partial.stringWrapper = "test string"
        XCTAssertEqual(partial.stringWrapper, "test string")
        XCTAssertNil(partial.optionalStringWrapper ?? nil)
        XCTAssertNil(try? partial.unwrapped())

        partial.stringWrapper = nil
        XCTAssertNil(partial.stringWrapper)
        XCTAssertNil(partial.optionalStringWrapper ?? nil)
        XCTAssertNil(try? partial.unwrapped())

        partial.optionalStringWrapper = "test string"
        XCTAssertNil(partial.stringWrapper)
        XCTAssertEqual(partial.optionalStringWrapper, "test string")
        XCTAssertNil(try? partial.unwrapped())

        partial.optionalStringWrapper = nil
        XCTAssertNil(partial.stringWrapper)
        XCTAssertNil(partial.optionalStringWrapper ?? nil)
        XCTAssertNil(try? partial.unwrapped())

        partial.stringWrapper = "test string"
        partial.optionalStringWrapper = StringWrapper?.none
        XCTAssertEqual(try? partial.unwrapped(), StringWrapperWrapper(stringWrapper: "test string", optionalStringWrapper: nil))
    }

    func testSettingPartialConvertibleValue() throws {
        var partial = Partial<StringWrapperWrapper>()
        partial[\.stringWrapper] = "Initial value"
        partial[\.optionalStringWrapper] = "Initial optional value"

        XCTAssertThrowsError(try partial.setValue(Partial<StringWrapper>(), for: \.stringWrapper)) { thrownError in
            XCTAssertEqual(thrownError as? Partial<StringWrapper>.Error<String>, .keyPathNotSet(\.string))
        }
        XCTAssertEqual(partial[\.stringWrapper], "Initial value")

        XCTAssertThrowsError(try partial.setValue(Partial<StringWrapper>(), for: \.optionalStringWrapper)) { thrownError in
            XCTAssertEqual(thrownError as? Partial<StringWrapper>.Error<String>, .keyPathNotSet(\.string))
        }
        XCTAssertEqual(partial[\.optionalStringWrapper], "Initial optional value")

        // It would be nice to support this, but it would require `Optional` to
        // be conformed to `PartialConvertible`, which isn't currently possible
        // because the initialiser would need to "unwrap" the passed `Partial`
        // to allow the use of `StringWrapper.init(partial:)`
//        XCTAssertThrowsError(try partial.setValue(Partial<StringWrapper?>(), for: \.optionalStringWrapper)) { thrownError in
//            print(thrownError)
//        Partial<StringWrapper?>.Error<String>
//            XCTAssertEqual(thrownError as? Partial<StringWrapper?>.Error<String?>, .keyPathNotSet(\.?.string))
//        }
//        XCTAssertEqual(partial[\.optionalStringWrapper], "Initial optional value")

        var partialStringWrapper = Partial<StringWrapper>()
        partialStringWrapper.string = "New value"
        try partial.setValue(partialStringWrapper, for: \.stringWrapper)
        XCTAssertEqual(partial[\.stringWrapper], "New value")
    }

    func testSettingPartialConvertibleValueWithCustomUnwrapper() throws {
        var partial = Partial<StringWrapperWrapper>()
        partial[\.stringWrapper] = "Initial value"

        enum TestError: Error {
            case testError
        }

        XCTAssertThrowsError(try partial.setValue(Partial<StringWrapper>(), for: \.stringWrapper) { _ in
            throw TestError.testError
        }) { thrownError in
            XCTAssertEqual(thrownError as? TestError, .testError)
        }

        XCTAssertEqual(partial[\.stringWrapper], "Initial value")

        partial.setValue(Partial<StringWrapper>(), for: \.stringWrapper) { _ in
            return "Custom value"
        }

        XCTAssertEqual(partial[\.stringWrapper], "Custom value")
    }
}

//extension PartialProtocol {
//    /// Attempts to update the stored value for the given key path by unwrapping the provided partial value. If the
//    /// unwrapping fails the error will be thrown.
//    ///
//    /// - Parameter partial: A partial wrapping a value of type `Value`.
//    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value?`.
//    /// - Parameter unwrapper: A closure that will be called to unwrap the passed partial.
//    mutating func setValue(
//        _ partial: Partial<StringWrapper?>,
//        for keyPath: KeyPath<StringWrapperWrapper, StringWrapper?>,
//        unwrapper: (_ partial: Partial<StringWrapper?>) throws -> StringWrapper?
//    ) rethrows {
//        if let value = partial.
//        let value = try unwrapper(partial)
//        setValue(value, for: keyPath)
//    }
//}
