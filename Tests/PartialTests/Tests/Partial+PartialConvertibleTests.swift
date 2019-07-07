import Quick
import Nimble

@testable
import Partial

final class Partial_PartialConvertibleTests: QuickSpec {

    override func spec() {
        describe("Partial+PartialConvertible") {
            var partial: Partial<StringWrapperWrapper>!

            beforeEach {
                partial = Partial()
            }

            context("a non-optional key path") {
                let keyPath = \StringWrapperWrapper.stringWrapper
                var initialValue: StringWrapper!

                beforeEach {
                    initialValue = "initial value"
                    partial.setValue(initialValue, for: keyPath)
                }

                context("set no an incomplete Partial") {
                    var thrownError: Error?

                    beforeEach {
                        do {
                            try partial.setValue(Partial<StringWrapper>(), for: keyPath)
                        } catch {
                            thrownError = error
                        }
                    }

                    afterEach {
                        thrownError = nil
                    }

                    it("should throw a `keyPathNotSet` error") {
                        let expectedError = Partial<StringWrapper>.Error.keyPathNotSet(\.string)
                        expect(thrownError).to(matchError(expectedError))
                    }

                    it("should not overwrite the value") {
                        expect(partial[keyPath]) == initialValue
                    }
                }

                context("set to a complete partial") {
                    var unwrappedValue: StringWrapper!
                    var thrownError: Error?

                    beforeEach {
                        unwrappedValue = "unwrapped value"

                        do {
                            var partialStringWrapper = Partial<StringWrapper>()
                            partialStringWrapper[\.string] = unwrappedValue.string
                            try partial.setValue(partialStringWrapper, for: keyPath)
                        } catch {
                            thrownError = error
                        }
                    }

                    it("should not throw an error") {
                        expect(thrownError).to(beNil())
                    }

                    it("should set the key path to the unwrapped value") {
                        expect(partial[keyPath]) == unwrappedValue
                    }
                }
            }

            context("an optional key path") {
                let keyPath = \StringWrapperWrapper.optionalStringWrapper
                var initialValue: StringWrapper!

                beforeEach {
                    initialValue = "initial value"
                    partial.setValue(initialValue, for: keyPath)
                }

                context("set no an incomplete Partial") {
                    var thrownError: Error?

                    beforeEach {
                        do {
                            try partial.setValue(Partial<StringWrapper>(), for: keyPath)
                        } catch {
                            thrownError = error
                        }
                    }

                    afterEach {
                        thrownError = nil
                    }

                    it("should throw a `keyPathNotSet` error") {
                        let expectedError = Partial<StringWrapper>.Error.keyPathNotSet(\.string)
                        expect(thrownError).to(matchError(expectedError))
                    }

                    it("should not overwrite the value") {
                        expect(partial[keyPath]) == initialValue
                    }
                }

                context("set to a complete partial") {
                    var unwrappedValue: StringWrapper!
                    var thrownError: Error?

                    beforeEach {
                        unwrappedValue = "unwrapped value"

                        do {
                            var partialStringWrapper = Partial<StringWrapper>()
                            partialStringWrapper[\.string] = unwrappedValue.string
                            try partial.setValue(partialStringWrapper, for: keyPath)
                        } catch {
                            thrownError = error
                        }
                    }

                    it("should not throw an error") {
                        expect(thrownError).to(beNil())
                    }

                    it("should set the key path to the unwrapped value") {
                        expect(partial[keyPath]) == unwrappedValue
                    }
                }
            }

            context("unwrappedValue()") {
                it("should throw the error thrown by Wrapped.init(partial:)") {
                    let expectedError = Partial<StringWrapperWrapper>.Error.keyPathNotSet(\.stringWrapper)
                    expect { try partial.unwrappedValue() }.to(throwError(expectedError))
                }

                context("when the partial is complete") {
                    var unwrappedValue: StringWrapperWrapper?

                    beforeEach {
                        let stringWrapper = StringWrapper(stringLiteral: "string wrapper")
                        let optionaStringWrapper = StringWrapper(stringLiteral: "optional string wrapper")
                        unwrappedValue = StringWrapperWrapper(stringWrapper: stringWrapper, optionalStringWrapper: optionaStringWrapper)
                        partial[\.stringWrapper] = stringWrapper
                        partial[\.optionalStringWrapper] = optionaStringWrapper
                    }

                    it("should not throw an error") {
                        expect { try partial.unwrappedValue() }.toNot(throwError())
                    }

                    it("should return an unwrapped value") {
                        expect { try? partial.unwrappedValue() } == unwrappedValue
                    }
                }
            }
        }
    }

}
