import Quick
import Nimble

@testable
import Partial

final class Tests: QuickSpec {

    override func spec() {
        describe("Partial") {
            context("wrapping a type with a non-optional property") {
                struct Wrapped {
                    struct Embedded: Equatable {
                        let string: String
                        init(string: String) {
                            self.string = string
                        }
                    }
                    let embedded: Embedded
                }

                context("initialised without a backing value") {
                    var partial: Partial<Wrapped>!

                    beforeEach {
                        partial = Partial()
                    }

                    context("with the property value not set") {
                        context("the throwing value(for:) function") {
                            it("should throw a keyPathNotSet error") {
                                let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                                expect {
                                    let result: Wrapped.Embedded = try partial.value(for: \.embedded)
                                    return result
                                }.to(throwError(expectedError))
                            }
                        }

                        context("the non-throwing value(for:) function") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return `nil`") {
                                expect(result).to(beNil())
                            }
                        }

                        context("the partialValue(for:) function") {
                            it("should return an empty partial") {
                                let result = partial.partialValue(for: \.embedded)
                                expect(result.value(for: \.string)).to(beNil())
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial[\.embedded]
                            }

                            it("should return `nil`") {
                                expect(result).to(beNil())
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return `nil`") {
                                expect(result).to(beNil())
                            }
                        }
                        #endif
                    }

                    context("with the property value set") {
                        var valueSet: Wrapped.Embedded!

                        beforeEach {
                            valueSet = Wrapped.Embedded(string: "test")
                            partial.setValue(valueSet, for: \.embedded)
                        }

                        context("the throwing value(for:) function") {
                            it("should not throw an error") {
                                expect {
                                    let result: Wrapped.Embedded = try partial.value(for: \.embedded)
                                    return result
                                }.toNot(throwError())
                            }

                            it("should return the set value") {
                                expect {
                                    let result: Wrapped.Embedded = try partial.value(for: \.embedded)
                                    return result
                                }.to(equal(valueSet))
                            }
                        }

                        context("the non-throwing value(for:) function") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }

                        context("the partialValue(for:) function") {
                            it("should return the a partial wrapping the set value") {
                                let result = partial.partialValue(for: \.embedded)
                                expect(result.backingValue) == valueSet
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }
                        #endif
                    }

                    context("with the property value set to a partial") {
                        var valueSet: Partial<Wrapped.Embedded>!

                        beforeEach {
                            valueSet = Partial<Wrapped.Embedded>()
                            valueSet.setValue("test", for: \.string)
                            partial.setValue(valueSet, for: \.embedded)
                        }

                        context("the throwing value(for:) function") {
                            it("should throw a foundUnwrappablePartial error") {
                                let expectedError = Partial<Wrapped>.Error.foundUnwrappablePartial(valueSet)
                                expect {
                                    let result = try partial.value(for: \.embedded)
                                    return result
                                }.to(throwError(expectedError))
                            }
                        }

                        context("the non-throwing value(for:) function") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return `nil`") {
                                expect(result).to(beNil())
                            }
                        }

                        context("the partialValue(for:) function") {
                            it("should return the set partial") {
                                let result = partial.partialValue(for: \.embedded)
                                expect(result.value(for: \.string)).to(equal(valueSet.value(for: \.string)))
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return `nil`") {
                                expect(result).to(beNil())
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return `nil`") {
                                expect(result).to(beNil())
                            }
                        }
                        #endif
                    }
                }

                context("initialised with a backing value") {
                    var backingValue: Wrapped!
                    var partial: Partial<Wrapped>!

                    beforeEach {
                        backingValue = Wrapped(embedded: Wrapped.Embedded(string: "backing-test"))
                        partial = Partial(backingValue: backingValue)
                    }

                    context("with the property value not set") {
                        context("the throwing value(for:) function") {
                            it("should not throw an error") {
                                expect {
                                    let result: Wrapped.Embedded = try partial.value(for: \.embedded)
                                    return result
                                }.toNot(throwError())
                            }

                            it("should return the value from the backing value") {
                                expect {
                                    let result: Wrapped.Embedded = try partial.value(for: \.embedded)
                                    return result
                                }.to(equal(backingValue.embedded))
                            }
                        }

                        context("the non-throwing value(for:) function") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return the value from the backing value") {
                                expect(result) == backingValue.embedded
                            }
                        }

                        context("the partialValue(for:) function") {
                            it("should return a partial backed by the value from the backing value") {
                                let result = partial.partialValue(for: \.embedded)
                                expect(result.backingValue) == backingValue.embedded
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial[\.embedded]
                            }

                            it("should return the value from the backing value") {
                                expect(result) == backingValue.embedded
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return the value from the backing value") {
                                expect(result) == backingValue.embedded
                            }
                        }
                        #endif
                    }

                    context("with the property value set") {
                        var valueSet: Wrapped.Embedded!

                        beforeEach {
                            valueSet = Wrapped.Embedded(string: "test")
                            partial.setValue(valueSet, for: \.embedded)
                        }

                        context("the throwing value(for:) function") {
                            it("should not throw an error") {
                                expect {
                                    let result: Wrapped.Embedded = try partial.value(for: \.embedded)
                                    return result
                                    }.toNot(throwError())
                            }

                            it("should return the set value") {
                                expect {
                                    let result: Wrapped.Embedded = try partial.value(for: \.embedded)
                                    return result
                                    }.to(equal(valueSet))
                            }
                        }

                        context("the non-throwing value(for:) function") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }

                        context("the partialValue(for:) function") {
                            it("should return the a partial wrapping the set value") {
                                let result = partial.partialValue(for: \.embedded)
                                expect(result.backingValue) == valueSet
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }
                        #endif
                    }

                    context("with the property value set to a partial") {
                        var valueSet: Partial<Wrapped.Embedded>!

                        beforeEach {
                            valueSet = Partial<Wrapped.Embedded>()
                            valueSet.setValue("test", for: \.string)
                            partial.setValue(valueSet, for: \.embedded)
                        }

                        context("the throwing value(for:) function") {
                            it("should throw a foundUnwrappablePartial error") {
                                let expectedError = Partial<Wrapped>.Error.foundUnwrappablePartial(valueSet)
                                expect {
                                    let result = try partial.value(for: \.embedded)
                                    return result
                                    }.to(throwError(expectedError))
                            }
                        }

                        context("the non-throwing value(for:) function") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return `nil`") {
                                expect(result).to(beNil())
                            }
                        }

                        context("the partialValue(for:) function") {
                            it("should return the set partial") {
                                let result = partial.partialValue(for: \.embedded)
                                expect(result.value(for: \.string)).to(equal(valueSet.value(for: \.string)))
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return `nil`") {
                                expect(result).to(beNil())
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return `nil`") {
                                expect(result).to(beNil())
                            }
                        }
                        #endif
                    }
                }
            }

            context("wrapping a type with an optional property") {
                struct Wrapped {
                    struct Embedded: Equatable {
                        let string: String
                        init(string: String) {
                            self.string = string
                        }
                    }
                    let embedded: Embedded?
                }

                context("initialised without a backing value") {
                    var partial: Partial<Wrapped>!

                    beforeEach {
                        partial = Partial()
                    }

                    context("with the property value not set") {
                        context("the throwing value(for:) function") {
                            it("should throw a keyPathNotSet error") {
                                let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                                expect {
                                    let result: Wrapped.Embedded? = try partial.value(for: \.embedded)
                                    return result
                                }.to(throwError(expectedError))
                            }
                        }

                        context("the non-throwing value(for:) function") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return `nil`") {
                                expect(result).to(beNil())
                            }
                        }

                        context("the partialValue(for:) function") {
                            it("should return an empty partial") {
                                let result = partial.partialValue(for: \.embedded)
                                expect(result.value(for: \.string)).to(beNil())
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial[\.embedded]
                            }

                            it("should return `nil`") {
                                expect(result).to(beNil())
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return `nil`") {
                                expect(result).to(beNil())
                            }
                        }
                        #endif
                    }

                    context("with the property value set to nil") {
                        beforeEach {
                            partial.setValue(nil, for: \.embedded)
                        }

                        context("the throwing value(for:) function") {
                            it("should not throw an error") {
                                expect { try partial.value(for: \.embedded) }.toNot(throwError())
                            }

                            it("should return `nil`") {
                                expect { try partial.value(for: \.embedded) }.to(beNil())
                            }
                        }

                        context("the non-throwing value(for:) function") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return `nil` wrapped in an `Optional`") {
                                expect(result).to(beNilWrappedInOptional())
                            }
                        }

                        context("the partialValue(for:) function") {
                            it("should return an empty partial") {
                                let result = partial.partialValue(for: \.embedded)
                                expect(result.value(for: \.string)).to(beNil())
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return `nil` wrapped in an `Optional`") {
                                expect(result).to(beNilWrappedInOptional())
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return `nil` wrapped in an `Optional`") {
                                expect(result).to(beNilWrappedInOptional())
                            }
                        }
                        #endif
                    }

                    context("with the property value set to an instance of the propery's type") {
                        var valueSet: Wrapped.Embedded!

                        beforeEach {
                            valueSet = Wrapped.Embedded(string: "test")
                            partial.setValue(valueSet, for: \.embedded)
                        }

                        context("the throwing value(for:) function") {
                            it("should not throw an error") {
                                expect {
                                    let result: Wrapped.Embedded? = try partial.value(for: \.embedded)
                                    return result
                                }.toNot(throwError())
                            }

                            it("should return the set value") {
                                expect {
                                    let result: Wrapped.Embedded? = try partial.value(for: \.embedded)
                                    return result
                                }.to(equal(valueSet))
                            }
                        }

                        context("the non-throwing value(for:) function") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }

                        context("the partialValue(for:) function") {
                            it("should return the a partial wrapping the set value") {
                                let result = partial.partialValue(for: \.embedded)
                                expect(result.backingValue) == valueSet
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }
                        #endif
                    }

                    context("with the property value set to a partial") {
                        var valueSet: Partial<Wrapped.Embedded>!

                        beforeEach {
                            valueSet = Partial<Wrapped.Embedded>()
                            valueSet.setValue("test", for: \.string)
                            partial.setValue(valueSet, for: \.embedded)
                        }

                        context("the throwing value(for:) function") {
                            it("should throw a foundUnwrappablePartial error") {
                                let expectedError = Partial<Wrapped>.Error.foundUnwrappablePartial(valueSet)
                                expect {
                                    let result = try partial.value(for: \.embedded)
                                    return result
                                }.to(throwError(expectedError))
                            }
                        }

                        context("the non-throwing value(for:) function") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return `nil`") {
                                expect(result).to(beNil())
                            }
                        }

                        context("the partialValue(for:) function") {
                            it("should return the set partial") {
                                let result = partial.partialValue(for: \.embedded)
                                expect(result.value(for: \.string)).to(equal(valueSet.value(for: \.string)))
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return `nil`") {
                                expect(result).to(beNil())
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return `nil`") {
                                expect(result).to(beNil())
                            }
                        }
                        #endif
                    }
                }

                context("initialised with a backing value") {
                    var backingValue: Wrapped!
                    var partial: Partial<Wrapped>!

                    beforeEach {
                        backingValue = Wrapped(embedded: Wrapped.Embedded(string: "backing-test"))
                        partial = Partial(backingValue: backingValue)
                    }

                    context("with the property value not set") {
                        context("the throwing value(for:) function") {
                            it("should not throw an error") {
                                expect {
                                    let result: Wrapped.Embedded? = try partial.value(for: \.embedded)
                                    return result
                                }.toNot(throwError())
                            }

                            it("should return the value from the backing value") {
                                expect {
                                    let result: Wrapped.Embedded? = try partial.value(for: \.embedded)
                                    return result
                                }.to(equal(backingValue.embedded))
                            }
                        }

                        context("the non-throwing value(for:) function") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return the value from the backing value") {
                                expect(result) == backingValue.embedded
                            }
                        }

                        context("the partialValue(for:) function") {
                            it("should return a partial backed by the value from the backing value") {
                                let result = partial.partialValue(for: \.embedded)
                                expect(result.backingValue) == backingValue.embedded
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial[\.embedded]
                            }

                            it("should return the value from the backing value") {
                                expect(result) == backingValue.embedded
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return the value from the backing value") {
                                expect(result) == backingValue.embedded
                            }
                        }
                        #endif
                    }

                    context("with the property value set to nil") {
                        beforeEach {
                            partial.setValue(nil, for: \.embedded)
                        }

                        context("the throwing value(for:) function") {
                            it("should not throw an error") {
                                expect { try partial.value(for: \.embedded) }.toNot(throwError())
                            }

                            it("should return `nil`") {
                                expect { try partial.value(for: \.embedded) }.to(beNil())
                            }
                        }

                        context("the non-throwing value(for:) function") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return `nil` wrapped in an `Optional`") {
                                expect(result).to(beNilWrappedInOptional())
                            }
                        }

                        context("the partialValue(for:) function") {
                            it("should return an empty partial") {
                                let result = partial.partialValue(for: \.embedded)
                                expect(result.value(for: \.string)).to(beNil())
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return `nil` wrapped in an `Optional`") {
                                expect(result).to(beNilWrappedInOptional())
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return `nil` wrapped in an `Optional`") {
                                expect(result).to(beNilWrappedInOptional())
                            }
                        }
                        #endif
                    }

                    context("with the property value set to an instance of the propery's type") {
                        var valueSet: Wrapped.Embedded!

                        beforeEach {
                            valueSet = Wrapped.Embedded(string: "test")
                            partial.setValue(valueSet, for: \.embedded)
                        }

                        context("the throwing value(for:) function") {
                            it("should not throw an error") {
                                expect {
                                    let result: Wrapped.Embedded? = try partial.value(for: \.embedded)
                                    return result
                                    }.toNot(throwError())
                            }

                            it("should return the set value") {
                                expect {
                                    let result: Wrapped.Embedded? = try partial.value(for: \.embedded)
                                    return result
                                    }.to(equal(valueSet))
                            }
                        }

                        context("the non-throwing value(for:) function") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }

                        context("the partialValue(for:) function") {
                            it("should return the a partial wrapping the set value") {
                                let result = partial.partialValue(for: \.embedded)
                                expect(result.backingValue) == valueSet
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }
                        #endif
                    }

                    context("with the property value set to a partial") {
                        var valueSet: Partial<Wrapped.Embedded>!

                        beforeEach {
                            valueSet = Partial<Wrapped.Embedded>()
                            valueSet.setValue("test", for: \.string)
                            partial.setValue(valueSet, for: \.embedded)
                        }

                        context("the throwing value(for:) function") {
                            it("should throw a foundUnwrappablePartial error") {
                                let expectedError = Partial<Wrapped>.Error.foundUnwrappablePartial(valueSet)
                                expect {
                                    let result = try partial.value(for: \.embedded)
                                    return result
                                    }.to(throwError(expectedError))
                            }
                        }

                        context("the non-throwing value(for:) function") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return `nil`") {
                                expect(result).to(beNil())
                            }
                        }

                        context("the partialValue(for:) function") {
                            it("should return the set partial") {
                                let result = partial.partialValue(for: \.embedded)
                                expect(result.value(for: \.string)).to(equal(valueSet.value(for: \.string)))
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return `nil`") {
                                expect(result).to(beNil())
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return `nil`") {
                                expect(result).to(beNil())
                            }
                        }
                        #endif
                    }
                }
            }

            context("wrapping a type with a non-optional `PartialConvertible` property") {
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
                    let embedded: Embedded
                }

                context("initialised without a backing value") {
                    var partial: Partial<Wrapped>!

                    beforeEach {
                        partial = Partial()
                    }

                    context("with the property value not set") {
                        context("the throwing value(for:) function") {
                            it("should throw a keyPathNotSet error") {
                                let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                                expect {
                                    let result: Wrapped.Embedded = try partial.value(for: \.embedded)
                                    return result
                                    }.to(throwError(expectedError))
                            }
                        }

                        context("the non-throwing value(for:) function") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return `nil`") {
                                expect(result).to(beNil())
                            }
                        }

                        context("the partialValue(for:) function") {
                            it("should return an empty partial") {
                                let result = partial.partialValue(for: \.embedded)
                                expect(result.value(for: \.string)).to(beNil())
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial[\.embedded]
                            }

                            it("should return `nil`") {
                                expect(result).to(beNil())
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return `nil`") {
                                expect(result).to(beNil())
                            }
                        }
                        #endif
                    }

                    context("with the property value set") {
                        var valueSet: Wrapped.Embedded!

                        beforeEach {
                            valueSet = Wrapped.Embedded(string: "test")
                            partial.setValue(valueSet, for: \.embedded)
                        }

                        context("the throwing value(for:) function") {
                            it("should not throw an error") {
                                expect {
                                    let result: Wrapped.Embedded = try partial.value(for: \.embedded)
                                    return result
                                    }.toNot(throwError())
                            }

                            it("should return the set value") {
                                expect {
                                    let result: Wrapped.Embedded = try partial.value(for: \.embedded)
                                    return result
                                    }.to(equal(valueSet))
                            }
                        }

                        context("the non-throwing value(for:) function") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }

                        context("the partialValue(for:) function") {
                            it("should return the a partial wrapping the set value") {
                                let result = partial.partialValue(for: \.embedded)
                                expect(result.backingValue) == valueSet
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }
                        #endif
                    }

                    context("with the property value set to a partial") {
                        var unwrappedValue: Wrapped.Embedded!
                        var valueSet: Partial<Wrapped.Embedded>!

                        beforeEach {
                            unwrappedValue = Wrapped.Embedded(string: "test")
                            valueSet = Partial<Wrapped.Embedded>()
                            valueSet.setValue(unwrappedValue.string, for: \.string)
                            partial.setValue(valueSet, for: \.embedded)
                        }

                        context("the throwing value(for:) function") {
                            it("should not throw") {
                                expect {
                                    let result = try partial.value(for: \.embedded)
                                    return result
                                }.toNot(throwError())
                            }

                            it("should return an unwrapped value") {
                                expect {
                                    let result = try partial.value(for: \.embedded)
                                    return result
                                }.to(equal(unwrappedValue))
                            }
                        }

                        context("the non-throwing value(for:) function") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return an unwrapped value") {
                                expect(result).to(equal(unwrappedValue))
                            }
                        }

                        context("the partialValue(for:) function") {
                            it("should return the set partial") {
                                let result = partial.partialValue(for: \.embedded)
                                expect(result.value(for: \.string)).to(equal(valueSet.value(for: \.string)))
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return an unwrapped value") {
                                expect(result).to(equal(unwrappedValue))
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return an unwrapped value") {
                                expect(result).to(equal(unwrappedValue))
                            }
                        }
                        #endif
                    }
                }

                context("initialised with a backing value") {
                    var backingValue: Wrapped!
                    var partial: Partial<Wrapped>!

                    beforeEach {
                        backingValue = Wrapped(embedded: Wrapped.Embedded(string: "backing-test"))
                        partial = Partial(backingValue: backingValue)
                    }

                    context("with the property value not set") {
                        context("the throwing value(for:) function") {
                            it("should not throw an error") {
                                expect {
                                    let result: Wrapped.Embedded = try partial.value(for: \.embedded)
                                    return result
                                }.toNot(throwError())
                            }

                            it("should return the value from the backing value") {
                                expect {
                                    let result: Wrapped.Embedded = try partial.value(for: \.embedded)
                                    return result
                                }.to(equal(backingValue.embedded))
                            }
                        }

                        context("the non-throwing value(for:) function") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return the value from the backing value") {
                                expect(result) == backingValue.embedded
                            }
                        }

                        context("the partialValue(for:) function") {
                            it("should return a partial backed by the value from the backing value") {
                                let result = partial.partialValue(for: \.embedded)
                                expect(result.backingValue) == backingValue.embedded
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial[\.embedded]
                            }

                            it("should return the value from the backing value") {
                                expect(result) == backingValue.embedded
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return the value from the backing value") {
                                expect(result) == backingValue.embedded
                            }
                        }
                        #endif
                    }

                    context("with the property value set") {
                        var valueSet: Wrapped.Embedded!

                        beforeEach {
                            valueSet = Wrapped.Embedded(string: "test")
                            partial.setValue(valueSet, for: \.embedded)
                        }

                        context("the throwing value(for:) function") {
                            it("should not throw an error") {
                                expect {
                                    let result: Wrapped.Embedded = try partial.value(for: \.embedded)
                                    return result
                                    }.toNot(throwError())
                            }

                            it("should return the set value") {
                                expect {
                                    let result: Wrapped.Embedded = try partial.value(for: \.embedded)
                                    return result
                                    }.to(equal(valueSet))
                            }
                        }

                        context("the non-throwing value(for:) function") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }

                        context("the partialValue(for:) function") {
                            it("should return the a partial wrapping the set value") {
                                let result = partial.partialValue(for: \.embedded)
                                expect(result.backingValue) == valueSet
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }
                        #endif
                    }

                    context("with the property value set to a partial") {
                        var unwrappedValue: Wrapped.Embedded!
                        var valueSet: Partial<Wrapped.Embedded>!

                        beforeEach {
                            unwrappedValue = Wrapped.Embedded(string: "test")
                            valueSet = Partial<Wrapped.Embedded>()
                            valueSet.setValue(unwrappedValue.string, for: \.string)
                            partial.setValue(valueSet, for: \.embedded)
                        }

                        context("the throwing value(for:) function") {
                            it("should not throw") {
                                expect {
                                    let result = try partial.value(for: \.embedded)
                                    return result
                                    }.toNot(throwError())
                            }

                            it("should return an unwrapped value") {
                                expect {
                                    let result = try partial.value(for: \.embedded)
                                    return result
                                    }.to(equal(unwrappedValue))
                            }
                        }

                        context("the non-throwing value(for:) function") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return an unwrapped value") {
                                expect(result).to(equal(unwrappedValue))
                            }
                        }

                        context("the partialValue(for:) function") {
                            it("should return the set partial") {
                                let result = partial.partialValue(for: \.embedded)
                                expect(result.value(for: \.string)).to(equal(valueSet.value(for: \.string)))
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return an unwrapped value") {
                                expect(result).to(equal(unwrappedValue))
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return an unwrapped value") {
                                expect(result).to(equal(unwrappedValue))
                            }
                        }
                        #endif
                    }
                }
            }

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
                    var partial: Partial<Wrapped>!

                    beforeEach {
                        partial = Partial()
                    }

                    context("with the property value not set") {
                        context("the throwing value(for:) function") {
                            it("should throw a keyPathNotSet error") {
                                let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                                expect {
                                    let result: Wrapped.Embedded? = try partial.value(for: \.embedded)
                                    return result
                                    }.to(throwError(expectedError))
                            }
                        }

                        context("the non-throwing value(for:) function") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return `nil`") {
                                expect(result).to(beNil())
                            }
                        }

                        context("the partialValue(for:) function") {
                            it("should return an empty partial") {
                                let result = partial.partialValue(for: \.embedded)
                                expect(result.value(for: \.string)).to(beNil())
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial[\.embedded]
                            }

                            it("should return `nil`") {
                                expect(result).to(beNil())
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return `nil`") {
                                expect(result).to(beNil())
                            }
                        }
                        #endif
                    }

                    context("with the property value set to nil") {
                        beforeEach {
                            partial.setValue(nil, for: \.embedded)
                        }

                        context("the throwing value(for:) function") {
                            it("should not throw an error") {
                                expect { try partial.value(for: \.embedded) }.toNot(throwError())
                            }

                            it("should return `nil`") {
                                expect { try partial.value(for: \.embedded) }.to(beNil())
                            }
                        }

                        context("the non-throwing value(for:) function") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return `nil` wrapped in an `Optional`") {
                                expect(result).to(beNilWrappedInOptional())
                            }
                        }

                        context("the partialValue(for:) function") {
                            it("should return an empty partial") {
                                let result = partial.partialValue(for: \.embedded)
                                expect(result.value(for: \.string)).to(beNil())
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return `nil` wrapped in an `Optional`") {
                                expect(result).to(beNilWrappedInOptional())
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return `nil` wrapped in an `Optional`") {
                                expect(result).to(beNilWrappedInOptional())
                            }
                        }
                        #endif
                    }

                    context("with the property value set to an instance of the propery's type") {
                        var valueSet: Wrapped.Embedded!

                        beforeEach {
                            valueSet = Wrapped.Embedded(string: "test")
                            partial.setValue(valueSet, for: \.embedded)
                        }

                        context("the throwing value(for:) function") {
                            it("should not throw an error") {
                                expect {
                                    let result: Wrapped.Embedded? = try partial.value(for: \.embedded)
                                    return result
                                    }.toNot(throwError())
                            }

                            it("should return the set value") {
                                expect {
                                    let result: Wrapped.Embedded? = try partial.value(for: \.embedded)
                                    return result
                                    }.to(equal(valueSet))
                            }
                        }

                        context("the non-throwing value(for:) function") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }

                        context("the partialValue(for:) function") {
                            it("should return the a partial wrapping the set value") {
                                let result = partial.partialValue(for: \.embedded)
                                expect(result.backingValue) == valueSet
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }
                        #endif
                    }

                    context("with the property value set to a partial") {
                        var unwrappedValue: Wrapped.Embedded!
                        var valueSet: Partial<Wrapped.Embedded>!

                        beforeEach {
                            unwrappedValue = Wrapped.Embedded(string: "test")
                            valueSet = Partial<Wrapped.Embedded>()
                            valueSet.setValue(unwrappedValue.string, for: \.string)
                            partial.setValue(valueSet, for: \.embedded)
                        }

                        context("the throwing value(for:) function") {
                            it("should not throw") {
                                expect {
                                    let result = try partial.value(for: \.embedded)
                                    return result
                                }.toNot(throwError())
                            }

                            it("should return an unwrapped value") {
                                expect {
                                    let result = try partial.value(for: \.embedded)
                                    return result
                                }.to(equal(unwrappedValue))
                            }
                        }

                        context("the non-throwing value(for:) function") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return an unwrapped value") {
                                expect(result).to(equal(unwrappedValue))
                            }
                        }

                        context("the partialValue(for:) function") {
                            it("should return the set partial") {
                                let result = partial.partialValue(for: \.embedded)
                                expect(result.value(for: \.string)).to(equal(valueSet.value(for: \.string)))
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return an unwrapped value") {
                                expect(result).to(equal(unwrappedValue))
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return an unwrapped value") {
                                expect(result).to(equal(unwrappedValue))
                            }
                        }
                        #endif
                    }


                }

                fcontext("initialised with a backing value") {
                    var backingValue: Wrapped!
                    var partial: Partial<Wrapped>!

                    beforeEach {
                        backingValue = Wrapped(embedded: Wrapped.Embedded(string: "backing-test"))
                        partial = Partial(backingValue: backingValue)
                    }

                    context("with the property value not set") {
                        context("the throwing value(for:) function") {
                            it("should not throw an error") {
                                expect {
                                    let result: Wrapped.Embedded? = try partial.value(for: \.embedded)
                                    return result
                                }.toNot(throwError())
                            }

                            it("should return the value from the backing value") {
                                expect {
                                    let result: Wrapped.Embedded? = try partial.value(for: \.embedded)
                                    return result
                                }.to(equal(backingValue.embedded))
                            }
                        }

                        context("the non-throwing value(for:) function") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return the value from the backing value") {
                                expect(result) == backingValue.embedded
                            }
                        }

                        context("the partialValue(for:) function") {
                            it("should return a partial backed by the value from the backing value") {
                                let result = partial.partialValue(for: \.embedded)
                                expect(result.backingValue) == backingValue.embedded
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial[\.embedded]
                            }

                            it("should return the value from the backing value") {
                                expect(result) == backingValue.embedded
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return the value from the backing value") {
                                expect(result) == backingValue.embedded
                            }
                        }
                        #endif
                    }

                    context("with the property value set to nil") {
                        beforeEach {
                            partial.setValue(nil, for: \.embedded)
                        }

                        context("the throwing value(for:) function") {
                            it("should not throw an error") {
                                expect { try partial.value(for: \.embedded) }.toNot(throwError())
                            }

                            it("should return `nil`") {
                                expect { try partial.value(for: \.embedded) }.to(beNil())
                            }
                        }

                        context("the non-throwing value(for:) function") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return `nil` wrapped in an `Optional`") {
                                expect(result).to(beNilWrappedInOptional())
                            }
                        }

                        context("the partialValue(for:) function") {
                            it("should return an empty partial") {
                                let result = partial.partialValue(for: \.embedded)
                                expect(result.value(for: \.string)).to(beNil())
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return `nil` wrapped in an `Optional`") {
                                expect(result).to(beNilWrappedInOptional())
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return `nil` wrapped in an `Optional`") {
                                expect(result).to(beNilWrappedInOptional())
                            }
                        }
                        #endif
                    }

                    context("with the property value set to an instance of the propery's type") {
                        var valueSet: Wrapped.Embedded!

                        beforeEach {
                            valueSet = Wrapped.Embedded(string: "test")
                            partial.setValue(valueSet, for: \.embedded)
                        }

                        context("the throwing value(for:) function") {
                            it("should not throw an error") {
                                expect {
                                    let result: Wrapped.Embedded? = try partial.value(for: \.embedded)
                                    return result
                                    }.toNot(throwError())
                            }

                            it("should return the set value") {
                                expect {
                                    let result: Wrapped.Embedded? = try partial.value(for: \.embedded)
                                    return result
                                    }.to(equal(valueSet))
                            }
                        }

                        context("the non-throwing value(for:) function") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }

                        context("the partialValue(for:) function") {
                            it("should return the a partial wrapping the set value") {
                                let result = partial.partialValue(for: \.embedded)
                                expect(result.backingValue) == valueSet
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }
                        #endif
                    }

                    context("with the property value set to a partial") {
                        var unwrappedValue: Wrapped.Embedded!
                        var valueSet: Partial<Wrapped.Embedded>!

                        beforeEach {
                            unwrappedValue = Wrapped.Embedded(string: "test")
                            valueSet = Partial<Wrapped.Embedded>()
                            valueSet.setValue(unwrappedValue.string, for: \.string)
                            partial.setValue(valueSet, for: \.embedded)
                        }

                        context("the throwing value(for:) function") {
                            it("should not throw") {
                                expect {
                                    let result = try partial.value(for: \.embedded)
                                    return result
                                    }.toNot(throwError())
                            }

                            it("should return an unwrapped value") {
                                expect {
                                    let result = try partial.value(for: \.embedded)
                                    return result
                                    }.to(equal(unwrappedValue))
                            }
                        }

                        context("the non-throwing value(for:) function") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return an unwrapped value") {
                                expect(result).to(equal(unwrappedValue))
                            }
                        }

                        context("the partialValue(for:) function") {
                            it("should return the set partial") {
                                let result = partial.partialValue(for: \.embedded)
                                expect(result.value(for: \.string)).to(equal(valueSet.value(for: \.string)))
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.value(for: \.embedded)
                            }

                            it("should return an unwrapped value") {
                                expect(result).to(equal(unwrappedValue))
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded??

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return an unwrapped value") {
                                expect(result).to(equal(unwrappedValue))
                            }
                        }
                        #endif
                    }
                }
            }
        }
    }
}
