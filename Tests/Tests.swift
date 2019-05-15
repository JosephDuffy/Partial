import Quick
import Nimble
import Partial

final class Tests: QuickSpec {

    override func spec() {
        describe("Partial") {
            context("wrapping a CGSize") {
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
        }
    }

}
