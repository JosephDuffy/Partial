import Quick
import Nimble

@testable
import Partial

final class PartialBuilder_PartialConvertibleTests: QuickSpec {

    override func spec() {
        describe("PartialBuilder+PartialConvertible") {
            var builder: PartialBuilder<StringWrapperWrapper>!

            beforeEach {
                builder = PartialBuilder()
            }

            context("a non-optional key path") {
                let keyPath = \StringWrapperWrapper.stringWrapper
                var initialValue: StringWrapper!

                beforeEach {
                    initialValue = "initial value"
                    builder.setValue(initialValue, for: keyPath)
                }

                context("set no an incomplete Partial") {
                    var thrownError: Error?

                    beforeEach {
                        do {
                            try builder.setValue(Partial<StringWrapper>(), for: keyPath)
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
                        expect(builder[keyPath]) == initialValue
                    }
                }

                context("set to a complete partial") {
                    var unwrapped: StringWrapper!
                    var thrownError: Error?

                    beforeEach {
                        unwrapped = "unwrapped value"

                        do {
                            var partialStringWrapper = Partial<StringWrapper>()
                            partialStringWrapper[\.string] = unwrapped.string
                            try builder.setValue(partialStringWrapper, for: keyPath)
                        } catch {
                            thrownError = error
                        }
                    }

                    it("should not throw an error") {
                        expect(thrownError).to(beNil())
                    }

                    it("should set the key path to the unwrapped value") {
                        expect(builder[keyPath]) == unwrapped
                    }
                }

                context("set with a custom unwrapper") {
                    context("that throws an error") {
                        enum TestError: Error {
                            case testError
                        }

                        var thrownError: Error!

                        beforeEach {
                            do {
                                try builder.setValue(Partial<StringWrapper>(), for: keyPath) { _ in
                                    throw TestError.testError
                                }
                            } catch {
                                thrownError = error
                            }
                        }

                        afterEach {
                            thrownError = nil
                        }

                        it("should throw errors thrown by the unwrapper") {
                            expect(thrownError).to(matchError(TestError.testError))
                        }
                    }

                    context("that returns a value") {
                        var returnedValue: StringWrapper!

                        beforeEach {
                            returnedValue = "returned value"
                            builder.setValue(Partial<StringWrapper>(), for: keyPath) { _ in
                                return returnedValue
                            }
                        }
                        it("should set the key path to the value returned by the unwrapper") {
                            expect(builder[keyPath]) == returnedValue
                        }
                    }
                }
            }

            context("an optional key path") {
                let keyPath = \StringWrapperWrapper.optionalStringWrapper
                var initialValue: StringWrapper!

                beforeEach {
                    initialValue = "initial value"
                    builder.setValue(initialValue, for: keyPath)
                }

                context("set no an incomplete Partial") {
                    var thrownError: Error?

                    beforeEach {
                        do {
                            try builder.setValue(Partial<StringWrapper>(), for: keyPath)
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
                        expect(builder[keyPath]) == initialValue
                    }
                }

                context("set to a complete partial") {
                    var unwrapped: StringWrapper!
                    var thrownError: Error?

                    beforeEach {
                        unwrapped = "unwrapped value"

                        do {
                            var partialStringWrapper = Partial<StringWrapper>()
                            partialStringWrapper[\.string] = unwrapped.string
                            try builder.setValue(partialStringWrapper, for: keyPath)
                        } catch {
                            thrownError = error
                        }
                    }

                    it("should not throw an error") {
                        expect(thrownError).to(beNil())
                    }

                    it("should set the key path to the unwrapped value") {
                        expect(builder[keyPath]) == unwrapped
                    }
                }

                context("set with a custom unwrapper") {
                    context("that throws an error") {
                        enum TestError: Error {
                            case testError
                        }

                        var thrownError: Error!

                        beforeEach {
                            do {
                                try builder.setValue(Partial<StringWrapper>(), for: keyPath) { _ in
                                    throw TestError.testError
                                }
                            } catch {
                                thrownError = error
                            }
                        }

                        afterEach {
                            thrownError = nil
                        }

                        it("should throw errors thrown by the unwrapper") {
                            expect(thrownError).to(matchError(TestError.testError))
                        }
                    }

                    context("that returns a value") {
                        var returnedValue: StringWrapper!

                        beforeEach {
                            returnedValue = "returned value"
                            builder.setValue(Partial<StringWrapper>(), for: keyPath) { _ in
                                return returnedValue
                            }
                        }
                        it("should set the key path to the value returned by the unwrapper") {
                            expect(builder[keyPath]) == returnedValue
                        }
                    }
                }
            }

            context("unwrapped()") {
                it("should throw the error thrown by Wrapped.init(partial:)") {
                    let expectedError = Partial<StringWrapperWrapper>.Error.keyPathNotSet(\.stringWrapper)
                    expect({ try builder.unwrapped() }).to(throwError(expectedError))
                }

                context("when the partial is complete") {
                    var unwrapped: StringWrapperWrapper?

                    beforeEach {
                        let stringWrapper = StringWrapper(stringLiteral: "string wrapper")
                        let optionaStringWrapper = StringWrapper(stringLiteral: "optional string wrapper")
                        unwrapped = StringWrapperWrapper(stringWrapper: stringWrapper, optionalStringWrapper: optionaStringWrapper)
                        builder[\.stringWrapper] = stringWrapper
                        builder[\.optionalStringWrapper] = optionaStringWrapper
                    }

                    it("should not throw an error") {
                        expect({ try builder.unwrapped() }).toNot(throwError())
                    }

                    it("should return an unwrapped value") {
                        expect({ try? builder.unwrapped() }) == unwrapped
                    }
                }
            }
        }
    }

}
