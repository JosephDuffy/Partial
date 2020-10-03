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

            context("description") {
                it("should include the name of the wrapping type") {
                    expect(String(describing: builder)).to(contain(String(describing: StringWrapperWrapper.self)))
                }
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

                context("dynamic member lookup") {
                    it("should return `nil`") {
                        expect(builder[dynamicMember: keyPath]).to(beNil())
                    }
                }
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

                context("dynamic member lookup") {
                    it("should return `nil`") {
                        expect(builder[dynamicMember: keyPath]).to(beNil())
                    }
                }
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

                context("dynamic member lookup") {
                    it("should return the set value") {
                        expect(builder[dynamicMember: keyPath]) == newValue
                    }
                }

                context("description") {
                    it("should include description of the set value") {
                        expect(String(describing: builder)).to(contain(String(describing: newValue!)))
                    }
                }

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

                context("dynamic member lookup") {
                    it("should return the set value") {
                        expect(builder[dynamicMember: keyPath]) == newValue
                    }
                }

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

                context("dynamic member lookup") {
                    it("should return `nil` wrapped in an Optional") {
                        expect(builder[dynamicMember: keyPath]).to(beNilWrappedInOptional())
                    }
                }

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
            
            context("creating a builder for a property") {
                struct Root {
                    let name: StringWrapper
                }
                
                var rootBuilder: PartialBuilder<Root>!
                var nameBuilder: AttachedPartialBuilder<StringWrapper>!
                
                beforeEach {
                    rootBuilder = PartialBuilder<Root>()
                    nameBuilder = rootBuilder.builder(for: \.name)
                    nameBuilder.setValue("foo", for: \.string)
                }

                it("updates the original builder") {
                    expect(rootBuilder.name?.string).to(equal("foo"))
                }
                
                it("stops updating the original builder after detaching") {
                    nameBuilder.detach()
                    nameBuilder.setValue("bar", for: \.string)
                    expect(rootBuilder.name).to(equal("foo"))
                }
                
                it("resets original builder value to nil after becoming invalid") {
                    nameBuilder.removeValue(for: \.string)
                    expect(rootBuilder.name).to(beNil())
                }
            }
        }
    }

}
