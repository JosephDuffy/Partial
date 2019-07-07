import Quick
import Nimble

@testable
import Partial

final class PartialBuilderTests: QuickSpec {

    override func spec() {
        describe("PartialBuilder") {
            var builder: PartialBuilder<StringWrapperWrapper>!

            beforeEach {
                builder = PartialBuilder()
            }

            context("a non-optional key path that has not been set") {
                let keyPath = \StringWrapperWrapper.stringWrapper

                context("value(for:)") {
                    it("should throw a `keyPathNotSet` error") {
                        let expectedError = Partial<StringWrapperWrapper>.Error.keyPathNotSet(keyPath)
                        expect { try builder.value(for: keyPath) }.to(throwError(expectedError))
                    }
                }

                context("subscript") {
                    it("should return `nil`") {
                        expect(builder[keyPath]).to(beNil())
                    }
                }

                #if swift(>=5.1)
                context("dynamic member lookup") {
                    it("should return `nil`") {
                        expect(builder[dynamicMember: keyPath]).to(beNil())
                    }
                }
                #endif
            }

            context("an optional key path that has not been set") {
                let keyPath = \StringWrapperWrapper.optionalStringWrapper

                context("value(for:)") {
                    it("should throw a `keyPathNotSet` error") {
                        let expectedError = Partial<StringWrapperWrapper>.Error.keyPathNotSet(keyPath)
                        expect { try builder.value(for: keyPath) }.to(throwError(expectedError))
                    }
                }

                context("subscript") {
                    it("should return `nil`") {
                        expect(builder[keyPath]).to(beNil())
                    }
                }

                #if swift(>=5.1)
                context("dynamic member lookup") {
                    it("should return `nil`") {
                        expect(builder[dynamicMember: keyPath]).to(beNil())
                    }
                }
                #endif
            }

            context("a non-optional key path that has been set") {
                let keyPath = \StringWrapperWrapper.stringWrapper
                var newValue: StringWrapper!

                beforeEach {
                    newValue = "new value"
                    builder.setValue(newValue, for: keyPath)
                }

                context("value(for:)") {
                    it("should not throw an error") {
                        expect { try builder.value(for: keyPath) }.toNot(throwError())
                    }

                    it("should return the set value") {
                        expect { try builder.value(for: keyPath) } == newValue
                    }
                }

                context("subscript") {
                    it("should return the set value") {
                        expect(builder[keyPath]) == newValue
                    }
                }

                #if swift(>=5.1)
                context("dynamic member lookup") {
                    it("should return the set value") {
                        expect(builder[dynamicMember: keyPath]) == newValue
                    }
                }
                #endif

                context("removeValue(for:)") {
                    beforeEach {
                        builder.removeValue(for: keyPath)
                    }

                    it("should cause the value to be unset") {
                        let expectedError = Partial<StringWrapperWrapper>.Error.keyPathNotSet(keyPath)
                        expect { try builder.value(for: keyPath) }.to(throwError(expectedError))
                    }
                }
            }

            context("an optional key path that has been set to a non-nil value") {
                let keyPath = \StringWrapperWrapper.optionalStringWrapper
                var newValue: StringWrapper!

                beforeEach {
                    newValue = "new value"
                    builder.setValue(newValue, for: keyPath)
                }

                context("value(for:)") {
                    it("should not throw an error") {
                        expect { try builder.value(for: keyPath) }.toNot(throwError())
                    }

                    it("should return the set value") {
                        expect { try builder.value(for: keyPath) } == newValue
                    }
                }

                context("subscript") {
                    it("should return the set value") {
                        expect(builder[keyPath]) == newValue
                    }
                }

                #if swift(>=5.1)
                context("dynamic member lookup") {
                    it("should return the set value") {
                        expect(builder[dynamicMember: keyPath]) == newValue
                    }
                }
                #endif

                context("removeValue(for:)") {
                    beforeEach {
                        builder.removeValue(for: keyPath)
                    }

                    it("should cause the value to be unset") {
                        let expectedError = Partial<StringWrapperWrapper>.Error.keyPathNotSet(keyPath)
                        expect { try builder.value(for: keyPath) }.to(throwError(expectedError))
                    }
                }
            }

            context("an optional key path that has been set to `nil`") {
                let keyPath = \StringWrapperWrapper.optionalStringWrapper

                beforeEach {
                    builder.setValue(nil, for: keyPath)
                }

                context("value(for:)") {
                    it("should not throw an error") {
                        expect { try builder.value(for: keyPath) }.toNot(throwError())
                    }

                    it("should return `nil`") {
                        expect { try builder.value(for: keyPath) }.to(beNil())
                    }
                }

                context("subscript") {
                    it("should return `nil` wrapped in an Optional") {
                        expect(builder[keyPath]).to(beNilWrappedInOptional())
                    }
                }

                #if swift(>=5.1)
                context("dynamic member lookup") {
                    it("should return `nil` wrapped in an Optional") {
                        expect(builder[dynamicMember: keyPath]).to(beNilWrappedInOptional())
                    }
                }
                #endif

                context("removeValue(for:)") {
                    beforeEach {
                        builder.removeValue(for: keyPath)
                    }

                    it("should cause the value to be unset") {
                        let expectedError = Partial<StringWrapperWrapper>.Error.keyPathNotSet(keyPath)
                        expect { try builder.value(for: keyPath) }.to(throwError(expectedError))
                    }
                }
            }

            context("a non-optional key path set with the subscript") {
                let keyPath = \StringWrapperWrapper.stringWrapper
                var newValue: StringWrapper!

                beforeEach {
                    newValue = "new value"
                    builder[keyPath] = newValue
                }

                it("should be returned by value(for:)") {
                    expect { try builder.value(for: keyPath) } == newValue
                }
            }

            context("an optional key path set to a non-nil with the subscript") {
                let keyPath = \StringWrapperWrapper.optionalStringWrapper
                var newValue: StringWrapper!

                beforeEach {
                    newValue = "new value"
                    builder[keyPath] = newValue
                }

                it("should be returned by value(for:)") {
                    expect { try builder.value(for: keyPath) } == newValue
                }
            }

            context("an optional key path set to `nil` wrapped in an `Optional` with the subscript") {
                let keyPath = \StringWrapperWrapper.optionalStringWrapper

                beforeEach {
                    builder[keyPath] = StringWrapper?.none
                }

                it("should be returned by value(for:)") {
                    expect { try builder.value(for: keyPath) }.to(beNil())
                }
            }

            context("setting a non-optional key path set to `nil` with the subscript") {
                let keyPath = \StringWrapperWrapper.stringWrapper

                beforeEach {
                    builder[keyPath] = "first value"
                    builder[keyPath] = nil
                }

                it("should remove the value") {
                    expect { try? builder.value(for: keyPath) }.to(beNil())
                }
            }

            context("setting an optional key path set to a `nil` with the subscript") {
                let keyPath = \StringWrapperWrapper.optionalStringWrapper

                beforeEach {
                    builder[keyPath] = "first value"
                    builder[keyPath] = nil
                }

                it("should remove the value") {
                    expect { try? builder.value(for: keyPath) }.to(beNil())
                }
            }

            #if swift(>=5.1)
            context("a non-optional key path set with dynamic member lookup") {
                let keyPath = \StringWrapperWrapper.stringWrapper
                var newValue: StringWrapper!

                beforeEach {
                    newValue = "new value"
                    builder[dynamicMember: keyPath] = newValue
                }

                it("should be returned by value(for:)") {
                    expect { try builder.value(for: keyPath) } == newValue
                }
            }

            context("an optional key path set to a non-nil with dynamic member lookup") {
                let keyPath = \StringWrapperWrapper.optionalStringWrapper
                var newValue: StringWrapper!

                beforeEach {
                    newValue = "new value"
                    builder[dynamicMember: keyPath] = newValue
                }

                it("should be returned by value(for:)") {
                    expect { try builder.value(for: keyPath) } == newValue
                }
            }

            context("an optional key path set to `nil` wrapped in an `Optional` with dynamic member lookup") {
                let keyPath = \StringWrapperWrapper.optionalStringWrapper

                beforeEach {
                    builder[dynamicMember: keyPath] = StringWrapper?.none
                }

                it("should be returned by value(for:)") {
                    expect { try builder.value(for: keyPath) }.to(beNil())
                }
            }

            context("setting a non-optional key path set to `nil` with dynamic member lookup") {
                let keyPath = \StringWrapperWrapper.stringWrapper

                beforeEach {
                    builder[dynamicMember: keyPath] = "first value"
                    builder[dynamicMember: keyPath] = nil
                }

                it("should remove the value") {
                    expect { try? builder.value(for: keyPath) }.to(beNil())
                }
            }

            context("setting an optional key path set to a `nil` with dynamic member lookup") {
                let keyPath = \StringWrapperWrapper.optionalStringWrapper

                beforeEach {
                    builder[keyPath] = "first value"
                    builder[keyPath] = nil
                }

                it("should remove the value") {
                    expect { try? builder.value(for: keyPath) }.to(beNil())
                }
            }
            #endif
        }
    }

}
