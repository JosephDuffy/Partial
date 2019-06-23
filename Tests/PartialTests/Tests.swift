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
                        it("should throw a keyPathNotSet error") {
                            let expectedError = Partial<MockPartialConvertible>.Error.keyPathNotSet(\.stringProperty)
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
                        it("should throw a keyPathNotSet error") {
                            let expectedError = Partial<MockPartialConvertible>.Error.keyPathNotSet(\.optionalString)
                            expect { try partial.value(for: \.optionalString) }.to(throwError(expectedError))
                        }
                    }
                }

                context("with the embedded value set to nil") {
                    beforeEach {
                        partial.setValue(nil, for: \.optionalString)
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

                #if swift(>=5.1)
                context("with the embedded value set to 'test' via the dynamic member lookup") {
                    beforeEach {
                        partial.optionalString = "test"
                    }

                    context("the value(for:) function") {
                        it("should not throw an error") {
                            expect { try partial.value(for: \.optionalString) }.toNot(throwError())
                        }

                        it("should return 'test'") {
                            expect { try partial.value(for: \.optionalString) }.to(equal("test"))
                        }
                    }

                    context("accessing the value via the dynamic member lookup") {
                        it("should return 'test'") {
                            expect(partial.optionalString) == "test"
                        }
                    }
                }
                #endif
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
                            it("should throw keyPathNotSet error") {
                                let expectedError =
                                    Partial<MockPartialConvertible.PartialConvertibleStringWrapper>
                                        .Error
                                        .keyPathNotSet(\.stringProperty)

                                expect { try partial.unwrappedValue() }.to(throwError(expectedError))
                            }
                        }
                    }

                    context("then removed via removeValue(for:)") {
                        beforeEach {
                            partial[\.partialConvertibleProperty].removeValue(for: \.stringProperty)
                        }

                        context("the unwrappedValue() function") {
                            it("should throw keyPathNotSet error") {
                                let expectedError =
                                    Partial<MockPartialConvertible.PartialConvertibleStringWrapper>
                                        .Error
                                        .keyPathNotSet(\.stringProperty)

                                expect { try partial.unwrappedValue() }.to(throwError(expectedError))
                            }
                        }
                    }
                }
            }
        }
    }

}
