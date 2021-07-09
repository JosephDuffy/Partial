import Quick
import Nimble

@testable
import Partial

final class PartiallyBuiltTests: QuickSpec {

    override func spec() {
        describe("PartiallyBuilt") {
            var partiallyBuilt: PartiallyBuilt<StringWrapper>!

            beforeEach {
                partiallyBuilt = PartiallyBuilt()
            }

            context("with an incomplete partial value") {
                it("wrappedValue should be nil") {
                    expect(partiallyBuilt.wrappedValue).to(beNil())
                }
            }

            context("with a complete partial value") {
                let setValue = StringWrapper(stringLiteral: "test")
                beforeEach {
                    partiallyBuilt.projectedValue.string = "test"
                }

                it("wrappedValue should return the unwrapped value") {
                    expect(partiallyBuilt.wrappedValue).to(equal(setValue))
                }
            }

            context("initialised with a complete partial") {
                let setValue = StringWrapper(stringLiteral: "test")
                beforeEach {
                    var partial = Partial<StringWrapper>()
                    partial.string = setValue.string
                    partiallyBuilt = PartiallyBuilt(partial: partial)
                }

                it("wrappedValue should return the unwrapped value") {
                    expect(partiallyBuilt.wrappedValue).to(equal(setValue))
                }
            }
        }
    }

}
