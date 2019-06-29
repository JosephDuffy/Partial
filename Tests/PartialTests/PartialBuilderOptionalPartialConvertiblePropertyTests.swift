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

                    context("partialValue(for:)") {
                        it("should return a partial without a value set") {
                            let result = builder.partialValue(for: \.embedded)
                            expect { try? result.value(for: \.string) }.to(beNil())
                        }

                        it("should return a partial without a backing value") {
                            let result = builder.partialValue(for: \.embedded)
                            expect(result.backingValue).to(beNil())
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

                        context("partialValue(for:)") {
                            it("should return a partial without a value set") {
                                let result = builder.partialValue(for: \.embedded)
                                expect { try? result.value(for: \.string) }.to(beNil())
                            }

                            it("should return a partial without a backing value") {
                                let result = builder.partialValue(for: \.embedded)
                                expect(result.backingValue).to(beNil())
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

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
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

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
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

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
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

                        context("partialValue(for:)") {
                            it("should return a partial without a value set") {
                                let result = builder.partialValue(for: \.embedded)
                                expect { try? result.value(for: \.string) }.to(beNil())
                            }

                            it("should return a partial without a backing value") {
                                let result = builder.partialValue(for: \.embedded)
                                expect(result.backingValue).to(beNil())
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

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
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

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
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

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
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

                        context("partialValue(for:)") {
                            it("should return a partial without a value set") {
                                let result = builder.partialValue(for: \.embedded)
                                expect { try? result.value(for: \.string) }.to(beNil())
                            }

                            it("should return a partial without a backing value") {
                                let result = builder.partialValue(for: \.embedded)
                                expect(result.backingValue).to(beNil())
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

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
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

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
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

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
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

                        context("partialValue(for:)") {
                            it("should return the a partial wrapping the set value") {
                                let result = builder.partialValue(for: \.embedded)
                                expect(result.backingValue) == valueSet
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

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
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

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
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

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
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

                        context("partialValue(for:)") {
                            it("should return the a partial wrapping the set value") {
                                let result = builder.partialValue(for: \.embedded)
                                expect(result.backingValue) == valueSet
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

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
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

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
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

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
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

                        context("partialValue(for:)") {
                            it("should return the a partial wrapping the set value") {
                                let result = builder.partialValue(for: \.embedded)
                                expect(result.backingValue) == valueSet
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

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
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

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
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

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
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

                    context("with the value set to a partial via `setValue(_:for:)`") {
                        var unwrappedValue: Wrapped.Embedded!
                        var valueSet: Partial<Wrapped.Embedded>!

                        beforeEach {
                            unwrappedValue = Wrapped.Embedded(string: "test")
                            valueSet = Partial<Wrapped.Embedded>()
                            valueSet.setValue(unwrappedValue.string, for: \.string)
                            builder.setValue(valueSet, for: \.embedded)
                        }

                        context("value(for:)") {
                            it("should not throw") {
                                expect { try builder.value(for: \.embedded) }.toNot(throwError())
                            }

                            it("should return an unwrapped value") {
                                expect { try builder.value(for: \.embedded) }.to(equal(unwrappedValue))
                            }
                        }

                        context("partialValue(for:)") {
                            it("should return the set partial") {
                                let result = builder.partialValue(for: \.embedded)
                                expect { try result.value(for: \.string) } == valueSet[\.string]
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = builder[\.embedded]
                            }

                            it("should return an unwrapped value") {
                                expect(result).to(equal(unwrappedValue))
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = builder.embedded
                            }

                            it("should return an unwrapped value") {
                                expect(result).to(equal(unwrappedValue))
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

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
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

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
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

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
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
                }

                context("initialised with a backing value") {
                    var backingValue: Wrapped!
                    var builder: PartialBuilder<Wrapped>!

                    beforeEach {
                        backingValue = Wrapped(embedded: Wrapped.Embedded(string: "backing-test"))
                        builder = PartialBuilder(backingValue: backingValue)
                    }

                    context("value(for:)") {
                        it("should not throw an error") {
                            expect { try builder.value(for: \.embedded) }.toNot(throwError())
                        }

                        it("should return the value from the backing value") {
                            expect { try builder.value(for: \.embedded) }.to(equal(backingValue.embedded))
                        }
                    }

                    context("partialValue(for:)") {
                        it("should return a partial backed by the value from the backing value") {
                            let result = builder.partialValue(for: \.embedded)
                            expect(result.backingValue) == backingValue.embedded
                        }
                    }

                    context("the subscript") {
                        var result: Wrapped.Embedded??

                        beforeEach {
                            result = builder[\.embedded]
                        }

                        it("should return the value from the backing value") {
                            expect(result) == backingValue.embedded
                        }
                    }

                    #if swift(>=5.1)
                    context("dynamic member lookup") {
                        var result: Wrapped.Embedded??

                        beforeEach {
                            result = builder.embedded
                        }

                        it("should return the value from the backing value") {
                            expect(result) == backingValue.embedded
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

                        context("partialValue(for:)") {
                            it("should return a partial without a value set") {
                                let result = builder.partialValue(for: \.embedded)
                                expect { try? result.value(for: \.string) }.to(beNil())
                            }

                            it("should return a partial without a backing value") {
                                let result = builder.partialValue(for: \.embedded)
                                expect(result.backingValue).to(beNil())
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
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return the value from the backing value") {
                                    expect { try builder.value(for: \.embedded) }.to(equal(backingValue.embedded))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial backed by the value from the backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue) == backingValue.embedded
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }
                            #endif
                        }

                        context("then removed via the subscript") {
                            beforeEach {
                                builder[\.embedded] = nil
                            }

                            context("value(for:)") {
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return the value from the backing value") {
                                    expect { try builder.value(for: \.embedded) }.to(equal(backingValue.embedded))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial backed by the value from the backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue) == backingValue.embedded
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
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
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return the value from the backing value") {
                                    expect { try builder.value(for: \.embedded) }.to(equal(backingValue.embedded))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial backed by the value from the backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue) == backingValue.embedded
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }

                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
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

                        context("partialValue(for:)") {
                            it("should return a partial without a value set") {
                                let result = builder.partialValue(for: \.embedded)
                                expect { try? result.value(for: \.string) }.to(beNil())
                            }

                            it("should return a partial without a backing value") {
                                let result = builder.partialValue(for: \.embedded)
                                expect(result.backingValue).to(beNil())
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
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return the value from the backing value") {
                                    expect { try builder.value(for: \.embedded) }.to(equal(backingValue.embedded))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial backed by the value from the backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue) == backingValue.embedded
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }
                            #endif
                        }

                        context("then removed via the subscript") {
                            beforeEach {
                                builder[\.embedded] = nil
                            }

                            context("value(for:)") {
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return the value from the backing value") {
                                    expect { try builder.value(for: \.embedded) }.to(equal(backingValue.embedded))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial backed by the value from the backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue) == backingValue.embedded
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
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
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return the value from the backing value") {
                                    expect { try builder.value(for: \.embedded) }.to(equal(backingValue.embedded))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial backed by the value from the backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue) == backingValue.embedded
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }

                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
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

                        context("partialValue(for:)") {
                            it("should return a partial without a value set") {
                                let result = builder.partialValue(for: \.embedded)
                                expect { try? result.value(for: \.string) }.to(beNil())
                            }

                            it("should return a partial without a backing value") {
                                let result = builder.partialValue(for: \.embedded)
                                expect(result.backingValue).to(beNil())
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
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return the value from the backing value") {
                                    expect { try builder.value(for: \.embedded) }.to(equal(backingValue.embedded))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial backed by the value from the backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue) == backingValue.embedded
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }
                            #endif
                        }

                        context("then removed via the subscript") {
                            beforeEach {
                                builder[\.embedded] = nil
                            }

                            context("value(for:)") {
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return the value from the backing value") {
                                    expect { try builder.value(for: \.embedded) }.to(equal(backingValue.embedded))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial backed by the value from the backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue) == backingValue.embedded
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
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
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return the value from the backing value") {
                                    expect { try builder.value(for: \.embedded) }.to(equal(backingValue.embedded))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial backed by the value from the backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue) == backingValue.embedded
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }

                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
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

                        context("partialValue(for:)") {
                            it("should return the a partial wrapping the set value") {
                                let result = builder.partialValue(for: \.embedded)
                                expect(result.backingValue) == valueSet
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
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return the value from the backing value") {
                                    expect { try builder.value(for: \.embedded) }.to(equal(backingValue.embedded))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial backed by the value from the backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue) == backingValue.embedded
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }
                            #endif
                        }

                        context("then removed via the subscript") {
                            beforeEach {
                                builder[\.embedded] = nil
                            }

                            context("value(for:)") {
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return the value from the backing value") {
                                    expect { try builder.value(for: \.embedded) }.to(equal(backingValue.embedded))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial backed by the value from the backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue) == backingValue.embedded
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
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
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return the value from the backing value") {
                                    expect { try builder.value(for: \.embedded) }.to(equal(backingValue.embedded))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial backed by the value from the backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue) == backingValue.embedded
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }

                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
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

                        context("partialValue(for:)") {
                            it("should return the a partial wrapping the set value") {
                                let result = builder.partialValue(for: \.embedded)
                                expect(result.backingValue) == valueSet
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
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return the value from the backing value") {
                                    expect { try builder.value(for: \.embedded) }.to(equal(backingValue.embedded))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial backed by the value from the backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue) == backingValue.embedded
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }
                            #endif
                        }

                        context("then removed via the subscript") {
                            beforeEach {
                                builder[\.embedded] = nil
                            }

                            context("value(for:)") {
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return the value from the backing value") {
                                    expect { try builder.value(for: \.embedded) }.to(equal(backingValue.embedded))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial backed by the value from the backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue) == backingValue.embedded
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
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
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return the value from the backing value") {
                                    expect { try builder.value(for: \.embedded) }.to(equal(backingValue.embedded))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial backed by the value from the backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue) == backingValue.embedded
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }

                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
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

                        context("partialValue(for:)") {
                            it("should return the a partial wrapping the set value") {
                                let result = builder.partialValue(for: \.embedded)
                                expect(result.backingValue) == valueSet
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
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return the value from the backing value") {
                                    expect { try builder.value(for: \.embedded) }.to(equal(backingValue.embedded))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial backed by the value from the backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue) == backingValue.embedded
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }
                            #endif
                        }

                        context("then removed via the subscript") {
                            beforeEach {
                                builder[\.embedded] = nil
                            }

                            context("value(for:)") {
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return the value from the backing value") {
                                    expect { try builder.value(for: \.embedded) }.to(equal(backingValue.embedded))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial backed by the value from the backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue) == backingValue.embedded
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
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
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return the value from the backing value") {
                                    expect { try builder.value(for: \.embedded) }.to(equal(backingValue.embedded))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial backed by the value from the backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue) == backingValue.embedded
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }

                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }
                        }
                        #endif
                    }
                    #endif

                    context("with the value set to a partial via `setValue(_:for:)`") {
                        var unwrappedValue: Wrapped.Embedded!
                        var valueSet: Partial<Wrapped.Embedded>!

                        beforeEach {
                            unwrappedValue = Wrapped.Embedded(string: "test")
                            valueSet = Partial<Wrapped.Embedded>()
                            valueSet.setValue(unwrappedValue.string, for: \.string)
                            builder.setValue(valueSet, for: \.embedded)
                        }

                        context("value(for:)") {
                            it("should not throw") {
                                expect { try builder.value(for: \.embedded) }.toNot(throwError())
                            }

                            it("should return an unwrapped value") {
                                expect { try builder.value(for: \.embedded) }.to(equal(unwrappedValue))
                            }
                        }

                        context("partialValue(for:)") {
                            it("should return the set partial") {
                                let result = builder.partialValue(for: \.embedded)
                                expect { try result.value(for: \.string) } == valueSet[\.string]
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = builder[\.embedded]
                            }

                            it("should return an unwrapped value") {
                                expect(result).to(equal(unwrappedValue))
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = builder.embedded
                            }

                            it("should return an unwrapped value") {
                                expect(result).to(equal(unwrappedValue))
                            }
                        }
                        #endif

                        context("then removed with removeValue(for:)") {
                            beforeEach {
                                builder.removeValue(for: \.embedded)
                            }

                            context("value(for:)") {
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return the value from the backing value") {
                                    expect { try builder.value(for: \.embedded) }.to(equal(backingValue.embedded))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial backed by the value from the backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue) == backingValue.embedded
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }
                            #endif
                        }

                        context("then removed via the subscript") {
                            beforeEach {
                                builder[\.embedded] = nil
                            }

                            context("value(for:)") {
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return the value from the backing value") {
                                    expect { try builder.value(for: \.embedded) }.to(equal(backingValue.embedded))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial backed by the value from the backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue) == backingValue.embedded
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
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
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return the value from the backing value") {
                                    expect { try builder.value(for: \.embedded) }.to(equal(backingValue.embedded))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial backed by the value from the backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue) == backingValue.embedded
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }

                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }
                        }
                        #endif
                    }
                }

                context("initialised with a backing value with the property set to `nil`") {
                    var backingValue: Wrapped!
                    var builder: PartialBuilder<Wrapped>!

                    beforeEach {
                        backingValue = Wrapped(embedded: nil)
                        builder = PartialBuilder(backingValue: backingValue)
                    }

                    context("value(for:)") {
                        it("should not throw an error") {
                            expect { try builder.value(for: \.embedded) }.toNot(throwError())
                        }

                        it("should return `nil`") {
                            expect { try builder.value(for: \.embedded) }.to(beNil())
                        }
                    }

                    context("partialValue(for:)") {
                        it("should return a partial without a value set") {
                            let result = builder.partialValue(for: \.embedded)
                            expect { try? result.value(for: \.string) }.to(beNil())
                        }

                        it("should return a partial without a backing value") {
                            let result = builder.partialValue(for: \.embedded)
                            expect(result.backingValue).to(beNil())
                        }
                    }

                    context("the subscript") {
                        var result: Wrapped.Embedded??

                        beforeEach {
                            result = builder[\.embedded]
                        }

                        it("should return `nil` wrapped in an optional") {
                            expect(result).to(beNilWrappedInOptional())
                        }
                    }

                    #if swift(>=5.1)
                    context("dynamic member lookup") {
                        var result: Wrapped.Embedded??

                        beforeEach {
                            result = builder.embedded
                        }

                        it("should return `nil` wrapped in an optional") {
                            expect(result).to(beNilWrappedInOptional())
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

                        context("partialValue(for:)") {
                            it("should return a partial without a value set") {
                                let result = builder.partialValue(for: \.embedded)
                                expect { try? result.value(for: \.string) }.to(beNil())
                            }

                            it("should return a partial without a backing value") {
                                let result = builder.partialValue(for: \.embedded)
                                expect(result.backingValue).to(beNil())
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
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return `nil`") {
                                    expect { try builder.value(for: \.embedded) }.to(beNil())
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
                                }
                            }
                            #endif
                        }

                        context("then removed via the subscript") {
                            beforeEach {
                                builder[\.embedded] = nil
                            }

                            context("value(for:)") {
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return `nil`") {
                                    expect { try builder.value(for: \.embedded) }.to(beNil())
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
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
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return `nil`") {
                                    expect { try builder.value(for: \.embedded) }.to(beNil())
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
                                }
                            }

                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
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

                        context("partialValue(for:)") {
                            it("should return a partial without a value set") {
                                let result = builder.partialValue(for: \.embedded)
                                expect { try? result.value(for: \.string) }.to(beNil())
                            }

                            it("should return a partial without a backing value") {
                                let result = builder.partialValue(for: \.embedded)
                                expect(result.backingValue).to(beNil())
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
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return `nil`") {
                                    expect { try builder.value(for: \.embedded) }.to(beNil())
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
                                }
                            }
                            #endif
                        }

                        context("then removed via the subscript") {
                            beforeEach {
                                builder[\.embedded] = nil
                            }

                            context("value(for:)") {
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return `nil`") {
                                    expect { try builder.value(for: \.embedded) }.to(beNil())
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
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
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return `nil`") {
                                    expect { try builder.value(for: \.embedded) }.to(beNil())
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
                                }
                            }

                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
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

                        context("partialValue(for:)") {
                            it("should return a partial without a value set") {
                                let result = builder.partialValue(for: \.embedded)
                                expect { try? result.value(for: \.string) }.to(beNil())
                            }

                            it("should return a partial without a backing value") {
                                let result = builder.partialValue(for: \.embedded)
                                expect(result.backingValue).to(beNil())
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
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return `nil`") {
                                    expect { try builder.value(for: \.embedded) }.to(beNil())
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
                                }
                            }
                            #endif
                        }

                        context("then removed via the subscript") {
                            beforeEach {
                                builder[\.embedded] = nil
                            }

                            context("value(for:)") {
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return `nil`") {
                                    expect { try builder.value(for: \.embedded) }.to(beNil())
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
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
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return `nil`") {
                                    expect { try builder.value(for: \.embedded) }.to(beNil())
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
                                }
                            }

                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
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

                        context("partialValue(for:)") {
                            it("should return the a partial wrapping the set value") {
                                let result = builder.partialValue(for: \.embedded)
                                expect(result.backingValue) == valueSet
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
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return `nil`") {
                                    expect { try builder.value(for: \.embedded) }.to(beNil())
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
                                }
                            }
                            #endif
                        }

                        context("then removed via the subscript") {
                            beforeEach {
                                builder[\.embedded] = nil
                            }

                            context("value(for:)") {
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return `nil`") {
                                    expect { try builder.value(for: \.embedded) }.to(beNil())
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
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
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return `nil`") {
                                    expect { try builder.value(for: \.embedded) }.to(beNil())
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
                                }
                            }

                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
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

                        context("partialValue(for:)") {
                            it("should return the a partial wrapping the set value") {
                                let result = builder.partialValue(for: \.embedded)
                                expect(result.backingValue) == valueSet
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
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return `nil`") {
                                    expect { try builder.value(for: \.embedded) }.to(beNil())
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
                                }
                            }
                            #endif
                        }

                        context("then removed via the subscript") {
                            beforeEach {
                                builder[\.embedded] = nil
                            }

                            context("value(for:)") {
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return `nil`") {
                                    expect { try builder.value(for: \.embedded) }.to(beNil())
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
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
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return `nil`") {
                                    expect { try builder.value(for: \.embedded) }.to(beNil())
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
                                }
                            }

                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
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

                        context("partialValue(for:)") {
                            it("should return the a partial wrapping the set value") {
                                let result = builder.partialValue(for: \.embedded)
                                expect(result.backingValue) == valueSet
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
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return `nil`") {
                                    expect { try builder.value(for: \.embedded) }.to(beNil())
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
                                }
                            }
                            #endif
                        }

                        context("then removed via the subscript") {
                            beforeEach {
                                builder[\.embedded] = nil
                            }

                            context("value(for:)") {
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return `nil`") {
                                    expect { try builder.value(for: \.embedded) }.to(beNil())
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
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
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return `nil`") {
                                    expect { try builder.value(for: \.embedded) }.to(beNil())
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
                                }
                            }

                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
                                }
                            }
                        }
                        #endif
                    }
                    #endif

                    context("with the value set to a partial via `setValue(_:for:)`") {
                        var unwrappedValue: Wrapped.Embedded!
                        var valueSet: Partial<Wrapped.Embedded>!

                        beforeEach {
                            unwrappedValue = Wrapped.Embedded(string: "test")
                            valueSet = Partial<Wrapped.Embedded>()
                            valueSet.setValue(unwrappedValue.string, for: \.string)
                            builder.setValue(valueSet, for: \.embedded)
                        }

                        context("value(for:)") {
                            it("should not throw") {
                                expect { try builder.value(for: \.embedded) }.toNot(throwError())
                            }

                            it("should return an unwrapped value") {
                                expect { try builder.value(for: \.embedded) }.to(equal(unwrappedValue))
                            }
                        }

                        context("partialValue(for:)") {
                            it("should return the set partial") {
                                let result = builder.partialValue(for: \.embedded)
                                expect { try result.value(for: \.string) } == valueSet[\.string]
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = builder[\.embedded]
                            }

                            it("should return an unwrapped value") {
                                expect(result).to(equal(unwrappedValue))
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = builder.embedded
                            }

                            it("should return an unwrapped value") {
                                expect(result).to(equal(unwrappedValue))
                            }
                        }
                        #endif

                        context("then removed with removeValue(for:)") {
                            beforeEach {
                                builder.removeValue(for: \.embedded)
                            }

                            context("value(for:)") {
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return `nil`") {
                                    expect { try builder.value(for: \.embedded) }.to(beNil())
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
                                }
                            }
                            #endif
                        }

                        context("then removed via the subscript") {
                            beforeEach {
                                builder[\.embedded] = nil
                            }

                            context("value(for:)") {
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return `nil`") {
                                    expect { try builder.value(for: \.embedded) }.to(beNil())
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
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
                                it("should not throw an error") {
                                    expect { try builder.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return `nil`") {
                                    expect { try builder.value(for: \.embedded) }.to(beNil())
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = builder.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder[\.embedded]
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
                                }
                            }

                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded??

                                beforeEach {
                                    result = builder.embedded
                                }

                                it("should return `nil` wrapped in an optional") {
                                    expect(result).to(beNilWrappedInOptional())
                                }
                            }
                        }
                        #endif
                    }
                }
            }
        }
    }
}
