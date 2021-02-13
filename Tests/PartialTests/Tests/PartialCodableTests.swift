import Quick
import Nimble
import Foundation

@testable
import Partial

final class PartialCodableTests: QuickSpec {
    override func spec() {
        describe("PartialCodable") {
            struct CodableType: Codable, PartialCodable, Hashable {
                @KeyPathCodingKeyCollectionBuilder<Self, CodingKeys>
                static var keyPathCodingKeyCollection: KeyPathCodingKeyCollection<Self, CodingKeys> {
                    (\Self.stringValue, CodingKeys.foo)
                    (\Self.intValue, CodingKeys.intValue)
                }

                let stringValue: String
                let intValue: Int
            }

            var partial: Partial<CodableType>!

            beforeEach {
                partial = Partial()
            }

            context("with complete value") {
                beforeEach {
                    partial.stringValue = "foo"
                    partial.intValue = 123
                }

                context("the encoded data") {
                    var encodedData: Data!

                    beforeEach {
                        let encoder = JSONEncoder()
                        encodedData = try? encoder.encode(partial)
                    }

                    it("should not be nil") {
                        expect(encodedData).toNot(beNil())
                    }

                    it("should be usable to decode Wrapped") {
                        do {
                            let decoder = JSONDecoder()
                            let decodedValue = try decoder.decode(CodableType.self, from: encodedData)

                            expect(decodedValue.stringValue) == "foo"
                            expect(decodedValue.intValue) == 123
                        } catch {
                            fail("Should not throw: \(error)")
                        }
                    }

                    it("should be usable to decode Partial<Wrapped>") {
                        do {
                            let decoder = JSONDecoder()
                            let decodedValue = try decoder.decode(Partial<CodableType>.self, from: encodedData)

                            expect(decodedValue.stringValue) == "foo"
                            expect(decodedValue.intValue) == 123
                        } catch {
                            fail("Should not throw: \(error)")
                        }
                    }
                }
            }
        }
    }
}
