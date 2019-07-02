import Quick
import Nimble

@testable
import Partial

final class PartialBuilderOptionalPartialConvertiblePropertyTests: QuickSpec {

    override func spec() {
        describe("PartialBuilder") {
            context("wrapping a type with an optional `PartialConvertible` property") {
                struct Wrapped {
                    struct Embedded: PartialConvertible, Equatable {
                        let string: String
                        init(string: String) {
                            self.string = string
                        }
                        init(partial: Partial<Wrapped.Embedded>) throws {
                            string = try partial.value(for: \.string)
                        }
                    }
                    let embedded: Embedded?
                }

                context("initialised without a backing value") {
                    var builder: PartialBuilder<Wrapped>!

                    beforeEach {
                        builder = PartialBuilder()
                    }

                    context("value(for:)") {
                        it("should throw a keyPathNotSet error") {
                            let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                            expect { try builder.value(for: \.embedded) }.to(throwError(expectedError))
                        }
                    }

                    context("the subscript") {
                        var result: Wrapped.Embedded??

                        beforeEach {
                            result = builder[\.embedded]
                        }

                        it("should return `nil`") {
                            expect(result).to(beNil())
                        }
                    }

                    #if swift(>=5.1)
                    context("dynamic member lookup") {
                        var result: Wrapped.Embedded??

                        beforeEach {
                            result = builder.embedded
                        }

                        it("should return `nil`") {
                            expect(result).to(beNil())
                        }
                    }
                    #endif

                    context("with the value set to nil via `setValue(_:for:)`") {
                        beforeEach {
                            builder.setValue(nil, for: \.embedded)
                        }

                        context("value(for:)") {
                            it("should not throw an error") {
                                expect { try builder.value(for: \.embedded) }.toNot(throwError())
                            }

                            it("should return `nil`") {
                                expect { try builder.value(for: \.embedded) }.to(beNil())
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = builder[\.embedded]
                            }

                            it("should return `nil` wrapped in an `Optional`") {
                                expect(result).to(beNilWrappedInOptional())
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = builder.embedded
                            }

                            it("should return `nil` wrapped in an `Optional`") {
                                expect(result).to(beNilWrappedInOptional())
                            }
                        }
                        #endif

                        context("then removed with removeValue(for:)") {
                            beforeEach {
                                builder.removeValue(for: \.embedded)
                            }

                            context("value(for:)") {
                                it("should throw a keyPathNotSet error") {
                                    let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                                    expect { try builder.value(for: \.embedded) }.to(throwError(expectedError))
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }
                            #endif
                        }

                        context("then removed via the subscript") {
                            beforeEach {
                                builder[\.embedded] = nil
                            }

                            context("value(for:)") {
                                it("should throw a keyPathNotSet error") {
                                    let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                                    expect { try builder.value(for: \.embedded) }.to(throwError(expectedError))
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }
                            #endif
                        }

                        #if swift(>=5.1)
                        context("then removed via dynamic member lookup") {
                            beforeEach {
                                builder.embedded = nil
                            }

                            context("value(for:)") {
                                it("should throw a keyPathNotSet error") {
                                    let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                                    expect { try builder.value(for: \.embedded) }.to(throwError(expectedError))
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }

                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }
                        }
                        #endif
                    }

                    context("with the value set to nil via the subscript") {
                        beforeEach {
                            builder[\.embedded] = Wrapped.Embedded?.none
                        }

                        context("value(for:)") {
                            it("should not throw an error") {
                                expect { try builder.value(for: \.embedded) }.toNot(throwError())
                            }

                            it("should return `nil`") {
                                expect { try builder.value(for: \.embedded) }.to(beNil())
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = builder[\.embedded]
                            }

                            it("should return `nil` wrapped in an `Optional`") {
                                expect(result).to(beNilWrappedInOptional())
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = builder.embedded
                            }

                            it("should return `nil` wrapped in an `Optional`") {
                                expect(result).to(beNilWrappedInOptional())
                            }
                        }
                        #endif

                        context("then removed with removeValue(for:)") {
                            beforeEach {
                                builder.removeValue(for: \.embedded)
                            }

                            context("value(for:)") {
                                it("should throw a keyPathNotSet error") {
                                    let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                                    expect { try builder.value(for: \.embedded) }.to(throwError(expectedError))
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }
                            #endif
                        }

                        context("then removed via the subscript") {
                            beforeEach {
                                builder[\.embedded] = nil
                            }

                            context("value(for:)") {
                                it("should throw a keyPathNotSet error") {
                                    let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                                    expect { try builder.value(for: \.embedded) }.to(throwError(expectedError))
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }
                            #endif
                        }

                        #if swift(>=5.1)
                        context("then removed via dynamic member lookup") {
                            beforeEach {
                                builder.embedded = nil
                            }

                            context("value(for:)") {
                                it("should throw a keyPathNotSet error") {
                                    let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                                    expect { try builder.value(for: \.embedded) }.to(throwError(expectedError))
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }

                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }
                        }
                        #endif
                    }

                    #if swift(>=5.1)
                    context("with the value set to nil via dynamic member lookup") {
                        beforeEach {
                            builder.embedded = Wrapped.Embedded?.none
                        }

                        context("value(for:)") {
                            it("should not throw an error") {
                                expect { try builder.value(for: \.embedded) }.toNot(throwError())
                            }

                            it("should return `nil`") {
                                expect { try builder.value(for: \.embedded) }.to(beNil())
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = builder[\.embedded]
                            }

                            it("should return `nil` wrapped in an `Optional`") {
                                expect(result).to(beNilWrappedInOptional())
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = builder.embedded
                            }

                            it("should return `nil` wrapped in an `Optional`") {
                                expect(result).to(beNilWrappedInOptional())
                            }
                        }
                        #endif

                        context("then removed with removeValue(for:)") {
                            beforeEach {
                                builder.removeValue(for: \.embedded)
                            }

                            context("value(for:)") {
                                it("should throw a keyPathNotSet error") {
                                    let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                                    expect { try builder.value(for: \.embedded) }.to(throwError(expectedError))
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }
                            #endif
                        }

                        context("then removed via the subscript") {
                            beforeEach {
                                builder[\.embedded] = nil
                            }

                            context("value(for:)") {
                                it("should throw a keyPathNotSet error") {
                                    let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                                    expect { try builder.value(for: \.embedded) }.to(throwError(expectedError))
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }
                            #endif
                        }

                        #if swift(>=5.1)
                        context("then removed via dynamic member lookup") {
                            beforeEach {
                                builder.embedded = nil
                            }

                            context("value(for:)") {
                                it("should throw a keyPathNotSet error") {
                                    let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                                    expect { try builder.value(for: \.embedded) }.to(throwError(expectedError))
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }

                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }
                        }
                        #endif
                    }
                    #endif

                    context("with the value set to an instance of the propery's type via `setValue(_:for:)`") {
                        var valueSet: Wrapped.Embedded!

                        beforeEach {
                            valueSet = Wrapped.Embedded(string: "test")
                            builder.setValue(valueSet, for: \.embedded)
                        }

                        context("value(for:)") {
                            it("should not throw an error") {
                                expect { try builder.value(for: \.embedded) }.toNot(throwError())
                            }

                            it("should return the set value") {
                                expect { try builder.value(for: \.embedded) }.to(equal(valueSet))
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = builder[\.embedded]
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = builder.embedded
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }
                        #endif

                        context("then removed with removeValue(for:)") {
                            beforeEach {
                                builder.removeValue(for: \.embedded)
                            }

                            context("value(for:)") {
                                it("should throw a keyPathNotSet error") {
                                    let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                                    expect { try builder.value(for: \.embedded) }.to(throwError(expectedError))
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }
                            #endif
                        }

                        context("then removed via the subscript") {
                            beforeEach {
                                builder[\.embedded] = nil
                            }

                            context("value(for:)") {
                                it("should throw a keyPathNotSet error") {
                                    let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                                    expect { try builder.value(for: \.embedded) }.to(throwError(expectedError))
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }
                            #endif
                        }

                        #if swift(>=5.1)
                        context("then removed via dynamic member lookup") {
                            beforeEach {
                                builder.embedded = nil
                            }

                            context("value(for:)") {
                                it("should throw a keyPathNotSet error") {
                                    let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                                    expect { try builder.value(for: \.embedded) }.to(throwError(expectedError))
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }

                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }
                        }
                        #endif
                    }

                    context("with the value set to an instance of the propery's type via the subscript") {
                        var valueSet: Wrapped.Embedded!

                        beforeEach {
                            valueSet = Wrapped.Embedded(string: "test")
                            builder[\.embedded] = valueSet
                        }

                        context("value(for:)") {
                            it("should not throw an error") {
                                expect { try builder.value(for: \.embedded) }.toNot(throwError())
                            }

                            it("should return the set value") {
                                expect { try builder.value(for: \.embedded) }.to(equal(valueSet))
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = builder[\.embedded]
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = builder.embedded
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }
                        #endif

                        context("then removed with removeValue(for:)") {
                            beforeEach {
                                builder.removeValue(for: \.embedded)
                            }

                            context("value(for:)") {
                                it("should throw a keyPathNotSet error") {
                                    let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                                    expect { try builder.value(for: \.embedded) }.to(throwError(expectedError))
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }
                            #endif
                        }

                        context("then removed via the subscript") {
                            beforeEach {
                                builder[\.embedded] = nil
                            }

                            context("value(for:)") {
                                it("should throw a keyPathNotSet error") {
                                    let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                                    expect { try builder.value(for: \.embedded) }.to(throwError(expectedError))
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }
                            #endif
                        }

                        #if swift(>=5.1)
                        context("then removed via dynamic member lookup") {
                            beforeEach {
                                builder.embedded = nil
                            }

                            context("value(for:)") {
                                it("should throw a keyPathNotSet error") {
                                    let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                                    expect { try builder.value(for: \.embedded) }.to(throwError(expectedError))
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }

                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }
                        }
                        #endif
                    }

                    #if swift(>=5.1)
                    context("with the value set to an instance of the propery's type via dynamic member lookup") {
                        var valueSet: Wrapped.Embedded!

                        beforeEach {
                            valueSet = Wrapped.Embedded(string: "test")
                            builder.embedded = valueSet
                        }

                        context("value(for:)") {
                            it("should not throw an error") {
                                expect { try builder.value(for: \.embedded) }.toNot(throwError())
                            }

                            it("should return the set value") {
                                expect { try builder.value(for: \.embedded) }.to(equal(valueSet))
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = builder[\.embedded]
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = builder.embedded
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }
                        #endif

                        context("then removed with removeValue(for:)") {
                            beforeEach {
                                builder.removeValue(for: \.embedded)
                            }

                            context("value(for:)") {
                                it("should throw a keyPathNotSet error") {
                                    let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                                    expect { try builder.value(for: \.embedded) }.to(throwError(expectedError))
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }
                            #endif
                        }

                        context("then removed via the subscript") {
                            beforeEach {
                                builder[\.embedded] = nil
                            }

                            context("value(for:)") {
                                it("should throw a keyPathNotSet error") {
                                    let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                                    expect { try builder.value(for: \.embedded) }.to(throwError(expectedError))
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }
                            #endif
                        }

                        #if swift(>=5.1)
                        context("then removed via dynamic member lookup") {
                            beforeEach {
                                builder.embedded = nil
                            }

                            context("value(for:)") {
                                it("should throw a keyPathNotSet error") {
                                    let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                                    expect { try builder.value(for: \.embedded) }.to(throwError(expectedError))
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }

                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }
                        }
                        #endif
                    }
                    #endif
                }
            }
        }
    }
}
