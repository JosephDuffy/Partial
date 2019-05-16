import CoreGraphics
import Quick
import Nimble
import Partial

final class Tests: QuickSpec {

    override func spec() {
        describe("Partial") {
            context("wrapping a CGSize") {
                // TODO: Change to something in Foundation (to support Linux)
                var partial: Partial<CGSize>!
                
                beforeEach {
                    partial = Partial()
                }
                
                context("with no values") {
                    context("value(for:) function") {
                        it("should throw missingKey error") {
                            expect { try partial.value(for: \.height) }.to(throwError(Partial<CGSize>.Error.missingKey(\.height)))
                        }
                    }
                }
            }
            
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
                        it("should throw an error") {
                            expect { try partial.unwrappedValue() }.to(throwError())
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
                }
            }
        }
    }

}
