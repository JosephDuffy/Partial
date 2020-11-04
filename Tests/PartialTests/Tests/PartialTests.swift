import Quick
import Nimble

@testable
import Partial

final class PartialTests: QuickSpec {

    override func spec() {
        describe("Partial") {
            var partial: Partial<StringWrapperWrapper>!

            beforeEach {
                partial = Partial()
            }

            context("description") {
                it("should include the name of the wrapping type") {
                    expect(String(describing: partial)).to(contain(String(describing: StringWrapperWrapper.self)))
                }
            }

            context("a non-optional key path that has not been set") {
                let keyPath = \StringWrapperWrapper.stringWrapper

                context("value(for:)") {
                    it("should throw a `keyPathNotSet` error") {
                        let expectedError = Partial<StringWrapperWrapper>.Error.keyPathNotSet(keyPath)
                        expect(expression: { try partial.value(for: keyPath) }).to(throwError(expectedError))
                    }
                }

                context("subscript") {
                    it("should return `nil`") {
                        expect(partial[keyPath]).to(beNil())
                    }
                }

                context("dynamic member lookup") {
                    it("should return `nil`") {
                        expect(partial[dynamicMember: keyPath]).to(beNil())
                    }
                }
            }

            context("an optional key path that has not been set") {
                let keyPath = \StringWrapperWrapper.optionalStringWrapper

                context("value(for:)") {
                    it("should throw a `keyPathNotSet` error") {
                        let expectedError = Partial<StringWrapperWrapper>.Error.keyPathNotSet(keyPath)
                        expect(expression: { try partial.value(for: keyPath) }).to(throwError(expectedError))
                    }
                }

                context("subscript") {
                    it("should return `nil`") {
                        expect(partial[keyPath]).to(beNil())
                    }
                }

                context("dynamic member lookup") {
                    it("should return `nil`") {
                        expect(partial[dynamicMember: keyPath]).to(beNil())
                    }
                }
            }

            context("a non-optional key path that has been set") {
                let keyPath = \StringWrapperWrapper.stringWrapper
                var newValue: StringWrapper!

                beforeEach {
                    newValue = "new value"
                    partial.setValue(newValue, for: keyPath)
                }

                context("value(for:)") {
                    it("should not throw an error") {
                        expect(expression: { try partial.value(for: keyPath) }).toNot(throwError())
                    }

                    it("should return the set value") {
                        expect(expression: { try partial.value(for: keyPath) }) == newValue
                    }
                }

                context("subscript") {
                    it("should return the set value") {
                        expect(partial[keyPath]) == newValue
                    }
                }

                context("dynamic member lookup") {
                    it("should return the set value") {
                        expect(partial[dynamicMember: keyPath]) == newValue
                    }
                }

                context("description") {
                    it("should include description of the set value") {
                        expect(String(describing: partial)).to(contain(String(describing: newValue!)))
                    }
                }

                context("removeValue(for:)") {
                    beforeEach {
                        partial.removeValue(for: keyPath)
                    }

                    it("should cause the value to be unset") {
                        let expectedError = Partial<StringWrapperWrapper>.Error.keyPathNotSet(keyPath)
                        expect(expression: { try partial.value(for: keyPath) }).to(throwError(expectedError))
                    }
                }
            }

            context("an optional key path that has been set to a non-nil value") {
                let keyPath = \StringWrapperWrapper.optionalStringWrapper
                var newValue: StringWrapper!

                beforeEach {
                    newValue = "new value"
                    partial.setValue(newValue, for: keyPath)
                }

                context("value(for:)") {
                    it("should not throw an error") {
                        expect(expression: { try partial.value(for: keyPath) }).toNot(throwError())
                    }

                    it("should return the set value") {
                        expect(expression: { try partial.value(for: keyPath) }) == newValue
                    }
                }

                context("subscript") {
                    it("should return the set value") {
                        expect(partial[keyPath]) == newValue
                    }
                }

                context("dynamic member lookup") {
                    it("should return the set value") {
                        expect(partial[dynamicMember: keyPath]) == newValue
                    }
                }

                context("removeValue(for:)") {
                    beforeEach {
                        partial.removeValue(for: keyPath)
                    }

                    it("should cause the value to be unset") {
                        let expectedError = Partial<StringWrapperWrapper>.Error.keyPathNotSet(keyPath)
                        expect(expression: { try partial.value(for: keyPath) }).to(throwError(expectedError))
                    }
                }
            }

            context("an optional key path that has been set to `nil`") {
                let keyPath = \StringWrapperWrapper.optionalStringWrapper

                beforeEach {
                    partial.setValue(nil, for: keyPath)
                }

                context("value(for:)") {
                    it("should not throw an error") {
                        expect(expression: { try partial.value(for: keyPath) }).toNot(throwError())
                    }

                    it("should return `nil`") {
                        expect(expression: { try partial.value(for: keyPath) }).to(beNil())
                    }
                }

                context("subscript") {
                    it("should return `nil` wrapped in an Optional") {
                        expect(partial[keyPath]).to(beNilWrappedInOptional())
                    }
                }

                context("dynamic member lookup") {
                    it("should return `nil` wrapped in an Optional") {
                        expect(partial[dynamicMember: keyPath]).to(beNilWrappedInOptional())
                    }
                }

                context("removeValue(for:)") {
                    beforeEach {
                        partial.removeValue(for: keyPath)
                    }

                    it("should cause the value to be unset") {
                        let expectedError = Partial<StringWrapperWrapper>.Error.keyPathNotSet(keyPath)
                        expect(expression: { try partial.value(for: keyPath) }).to(throwError(expectedError))
                    }
                }
            }

            context("a non-optional key path set with the subscript") {
                let keyPath = \StringWrapperWrapper.stringWrapper
                var newValue: StringWrapper!

                beforeEach {
                    newValue = "new value"
                    partial[keyPath] = newValue
                }

                it("should be returned by value(for:)") {
                    expect(expression: { try partial.value(for: keyPath) }) == newValue
                }
            }

            context("an optional key path set to a non-nil with the subscript") {
                let keyPath = \StringWrapperWrapper.optionalStringWrapper
                var newValue: StringWrapper!

                beforeEach {
                    newValue = "new value"
                    partial[keyPath] = newValue
                }

                it("should be returned by value(for:)") {
                    expect(expression: { try partial.value(for: keyPath) }) == newValue
                }
            }

            context("an optional key path set to `nil` wrapped in an `Optional` with the subscript") {
                let keyPath = \StringWrapperWrapper.optionalStringWrapper

                beforeEach {
                    partial[keyPath] = StringWrapper?.none
                }

                it("should be returned by value(for:)") {
                    expect(expression: { try partial.value(for: keyPath) }).to(beNil())
                }
            }

            context("setting a non-optional key path set to `nil` with the subscript") {
                let keyPath = \StringWrapperWrapper.stringWrapper

                beforeEach {
                    partial[keyPath] = "first value"
                    partial[keyPath] = nil
                }

                it("should remove the value") {
                    expect(expression: { try? partial.value(for: keyPath) }).to(beNil())
                }
            }

            context("setting an optional key path set to a `nil` with the subscript") {
                let keyPath = \StringWrapperWrapper.optionalStringWrapper

                beforeEach {
                    partial[keyPath] = "first value"
                    partial[keyPath] = nil
                }

                it("should remove the value") {
                    expect(expression: { try? partial.value(for: keyPath) }).to(beNil())
                }
            }

            context("a non-optional key path set with dynamic member lookup") {
                let keyPath = \StringWrapperWrapper.stringWrapper
                var newValue: StringWrapper!

                beforeEach {
                    newValue = "new value"
                    partial[dynamicMember: keyPath] = newValue
                }

                it("should be returned by value(for:)") {
                    expect(expression: { try partial.value(for: keyPath) }) == newValue
                }
            }

            context("an optional key path set to a non-nil with dynamic member lookup") {
                let keyPath = \StringWrapperWrapper.optionalStringWrapper
                var newValue: StringWrapper!

                beforeEach {
                    newValue = "new value"
                    partial[dynamicMember: keyPath] = newValue
                }

                it("should be returned by value(for:)") {
                    expect(expression: { try partial.value(for: keyPath) }) == newValue
                }
            }

            context("an optional key path set to `nil` wrapped in an `Optional` with dynamic member lookup") {
                let keyPath = \StringWrapperWrapper.optionalStringWrapper

                beforeEach {
                    partial[dynamicMember: keyPath] = StringWrapper?.none
                }

                it("should be returned by value(for:)") {
                    expect(expression: { try partial.value(for: keyPath) }).to(beNil())
                }
            }

            context("setting a non-optional key path set to `nil` with dynamic member lookup") {
                let keyPath = \StringWrapperWrapper.stringWrapper

                beforeEach {
                    partial[dynamicMember: keyPath] = "first value"
                    partial[dynamicMember: keyPath] = nil
                }

                it("should remove the value") {
                    expect(expression: { try? partial.value(for: keyPath) }).to(beNil())
                }
            }

            context("setting an optional key path set to a `nil` with dynamic member lookup") {
                let keyPath = \StringWrapperWrapper.optionalStringWrapper

                beforeEach {
                    partial[keyPath] = "first value"
                    partial[keyPath] = nil
                }

                it("should remove the value") {
                    expect(expression: { try? partial.value(for: keyPath) }).to(beNil())
                }
            }
        }
    }

}
