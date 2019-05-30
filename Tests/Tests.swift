import Quick
import Nimble
import Partial

final class Tests: QuickSpec {

    override func spec() {
        describe("Partial") {
            context("wrapping a PartialConvertible type") {
                struct MockPartialConvertible: PartialConvertible {
                    let stringProperty: String
                    init(partial: Partial<MockPartialConvertible>) throws {
                        stringProperty = try partial.value(for: \.stringProperty)
                    }
                }

                var partial: Partial<MockPartialConvertible> = Partial()

                beforeEach {
                    partial = Partial()
                }

                context("with no values") {
                    context("the unwrappedValue() function") {
                        it("should throw a missingKey error") {
                            let expectedError = Partial<MockPartialConvertible>.Error.missingKey(\.stringProperty)
                            expect { try partial.unwrappedValue() }.to(throwError(expectedError))
                        }
                    }
                }

                context("with all values") {
                    beforeEach {
                        partial[\.stringProperty] = "test"
                    }

                    context("the unwrappedValue() function") {
                        it("should not throw an error") {
                            expect { try partial.unwrappedValue() }.toNot(throwError())
                        }
                    }
                }
            }

            context("wrapping a PartialConvertible type with an Optional property") {
                struct MockPartialConvertible: PartialConvertible {
                    let optionalString: String?

                    init(partial: Partial<MockPartialConvertible>) throws {
                        optionalString = try partial.value(for: \.optionalString)
                    }
                }

                var partial: Partial<MockPartialConvertible> = Partial()

                beforeEach {
                    partial = Partial()
                }

                context("with the embedded value not set") {
                    context("the value(for:) function") {
                        it("should throw a missingKey error") {
                            let missingKeyError = Partial<MockPartialConvertible>.Error.missingKey(\.optionalString)
                            expect { try partial.value(for: \.optionalString) }.to(throwError(missingKeyError))
                        }
                    }
                }

                context("with the embedded value set to nil") {
                    beforeEach {
                        partial.set(value: nil, for: \.optionalString)
                    }

                    context("the value(for:) function") {
                        it("should not throw an error") {
                            expect { try partial.value(for: \.optionalString) }.toNot(throwError())
                        }

                        it("should return nil") {
                            expect { try partial.value(for: \.optionalString) }.to(beNil())
                        }
                    }
                }
            }

            context("wrapping a PartialConvertible type with a PartialConvertible property") {
                struct MockPartialConvertible: PartialConvertible {
                    struct PartialConvertibleStringWrapper: PartialConvertible {
                        let stringProperty: String
                        init(partial: Partial<PartialConvertibleStringWrapper>) throws {
                            stringProperty = try partial.value(for: \.stringProperty)
                        }
                    }

                    let partialConvertibleProperty: PartialConvertibleStringWrapper

                    init(partial: Partial<MockPartialConvertible>) throws {
                        partialConvertibleProperty = try partial.value(for: \.partialConvertibleProperty)
                    }
                }

                var partial: Partial<MockPartialConvertible> = Partial()

                beforeEach {
                    partial = Partial()
                }

                context("with the embedded value set via the subscript") {
                    beforeEach {
                        partial[\.partialConvertibleProperty][\.stringProperty] = "test"
                    }

                    context("the unwrappedValue() function") {
                        it("should not throw an error") {
                            expect { try partial.unwrappedValue() }.toNot(throwError())
                        }
                    }

                    context("then set to nil") {
                        beforeEach {
                            partial[\.partialConvertibleProperty][\.stringProperty] = nil
                        }

                        context("the unwrappedValue() function") {
                            it("should throw missingKey error") {
                                let expectedError =
                                    Partial<MockPartialConvertible.PartialConvertibleStringWrapper>
                                        .Error
                                        .missingKey(\.stringProperty)

                                expect { try partial.unwrappedValue() }.to(throwError(expectedError))
                            }
                        }
                    }

                    context("then removed via removeValue(for:)") {
                        beforeEach {
                            partial[\.partialConvertibleProperty].removeValue(for: \.stringProperty)
                        }

                        context("the unwrappedValue() function") {
                            it("should throw missingKey error") {
                                let expectedError =
                                    Partial<MockPartialConvertible.PartialConvertibleStringWrapper>
                                        .Error
                                        .missingKey(\.stringProperty)

                                expect { try partial.unwrappedValue() }.to(throwError(expectedError))
                            }
                        }
                    }
                }
            }
        }
    }

}
